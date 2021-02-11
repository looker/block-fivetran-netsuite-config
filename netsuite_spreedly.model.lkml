connection: "snowflake" #this needs to be personalized
label: "Netsuite"
# include: "//block-fivetran-netsuite-spreedly/*.view"

# include: "//block-fivetran-netsuite-spreedly/accounts_payable.dashboard"
# include: "//block-fivetran-netsuite-spreedly/accounts_receivable.dashboard"
include: "/dashboards/balance_sheet.dashboard"
include: "/dashboards/income_statement.dashboard"
include: "/dashboards/sales.dashboard"
# include: "//block-fivetran-netsuite-spreedly/expenses_.dashboard"

include: "/explores/*.explore.lkml"
include: "*.view.lkml"
include: "/views/*.view.lkml"

include: "//spreedly/heroku_kafka/views/*.view"
include: "customer_daily_income_transaction_details_summary.view"
include: "//spreedly/heroku_kafka/config.lkml"

# include: "//spreedly/heroku_kafka/heroku_kafka.model"

# shortcut pulling in all model

# include: "//spreedly/heroku_kafka/customer_health_score.layer.lkml"
# include: "//spreedly/heroku_kafka/views/organizations.view"
# include: "//spreedly/heroku_kafka/views/accounts.view"

# datagroup: whitelist_etl {
#   max_cache_age: "24 hours"
#   sql_trigger: select count(*) from "SNOWPIPE"."TRANSACTIONS" ;;
# }

explore: balance_sheet {
  extends: [balance_sheet_core]
}

explore: income_statement {
  extends: [income_statement_core]
}

explore: income_transaction_details {
  view_name: transaction_lines
  description: "Only income statement lines"
  extends: [transaction_lines]
  sql_always_where: ${transactions_with_converted_amounts.is_income_statement}

  AND ${EXTENDED}

  ;; #maybe need more stuff, like this query https://spreedly.cloud.looker.com/explore/netsuite_spreedly/transaction_lines?qid=vZGw7W8JFZ4SjVrGhQS2AI&toggle=fil

}


# MFJ 1/15/20 added join to see indirect fields on indirect revenue to check
explore: monthly_org_partner_gateway_transactions {
   join: monthly_partner_gateway_transactions{
    type: left_outer
      sql_on:${monthly_org_partner_gateway_transactions.netsuite_gateway_type}=${monthly_partner_gateway_transactions.netsuite_gateway_type}
        And ${monthly_org_partner_gateway_transactions.created_month}=${monthly_partner_gateway_transactions.created_month};;
      relationship: many_to_one
    }
    join: monthly_gateway_partner_revenue {
      type: left_outer
      sql_on: ${monthly_gateway_partner_revenue.gateway_type} = ${monthly_org_partner_gateway_transactions.netsuite_gateway_type}
      And ${monthly_gateway_partner_revenue.ending_month::string} = ${monthly_org_partner_gateway_transactions.created_month::string};;
    relationship: many_to_one
    }

    }

# MFJ 1/12/20 tried adding explore for Total revenue transactions AND adding in transaction line direct revenue
# explore: monthly_org_gateway_partner_total_revenue {
#   extends: [transaction_lines]
#   join: customers {
#     type: left_outer
#     sql_on: ${customers.spreedly_billing_id} =${monthly_org_gateway_partner_total_revenue.organization_key}
#     and ${transaction_lines.date_closed_month} =${monthly_org_gateway_partner_total_revenue.ending_month};;
#     relationship: many_to_one
#   }
# }

# explore: netsuite_with_indirect_revenue {
#   extends: [transaction_lines]
#   join: organizations {
#     sql_on: ${customers.customer_extid} = ${organizations.key} ;;
#     relationship: many_to_one
#   }

#   join: accounts_lava {
#     from: accounts
#     type: left_outer
#     sql_on: ${organizations.key} =${accounts_lava.organization_key} ;;
#     relationship: many_to_one
#   }
#   join: transactions_lava {
#     from: transactions
#     sql_on: ${accounts_lava.key} = ${transactions_lava.account_key} ;;
# relationship: one_to_many
#   }
#   join: gateways {
#     type: left_outer
#     sql_on: ${gateways.key}=${transactions_lava.gateway_key} ;;
#     relationship: many_to_one # verify uniqueness of keys to update the relationship
#   }

#   join: bin_data {
#     type: left_outer
#     sql_on: ${bin_data.bin}=${transactions_lava.payment_method_first_six_digits};;
#     relationship: many_to_many
#   }

#   join: receivers {
#     type: left_outer
#     sql_on: ${receivers.key}=${transactions_lava.payment_method_receiver_key} ;;
#     relationship: many_to_one # verify uniqueness of keys to update the relationship

#   }

#   join: payment_methods {
#     type: left_outer
#     sql_on: ${transactions_lava.payment_method_key}=${payment_methods.key} ;;
#     relationship: many_to_one
#   }

#   # join: customer_health_score_ndt {
#   #   type: left_outer
#   #   sql_on: ${organizations.name}=${customer_health_score_ndt.name} and
#   #     ${organizations.key}=${customer_health_score_ndt.key};;
#   #   relationship: one_to_one
#   # }
# }

# explore: balance_sheet {
#   extends: [balance_sheet_core]
# }

# explore: income_statement {
#   extends: [income_statement_core]
# }

# explore: transaction_details {
#   extends: [transaction_details_core]
# }
