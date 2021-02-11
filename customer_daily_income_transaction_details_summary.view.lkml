
view: customer_daily_income_transaction_details_summary {

    derived_table: {
      # datagroup_trigger: transaction_lines
      explore_source: income_transaction_details {
        column: customer_extid { field: customers.customer_extid }
        column: transaction_date { field: transactions.transaction_date }
        column: sum_transaction_converted_amount { field: transactions_with_converted_amounts.sum_transaction_converted_amount }
      }
    }
    dimension: primary_key {
      hidden: yes
      primary_key: yes
      sql: ${customer_extid}||${transaction_raw} ;;
    }
    dimension: customer_extid {}
    dimension_group: transaction {
      timeframes: [raw,date,month,quarter,year]
      type: time
      sql: ${TABLE}.transaction_date ;;
    }
    dimension: sum_transaction_converted_amount_raw {
      value_format: "$#,##0.00"
      hidden: yes
      type: number
      sql: ${TABLE}.sum_transaction_converted_amount ;;
    }
    measure: transaction_converted_amount {
      value_format: "$#,##0.00"
      type: sum
      sql: ${sum_transaction_converted_amount_raw} ;;
    }
  }
