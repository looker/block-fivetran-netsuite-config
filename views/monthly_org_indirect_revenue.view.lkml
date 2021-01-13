view: monthly_org_indirect_revenue {
  derived_table: {
      explore_source: monthly_org_partner_gateway_transactions {
        column: created_month {}
        # column: gateway_type {}
        column: organization_key {}
        column: total_indirect_revenue {field:monthly_gateway_partner_revenue.total_indirect_revenue}
        # column: sum_transaction_amount { field: monthly_gateway_partner_revenue.sum_transaction_amount }
        # column: transactions_per_org_gateway {field:monthly_org_partner_gateway_transactions.count}
        # column: transactions_per_gateway { field: monthly_partner_gateway_transactions.count }
        # derived_column:  thing {
        #   sql: sum(sum_transaction_amount*transactions_per_org_gateway/transactions_per_gateway) over (partition by organization_key) ;;
        # }
      }
    }

    dimension: primary_key {
      type: string
      primary_key: yes
      sql: ${organization_key}||${created_month} ;;
      hidden: yes
    }

    dimension: created_month {
      hidden: yes
      description: "Transaction created Date/Time"
      type: date_month
    }

    dimension: organization_key {
      hidden: yes
      description: "Unique key to identify a customer in Heroku"
    }

    dimension: total_indirect_revenue_raw {
      type: number
      sql: ${TABLE}.total_indirect_revenue ;;
      hidden: yes
    }

    measure: indirect_revenue {
      description: "Cannot be used below a monthly+Org grain. Quarterly is OK, daily is not."
      type: sum
      sql: ${total_indirect_revenue_raw} ;;
    }

  measure: total_revenue {
    type: number
    value_format_name: usd
    sql: ${transaction_lines.sum_transaction_amount}+${indirect_revenue} ;;
  }

  }

# dimension: indirect_revenue{
#   description: "Calculate the Indirect revenue for all organizations taking % of total GW TSX * Total GW Revenue"
#   value_format: "$#,##0.00"
#   type: number
#   sql: 1.0*${sum_transaction_amount}*${monthly_partner_gateway_transactions.percent_of_monthly_gateway_transactions};;
# }

# measure:total_indirect_revenue{
#   type: sum
#   drill_fields: [gateway_type,ending_month,sum_transaction_amount,monthly_partner_gateway_transactions.percent_of_monthly_gateway_transactions]
#   sql: ${indirect_revenue} ;;
# }
