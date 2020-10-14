connection: "@{CONNECTION_NAME}" #this needs to be personalized

include: "//block-fivetran-netsuite-spreedly/*.view"
include: "//block-fivetran-netsuite-spreedly/views/*.view"

include: "//block-fivetran-netsuite-spreedly/*.explore"
# include: "//block-fivetran-netsuite-spreedly/accounts_payable.dashboard"
# include: "//block-fivetran-netsuite-spreedly/accounts_receivable.dashboard"
include: "//block-fivetran-netsuite-spreedly/balance_sheet.dashboard"
include: "//block-fivetran-netsuite-spreedly/income_statement.dashboard"
include: "//block-fivetran-netsuite-spreedly/sales.dashboard"
# include: "//block-fivetran-netsuite-spreedly/expenses_.dashboard"

include: "*.view.lkml"

explore: balance_sheet {
  extends: [balance_sheet_core]
}

explore: income_statement {
  extends: [income_statement_core]
}

# explore: transaction_details {
#   extends: [transaction_details_core]
# }

explore: +transaction_lines {
  description: "this is the right transaction lines"
}

# explore: balance_sheet {
#   extends: [balance_sheet_core]
# }

# explore: income_statement {
#   extends: [income_statement_core]
# }

# explore: transaction_details {
#   extends: [transaction_details_core]
# }
