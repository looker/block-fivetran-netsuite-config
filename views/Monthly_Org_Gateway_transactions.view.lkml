# If necessary, uncomment the line below to include explore_source.
# include: "netsuite_spreedly.model.lkml"

view: monthly_org_gateway_transactions {

    derived_table: {
      explore_source: transaction_lines {
        column: gateway_type { field: customers.gateway_type }
        column: spreedly_billing_id { field: customers.spreedly_billing_id }
        column: ending_month { field: accounting_periods.ending_month }
        column: name { field: accounts.name }
        column: sum_transaction_amount {}
        filters: {
          field: accounting_periods.ending_month
          value: "3 months ago for 3 months"
        }
        filters: {
          field: accounts.name
          value: "MtM API Call Usage"
        }
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
    dimension: gateway_type {}
    dimension: spreedly_billing_id {}
    dimension: ending_month {
      type: date_month
    }
    dimension: name {}
    dimension: sum_transaction_amount {
      value_format: "$#,##0.00"
      type: number
    }
  }
