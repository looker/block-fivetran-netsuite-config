connection: "@{CONNECTION_NAME}" #this needs to be personalized

include: "*.view.lkml"

explore: balance_sheet_config {
  extends: [balance_sheet_core]
  extension: required
}

explore: income_statement_config {
  extends: [income_statement_core]
  extension: required
}

explore: transaction_details_config {
  extends: [transaction_details_core]
  extension: required
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
