view: transaction_lines {
  sql_table_name: @{SCHEMA_NAME}."TRANSACTION_LINES"
    ;;
  drill_fields: [transaction_line_id]

  dimension: unique_key {
    primary_key: yes
    type: number
    sql: ${TABLE}."UNIQUE_KEY" ;;
  }

  dimension: transaction_line_id {
    type: number
    sql: ${TABLE}."TRANSACTION_LINE_ID" ;;
  }


  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."_FIVETRAN_SYNCED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}."ACCOUNT_ID" ;;
  }

  dimension: adjustment_field {
    type: string
    sql: ${TABLE}."ADJUSTMENT_FIELD" ;;
  }

  dimension: adjustment_tax_code_id {
    type: number
    sql: ${TABLE}."ADJUSTMENT_TAX_CODE_ID" ;;
  }

  dimension: alt_sales_amount {
    type: number
    sql: ${TABLE}."ALT_SALES_AMOUNT" ;;
  }

  dimension: amortization_residual {
    type: string
    sql: ${TABLE}."AMORTIZATION_RESIDUAL" ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}."AMOUNT" ;;
  }

  dimension: transaction_amount {
    type: number
    sql: case
          when lower(${accounts.type_name}) = 'income' or lower(${accounts.type_name}) = 'other income' then -${amount}
          else ${amount}
          end ;;
  }

  dimension: amount_foreign {
    type: number
    sql: ${TABLE}."AMOUNT_FOREIGN" ;;
  }

  dimension: amount_foreign_linked {
    type: number
    sql: ${TABLE}."AMOUNT_FOREIGN_LINKED" ;;
  }

  dimension: amount_linked {
    type: number
    sql: ${TABLE}."AMOUNT_LINKED" ;;
  }

  dimension: amount_pending {
    type: number
    sql: ${TABLE}."AMOUNT_PENDING" ;;
  }

  dimension: amount_settlement {
    type: number
    sql: ${TABLE}."AMOUNT_SETTLEMENT" ;;
  }

  dimension: amount_taxable {
    type: number
    sql: ${TABLE}."AMOUNT_TAXABLE" ;;
  }

  dimension: amount_taxed {
    type: number
    sql: ${TABLE}."AMOUNT_TAXED" ;;
  }

  dimension: annual_prorate {
    type: number
    sql: ${TABLE}."ANNUAL_PRORATE" ;;
  }

  dimension: bill_variance_status {
    type: string
    sql: ${TABLE}."BILL_VARIANCE_STATUS" ;;
  }

  dimension: billing_schedule_id {
    type: number
    sql: ${TABLE}."BILLING_SCHEDULE_ID" ;;
  }

  dimension: billing_subsidiary_id {
    type: number
    sql: ${TABLE}."BILLING_SUBSIDIARY_ID" ;;
  }

  dimension: bom_quantity {
    type: number
    sql: ${TABLE}."BOM_QUANTITY" ;;
  }

  dimension: catch_up_period_id {
    type: number
    sql: ${TABLE}."CATCH_UP_PERIOD_ID" ;;
  }

  dimension: charge_rule_id {
    type: number
    sql: ${TABLE}."CHARGE_RULE_ID" ;;
  }

  dimension: charge_type {
    type: number
    sql: ${TABLE}."CHARGE_TYPE" ;;
  }

  dimension: chargify_line_item_tax {
    type: number
    sql: ${TABLE}."CHARGIFY_LINE_ITEM_TAX" ;;
  }

  dimension: class_id {
    type: number
    sql: ${TABLE}."CLASS_ID" ;;
  }

  dimension: code_of_supply_id {
    type: number
    sql: ${TABLE}."CODE_OF_SUPPLY_ID" ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}."COMPANY_ID" ;;
  }

  dimension: component_id {
    type: number
    sql: ${TABLE}."COMPONENT_ID" ;;
  }

  dimension: component_yield {
    type: number
    sql: ${TABLE}."COMPONENT_YIELD" ;;
  }

  dimension: cost_estimate_type {
    type: string
    sql: ${TABLE}."COST_ESTIMATE_TYPE" ;;
  }

  dimension: counterparty_vat_number {
    type: string
    sql: ${TABLE}."COUNTERPARTY_VAT_NUMBER" ;;
  }

  dimension: country_of_origin {
    type: string
    sql: ${TABLE}."COUNTRY_OF_ORIGIN" ;;
  }

  dimension: country_of_origin_code {
    type: string
    sql: ${TABLE}."COUNTRY_OF_ORIGIN_CODE" ;;
  }

  dimension_group: date_cleared {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_CLEARED" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_closed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_CLOSED" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_CREATED" AS TIMESTAMP_NTZ) ;;
  }


  dimension_group: date_deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_DELETED" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_LAST_MODIFIED" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_last_modified_gmt {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_LAST_MODIFIED_GMT" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_requested {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_REQUESTED" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_revenue_committed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."DATE_REVENUE_COMMITTED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: delay_rev_rec {
    type: string
    sql: ${TABLE}."DELAY_REV_REC" ;;
  }

  dimension: department_id {
    type: number
    sql: ${TABLE}."DEPARTMENT_ID" ;;
  }

  dimension: details_of_subject_and_exem_id {
    type: number
    sql: ${TABLE}."DETAILS_OF_SUBJECT_AND_EXEM_ID" ;;
  }

  dimension: do_not_display_line {
    type: string
    sql: ${TABLE}."DO_NOT_DISPLAY_LINE" ;;
  }

  dimension: do_not_print_line {
    type: string
    sql: ${TABLE}."DO_NOT_PRINT_LINE" ;;
  }

  dimension: do_restock {
    type: string
    sql: ${TABLE}."DO_RESTOCK" ;;
  }

  dimension: emirate_id {
    type: number
    sql: ${TABLE}."EMIRATE_ID" ;;
  }

  dimension: establishment_code {
    type: string
    sql: ${TABLE}."ESTABLISHMENT_CODE" ;;
  }

  dimension: estimated_cost {
    type: number
    sql: ${TABLE}."ESTIMATED_COST" ;;
  }

  dimension: estimated_cost_foreign {
    type: number
    sql: ${TABLE}."ESTIMATED_COST_FOREIGN" ;;
  }

  dimension: eu_triangulation {
    type: string
    sql: ${TABLE}."EU_TRIANGULATION" ;;
  }

  dimension_group: expected_receipt {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."EXPECTED_RECEIPT_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: expense_account_id {
    type: number
    sql: ${TABLE}."EXPENSE_ACCOUNT_ID" ;;
  }

  dimension: expense_category_id {
    type: number
    sql: ${TABLE}."EXPENSE_CATEGORY_ID" ;;
  }

  dimension: gl_number {
    type: string
    sql: ${TABLE}."GL_NUMBER" ;;
  }

  dimension: gl_sequence {
    type: string
    sql: ${TABLE}."GL_SEQUENCE" ;;
  }

  dimension: gl_sequence_id {
    type: number
    sql: ${TABLE}."GL_SEQUENCE_ID" ;;
  }

  dimension: gross_amount {
    type: number
    sql: ${TABLE}."GROSS_AMOUNT" ;;
  }

  dimension: has_cost_line {
    type: string
    sql: ${TABLE}."HAS_COST_LINE" ;;
  }

  dimension: is_allocation {
    type: string
    sql: ${TABLE}."IS_ALLOCATION" ;;
  }

  dimension: is_amortization_rev_rec {
    type: string
    sql: ${TABLE}."IS_AMORTIZATION_REV_REC" ;;
  }

  dimension: is_commitment_confirmed {
    type: string
    sql: ${TABLE}."IS_COMMITMENT_CONFIRMED" ;;
  }

  dimension: is_cost_line {
    type: string
    sql: ${TABLE}."IS_COST_LINE" ;;
  }

  dimension: is_custom_line {
    type: string
    sql: ${TABLE}."IS_CUSTOM_LINE" ;;
  }

  dimension: is_exclude_from_rate_request {
    type: string
    sql: ${TABLE}."IS_EXCLUDE_FROM_RATE_REQUEST" ;;
  }

  dimension: is_fx_variance {
    type: string
    sql: ${TABLE}."IS_FX_VARIANCE" ;;
  }

  dimension: is_item_value_adjustment {
    type: string
    sql: ${TABLE}."IS_ITEM_VALUE_ADJUSTMENT" ;;
  }

  dimension: is_landed_cost {
    type: string
    sql: ${TABLE}."IS_LANDED_COST" ;;
  }

  dimension: is_scrap {
    type: string
    sql: ${TABLE}."IS_SCRAP" ;;
  }

  dimension: is_vsoe_allocation_line {
    type: string
    sql: ${TABLE}."IS_VSOE_ALLOCATION_LINE" ;;
  }

  dimension: isbillable {
    type: string
    sql: ${TABLE}."ISBILLABLE" ;;
  }

  dimension: iscleared {
    type: string
    sql: ${TABLE}."ISCLEARED" ;;
  }

  dimension: isnonreimbursable {
    type: string
    sql: ${TABLE}."ISNONREIMBURSABLE" ;;
  }

  dimension: istaxable {
    type: string
    sql: ${TABLE}."ISTAXABLE" ;;
  }

  dimension: item_count {
    type: number
    sql: ${TABLE}."ITEM_COUNT" ;;
  }

  dimension: item_id {
    type: number
    sql: ${TABLE}."ITEM_ID" ;;
  }

  dimension: item_on_je_id {
    type: number
    sql: ${TABLE}."ITEM_ON_JE_ID" ;;
  }

  dimension: item_received {
    type: string
    sql: ${TABLE}."ITEM_RECEIVED" ;;
  }

  dimension: item_source {
    type: string
    sql: ${TABLE}."ITEM_SOURCE" ;;
  }

  dimension: item_unit_price {
    type: string
    sql: ${TABLE}."ITEM_UNIT_PRICE" ;;
  }

  dimension: kit_part_number {
    type: number
    sql: ${TABLE}."KIT_PART_NUMBER" ;;
  }

  dimension: landed_cost_source_line_id {
    type: number
    sql: ${TABLE}."LANDED_COST_SOURCE_LINE_ID" ;;
  }

  dimension: location_id {
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
  }

  dimension: match_bill_to_receipt {
    type: string
    sql: ${TABLE}."MATCH_BILL_TO_RECEIPT" ;;
  }

  dimension: memo {
    type: string
    sql: ${TABLE}."MEMO" ;;
  }

  dimension: merchant_id {
    type: number
    sql: ${TABLE}."MERCHANT_ID" ;;
  }

  dimension: needs_revenue_element {
    type: string
    sql: ${TABLE}."NEEDS_REVENUE_ELEMENT" ;;
  }

  dimension: net_amount {
    type: number
    sql: ${TABLE}."NET_AMOUNT" ;;
  }

  dimension: net_amount_foreign {
    type: number
    sql: ${TABLE}."NET_AMOUNT_FOREIGN" ;;
  }

  dimension: non_posting_line {
    type: string
    sql: ${TABLE}."NON_POSTING_LINE" ;;
  }
  dimension: is_transaction_non_posting {
    type: yesno
    sql: lower(${non_posting_line})='yes' ;;
  }

  dimension: notc_id {
    type: number
    sql: ${TABLE}."NOTC_ID" ;;
  }

  dimension: number_billed {
    type: number
    sql: ${TABLE}."NUMBER_BILLED" ;;
  }

  dimension: operation_sequence_number {
    type: number
    sql: ${TABLE}."OPERATION_SEQUENCE_NUMBER" ;;
  }

  dimension: order_priority {
    type: number
    sql: ${TABLE}."ORDER_PRIORITY" ;;
  }

  dimension: payment_method_id {
    type: number
    sql: ${TABLE}."PAYMENT_METHOD_ID" ;;
  }

  dimension: payroll_item_id {
    type: number
    sql: ${TABLE}."PAYROLL_ITEM_ID" ;;
  }

  dimension: payroll_wage_base_amount {
    type: number
    sql: ${TABLE}."PAYROLL_WAGE_BASE_AMOUNT" ;;
  }

  dimension: payroll_year_to_date_amount {
    type: number
    sql: ${TABLE}."PAYROLL_YEAR_TO_DATE_AMOUNT" ;;
  }

  dimension_group: period_closed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."PERIOD_CLOSED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: price_type_id {
    type: number
    sql: ${TABLE}."PRICE_TYPE_ID" ;;
  }

  dimension: program_id {
    type: number
    sql: ${TABLE}."PROGRAM_ID" ;;
  }

  dimension: project_task_id {
    type: number
    sql: ${TABLE}."PROJECT_TASK_ID" ;;
  }

  dimension: property_tax_code_id {
    type: number
    sql: ${TABLE}."PROPERTY_TAX_CODE_ID" ;;
  }

  dimension: purchase_contract_id {
    type: number
    sql: ${TABLE}."PURCHASE_CONTRACT_ID" ;;
  }

  dimension: quantity_allocated {
    type: number
    sql: ${TABLE}."QUANTITY_ALLOCATED" ;;
  }

  dimension: quantity_committed {
    type: number
    sql: ${TABLE}."QUANTITY_COMMITTED" ;;
  }

  dimension: quantity_packed {
    type: number
    sql: ${TABLE}."QUANTITY_PACKED" ;;
  }

  dimension: quantity_picked {
    type: number
    sql: ${TABLE}."QUANTITY_PICKED" ;;
  }

  dimension: quantity_received_in_shipment {
    type: number
    sql: ${TABLE}."QUANTITY_RECEIVED_IN_SHIPMENT" ;;
  }

  dimension: receipt_url {
    type: string
    sql: ${TABLE}."RECEIPT_URL" ;;
  }

  dimension_group: receivebydate {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."RECEIVEBYDATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: reimbursement_type {
    type: string
    sql: ${TABLE}."REIMBURSEMENT_TYPE" ;;
  }

  dimension: related_company_id {
    type: number
    sql: ${TABLE}."RELATED_COMPANY_ID" ;;
  }

  dimension_group: rev_rec_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."REV_REC_END_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: rev_rec_rule_id {
    type: number
    sql: ${TABLE}."REV_REC_RULE_ID" ;;
  }

  dimension_group: rev_rec_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."REV_REC_START_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: revenue_element_id {
    type: number
    sql: ${TABLE}."REVENUE_ELEMENT_ID" ;;
  }

  dimension: schedule_id {
    type: number
    sql: ${TABLE}."SCHEDULE_ID" ;;
  }

  dimension: serial_number_id {
    type: number
    sql: ${TABLE}."SERIAL_NUMBER_ID" ;;
  }

  dimension_group: service {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."SERVICE_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: shipdate {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."SHIPDATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: shipment_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."SHIPMENT_RECEIVED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: shipping_group_id {
    type: number
    sql: ${TABLE}."SHIPPING_GROUP_ID" ;;
  }

  dimension: source_subsidiary_id {
    type: number
    sql: ${TABLE}."SOURCE_SUBSIDIARY_ID" ;;
  }

  dimension: spreedly_program_id {
    type: number
    sql: ${TABLE}."SPREEDLY_PROGRAM_ID" ;;
  }

  dimension: statistical_procedure_for_p_id {
    type: number
    sql: ${TABLE}."STATISTICAL_PROCEDURE_FOR_P_ID" ;;
  }

  dimension: statistical_procedure_for_s_id {
    type: number
    sql: ${TABLE}."STATISTICAL_PROCEDURE_FOR_S_ID" ;;
  }

  dimension: statistical_value {
    type: number
    sql: ${TABLE}."STATISTICAL_VALUE" ;;
  }

  dimension: statistical_value__base_curre {
    type: number
    sql: ${TABLE}."STATISTICAL_VALUE__BASE_CURRE" ;;
  }

  dimension: subscription_line_id {
    type: number
    sql: ${TABLE}."SUBSCRIPTION_LINE_ID" ;;
  }

  dimension: subsidiary_id {
    type: number
    sql: ${TABLE}."SUBSIDIARY_ID" ;;
  }

  dimension: tax_item_id {
    type: number
    sql: ${TABLE}."TAX_ITEM_ID" ;;
  }

  dimension: tax_type {
    type: string
    sql: ${TABLE}."TAX_TYPE" ;;
  }

  dimension_group: term_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."TERM_END_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: term_in_months {
    type: number
    sql: ${TABLE}."TERM_IN_MONTHS" ;;
  }

  dimension_group: term_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."TERM_START_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: term_type_id {
    type: number
    sql: ${TABLE}."TERM_TYPE_ID" ;;
  }

  dimension: tobeemailed {
    type: string
    sql: ${TABLE}."TOBEEMAILED" ;;
  }

  dimension: tobefaxed {
    type: string
    sql: ${TABLE}."TOBEFAXED" ;;
  }

  dimension: tobeprinted {
    type: string
    sql: ${TABLE}."TOBEPRINTED" ;;
  }

  dimension: transaction_discount_line {
    type: string
    sql: ${TABLE}."TRANSACTION_DISCOUNT_LINE" ;;
  }

  dimension: transaction_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."TRANSACTION_ID" ;;
  }

  dimension: transaction_order {
    type: number
    sql: ${TABLE}."TRANSACTION_ORDER" ;;
  }

  dimension: transfer_order_item_line {
    type: number
    sql: ${TABLE}."TRANSFER_ORDER_ITEM_LINE" ;;
  }

  dimension: transfer_order_line_type {
    type: string
    sql: ${TABLE}."TRANSFER_ORDER_LINE_TYPE" ;;
  }

  dimension: unit_cost_override {
    type: number
    sql: ${TABLE}."UNIT_COST_OVERRIDE" ;;
  }

  dimension: unit_of_measure_id {
    type: number
    sql: ${TABLE}."UNIT_OF_MEASURE_ID" ;;
  }

  dimension: vsoe_allocation {
    type: number
    sql: ${TABLE}."VSOE_ALLOCATION" ;;
  }

  dimension: vsoe_amt {
    type: number
    sql: ${TABLE}."VSOE_AMT" ;;
  }

  dimension: vsoe_deferral {
    type: string
    sql: ${TABLE}."VSOE_DEFERRAL" ;;
  }

  dimension: vsoe_delivered {
    type: string
    sql: ${TABLE}."VSOE_DELIVERED" ;;
  }

  dimension: vsoe_discount {
    type: string
    sql: ${TABLE}."VSOE_DISCOUNT" ;;
  }

  dimension: vsoe_price {
    type: number
    sql: ${TABLE}."VSOE_PRICE" ;;
  }

  measure: count_transaction_detail_records {
    type: count
    drill_fields: [detail*]
  }

  measure: count_transaction_lines {
    type: count_distinct
    sql: ${transaction_line_id} ;;
  }

  measure: sum_transaction_amount {
    type: sum
    value_format_name: usd
    sql: ${transaction_amount} ;;
    drill_fields: [detail*]
  }

  measure: Budget_Variance {
    type: number
    value_format_name: usd
    sql: ${sum_transaction_amount}-${budget.sum_amount} ;;
  }

measure: min_create_date {
  type: date
  sql: min(${date_created_raw}) ;;
}


# measure: total_revenue {
#   type: number
#   value_format_name: usd
#   sql: ${sum_transaction_amount}+${monthly_org_indirect_revenue.indirect_revenue} ;;
#   drill_fields: [detail*]
# }

  set: detail {
    fields: [
      transaction_id,
      transaction_line_id,
      transaction_amount,
      memo,
      accounting_periods.ending_month,
      accounting_periods.full_name,
      accounting_periods.name,
      accounting_periods.is_accounting_period_adjustment,
      accounting_periods.is_accounting_period_closed,
      transactions.transaction_date,
      transactions.transaction_type,
      accounts.name,
      accounts.type_name,
      accounts.account_id,
      accounts.account_number,
      accounts.is_accounts_payable,
      accounts.is_accounts_receivable,
      accounts.parent_account_name,
      income_accounts.is_income_account,
      expense_accounts.is_expense_account,
      customers.customer_company_name,
      customers.city,
      customers.state,
      customers.zipcode,
      customers.country,
      customers.date_first_order_date,
      items.name,
      items.type_name,
      items.sales_description,
      locations.name,
      locations.city,
      locations.country,
      vendor_types.name,
      vendors.vendor_name,
      vendors.vendor_created_date,
      currencies.name,
      currencies.symbol,
      departments.name,
      subsidiaries.name,
      transactions.days_past_due_date_tier
    ]
  }

}
