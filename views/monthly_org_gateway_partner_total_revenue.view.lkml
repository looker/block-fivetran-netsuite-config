
# If necessary, uncomment the line below to include explore_source.
# include: "netsuite_spreedly.model.lkml"

view: monthly_org_gateway_partner_total_revenue {
    derived_table: {
      explore_source: monthly_org_partner_gateway_transactions {
        column: organization_key {}
        column: ending_month { field: monthly_gateway_partner_revenue.ending_month }
        column: total_indirect_revenue { field: monthly_gateway_partner_revenue.total_indirect_revenue }
        column: gateway_type { field: monthly_gateway_partner_revenue.gateway_type }

        filters: {
          field: monthly_gateway_partner_revenue.ending_month
          value: "2 months ago for 2 months"
        }
      }
    }
    dimension: organization_key {
      description: "Unique key to identify a customer in Heroku"
    }
    dimension: ending_month {
      type: date_month
    }
    dimension: total_indirect_revenue {
      type: number
    }
    dimension: gateway_type {}

    # meed to add a measure for indirect and direct revenue here?
    measure: total_revenue {
      type: sum
      drill_fields: [gateway_type,ending_month,transactions.sum_transaction_amount,monthly_partner_gateway_transactions.percent_of_monthly_gateway_transactions]
      sql: ${total_indirect_revenue}+${transaction_lines.sum_transaction_amount} ;;
    }

  }
