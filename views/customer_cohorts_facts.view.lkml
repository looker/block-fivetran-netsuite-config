# If necessary, uncomment the line below to include explore_source.
# include: "transaction_lines.explore.lkml"

view: customer_cohorts_facts {
    derived_table: {
      explore_source: transaction_lines {
        column: customer_id { field: customers.customer_id }
        column: min_create_date {}
      }
    }
    dimension: customer_id {
      type: number
    }
    dimension: min_create_date {
      type: number
    }

    dimension_group: customer_age {
      type: duration
      intervals: [month]
      sql_start: ${min_create_date} ;;
      sql_end: ${transaction_lines.date_created_raw} ;;
    }
  }
