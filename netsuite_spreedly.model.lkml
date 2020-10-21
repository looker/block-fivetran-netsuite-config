connection: "@{CONNECTION_NAME}" #this needs to be personalized

include: "//block-fivetran-netsuite-spreedly/*.view"
include: "//block-fivetran-netsuite-spreedly/views/*.view"

include: "//block-fivetran-netsuite-spreedly/*.explore"
# include: "//block-fivetran-netsuite-spreedly/accounts_payable.dashboard"
# include: "//block-fivetran-netsuite-spreedly/accounts_receivable.dashboard"
include: "//block-fivetran-netsuite-spreedly/balance_sheet.dashboard"
include: "//block-fivetran-netsuite-spreedly/income_statement.dashboard"
include: "//block-fivetran-netsuite-spreedly/sales.dashboard"
# include: "//block-fivetran-netsuite-spreedly/expenses_.dashboard"

include: "/views/*.view.lkml"

include: "//spreedly/heroku_kafka/views/transactions.view"

explore: balance_sheet {
  extends: [balance_sheet_core]
}

explore: income_statement {
  extends: [income_statement_core]
}

explore: income_transaction_details {
  description: "Only income statement lines"
  extends: [transaction_lines]
  sql_always_where: ${transactions_with_converted_amounts.is_income_statement}

  AND(${accounting_periods.fiscal_calendar_id} is null
        or ${accounting_periods.fiscal_calendar_id}  = (select
                                                      fiscal_calendar_id
                                                    from @{SCHEMA_NAME}.subsidiaries
                                                    where parent_id is null)
  )
  ;; #maybe need more stuff, like this query https://spreedly.cloud.looker.com/explore/netsuite_spreedly/transaction_lines?qid=vZGw7W8JFZ4SjVrGhQS2AI&toggle=fil
}

explore: +transaction_lines {
  description: "this is the full transaction lines"

  join: customer_types {
    type: left_outer
    sql_on: ${customers.customer_type_id} = ${customer_types.customer_type_id} ;;
    relationship: many_to_one
  }
  # join: transactions_lava {
  #   from: transactions
  #   sql_on: ${transaction_lines.transaction_id} = ${transactions_lava.id? ;;
  #   relationship: many_to_one
  # }
  join: classes { #TODO AJC Needs validation... not sure how to do that
    type: left_outer
    sql_on: ${transaction_lines.class_id} = ${classes.class_id} ;;
    relationship: many_to_one
  }
}

# explore: balance_sheet {
#   extends: [balance_sheet_core]
# }

# explore: income_statement {
#   extends: [income_statement_core]
# }

# explore: transaction_details {
#   extends: [transaction_details_core]
# }
