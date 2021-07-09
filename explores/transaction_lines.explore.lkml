include: "/*.view.lkml"
include: "/views/*.view.lkml"

include: "//spreedly/heroku_kafka/views/*.view"
include: "/customer_daily_income_transaction_details_summary.view"
include: "//spreedly/salesforce/views/account.view"
include: "/dashboard_refinements/**/*view"

# fields: [ALL_FIELDS*, -transactions_spreedly.is_production_transaction, -transactions_spreedly.count_test_transactions, -transactions_spreedly.count_production_transactions]
# Suggested filters/ Alwasys filter default yes -  for income transaction details:Account type: Income/Other income,Non posting: No

explore: transaction_lines { fields: [ALL_FIELDS*, -transactions_spreedly.is_production_transaction, -transactions_spreedly.count_test_transactions, -transactions_spreedly.count_production_transactions]
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
    relationship: many_to_many #TODO AJC Needs confirmation - the last 'and' statement is matching the same field to itself
  }

  join: dt_all_accounts_and_accounting_periods {
    type: full_outer
    sql_on: ${dt_all_accounts_and_accounting_periods.account_id} = ${transaction_lines.account_id}
    AND ${transactions.accounting_period_id} = ${dt_all_accounts_and_accounting_periods.accounting_period_id}
    AND ${transaction_lines.department_id} = ${dt_all_accounts_and_accounting_periods.department_id};;
    # AND ${transaction_lines.company_id} = ${dt_all_accounts_and_accounting_periods.customer_id};;
    relationship: many_to_one
  }

  join: accounts {
    from: accounts_netsuite
    type: left_outer
    sql_on: ${dt_all_accounts_and_accounting_periods.account_id} = ${accounts.account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: parent_account {
    from: accounts_netsuite
    sql_on: ${accounts.parent_id} = ${parent_account.account_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: accounting_periods {
    type: left_outer
    sql_on: ${dt_all_accounts_and_accounting_periods.accounting_period_id} = ${accounting_periods.accounting_period_id} ;;
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
    sql_on: ${dt_all_accounts_and_accounting_periods.department_id} = ${departments.department_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }
  join: subsidiaries {
    type: left_outer
    sql_on: ${transaction_lines.subsidiary_id} = ${subsidiaries.subsidiary_id} ;;
    relationship: many_to_one #TODO AJC needs confirmation
  }

  join: customer_budget {
    from: budget
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${customer_budget.customer_id}
    and ${dt_all_accounts_and_accounting_periods.accounting_period_id} = ${customer_budget.accounting_period_id}
    and not ${customer_budget._fivetran_deleted};;
    relationship: many_to_many
  }

  join: budget {
    from:  budget
    type: left_outer
          sql_on: ${dt_all_accounts_and_accounting_periods.account_id} = ${budget.account_id}
          and ${dt_all_accounts_and_accounting_periods.accounting_period_id} = ${budget.accounting_period_id}
          and ${dt_all_accounts_and_accounting_periods.department_id} = ${budget.department_id}
          and not ${budget._fivetran_deleted};;
    relationship: many_to_one
  }

  join: budget_category {
    type: left_outer
    sql_on: ${budget.category_id} = ${budget_category.budget_category_id};;
    relationship: many_to_one
  }

  join: customer_cohorts_facts {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${customer_cohorts_facts.customer_id}
      and not ${customers._fivetran_deleted} ;;
    relationship: one_to_one
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

  join: gateway_summary {
    type: left_outer
    sql_on: ${gateways.gateway_type} = ${gateway_summary.heroku_gateway_type};;
    relationship: many_to_one
  }

  join: monthly_org_partner_gateway_transactions{
    type: left_outer
    sql_on:${monthly_org_partner_gateway_transactions.netsuite_gateway_type}=${gateway_summary.netsuite_gateway_type}
      And ${monthly_org_partner_gateway_transactions.organization_key} = ${customers.spreedly_billing_id}
      And ${monthly_org_partner_gateway_transactions.created_month}=${accounting_periods.ending_month} ;;
    relationship: many_to_one
  }


  join: monthly_partner_gateway_transactions{
    type: left_outer
    sql_on:${monthly_org_partner_gateway_transactions.netsuite_gateway_type}=${gateway_summary.netsuite_gateway_type}
      And ${monthly_org_partner_gateway_transactions.created_month}=${accounting_periods.ending_month} ;;
    relationship: many_to_one
  }

join: account_salesforce {
  type: left_outer
  sql_on: ${organizations.key} = ${account_salesforce.billing_org_id_c} ;;
  relationship: many_to_one
}

  join: user_salesforce{
    type: left_outer
    sql_on: ${account_salesforce.owner_id} = ${user_salesforce.id} ;;
    relationship: many_to_one
  }


# join: customer_activity {
#   type: left_outer
#   sql_on: ${transactions_spreedly.key} = ${customer_activity.transaction_token};;
# relationship: many_to_one
# }

}

explore: +transaction_lines {
  join: top_customers_by_subscription_and_usage {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${top_customers_by_subscription_and_usage.customer_id} ;;
    relationship: many_to_one
  }

  join: top_customers_by_all_revenue {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${top_customers_by_all_revenue.customer_id} ;;
    relationship: many_to_one
  }

  join: top_gateways {
    type: left_outer
    sql_on: ${transaction_lines.company_id} = ${top_gateways.customer_id} ;;
    relationship: many_to_one
  }
}


# Place in `netsuite_spreedly` model
# Place in `netsuite_spreedly` model
explore: +transaction_lines {
  aggregate_table: rollup__accounting_periods_ending_month__classes_name__customers_customer_company_name {
    query: {
      dimensions: [accounting_periods.ending_month, classes.name, customers.customer_company_name]
      measures: [monthly_org_indirect_revenue.indirect_revenue, monthly_org_indirect_revenue.total_revenue, transaction_lines.sum_transaction_amount]
      filters: [
        accounting_periods.ending_month: "3 months ago for 3 months",
        accounts.type_name: "Income,Other Income",
        classes.name: "Enterprise,MtM",
        transaction_lines.is_transaction_non_posting: "No"
      ]
    }

    materialization: {
      datagroup_trigger: whitelist_etl
    }
  }
}
