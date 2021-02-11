view: locations {
  sql_table_name: "NETSUITE"."LOCATIONS"
    ;;
  drill_fields: [location_id]

  dimension: location_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
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

  dimension: address_one {
    type: string
    sql: ${TABLE}."ADDRESS_ONE" ;;
  }

  dimension: address_three {
    type: string
    sql: ${TABLE}."ADDRESS_THREE" ;;
  }

  dimension: address_two {
    type: string
    sql: ${TABLE}."ADDRESS_TWO" ;;
  }

  dimension: addressee {
    type: string
    sql: ${TABLE}."ADDRESSEE" ;;
  }

  dimension: attention {
    type: string
    sql: ${TABLE}."ATTENTION" ;;
  }

  dimension: branch_id {
    type: string
    sql: ${TABLE}."BRANCH_ID" ;;
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

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: inventory_available {
    type: string
    sql: ${TABLE}."INVENTORY_AVAILABLE" ;;
  }

  dimension: inventory_available_web_store {
    type: string
    sql: ${TABLE}."INVENTORY_AVAILABLE_WEB_STORE" ;;
  }

  dimension: is_include_in_supply_planning {
    type: string
    sql: ${TABLE}."IS_INCLUDE_IN_SUPPLY_PLANNING" ;;
  }

  dimension: isinactive {
    type: string
    sql: ${TABLE}."ISINACTIVE" ;;
  }

  dimension: location_extid {
    type: string
    sql: ${TABLE}."LOCATION_EXTID" ;;
  }

  dimension: location_modified_time {
    type: number
    sql: ${TABLE}."LOCATION_MODIFIED_TIME" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}."PHONE" ;;
  }

  dimension: return_address_one {
    type: string
    sql: ${TABLE}."RETURN_ADDRESS_ONE" ;;
  }

  dimension: return_address_two {
    type: string
    sql: ${TABLE}."RETURN_ADDRESS_TWO" ;;
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

  dimension: returnaddress {
    type: string
    sql: ${TABLE}."RETURNADDRESS" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: tran_num_prefix {
    type: string
    sql: ${TABLE}."TRAN_NUM_PREFIX" ;;
  }

  dimension: use_bins {
    type: string
    sql: ${TABLE}."USE_BINS" ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}."ZIPCODE" ;;
  }

  measure: count {
    type: count
    drill_fields: [location_id, name, full_name, items.count]
  }
}
