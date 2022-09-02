view: active_customer_count {
# If necessary, uncomment the line below to include explore_source.
# include: "transaction_lines.explore.lkml"

    derived_table: {
      explore_source: transaction_lines {
        column: name { field: customers.name }
        column: customer_id { field: customers.customer_id }
        column: sum_transaction_amount {}
        column: ending_month { field: accounting_periods.ending_month }
        column: ending_date { field: accounting_periods.ending_date }
        filters: {
          field: income_accounts.is_income_account
          value: "Yes"
        }
        filters: {
          field: income_accounts.name
          value: "ENT API Call Usage,Contract Subscription Revenue,ENT Other Usage,MtM Subscription Revenue,MtM API Call Usage,MtM Other Usage"
        }
      }
    }

    dimension: name {}

    dimension: customer_id {
      primary_key: yes
      type: number
    }

    dimension: sum_transaction_amount {
      description: "Calculate the amount of Revenue for a given item or customer in a given month"
      value_format: "$#,##0.00"
      type: number
    }


    dimension: ending_month {
      type: date_month
    }

  dimension: ending_date {
    type: date
  }

  measure: active_customer_count {
    type: count_distinct
    sql: case when ${sum_transaction_amount} > 0 then ${customer_id} end ;;
  }

  measure: total_customer_count {
    type: count_distinct
    sql:${customer_id} ;;
  }

  dimension: one_month_ago {
    type: date_month
    sql: add_months(${ending_date}, -1) ;;
  }

  dimension: two_months_ago {
    type: date_month
    sql: add_months(${ending_date}, -2) ;;
  }

  dimension: next_month {
    type: date_month
    sql: add_months(${ending_date}, 1) ;;
  }

  measure: revenue_previous_month {
    type: number
    sql: LAG (${sum_transaction_amount}, 1, NULL) OVER (ORDER BY ${ending_month}) ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_two_months_ago {
    type: number
    sql: LAG (${sum_transaction_amount}, 2, NULL) OVER (ORDER BY ${ending_month}) ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_next_month {
    type: number
    sql: LAG (${sum_transaction_amount}, -1, NULL) OVER (ORDER BY ${ending_month}) ;;
    value_format: "$#,##0.00"
  }

  measure: revenue_this_month {
    type: number
    sql: ${sum_transaction_amount} ;;
    value_format: "$#,##0.00"
  }


  }
