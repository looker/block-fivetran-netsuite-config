view: consolidated_exchange_rates {
  sql_table_name: @{SCHEMA_NAME}."CONSOLIDATED_EXCHANGE_RATES"
    ;;
  drill_fields: [consolidated_exchange_rate_id]

  dimension: consolidated_exchange_rate_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."CONSOLIDATED_EXCHANGE_RATE_ID" ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."_FIVETRAN_SYNCED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: accounting_book_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."ACCOUNTING_BOOK_ID" ;;
  }

  dimension: accounting_period_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."ACCOUNTING_PERIOD_ID" ;;
  }

  dimension: average_budget_rate {
    type: number
    sql: ${TABLE}."AVERAGE_BUDGET_RATE" ;;
  }

  dimension: average_rate {
    type: number
    sql: ${TABLE}."AVERAGE_RATE" ;;
  }

  dimension: current_budget_rate {
    type: number
    sql: ${TABLE}."CURRENT_BUDGET_RATE" ;;
  }

  dimension: current_rate {
    type: number
    sql: ${TABLE}."CURRENT_RATE" ;;
  }

  dimension_group: date_deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_DELETED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: from_subsidiary_id {
    type: number
    sql: ${TABLE}."FROM_SUBSIDIARY_ID" ;;
  }

  dimension: historical_budget_rate {
    type: number
    sql: ${TABLE}."HISTORICAL_BUDGET_RATE" ;;
  }

  dimension: historical_rate {
    type: number
    sql: ${TABLE}."HISTORICAL_RATE" ;;
  }

  dimension: to_subsidiary_id {
    type: number
    sql: ${TABLE}."TO_SUBSIDIARY_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      consolidated_exchange_rate_id,
      accounting_books.accounting_book_name,
      accounting_books.accounting_book_id,
      accounting_periods.accounting_period_id,
      accounting_periods.name,
      accounting_periods.full_name
    ]
  }
}
