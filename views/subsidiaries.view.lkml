view: subsidiaries {
  sql_table_name: @{SCHEMA_NAME}."SUBSIDIARIES"
    ;;
  drill_fields: [subsidiary_id]

  dimension: subsidiary_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."SUBSIDIARY_ID" ;;
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

  dimension: address {
    type: string
    sql: ${TABLE}."ADDRESS" ;;
  }

  dimension: address1 {
    type: string
    sql: ${TABLE}."ADDRESS1" ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}."ADDRESS2" ;;
  }

  dimension: base_currency_id {
    type: number
    sql: ${TABLE}."BASE_CURRENCY_ID" ;;
  }

  dimension: branch_id {
    type: string
    sql: ${TABLE}."BRANCH_ID" ;;
  }

  dimension: brn {
    type: string
    sql: ${TABLE}."BRN" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
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

  dimension: edition {
    type: string
    sql: ${TABLE}."EDITION" ;;
  }

  dimension: federal_number {
    type: string
    sql: ${TABLE}."FEDERAL_NUMBER" ;;
  }

  dimension: fiscal_calendar_id {
    type: number
    sql: ${TABLE}."FISCAL_CALENDAR_ID" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: is_elimination {
    type: string
    sql: ${TABLE}."IS_ELIMINATION" ;;
  }

  dimension: is_moss {
    type: string
    sql: ${TABLE}."IS_MOSS" ;;
  }

  dimension: isinactive {
    type: string
    sql: ${TABLE}."ISINACTIVE" ;;
  }

  dimension: isinactive_bool {
    type: string
    sql: ${TABLE}."ISINACTIVE_BOOL" ;;
  }

  dimension: legal_name {
    type: string
    sql: ${TABLE}."LEGAL_NAME" ;;
  }

  dimension: moss_nexus_id {
    type: number
    sql: ${TABLE}."MOSS_NEXUS_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
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

  dimension: return_address {
    type: string
    sql: ${TABLE}."RETURN_ADDRESS" ;;
  }

  dimension: return_address1 {
    type: string
    sql: ${TABLE}."RETURN_ADDRESS1" ;;
  }

  dimension: return_address2 {
    type: string
    sql: ${TABLE}."RETURN_ADDRESS2" ;;
  }

  dimension: return_city {
    type: string
    sql: ${TABLE}."RETURN_CITY" ;;
  }

  dimension: return_country {
    type: string
    sql: ${TABLE}."RETURN_COUNTRY" ;;
  }

  dimension: return_state {
    type: string
    sql: ${TABLE}."RETURN_STATE" ;;
  }

  dimension: return_zipcode {
    type: string
    sql: ${TABLE}."RETURN_ZIPCODE" ;;
  }

  dimension: shipping_address {
    type: string
    sql: ${TABLE}."SHIPPING_ADDRESS" ;;
  }

  dimension: shipping_address1 {
    type: string
    sql: ${TABLE}."SHIPPING_ADDRESS1" ;;
  }

  dimension: shipping_address2 {
    type: string
    sql: ${TABLE}."SHIPPING_ADDRESS2" ;;
  }

  dimension: shipping_city {
    type: string
    sql: ${TABLE}."SHIPPING_CITY" ;;
  }

  dimension: shipping_country {
    type: string
    sql: ${TABLE}."SHIPPING_COUNTRY" ;;
  }

  dimension: shipping_state {
    type: string
    sql: ${TABLE}."SHIPPING_STATE" ;;
  }

  dimension: shipping_zipcode {
    type: string
    sql: ${TABLE}."SHIPPING_ZIPCODE" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: state_tax_number {
    type: string
    sql: ${TABLE}."STATE_TAX_NUMBER" ;;
  }

  dimension: subnav__searchable_subsidiary {
    type: number
    sql: ${TABLE}."SUBNAV__SEARCHABLE_SUBSIDIARY" ;;
  }

  dimension: subsidiary_extid {
    type: string
    sql: ${TABLE}."SUBSIDIARY_EXTID" ;;
  }

  dimension: taxonomy_reference_id {
    type: number
    sql: ${TABLE}."TAXONOMY_REFERENCE_ID" ;;
  }

  dimension: tran_num_prefix {
    type: string
    sql: ${TABLE}."TRAN_NUM_PREFIX" ;;
  }

  dimension: uen {
    type: string
    sql: ${TABLE}."UEN" ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}."URL" ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}."ZIPCODE" ;;
  }

  measure: count {
    type: count
    drill_fields: [subsidiary_id, name, legal_name, full_name]
  }
}
