# If necessary, uncomment the line below to include explore_source.
# include: "transaction_lines.explore.lkml"

view: customer_cohorts_facts {
    derived_table: {
      explore_source: transaction_lines {
        column: customer_id { field: customers.customer_id }
        column: first_transaction_date {}
        column: first_transaction_month {}
      }
    }
    dimension: customer_id {
      type: number
    }
    dimension: first_transaction_date {
      type: number
    }

  dimension: first_transaction_month {
    type: date
  }

    dimension_group: customer_age {
      type: duration
      intervals: [day, month]
      sql_start: ${first_transaction_date} ;;
      sql_end: ${transaction_lines.date_created_raw} ;;
    }
  }
