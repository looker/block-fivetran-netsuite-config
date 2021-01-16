# If necessary, uncomment the line below to include explore_source.
# include: "netsuite_spreedly.model.lkml"


  view: monthly_gateway_partner_revenue {

    derived_table: {
      explore_source: transaction_lines {
        column: gateway_type { field: customers.gateway_type }
        column: ending_month { field: accounting_periods.ending_month }
        column: sum_transaction_amount {}

        filters: {
          field: accounts.type_name
          value: "Income,Other Income"
        }

        filters: {
          field: transaction_lines.is_transaction_non_posting
          value: "No"
        }
    }
    }

    dimension: primary_key {
      sql: ${gateway_type}||${ending_month} ;;
      primary_key: yes
    }

    dimension: gateway_type {}

    dimension: ending_month {
      type: date_month
    }

# what is this support to be capturing? Revenue?
    dimension: sum_transaction_amount {
      value_format: "$#,##0"
      type: number
      # sql: where ${income_accounts.is_income_account} = 'yes'
      # and where ${transaction_lines.is_transaction_non_posting} = 'no';;
    }

    # add the case and boolean and new numerator and denominator... add up revenue
    #implementation of flag (view: gateway_rev_share_type... field:rev_share_type - either. create new table. join on table for creating boolean flag....
    # MFJ 1/12/20 add Gateway rev share tye as table and new Revneue columns to NDTs..

    dimension:  indirect_revenue_ratio{
    hidden: no
    type: number
    sql:  case when ${monthly_org_partner_gateway_transactions.rev_share_type} = 'tsx' then ${monthly_org_partner_gateway_transactions.count}/${monthly_partner_gateway_transactions.count}
    when ${monthly_org_partner_gateway_transactions.rev_share_type} = 'rev' then ${monthly_org_partner_gateway_transactions.topline_revenue}/${monthly_partner_gateway_transactions.topline_revenue}
    else 0 end;;
    }

    dimension: indirect_revenue {
      type: number
      sql: ${sum_transaction_amount}*${indirect_revenue_ratio} ;;
      drill_fields: [monthly_org_partner_gateway_transactions.count,monthly_org_partner_gateway_transactions.topline_revenue,monthly_org_partner_gateway_transactions.count,gateway_type,sum_transaction_amount ]

    }

    measure: total_indirect_revenue {
      type: sum
      sql: ${indirect_revenue} ;;
    drill_fields: [monthly_org_partner_gateway_transactions.count,monthly_org_partner_gateway_transactions.topline_revenue,monthly_org_partner_gateway_transactions.count,gateway_type,sum_transaction_amount ]

    }

   measure: count {
      type: count
    }


  }
