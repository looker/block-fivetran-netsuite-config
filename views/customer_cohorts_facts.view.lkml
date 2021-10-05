# If necessary, uncomment the line below to include explore_source.
# include: "transaction_lines.explore.lkml"

view: customer_cohorts_facts {
    derived_table: {
      explore_source: transaction_lines {
        column: customer_id { field: customers.customer_id }
        column: first_transaction_date {}

       filters: {
          field: transaction_lines.is_transaction_non_posting
          value: "No"
        }
      }
    }
    dimension: customer_id {
      primary_key: yes
      type: number
    }

    dimension: first_transaction_date {
      type: date_raw
    }

  dimension_group: first_transaction_month{
    type: time
    timeframes: [
      day_of_year,
      month
      ]
    sql: ${first_transaction_date} ;;
  }


    dimension_group: customer_age {
      type: duration
      intervals: [day, month]
      sql_start: ${first_transaction_date} ;;
      sql_end: ${transaction_lines.date_created_raw} ;;
    }
  }

# Step 1: create the min create date for cohort
#   measure: min_create_date {
#     type: date
#     sql: min(${transaction_raw}) ;;
#   }
# Step 2: create a native derived (customer cohort fact) with 2 columns: customer id, min_create_date
# Step 3: create a dimension_group of type duration called customer age
# Start date = cohort date
# End date = transaction_raw (date) <<<
# Days from when they became cohort
# Specify internal - months
