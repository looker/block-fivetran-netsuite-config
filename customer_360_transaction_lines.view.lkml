include: "/explores/transaction_lines.explore.lkml"

view: customer_360_transaction_lines {
  derived_table: {
    explore_source: transaction_lines {
      column: sum_transaction_amount {}
      column: indirect_revenue { field: monthly_org_indirect_revenue.indirect_revenue }
      column: ending_date { field: accounting_periods.ending_date }
      column: ending_year { field: accounting_periods.ending_year }
      column: ending_month { field: accounting_periods.ending_month }
      column: name {field:account_salesforce.name}
      filters: {
        field: accounting_periods.ending_month
        value: "2 years"
      }
      filters: {
        field: income_accounts.is_income_account
        value: "Yes"
      }
      filters: {
        field: account_salesforce.account_stage_c
        value: "Active Customer,Prior Customer,SQA,SAA,MQA,MAA"
      }
      filters: {
        field: account_salesforce.is_deleted
        value: "No"
      }
    }
    datagroup_trigger: daily
  }
  dimension: sum_transaction_amount {
    type: number
  }
  dimension: indirect_revenue {
    description: "Cannot be used below a monthly+Org grain. Quarterly is OK, daily is not."
    type: number
  }
  dimension: ending_date {
    type: date
  }
  dimension: ending_year {
    type: date_year
  }
  dimension: ending_month {
    type: date_month
  }
  dimension: name {}

  measure: sum_transaction_amount_measure {
    type: max
    sql: ${sum_transaction_amount} ;;
    value_format: "$#,##0.00"
  }

  measure: indirect_revenue_measure {
    type: max
    sql: ${indirect_revenue} ;;
    value_format: "$#,##0.00"
  }
}
