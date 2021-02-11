view: budget {
  sql_table_name: "NETSUITE"."BUDGET"
    ;;
  drill_fields: [budget_id]

  dimension: budget_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."BUDGET_ID" ;;
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

  dimension: accounting_book_id {
    type: number
    sql: ${TABLE}."ACCOUNTING_BOOK_ID" ;;
  }

  dimension: accounting_period_id {
    type: number
    sql: ${TABLE}."ACCOUNTING_PERIOD_ID" ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}."AMOUNT" ;;
  }

  dimension_group: budget {
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
    sql: CAST(${TABLE}."BUDGET_DATE" AS TIMESTAMP_NTZ) ;;
  }


  dimension: category_id {
    type: number
    sql: ${TABLE}."CATEGORY_ID" ;;
  }

  dimension: class_id {
    type: number
    sql: ${TABLE}."CLASS_ID" ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}."CUSTOMER_ID" ;;
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

  dimension: department_id {
    type: number
    sql: ${TABLE}."DEPARTMENT_ID" ;;
  }

  dimension: item_id {
    type: number
    sql: ${TABLE}."ITEM_ID" ;;
  }

  dimension: location_id {
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
  }

  dimension: subsidiary_id {
    type: number
    sql: ${TABLE}."SUBSIDIARY_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [budget_id]
  }

  measure: sum_amount {
    type: sum
    value_format_name: usd
    sql: ${amount} ;;
    # drill_fields: [detail*]

  }



}
