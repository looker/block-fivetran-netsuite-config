view: vendors {
  sql_table_name: "NETSUITE"."VENDORS"
    ;;
  drill_fields: [vendor_id]

  dimension: vendor_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."VENDOR_ID" ;;
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

  dimension_group: account_status {
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
    sql: CAST(${TABLE}."ACCOUNT_STATUS_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: account_status_id {
    type: number
    sql: ${TABLE}."ACCOUNT_STATUS_ID" ;;
  }

  dimension: account_updater_enabled {
    type: string
    sql: ${TABLE}."ACCOUNT_UPDATER_ENABLED" ;;
  }

  dimension: accountnumber {
    type: string
    sql: ${TABLE}."ACCOUNTNUMBER" ;;
  }

  dimension_group: active_until {
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
    sql: CAST(${TABLE}."ACTIVE_UNTIL_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: altemail {
    type: string
    sql: ${TABLE}."ALTEMAIL" ;;
  }

  dimension: altphone {
    type: string
    sql: ${TABLE}."ALTPHONE" ;;
  }

  dimension: annual_revenue {
    type: number
    sql: ${TABLE}."ANNUAL_REVENUE" ;;
  }

  dimension: billaddress {
    type: string
    sql: ${TABLE}."BILLADDRESS" ;;
  }

  dimension: billing_class_id {
    type: number
    sql: ${TABLE}."BILLING_CLASS_ID" ;;
  }

  dimension: billing_page {
    type: string
    sql: ${TABLE}."BILLING_PAGE" ;;
  }

  dimension: brn {
    type: string
    sql: ${TABLE}."BRN" ;;
  }

  dimension: chargify_customer_id {
    type: string
    sql: ${TABLE}."CHARGIFY_CUSTOMER_ID" ;;
  }

  dimension: chargify_subdomain {
    type: string
    sql: ${TABLE}."CHARGIFY_SUBDOMAIN" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: collection_notes {
    type: string
    sql: ${TABLE}."COLLECTION_NOTES" ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}."COMMENTS" ;;
  }

  dimension: vendor_name {
    type: string
    sql: ${TABLE}."COMPANYNAME" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
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

  dimension: creditlimit {
    type: number
    sql: ${TABLE}."CREDITLIMIT" ;;
  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}."CURRENCY_ID" ;;
  }

  dimension_group: customer_activation {
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
    sql: CAST(${TABLE}."CUSTOMER_ACTIVATION_DATE" AS TIMESTAMP_NTZ) ;;
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

  dimension: default_department_id {
    type: number
    sql: ${TABLE}."DEFAULT_DEPARTMENT_ID" ;;
  }

  dimension: default_payment_method_id {
    type: number
    sql: ${TABLE}."DEFAULT_PAYMENT_METHOD_ID" ;;
  }

  dimension: dic {
    type: string
    sql: ${TABLE}."DIC" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: expense_account_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."EXPENSE_ACCOUNT_ID" ;;
  }

  dimension: fax {
    type: string
    sql: ${TABLE}."FAX" ;;
  }

  dimension: feature_level {
    type: string
    sql: ${TABLE}."FEATURE_LEVEL" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: home_phone {
    type: string
    sql: ${TABLE}."HOME_PHONE" ;;
  }

  dimension: hubspot_link {
    type: string
    sql: ${TABLE}."HUBSPOT_LINK" ;;
  }

  dimension: ico {
    type: string
    sql: ${TABLE}."ICO" ;;
  }

  dimension: id_number_in_the_country_of_r {
    type: string
    sql: ${TABLE}."ID_NUMBER_IN_THE_COUNTRY_OF_R" ;;
  }

  dimension: id_type_in_the_country_of_r_id {
    type: number
    sql: ${TABLE}."ID_TYPE_IN_THE_COUNTRY_OF_R_ID" ;;
  }

  dimension: in_transit_balance {
    type: number
    sql: ${TABLE}."IN_TRANSIT_BALANCE" ;;
  }

  dimension: incoterm {
    type: string
    sql: ${TABLE}."INCOTERM" ;;
  }

  dimension: industry_id {
    type: number
    sql: ${TABLE}."INDUSTRY_ID" ;;
  }

  dimension: is1099_eligible {
    type: string
    sql: ${TABLE}."IS1099ELIGIBLE" ;;
  }

  dimension: is_person {
    type: string
    sql: ${TABLE}."IS_PERSON" ;;
  }

  dimension: isemailhtml {
    type: string
    sql: ${TABLE}."ISEMAILHTML" ;;
  }

  dimension: isemailpdf {
    type: string
    sql: ${TABLE}."ISEMAILPDF" ;;
  }

  dimension: isinactive {
    type: string
    sql: ${TABLE}."ISINACTIVE" ;;
  }

  dimension: labor_cost {
    type: number
    sql: ${TABLE}."LABOR_COST" ;;
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

  dimension: lava_organization {
    type: string
    sql: ${TABLE}."LAVA_ORGANIZATION" ;;
  }

  dimension: line1 {
    type: string
    sql: ${TABLE}."LINE1" ;;
  }

  dimension: line2 {
    type: string
    sql: ${TABLE}."LINE2" ;;
  }

  dimension: line3 {
    type: string
    sql: ${TABLE}."LINE3" ;;
  }

  dimension: loginaccess {
    type: string
    sql: ${TABLE}."LOGINACCESS" ;;
  }

  dimension: lsa_link {
    type: string
    sql: ${TABLE}."LSA_LINK" ;;
  }

  dimension: lsa_link_name {
    type: string
    sql: ${TABLE}."LSA_LINK_NAME" ;;
  }

  dimension: mobile_phone {
    type: string
    sql: ${TABLE}."MOBILE_PHONE" ;;
  }

  dimension: multiple_emails {
    type: string
    sql: ${TABLE}."MULTIPLE_EMAILS" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: no__of_employees {
    type: number
    sql: ${TABLE}."NO__OF_EMPLOYEES" ;;
  }

  dimension: openbalance {
    type: number
    sql: ${TABLE}."OPENBALANCE" ;;
  }

  dimension: openbalance_foreign {
    type: number
    sql: ${TABLE}."OPENBALANCE_FOREIGN" ;;
  }

  dimension: payables_account_id {
    type: number
    sql: ${TABLE}."PAYABLES_ACCOUNT_ID" ;;
  }

  dimension: payment_terms_id {
    type: number
    sql: ${TABLE}."PAYMENT_TERMS_ID" ;;
  }

  dimension: payroll_id {
    type: string
    sql: ${TABLE}."PAYROLL_ID" ;;
  }

  dimension: personal_email {
    type: string
    sql: ${TABLE}."PERSONAL_EMAIL" ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}."PHONE" ;;
  }

  dimension: preferred_name {
    type: string
    sql: ${TABLE}."PREFERRED_NAME" ;;
  }

  dimension: printoncheckas {
    type: string
    sql: ${TABLE}."PRINTONCHECKAS" ;;
  }

  dimension: purchaseorderamount {
    type: number
    sql: ${TABLE}."PURCHASEORDERAMOUNT" ;;
  }

  dimension: purchaseorderquantity {
    type: number
    sql: ${TABLE}."PURCHASEORDERQUANTITY" ;;
  }

  dimension: purchaseorderquantitydiff {
    type: number
    sql: ${TABLE}."PURCHASEORDERQUANTITYDIFF" ;;
  }

  dimension: receiptamount {
    type: number
    sql: ${TABLE}."RECEIPTAMOUNT" ;;
  }

  dimension: receiptquantity {
    type: number
    sql: ${TABLE}."RECEIPTQUANTITY" ;;
  }

  dimension: receiptquantitydiff {
    type: number
    sql: ${TABLE}."RECEIPTQUANTITYDIFF" ;;
  }

  dimension: represents_subsidiary_id {
    type: number
    sql: ${TABLE}."REPRESENTS_SUBSIDIARY_ID" ;;
  }

  dimension: restrict_access_to_expensify {
    type: string
    sql: ${TABLE}."RESTRICT_ACCESS_TO_EXPENSIFY" ;;
  }

  dimension: shipaddress {
    type: string
    sql: ${TABLE}."SHIPADDRESS" ;;
  }

  dimension: spreedly_billing_id {
    type: string
    sql: ${TABLE}."SPREEDLY_BILLING_ID" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: subscription_plan_id {
    type: number
    sql: ${TABLE}."SUBSCRIPTION_PLAN_ID" ;;
  }

  dimension: subsidiary {
    type: number
    sql: ${TABLE}."SUBSIDIARY" ;;
  }

  dimension: tax_contact_first_name {
    type: string
    sql: ${TABLE}."TAX_CONTACT_FIRST_NAME" ;;
  }

  dimension: tax_contact_id {
    type: number
    sql: ${TABLE}."TAX_CONTACT_ID" ;;
  }

  dimension: tax_contact_last_name {
    type: string
    sql: ${TABLE}."TAX_CONTACT_LAST_NAME" ;;
  }

  dimension: tax_contact_middle_name {
    type: string
    sql: ${TABLE}."TAX_CONTACT_MIDDLE_NAME" ;;
  }

  dimension: tax_entity_id {
    type: number
    sql: ${TABLE}."TAX_ENTITY_ID" ;;
  }

  dimension: tax_number {
    type: string
    sql: ${TABLE}."TAX_NUMBER" ;;
  }

  dimension: taxidnum {
    type: string
    sql: ${TABLE}."TAXIDNUM" ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}."TEAM_ID" ;;
  }

  dimension: time_approver_id {
    type: number
    sql: ${TABLE}."TIME_APPROVER_ID" ;;
  }

  dimension: type_id {
    type: number
    sql: ${TABLE}."TYPE_ID" ;;
  }

  dimension: uen {
    type: string
    sql: ${TABLE}."UEN" ;;
  }

  dimension: unbilled_orders {
    type: number
    sql: ${TABLE}."UNBILLED_ORDERS" ;;
  }

  dimension: unbilled_orders_foreign {
    type: number
    sql: ${TABLE}."UNBILLED_ORDERS_FOREIGN" ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}."URL" ;;
  }

  dimension: vat_registration_no {
    type: string
    sql: ${TABLE}."VAT_REGISTRATION_NO" ;;
  }

  dimension: vendor_extid {
    type: string
    sql: ${TABLE}."VENDOR_EXTID" ;;
  }

  dimension: vendor_type_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."VENDOR_TYPE_ID" ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}."ZIPCODE" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      vendor_id,
      full_name,
      vendor_name,
      tax_contact_first_name,
      lsa_link_name,
      name,
      preferred_name,
      tax_contact_last_name,
      tax_contact_middle_name,
      vendor_types.name,
      vendor_types.vendor_type_id,
      expense_accounts.expense_account_id,
      expense_accounts.name,
      expense_accounts.full_name,
      expense_accounts.legal_name,
      items.count
    ]
  }
}
