

view: period_exchange_rate_map {
  derived_table: {
    sql:

        select
          consolidated_exchange_rates.accounting_period_id,
          consolidated_exchange_rates.average_rate,
          consolidated_exchange_rates.current_rate,
          consolidated_exchange_rates.historical_rate,
          consolidated_exchange_rates.from_subsidiary_id,
          consolidated_exchange_rates.to_subsidiary_id
        from ${consolidated_exchange_rates.SQL_TABLE_NAME} as consolidated_exchange_rates
        where consolidated_exchange_rates.to_subsidiary_id in (
          select
            subsidiary_id
          from ${subsidiaries.SQL_TABLE_NAME} as subsidiaries
          where parent_id is null  -- constrait - only the primary subsidiary has no parent
          )
          and consolidated_exchange_rates.accounting_book_id in (
            select
              accounting_book_id
            from ${accounting_books.SQL_TABLE_NAME} as accounting_books
            where lower(is_primary) = 'yes'
            )
          and not consolidated_exchange_rates._fivetran_deleted

      ;;
  }
}

view: accountxperiod_exchange_rate_map {
  derived_table: {
    sql:
    -- account table with exchange rate details by accounting period
        select
          period_exchange_rate_map.accounting_period_id,
          period_exchange_rate_map.from_subsidiary_id,
          period_exchange_rate_map.to_subsidiary_id,
          accounts.account_id,
          case
            when lower(accounts.general_rate_type) = 'historical' then period_exchange_rate_map.historical_rate
            when lower(accounts.general_rate_type) = 'current' then period_exchange_rate_map.current_rate
            when lower(accounts.general_rate_type) = 'average' then period_exchange_rate_map.average_rate
            else null
            end as exchange_rate
        from @{SCHEMA_NAME}."ACCOUNTS" as accounts
        cross join ${period_exchange_rate_map.SQL_TABLE_NAME} as period_exchange_rate_map
    ;;
  }
}


view: transaction_lines_w_accounting_period {
  derived_table: {
    sql:
          -- transaction line totals, by accounts, accounting period and subsidiary
        select
          transaction_lines.transaction_id,
          transaction_lines.transaction_line_id,
          transaction_lines.subsidiary_id,
          transaction_lines.account_id,
          transactions.accounting_period_id as transaction_accounting_period_id,
          coalesce(transaction_lines.amount, 0) as unconverted_amount
        from ${transaction_lines.SQL_TABLE_NAME} as transaction_lines
        join @{SCHEMA_NAME}."TRANSACTIONS" as transactions on transactions.transaction_id = transaction_lines.transaction_id
        where not transactions._fivetran_deleted
          and lower(transactions.transaction_type) != 'revenue arrangement'
          and lower(non_posting_line) != 'yes'
          ;;
  }
}
view: period_id_list_to_current_period {
  derived_table: {
    sql:
          -- period ids with all future period ids.  this is needed to calculate cumulative totals by correct exchange rates.
        select
          base.accounting_period_id,
          array_agg(multiplier.accounting_period_id) within group (order by multiplier.accounting_period_id) as accounting_periods_to_include_for
        from ${accounting_periods.SQL_TABLE_NAME} as base
        join ${accounting_periods.SQL_TABLE_NAME} as multiplier
          on multiplier.starting >= base.starting
          and multiplier.quarter = base.quarter
          and multiplier.year_0 = base.year_0
          and multiplier.fiscal_calendar_id = base.fiscal_calendar_id
          and multiplier.starting <= current_timestamp()
        where lower(base.quarter) = 'no'
          and lower(base.year_0) = 'no'
          and base.fiscal_calendar_id = (select
                                          fiscal_calendar_id
                                        from ${subsidiaries.SQL_TABLE_NAME}
                                        where parent_id is null) -- fiscal calendar will align with parent subsidiary's default calendar
        group by 1
          ;;
  }
}

view: flattened_period_id_list_to_current_period {
  derived_table: {
    sql:
        select
          accounting_period_id,
          reporting_accounting_period_id.value as reporting_accounting_period_id
        from ${period_id_list_to_current_period.SQL_TABLE_NAME} as period_id_list_to_current_period,
          lateral flatten (input => accounting_periods_to_include_for) reporting_accounting_period_id
      ;;
  }
}
view: transactions_in_every_calculation_period_w_exchange_rates {
  derived_table: {
    sql: select
          transaction_lines_w_accounting_period.*,
          reporting_accounting_period_id,
          exchange_reporting_period.exchange_rate as exchange_rate_reporting_period,
          exchange_transaction_period.exchange_rate as exchange_rate_transaction_period
        from ${transaction_lines_w_accounting_period.SQL_TABLE_NAME} as transaction_lines_w_accounting_period
        inner join ${flattened_period_id_list_to_current_period.SQL_TABLE_NAME} as flattened_period_id_list_to_current_period on flattened_period_id_list_to_current_period.accounting_period_id = transaction_lines_w_accounting_period.transaction_accounting_period_id
        left join ${accountxperiod_exchange_rate_map.SQL_TABLE_NAME} as exchange_reporting_period
          on exchange_reporting_period.accounting_period_id = flattened_period_id_list_to_current_period.reporting_accounting_period_id
          and exchange_reporting_period.account_id = transaction_lines_w_accounting_period.account_id
          and exchange_reporting_period.from_subsidiary_id = transaction_lines_w_accounting_period.subsidiary_id
        left join ${accountxperiod_exchange_rate_map.SQL_TABLE_NAME} as exchange_transaction_period
          on exchange_transaction_period.accounting_period_id = flattened_period_id_list_to_current_period.accounting_period_id
          and exchange_transaction_period.account_id = transaction_lines_w_accounting_period.account_id
          and exchange_transaction_period.from_subsidiary_id = transaction_lines_w_accounting_period.subsidiary_id ;;
  }
}

view: transactions_with_converted_amounts {
  derived_table: {
    sql:
        select
        transactions_in_every_calculation_period_w_exchange_rates.*,
        unconverted_amount * exchange_rate_reporting_period as converted_amount_using_reporting_month,
        unconverted_amount * exchange_rate_transaction_period as converted_amount_using_transaction_accounting_period,
        case
          when lower(accounts.type_name) in ('income','other income','expense','other expense','other income','cost of goods sold') then true
          else false
          end as is_income_statement,
        case
          when lower(accounts.type_name) in ('accounts receivable', 'bank', 'deferred expense', 'fixed asset', 'other asset', 'other current asset', 'unbilled receivable') then 'Asset'
          when lower(accounts.type_name) in ('cost of goods sold', 'expense', 'other expense') then 'Expense'
          when lower(accounts.type_name) in ('income', 'other income') then 'Income'
          when lower(accounts.type_name) in ('accounts payable', 'credit card', 'deferred revenue', 'long term liability', 'other current liability') then 'Liability'
          when lower(accounts.type_name) in ('equity', 'retained earnings', 'net income') then 'Equity'
          else null end as account_category
      from ${transactions_in_every_calculation_period_w_exchange_rates.SQL_TABLE_NAME} as transactions_in_every_calculation_period_w_exchange_rates
      left join @{SCHEMA_NAME}."ACCOUNTS" as accounts on accounts.account_id = transactions_in_every_calculation_period_w_exchange_rates.account_id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: primary_key {
    primary_key: yes #https://spreedly.cloud.looker.com/sql/rzgvvmbdsym8g8
    type: string
    hidden: yes
    sql: ${transaction_id}||${transaction_line_id}||${reporting_accounting_period_id}||${transaction_accounting_period_id} ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}."TRANSACTION_ID" ;;
  }

  dimension: transaction_line_id {
    type: number
    sql: ${TABLE}."TRANSACTION_LINE_ID" ;;
  }

  dimension: subsidiary_id {
    type: number
    sql: ${TABLE}."SUBSIDIARY_ID" ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}."ACCOUNT_ID" ;;
  }

  dimension: transaction_accounting_period_id {
    type: number
    sql: ${TABLE}."TRANSACTION_ACCOUNTING_PERIOD_ID" ;;
  }

  dimension: unconverted_amount {
    type: number
    sql: ${TABLE}."UNCONVERTED_AMOUNT" ;;
  }

  dimension: reporting_accounting_period_id {
    type: string
    sql: ${TABLE}."REPORTING_ACCOUNTING_PERIOD_ID" ;;
  }

  dimension: exchange_rate_reporting_period {
    type: number
    sql: ${TABLE}."EXCHANGE_RATE_REPORTING_PERIOD" ;;
  }

  dimension: exchange_rate_transaction_period {
    type: number
    sql: ${TABLE}."EXCHANGE_RATE_TRANSACTION_PERIOD" ;;
  }

  dimension: converted_amount_using_reporting_month {
    type: number
    sql: ${TABLE}."CONVERTED_AMOUNT_USING_REPORTING_MONTH" ;;
  }

  dimension: converted_amount_using_transaction_accounting_period {
    type: number
    sql: ${TABLE}."CONVERTED_AMOUNT_USING_TRANSACTION_ACCOUNTING_PERIOD" ;;
  }

  dimension: converted_amount {
    type: number
    sql: case
          when lower(${accounts.type_name}) = 'income' or lower(${accounts.type_name}) = 'other income' then -${converted_amount_using_transaction_accounting_period}
          else ${converted_amount_using_transaction_accounting_period}
          end ;;
  }

  dimension: is_income_statement {
    type: yesno
    sql: ${TABLE}."IS_INCOME_STATEMENT"='true' ;;
  }

  dimension: account_category {
    type: string
    sql: ${TABLE}."ACCOUNT_CATEGORY" ;;
  }
  measure: sum_transaction_converted_amount {
    type: sum
    value_format_name: usd
    sql: ${converted_amount} ;;
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      transaction_id,
      transaction_line_id,
      subsidiary_id,
      account_id,
      transaction_accounting_period_id,
      unconverted_amount,
      reporting_accounting_period_id,
      exchange_rate_reporting_period,
      exchange_rate_transaction_period,
      converted_amount_using_reporting_month,
      converted_amount_using_transaction_accounting_period,
      is_income_statement,
      account_category
    ]
  }

}
