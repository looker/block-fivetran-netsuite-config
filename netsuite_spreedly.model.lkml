# connection: "snowflake" #this needs to be personalized
label: "Netsuite"
# include: "//block-fivetran-netsuite-spreedly/*.view"

# include: "//block-fivetran-netsuite-spreedly/accounts_payable.dashboard"
# include: "//block-fivetran-netsuite-spreedly/accounts_receivable.dashboard"
include: "/dashboards/balance_sheet.dashboard"
include: "/dashboards/income_statement.dashboard"
include: "/dashboards/sales.dashboard"
# include: "//block-fivetran-netsuite-spreedly/expenses_.dashboard"

include: "*.explore.lkml"
include: "*.view.lkml"
include: "/views/*.view.lkml"

include: "//spreedly/heroku_kafka/views/*.view"
include: "customer_daily_income_transaction_details_summary.view"
include: "//spreedly/heroku_kafka/heroku_kafka.model"
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
  description: "Only income statement lines"
  extends: [transaction_lines]
  sql_always_where: ${transactions_with_converted_amounts.is_income_statement}

  AND ${EXTENDED}

  ;; #maybe need more stuff, like this query https://spreedly.cloud.looker.com/explore/netsuite_spreedly/transaction_lines?qid=vZGw7W8JFZ4SjVrGhQS2AI&toggle=fil

}

explore: transaction_lines {
  view_name: transaction_lines
  sql_always_where:
   (${accounting_periods.fiscal_calendar_id} is null
          or ${accounting_periods.fiscal_calendar_id}  = (select
                                                        fiscal_calendar_id
                                                      from @{SCHEMA_NAME}.subsidiaries
                                                      where parent_id is null    group by 1)
    )
    ;;
  join: transactions {
    from: transactions_netsuite
    type: left_outer #TODO AJC This was actually listed as just "join" but i don't know the snowflake default
    sql_on: ${transactions.transaction_id} = ${transaction_lines.transaction_id}
      and not ${transactions._fivetran_deleted} ;;
    relationship: many_to_many #AJC TODO wise to check and see if transaction_id is also a pkey, but it isnt what is indicated right now
  }
  join: transactions_with_converted_amounts {
    type: left_outer
    sql_on: ${transaction_lines.transaction_line_id} = ${transactions_with_converted_amounts.transaction_line_id}
        and ${transaction_lines.transaction_id} = ${transactions_with_converted_amounts.transaction_id}
        and ${transactions_with_converted_amounts.reporting_accounting_period_id} = ${transactions_with_converted_amounts.transaction_accounting_period_id}
 ;;
    relationship: many_to_many #TODO AJC Needs confirmation
  }

  join: accounts {
    from: accounts_netsuite
    type: left_outer
    sql_on: ${transaction_lines.account_id} = ${accounts.account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: parent_account {
    from: accounts_netsuite
    sql_on: ${accounts.parent_id} = ${parent_account.account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: accounting_periods {
    type: left_outer
    sql_on: ${transactions.accounting_period_id} = ${accounting_periods.accounting_period_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: income_accounts {
    type: left_outer
    sql_on: ${accounts.account_id} = ${income_accounts.income_account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: expense_accounts {
    type: left_outer
    sql_on: ${accounts.account_id} = ${expense_accounts.expense_account_id};;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: customers {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${customers.customer_id}
      and not ${customers._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: items {
    type: left_outer
    sql_on: ${transaction_lines.item_id} = ${items.item_id}
      and not ${items._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: locations {
    type: left_outer
    sql_on: ${transaction_lines.location_id} = ${locations.location_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: vendors {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${vendors.vendor_id}
      and not ${vendors._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: vendor_types {
    type: left_outer
    sql_on: ${vendors.vendor_type_id} = ${vendor_types.vendor_type_id}
      and not ${vendor_types._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: currencies {
    type: left_outer
    sql_on: ${transactions.currency_id} = ${currencies.currency_id}
      and not ${currencies._fivetran_deleted} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: departments {
    type: left_outer
    sql_on: ${transaction_lines.department_id} = ${departments.department_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: subsidiaries {
    type: left_outer
    sql_on: ${transaction_lines.subsidiary_id} = ${subsidiaries.subsidiary_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
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

  join: monthly_org_indirect_revenue {
    type: left_outer
    sql_on: ${customers.spreedly_billing_id} = ${monthly_org_indirect_revenue.organization_key}
    and ${accounting_periods.ending_month} = ${monthly_org_indirect_revenue.created_month};;
    relationship: many_to_one
  }
# prefix labels to Lava or Spreedly --> View Label
#netsuite transactions are called "Transactions" Spreedly is called transactions_Spreedly view was renamed
  join: organizations {
    type: left_outer
    view_label: "Spreedly Organizations"
    sql_on: ${customers.spreedly_billing_id}=${organizations.key} ;;
    relationship: many_to_one
  }

  join: accounts_spreedly {
    from: accounts
    type: left_outer
    sql_on: ${organizations.key}=${accounts_spreedly.organization_key} ;;
    relationship: many_to_one
  }

  join: transactions_spreedly {
    from: transactions
    type: left_outer
    sql_on: ${accounts_spreedly.key} = ${transactions_spreedly.account_key}
      and ${accounting_periods.ending_month} = ${transactions_spreedly.created_month};;
    relationship: many_to_one
  }

  join: gateways {
    type: left_outer
    sql_on: ${transactions_spreedly.gateway_key}=${gateways.key} ;;
    relationship: many_to_one
  }


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