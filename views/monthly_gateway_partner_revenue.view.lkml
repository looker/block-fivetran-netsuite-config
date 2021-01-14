# If necessary, uncomment the line below to include explore_source.
# include: "netsuite_spreedly.model.lkml"


  view: monthly_gateway_partner_revenue {

    derived_table: {
      explore_source: transaction_lines {
        column: gateway_type { field: customers.gateway_type }
        column: ending_month { field: accounting_periods.ending_month }
        column: sum_transaction_amount {}

      }
    }

    # filters: {
    #   field: accounts.type_name
    #   value: "Income,Other Income"
    # }

    # filters: {
    #   field: transaction_lines.is_transaction_non_posting
    #   value: "No"
    # }

    # filters: {
    #   field: accounts.name
    #   value: "SGP Annual Membership Fee,SGP Revenue Share,PGP Revenue Share"
    # }

    dimension: primary_key {
      sql: ${gateway_type}||${ending_month} ;;
      primary_key: yes
    }

    dimension: gateway_type {}

    dimension: ending_month {
      type: date_month
    }

    dimension: sum_transaction_amount {
      value_format: "$#,##0.00"
      type: number
    }

    # add the case and boolean and new numerator and denominator... add up revenue
    #implementation of flag (view: gateway_rev_share_type... field:rev_share_type - either. create new table. join on table for creating boolean flag....
    # MFJ 1/12/20 add Gateway rev share tye as table and new Revneue columns to NDTs..

    dimension:  indirect_revenue_ratio{
    hidden: yes
    type: number
    sql:  case when ${monthly_org_partner_gateway_transactions.rev_share_type} = 'tsx' then ${monthly_org_partner_gateway_transactions.count}/${monthly_partner_gateway_transactions.count}
    when ${monthly_org_partner_gateway_transactions.rev_share_type} = 'rev' then ${monthly_org_partner_gateway_transactions.topline_revenue}/${monthly_partner_gateway_transactions.topline_revenue}
    else 0 end;;
    # sql: ${monthly_org_partner_gateway_transactions.count}/${monthly_partner_gateway_transactions.count} ;;
    }

    dimension: indirect_revenue {
      type: number
      sql: ${sum_transaction_amount}*${indirect_revenue_ratio} ;;
    }

    measure: total_indirect_revenue {
      type: sum
      sql: ${indirect_revenue} ;;
    }

   measure: count {
      type: count
    }


  }
