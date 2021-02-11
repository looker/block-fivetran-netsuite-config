view: vendor_types {
  sql_table_name: "NETSUITE"."VENDOR_TYPES"
    ;;
  drill_fields: [vendor_type_id]

  dimension: vendor_type_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."VENDOR_TYPE_ID" ;;
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

  dimension: isinactive {
    type: string
    sql: ${TABLE}."ISINACTIVE" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  dimension: vendor_type_extid {
    type: string
    sql: ${TABLE}."VENDOR_TYPE_EXTID" ;;
  }

  measure: count {
    type: count
    drill_fields: [vendor_type_id, name, vendors.count]
  }
}
