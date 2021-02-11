view: transactions_netsuite {
  view_label: "Transactions"
  sql_table_name: @{SCHEMA_NAME}."TRANSACTIONS"
    ;;
  drill_fields: [payment_transaction_id]

  dimension: payment_transaction_id {
    primary_key: yes #TODO AJC Needs verification
    type: string
    sql: ${TABLE}."PAYMENT_TRANSACTION_ID" ;;
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

  dimension: account_based_number {
    type: string
    sql: ${TABLE}."ACCOUNT_BASED_NUMBER" ;;
  }

  dimension: accounting_book_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."ACCOUNTING_BOOK_ID" ;;
  }

  dimension_group: accounting {
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
    sql: CAST(${TABLE}."ACCOUNTING_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: accounting_period_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."ACCOUNTING_PERIOD_ID" ;;
  }

  dimension: acct_corp_card_expenses_id {
    type: number
    sql: ${TABLE}."ACCT_CORP_CARD_EXPENSES_ID" ;;
  }

  dimension: adjustment_journal {
    type: string
    sql: ${TABLE}."ADJUSTMENT_JOURNAL" ;;
  }

  dimension: amount_after_discount {
    type: number
    sql: ${TABLE}."AMOUNT_AFTER_DISCOUNT" ;;
  }

  dimension: amount_unbilled {
    type: number
    sql: ${TABLE}."AMOUNT_UNBILLED" ;;
  }

  dimension: bill_pay_transaction {
    type: string
    sql: ${TABLE}."BILL_PAY_TRANSACTION" ;;
  }

  dimension: bill_payment_method_id {
    type: number
    sql: ${TABLE}."BILL_PAYMENT_METHOD_ID" ;;
  }

  dimension: billaddress {
    type: string
    sql: ${TABLE}."BILLADDRESS" ;;
  }

  dimension: billing_account_id {
    type: number
    sql: ${TABLE}."BILLING_ACCOUNT_ID" ;;
  }

  dimension: billing_instructions {
    type: string
    sql: ${TABLE}."BILLING_INSTRUCTIONS" ;;
  }

  dimension: billing_record_cannot_be_subm {
    type: string
    sql: ${TABLE}."BILLING_RECORD_CANNOT_BE_SUBM" ;;
  }

  dimension: buildable {
    type: number
    sql: ${TABLE}."BUILDABLE" ;;
  }

  dimension: bulk_submission_id {
    type: number
    sql: ${TABLE}."BULK_SUBMISSION_ID" ;;
  }

  dimension: campaign_category_id {
    type: number
    sql: ${TABLE}."CAMPAIGN_CATEGORY_ID" ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}."CARRIER" ;;
  }

  dimension: cash_register {
    type: string
    sql: ${TABLE}."CASH_REGISTER" ;;
  }

  dimension: chargify_invoice_number {
    type: string
    sql: ${TABLE}."CHARGIFY_INVOICE_NUMBER" ;;
  }

  dimension: chargify_invoice_uid {
    type: string
    sql: ${TABLE}."CHARGIFY_INVOICE_UID" ;;
  }

  dimension: chargify_subdomain {
    type: string
    sql: ${TABLE}."CHARGIFY_SUBDOMAIN" ;;
  }

  dimension: chargify_transaction_id {
    type: string
    sql: ${TABLE}."CHARGIFY_TRANSACTION_ID" ;;
  }

  dimension_group: closed {
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
    sql: CAST(${TABLE}."CLOSED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: comment_0 {
    type: string
    sql: ${TABLE}."COMMENT_0" ;;
  }

  dimension: company_status_id {
    type: number
    sql: ${TABLE}."COMPANY_STATUS_ID" ;;
  }

  dimension: contract_cost_amount {
    type: number
    sql: ${TABLE}."CONTRACT_COST_AMOUNT" ;;
  }

  dimension: contract_defer_expense_acct_id {
    type: number
    sql: ${TABLE}."CONTRACT_DEFER_EXPENSE_ACCT_ID" ;;
  }

  dimension: contract_expense_acct_id {
    type: number
    sql: ${TABLE}."CONTRACT_EXPENSE_ACCT_ID" ;;
  }

  dimension: contract_expense_src_acct_id {
    type: number
    sql: ${TABLE}."CONTRACT_EXPENSE_SRC_ACCT_ID" ;;
  }

  dimension_group: contract_renewal {
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
    sql: CAST(${TABLE}."CONTRACT_RENEWAL_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: correction_type_id {
    type: number
    sql: ${TABLE}."CORRECTION_TYPE_ID" ;;
  }

  dimension: counterparty_vat_number {
    type: string
    sql: ${TABLE}."COUNTERPARTY_VAT_NUMBER" ;;
  }

  dimension: country_of_origin {
    type: string
    sql: ${TABLE}."COUNTRY_OF_ORIGIN" ;;
  }

  dimension_group: create {
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
    sql: CAST(${TABLE}."CREATE_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: created_by_id {
    type: number
    sql: ${TABLE}."CREATED_BY_ID" ;;
  }

  dimension: created_from {
    type: string
    sql: ${TABLE}."CREATED_FROM" ;;
  }

  dimension: created_from_id {
    type: number
    sql: ${TABLE}."CREATED_FROM_ID" ;;
  }

  dimension: created_from_memorized_tsx {
    type: string
    sql: ${TABLE}."CREATED_FROM_MEMORIZED_TSX" ;;
  }

  dimension: credit_reason_id {
    type: number
    sql: ${TABLE}."CREDIT_REASON_ID" ;;
  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}."CURRENCY_ID" ;;
  }

  dimension: custom_form_id {
    type: number
    sql: ${TABLE}."CUSTOM_FORM_ID" ;;
  }

  dimension: customs_registration_number {
    type: string
    sql: ${TABLE}."CUSTOMS_REGISTRATION_NUMBER" ;;
  }

  dimension_group: date_actual_prod_end {
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
    sql: CAST(${TABLE}."DATE_ACTUAL_PROD_END" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_actual_prod_start {
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
    sql: CAST(${TABLE}."DATE_ACTUAL_PROD_START" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_bid_close {
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
    sql: CAST(${TABLE}."DATE_BID_CLOSE" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_bid_open {
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
    sql: CAST(${TABLE}."DATE_BID_OPEN" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_contract_cost_accrual {
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
    sql: CAST(${TABLE}."DATE_CONTRACT_COST_ACCRUAL" AS TIMESTAMP_NTZ) ;;
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

  dimension_group: date_of_taxable_supply {
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
    sql: CAST(${TABLE}."DATE_OF_TAXABLE_SUPPLY" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_tax_point {
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
    sql: CAST(${TABLE}."DATE_TAX_POINT" AS TIMESTAMP_NTZ) ;;
  }

  dimension: delivery_terms_id {
    type: number
    sql: ${TABLE}."DELIVERY_TERMS_ID" ;;
  }

  dimension: details_of_subject_and_exem_id {
    type: number
    sql: ${TABLE}."DETAILS_OF_SUBJECT_AND_EXEM_ID" ;;
  }

  dimension_group: document {
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
    sql: CAST(${TABLE}."DOCUMENT_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: document_number {
    type: string
    sql: ${TABLE}."DOCUMENT_NUMBER" ;;
  }

  dimension_group: due {
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
    sql: CAST(${TABLE}."DUE_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: days_past_due_date_tier {
    type: string
    sql: case
          when datediff(day, to_date(${due_raw}), current_date)  < 0 then '< 0.0'
          when datediff(day, to_date(${due_raw}), current_date)  >= 0 and datediff(day, to_date(${due_raw}), current_date)  < 30 then '>= 0.0 and < 30.0'
          when datediff(day, to_date(${due_raw}), current_date)  >= 30 and datediff(day, to_date(${due_raw}), current_date)  < 60 then '>= 30.0 and < 60.0'
          when datediff(day, to_date(${due_raw}), current_date)  >= 60 and datediff(day, to_date(${due_raw}), current_date)  < 90 then '>= 60.0 and < 90.0'
          when datediff(day, to_date(${due_raw}), current_date)  >= 90 then '>= 90.0'
          else 'Undefined' end;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension_group: end {
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
    sql: CAST(${TABLE}."END_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}."ENTITY_ID" ;;
  }

  dimension: entity_tax_reg_num {
    type: string
    sql: ${TABLE}."ENTITY_TAX_REG_NUM" ;;
  }

  dimension: establishment_code {
    type: string
    sql: ${TABLE}."ESTABLISHMENT_CODE" ;;
  }

  dimension: exchange_rate {
    type: number
    sql: ${TABLE}."EXCHANGE_RATE" ;;
  }

  dimension_group: expected_close {
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
    sql: CAST(${TABLE}."EXPECTED_CLOSE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: external_ref_number {
    type: string
    sql: ${TABLE}."EXTERNAL_REF_NUMBER" ;;
  }

  dimension: external_reference {
    type: string
    sql: ${TABLE}."EXTERNAL_REFERENCE" ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}."FAX" ;;
  }

  dimension: fob {
    type: string
    sql: ${TABLE}."FOB" ;;
  }

  dimension: forecast_type {
    type: string
    sql: ${TABLE}."FORECAST_TYPE" ;;
  }

  dimension: hubspot_deal {
    type: string
    sql: ${TABLE}."HUBSPOT_DEAL" ;;
  }

  dimension: hubspot_deal_link {
    type: string
    sql: ${TABLE}."HUBSPOT_DEAL_LINK" ;;
  }

  dimension: import_declaration_no_ {
    type: string
    sql: ${TABLE}."IMPORT_DECLARATION_NO_" ;;
  }

  dimension: import_permit_no_ {
    type: string
    sql: ${TABLE}."IMPORT_PERMIT_NO_" ;;
  }

  dimension: include_in_forecast {
    type: string
    sql: ${TABLE}."INCLUDE_IN_FORECAST" ;;
  }

  dimension: incoterm {
    type: string
    sql: ${TABLE}."INCOTERM" ;;
  }

  dimension: intercompany_transaction_id {
    type: number
    sql: ${TABLE}."INTERCOMPANY_TRANSACTION_ID" ;;
  }

  dimension: intracommunity_transaction__id {
    type: number
    sql: ${TABLE}."INTRACOMMUNITY_TRANSACTION__ID" ;;
  }

  dimension_group: invoice {
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
    sql: CAST(${TABLE}."INVOICE_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: invoice_with_no_counterpart_a {
    type: string
    sql: ${TABLE}."INVOICE_WITH_NO_COUNTERPART_A" ;;
  }

  dimension: is_actualprodenddate_manual {
    type: string
    sql: ${TABLE}."IS_ACTUALPRODENDDATE_MANUAL" ;;
  }

  dimension: is_actualprodstartdate_manual {
    type: string
    sql: ${TABLE}."IS_ACTUALPRODSTARTDATE_MANUAL" ;;
  }

  dimension: is_advanced_intercompany {
    type: string
    sql: ${TABLE}."IS_ADVANCED_INTERCOMPANY" ;;
  }

  dimension: is_transaction_intercompany {
    type: yesno
    sql: lower(${is_advanced_intercompany})='yes' OR lower(${is_intercompany})='yes' ;;
  }

  dimension: is_autocalculate_lag {
    type: string
    sql: ${TABLE}."IS_AUTOCALCULATE_LAG" ;;
  }

  dimension: is_compliant {
    type: string
    sql: ${TABLE}."IS_COMPLIANT" ;;
  }

  dimension: is_created_from_merge {
    type: string
    sql: ${TABLE}."IS_CREATED_FROM_MERGE" ;;
  }

  dimension: is_cross_sub_transactions {
    type: string
    sql: ${TABLE}."IS_CROSS_SUB_TRANSACTIONS" ;;
  }

  dimension: is_finance_charge {
    type: string
    sql: ${TABLE}."IS_FINANCE_CHARGE" ;;
  }

  dimension: is_firmed {
    type: string
    sql: ${TABLE}."IS_FIRMED" ;;
  }

  dimension: is_in_transit_payment {
    type: string
    sql: ${TABLE}."IS_IN_TRANSIT_PAYMENT" ;;
  }

  dimension: is_intercompany {
    type: string
    sql: ${TABLE}."IS_INTERCOMPANY" ;;
  }

  dimension: is_merged_into_arrangements {
    type: string
    sql: ${TABLE}."IS_MERGED_INTO_ARRANGEMENTS" ;;
  }

  dimension: is_non_posting {
    type: string
    sql: ${TABLE}."IS_NON_POSTING" ;;
  }

  dimension: is_override_installments {
    type: string
    sql: ${TABLE}."IS_OVERRIDE_INSTALLMENTS" ;;
  }

  dimension: is_payment_hold {
    type: string
    sql: ${TABLE}."IS_PAYMENT_HOLD" ;;
  }

  dimension: is_reversal {
    type: string
    sql: ${TABLE}."IS_REVERSAL" ;;
  }

  dimension: is_tax_point_date_override {
    type: string
    sql: ${TABLE}."IS_TAX_POINT_DATE_OVERRIDE" ;;
  }

  dimension: is_tax_reg_override {
    type: string
    sql: ${TABLE}."IS_TAX_REG_OVERRIDE" ;;
  }

  dimension: is_wip {
    type: string
    sql: ${TABLE}."IS_WIP" ;;
  }

  dimension: issued_by_third_party {
    type: string
    sql: ${TABLE}."ISSUED_BY_THIRD_PARTY" ;;
  }

  dimension: issued_invoice_type_id {
    type: number
    sql: ${TABLE}."ISSUED_INVOICE_TYPE_ID" ;;
  }

  dimension: item_revision {
    type: number
    sql: ${TABLE}."ITEM_REVISION" ;;
  }

  dimension: itr_nexus {
    type: string
    sql: ${TABLE}."ITR_NEXUS" ;;
  }

  dimension: je_type_id {
    type: number
    sql: ${TABLE}."JE_TYPE_ID" ;;
  }

  dimension: job_id {
    type: number
    sql: ${TABLE}."JOB_ID" ;;
  }

  dimension: land_registercadaster_referen {
    type: string
    sql: ${TABLE}."LAND_REGISTERCADASTER_REFEREN" ;;
  }

  dimension: landed_cost_allocation_method {
    type: string
    sql: ${TABLE}."LANDED_COST_ALLOCATION_METHOD" ;;
  }

  dimension_group: last_modified {
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
    sql: CAST(${TABLE}."LAST_MODIFIED_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: last_sales_activity {
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
    sql: CAST(${TABLE}."LAST_SALES_ACTIVITY" AS TIMESTAMP_NTZ) ;;
  }

  dimension: lead_source_id {
    type: number
    sql: ${TABLE}."LEAD_SOURCE_ID" ;;
  }

  dimension: location_id {
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
  }

  dimension: lsa_link {
    type: string
    sql: ${TABLE}."LSA_LINK" ;;
  }

  dimension: lsa_link_name {
    type: string
    sql: ${TABLE}."LSA_LINK_NAME" ;;
  }

  dimension: memo {
    type: string
    sql: ${TABLE}."MEMO" ;;
  }

  dimension: memorized {
    type: string
    sql: ${TABLE}."MEMORIZED" ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}."MESSAGE" ;;
  }

  dimension: mode_of_transport_id {
    type: number
    sql: ${TABLE}."MODE_OF_TRANSPORT_ID" ;;
  }

  dimension: mx_operation_type_id {
    type: number
    sql: ${TABLE}."MX_OPERATION_TYPE_ID" ;;
  }

  dimension: nature_of_transaction_code_id {
    type: number
    sql: ${TABLE}."NATURE_OF_TRANSACTION_CODE_ID" ;;
  }

  dimension: needs_bill {
    type: string
    sql: ${TABLE}."NEEDS_BILL" ;;
  }

  dimension: needs_revenue_commitment {
    type: string
    sql: ${TABLE}."NEEDS_REVENUE_COMMITMENT" ;;
  }

  dimension: nexus_notc_id {
    type: number
    sql: ${TABLE}."NEXUS_NOTC_ID" ;;
  }

  dimension: nondeductible_adjustment_jo_id {
    type: number
    sql: ${TABLE}."NONDEDUCTIBLE_ADJUSTMENT_JO_ID" ;;
  }

  dimension: nondeductible_tax_adjusted {
    type: string
    sql: ${TABLE}."NONDEDUCTIBLE_TAX_ADJUSTED" ;;
  }

  dimension: number_of_pricing_tiers {
    type: number
    sql: ${TABLE}."NUMBER_OF_PRICING_TIERS" ;;
  }

  dimension: opening_balance_transaction {
    type: string
    sql: ${TABLE}."OPENING_BALANCE_TRANSACTION" ;;
  }

  dimension_group: operation {
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
    sql: CAST(${TABLE}."OPERATION_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: order_type_id {
    type: number
    sql: ${TABLE}."ORDER_TYPE_ID" ;;
  }

  dimension: original_bill_id {
    type: number
    sql: ${TABLE}."ORIGINAL_BILL_ID" ;;
  }

  dimension: original_invoice_id {
    type: number
    sql: ${TABLE}."ORIGINAL_INVOICE_ID" ;;
  }

  dimension: ownership_transfer_id {
    type: number
    sql: ${TABLE}."OWNERSHIP_TRANSFER_ID" ;;
  }

  dimension: packing_list_instructions {
    type: string
    sql: ${TABLE}."PACKING_LIST_INSTRUCTIONS" ;;
  }

  dimension: partner_id {
    type: number
    sql: ${TABLE}."PARTNER_ID" ;;
  }

  dimension: payment_batch {
    type: string
    sql: ${TABLE}."PAYMENT_BATCH" ;;
  }

  dimension: payment_frequency_id {
    type: number
    sql: ${TABLE}."PAYMENT_FREQUENCY_ID" ;;
  }

  dimension: payment_terms_id {
    type: number
    sql: ${TABLE}."PAYMENT_TERMS_ID" ;;
  }

  dimension: pn_ref_num {
    type: string
    sql: ${TABLE}."PN_REF_NUM" ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}."PROBABILITY" ;;
  }

  dimension: product_label_instructions {
    type: string
    sql: ${TABLE}."PRODUCT_LABEL_INSTRUCTIONS" ;;
  }

  dimension: projected_total {
    type: number
    sql: ${TABLE}."PROJECTED_TOTAL" ;;
  }

  dimension: promotion_code_id {
    type: number
    sql: ${TABLE}."PROMOTION_CODE_ID" ;;
  }

  dimension: promotion_code_instance_id {
    type: number
    sql: ${TABLE}."PROMOTION_CODE_INSTANCE_ID" ;;
  }

  dimension: property_location_id {
    type: number
    sql: ${TABLE}."PROPERTY_LOCATION_ID" ;;
  }

  dimension: purchase_order_instructions {
    type: string
    sql: ${TABLE}."PURCHASE_ORDER_INSTRUCTIONS" ;;
  }

  dimension: receipt_pending {
    type: string
    sql: ${TABLE}."RECEIPT_PENDING" ;;
  }

  dimension: received_invoice_type_id {
    type: number
    sql: ${TABLE}."RECEIVED_INVOICE_TYPE_ID" ;;
  }

  dimension: reference_no_ {
    type: string
    sql: ${TABLE}."REFERENCE_NO_" ;;
  }

  dimension: reference_no__of_original_inv {
    type: string
    sql: ${TABLE}."REFERENCE_NO__OF_ORIGINAL_INV" ;;
  }

  dimension: regime_code_id {
    type: number
    sql: ${TABLE}."REGIME_CODE_ID" ;;
  }

  dimension: regime_code_of_supply_id {
    type: number
    sql: ${TABLE}."REGIME_CODE_OF_SUPPLY_ID" ;;
  }

  dimension: region_of_origin_id {
    type: number
    sql: ${TABLE}."REGION_OF_ORIGIN_ID" ;;
  }

  dimension: registration_code_id {
    type: number
    sql: ${TABLE}."REGISTRATION_CODE_ID" ;;
  }

  dimension: registration_message {
    type: string
    sql: ${TABLE}."REGISTRATION_MESSAGE" ;;
  }

  dimension: registration_status_id {
    type: number
    sql: ${TABLE}."REGISTRATION_STATUS_ID" ;;
  }

  dimension: related_tranid {
    type: string
    sql: ${TABLE}."RELATED_TRANID" ;;
  }

  dimension_group: renewal {
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
    sql: CAST(${TABLE}."RENEWAL" AS TIMESTAMP_NTZ) ;;
  }

  dimension: renewal_type_id {
    type: number
    sql: ${TABLE}."RENEWAL_TYPE_ID" ;;
  }

  dimension: report_timestamp {
    type: string
    sql: ${TABLE}."REPORT_TIMESTAMP" ;;
  }

  dimension: revenue_commitment_status {
    type: string
    sql: ${TABLE}."REVENUE_COMMITMENT_STATUS" ;;
  }

  dimension_group: revenue_committed {
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
    sql: CAST(${TABLE}."REVENUE_COMMITTED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: revenue_status {
    type: string
    sql: ${TABLE}."REVENUE_STATUS" ;;
  }

  dimension: reversing_transaction_id {
    type: number
    sql: ${TABLE}."REVERSING_TRANSACTION_ID" ;;
  }

  dimension_group: sales_effective {
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
    sql: CAST(${TABLE}."SALES_EFFECTIVE_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: sales_rep_id {
    type: number
    sql: ${TABLE}."SALES_REP_ID" ;;
  }

  dimension: scheduling_method_id {
    type: string
    sql: ${TABLE}."SCHEDULING_METHOD_ID" ;;
  }

  dimension: shipaddress {
    type: string
    sql: ${TABLE}."SHIPADDRESS" ;;
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

  dimension: shipping_item_id {
    type: number
    sql: ${TABLE}."SHIPPING_ITEM_ID" ;;
  }

  dimension: simplified_invoice_article_7_ {
    type: string
    sql: ${TABLE}."SIMPLIFIED_INVOICE_ARTICLE_7_" ;;
  }

  dimension: special_scheme_code_or_effe__0 {
    type: number
    sql: ${TABLE}."SPECIAL_SCHEME_CODE_OR_EFFE__0" ;;
  }

  dimension: special_scheme_code_or_effe_id {
    type: number
    sql: ${TABLE}."SPECIAL_SCHEME_CODE_OR_EFFE_ID" ;;
  }

  dimension_group: start {
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
    sql: CAST(${TABLE}."START_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: tax_after_discount {
    type: number
    sql: ${TABLE}."TAX_AFTER_DISCOUNT" ;;
  }

  dimension: tax_reg_id {
    type: number
    sql: ${TABLE}."TAX_REG_ID" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}."TITLE" ;;
  }

  dimension: total_after_discount {
    type: number
    sql: ${TABLE}."TOTAL_AFTER_DISCOUNT" ;;
  }

  dimension_group: transaction {
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
    sql: CAST(${TABLE}."TRANDATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: tranid {
    type: string
    sql: ${TABLE}."TRANID" ;;
  }

  dimension: trans_is_vsoe_bundle {
    type: string
    sql: ${TABLE}."TRANS_IS_VSOE_BUNDLE" ;;
  }

  dimension: transaction_extid {
    type: string
    sql: ${TABLE}."TRANSACTION_EXTID" ;;
  }

  dimension: transaction_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."TRANSACTION_ID" ;;
  }

  dimension: transaction_number {
    type: string
    sql: ${TABLE}."TRANSACTION_NUMBER" ;;
  }

  dimension: transaction_partner {
    type: string
    sql: ${TABLE}."TRANSACTION_PARTNER" ;;
  }

  dimension: transaction_source {
    type: string
    sql: ${TABLE}."TRANSACTION_SOURCE" ;;
  }

  dimension: transaction_type {
    type: string
    sql: ${TABLE}."TRANSACTION_TYPE" ;;
  }

  dimension: transaction_website {
    type: number
    sql: ${TABLE}."TRANSACTION_WEBSITE" ;;
  }

  dimension: transfer_location {
    type: number
    sql: ${TABLE}."TRANSFER_LOCATION" ;;
  }

  dimension: use_item_cost_as_transfer_cost {
    type: string
    sql: ${TABLE}."USE_ITEM_COST_AS_TRANSFER_COST" ;;
  }

  dimension: visible_in_customer_center {
    type: string
    sql: ${TABLE}."VISIBLE_IN_CUSTOMER_CENTER" ;;
  }

  dimension: weighted_total {
    type: number
    sql: ${TABLE}."WEIGHTED_TOTAL" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      payment_transaction_id,
      lsa_link_name,
      transactions.lsa_link_name,
      transactions.payment_transaction_id,
      accounting_periods.accounting_period_id,
      accounting_periods.name,
      accounting_periods.full_name,
      accounting_books.accounting_book_name,
      accounting_books.accounting_book_id,
      transactions.count,
      transaction_lines.count
    ]
  }
}
