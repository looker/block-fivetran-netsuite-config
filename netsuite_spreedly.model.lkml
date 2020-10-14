connection: "@{CONNECTION_NAME}" #this needs to be personalized

include: "//block-fivetran-netsuite-spreedly/*.view"
include: "//block-fivetran-netsuite-spreedly/views/*.view"

include: "//block-fivetran-netsuite-spreedly/*.explore"
include: "//block-fivetran-netsuite-spreedly/*.dashboard"
include: "*.view.lkml"

explore: balance_sheet {
  extends: [balance_sheet_core]
}

explore: income_statement {
  extends: [income_statement_core]
}

explore: transaction_details {
  extends: [transaction_details_core]
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
