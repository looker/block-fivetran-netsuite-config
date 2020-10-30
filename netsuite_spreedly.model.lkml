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

include: "//spreedly/heroku_kafka/views/*.view"
# include: "//spreedly/heroku_kafka/customer_health_score.layer.lkml"
# include: "//spreedly/heroku_kafka/views/organizations.view"
# include: "//spreedly/heroku_kafka/views/accounts.view"

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

  AND ${EXTENDED}

  ;; #maybe need more stuff, like this query https://spreedly.cloud.looker.com/explore/netsuite_spreedly/transaction_lines?qid=vZGw7W8JFZ4SjVrGhQS2AI&toggle=fil
}

explore: +transaction_lines {
  description: "this is the full transaction lines"

  join: customer_types {
    type: left_outer
    sql_on: ${customers.customer_type_id} = ${customer_types.customer_type_id} ;;
    relationship: many_to_one
  }

  join: classes { #TODO AJC Needs validation... not sure how to do that
    type: left_outer
    sql_on: ${transaction_lines.class_id} = ${classes.class_id} ;;
    relationship: many_to_one
  }
}

explore: netsuite_with_indirect_revenue {
  extends: [transaction_lines]
  join: organizations {
    sql_on: ${customers.customer_extid} = ${organizations.key} ;;
    relationship: many_to_one
  }
  join: accounts_lava {
    from: accounts
    type: left_outer
    sql_on: ${accounts_lava.organization_key}=${organizations.key} ;;
    relationship: many_to_one
  }
  join: transactions_lava {
    from: transactions
    sql_on: ${accounts_lava.key} = ${transactions_lava.account_key} ;;
relationship: one_to_many
  }
  join: gateways {
    type: left_outer
    sql_on: ${gateways.key}=${transactions_lava.gateway_key} ;;
    relationship: many_to_one # verify uniqueness of keys to update the relationship
  }

  join: bin_data {
    type: left_outer
    sql_on: ${bin_data.bin}=${transactions_lava.payment_method_first_six_digits};;
    relationship: many_to_many
  }

  join: receivers {
    type: left_outer
    sql_on: ${receivers.key}=${transactions_lava.payment_method_receiver_key} ;;
    relationship: many_to_one # verify uniqueness of keys to update the relationship

  }

  join: payment_methods {
    type: left_outer
    sql_on: ${transactions_lava.payment_method_key}=${payment_methods.key} ;;
    relationship: many_to_one
  }

  # join: customer_health_score_ndt {
  #   type: left_outer
  #   sql_on: ${organizations.name}=${customer_health_score_ndt.name} and
  #     ${organizations.key}=${customer_health_score_ndt.key};;
  #   relationship: one_to_one
  # }
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
