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

  }
