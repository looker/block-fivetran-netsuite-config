include: "/views/transaction_lines.view"
#This view is used to store any parameters, dimensions and measures specifically
# used for the Top Customers and Top Gateways of the monthly board package

view: +transaction_lines {
  dimension: is_ytd_through_eom {
    view_label: "Top Customers and Gateways"
    type: yesno
    sql: EXTRACT(MONTH FROM ${accounting_periods.ending_raw}) < EXTRACT(MONTH from CURRENT_DATE())
      AND EXTRACT(YEAR FROM ${accounting_periods.ending_raw}) = EXTRACT(YEAR from CURRENT_DATE());;
  }

  dimension: is_ytd_through_eom_last_year {
    view_label: "Top Customers and Gateways"
    type: yesno
    sql: EXTRACT(MONTH FROM ${accounting_periods.ending_raw}) < EXTRACT(MONTH from CURRENT_DATE())
      AND EXTRACT(YEAR FROM ${accounting_periods.ending_raw})+1 = EXTRACT(YEAR from CURRENT_DATE());;
  }

  measure: sum_transaction_amount_ytd_through_eom {
    view_label: "Top Customers and Gateways"
    label: "Revenue YTD"
    group_label: "Actuals"
    type: sum
    value_format_name: usd_0
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [is_ytd_through_eom: "Yes"]
    drill_fields: [transaction_lines..detail*]
  }

  measure: budget_sum_amount_ytd_through_eom  {
    view_label: "Top Customers and Gateways"
    label: "YTD Plan through Recent EOM"
    group_label: "Budget"
    type: sum_distinct
    sql_distinct_key: ${customer_budget.budget_id} ;;
    value_format_name: usd_0
    sql: ${customer_budget.amount} ;;
    filters: [is_ytd_through_eom: "Yes", customer_budget.category_id: "3"]
  }

  measure: sum_transaction_amount_ytd_through_eom_last_year {
    view_label: "Top Customers and Gateways"
    label: "Revenue YTD Last Year"
    group_label: "Actuals"
    type: sum
    value_format_name: usd_0
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [is_ytd_through_eom_last_year: "Yes"]
    drill_fields: [transaction_lines..detail*]
  }

  measure: budget_variance_ytd_through_eom {
    view_label: "Top Customers and Gateways"
    label: "Variance to Plan ($ Change)"
    group_label: "Variance"
    type: number
    value_format_name: usd_0
    sql: ${sum_transaction_amount_ytd_through_eom} - ${budget_sum_amount_ytd_through_eom} ;;
  }

  measure: budget_variance_pct_ytd_through_eom {
    view_label: "Top Customers and Gateways"
    label: "Variance to Plan (%)"
    group_label: "Variance"
    type: number
    value_format_name: percent_0
    sql: ${budget_variance_ytd_through_eom} / NULLIF(${budget_sum_amount_ytd_through_eom},0) ;;
  }

  measure: yoy_variance_ytd_through_eom {
    view_label: "Top Customers and Gateways"
    label: "YoY Growth ($ Change)"
    group_label: "Variance"
    type: number
    value_format_name: usd_0
    sql: ${sum_transaction_amount_ytd_through_eom} - ${sum_transaction_amount_ytd_through_eom_last_year} ;;
  }

  measure: yoy_variance_pct_ytd_through_eom {
    view_label: "Top Customers and Gateways"
    label: "YoY Growth (%)"
    group_label: "Variance"
    type: number
    value_format_name: percent_0
    sql: ${yoy_variance_ytd_through_eom} / NULLIF(${sum_transaction_amount_ytd_through_eom_last_year},0) ;;
  }
}


view: top_customers_by_subscription_and_usage {
  derived_table: {
    explore_source: transaction_lines {
      column: name { field: customers.name }
      column: customer_id { field: customers.customer_id }
      column: sum_transaction_amount_ytd_through_eom {}
      derived_column: customer_rank {
        sql: row_number() over(order by sum_transaction_amount_ytd_through_eom desc) ;;
      }
      filters: {
        field: transaction_lines.is_transaction_non_posting
        value: "No"
      }
      filters: {
        field: income_accounts.is_income_account
        value: "Yes"
      }
      filters: {
        field: budget_category.name
        value: "Annual Budget,null"
      }
      filters: {
        field: income_accounts.name
        value: "ENT API Call Usage,Contract Subscription Revenue,ENT Other Usage,MtM Subscription Revenue,MtM API Call Usage,MtM Other Usage"
      }
      filters: {
        field: accounting_periods.ending_month
        value: "1 years"
      }
      limit: 25
      sorts: [transaction_lines.sum_transaction_amount_ytd_through_eom: desc]
    }
  }
  dimension: customer_id {
    view_label: "Top Customers and Gateways"
    hidden: yes
    type: number
    primary_key: yes
  }
  dimension: customer_rank_by_subscription_and_usage {
    view_label: "Top Customers and Gateways"
    type: number
    sql: ${TABLE}.customer_rank ;;
  }
  dimension: is_top_25_customer_by_subscription_and_usage {
    view_label: "Top Customers and Gateways"
    type: yesno
    sql: ${customer_id} is not null ;;
  }
}



view: top_customers_by_all_revenue {
  derived_table: {
    explore_source: transaction_lines {
      column: name { field: customers.name }
      column: customer_id { field: customers.customer_id }
      column: sum_transaction_amount_ytd_through_eom {}
      derived_column: customer_rank {
        sql: row_number() over(order by sum_transaction_amount_ytd_through_eom desc) ;;
      }
      filters: {
        field: transaction_lines.is_transaction_non_posting
        value: "No"
      }
      filters: {
        field: income_accounts.is_income_account
        value: "Yes"
      }
      filters: {
        field: budget_category.name
        value: "Annual Budget"
      }
      filters: {
        field: income_accounts.name
        value: "-SGP Revenue Share,-SGP Annual Membership Fee,-PGP Revenue Share"
      }
      filters: {
        field: accounting_periods.ending_month
        value: "1 years"
      }
      limit: 25
      sorts: [transaction_lines.sum_transaction_amount_ytd_through_eom: desc]
    }
  }
  dimension: customer_id {
    view_label: "Top Customers and Gateways"
    hidden: yes
    type: number
    primary_key: yes
  }
  dimension: customer_rank_by_all_revenue {
    view_label: "Top Customers and Gateways"
    type: number
    sql: ${TABLE}.customer_rank ;;
  }
  dimension: is_top_25_customer_by_all_revenue {
    view_label: "Top Customers and Gateways"
    type: yesno
    sql: ${customer_id} is not null ;;
  }
}




view: top_gateways {
  derived_table: {
    explore_source: transaction_lines {
      column: name { field: customers.name }
      column: customer_id { field: customers.customer_id }
      column: sum_transaction_amount_ytd_through_eom {}
      derived_column: customer_rank {
        sql: row_number() over(order by sum_transaction_amount_ytd_through_eom desc) ;;
      }
      filters: {
        field: transaction_lines.is_transaction_non_posting
        value: "No"
      }
      filters: {
        field: income_accounts.is_income_account
        value: "Yes"
      }
      filters: {
        field: income_accounts.name
        value: "SGP Revenue Share,SGP Annual Membership Fee,PGP Revenue Share"
      }
      filters: {
        field: accounting_periods.ending_date
        value: "1 years"
      }
      limit: 25
      sorts: [transaction_lines.sum_transaction_amount_ytd_through_eom: desc]
    }
  }
  dimension: customer_id {
    hidden: yes
    view_label: "Top Customers and Gateways"
    type: number
    primary_key: yes
  }
  dimension: gateway_rank {
    view_label: "Top Customers and Gateways"
    type: number
    sql: ${TABLE}.customer_rank ;;
  }
  dimension: is_top_25_gateway {
    view_label: "Top Customers and Gateways"
    type: yesno
    sql: ${customer_id} is not null ;;
  }
}
