view: expense_accounts {
  sql_table_name: "NETSUITE"."EXPENSE_ACCOUNTS"
    ;;
  drill_fields: [expense_account_id]

  dimension: expense_account_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."EXPENSE_ACCOUNT_ID" ;;
  }

  dimension: is_expense_account {
    type: yesno
    sql: ${expense_account_id} is not null ;;
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

  dimension: account_number {
    type: string
    sql: ${TABLE}."ACCOUNT_NUMBER" ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}."COMMENTS" ;;
  }

  dimension: current_balance {
    type: number
    sql: ${TABLE}."CURRENT_BALANCE" ;;
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

  dimension: desription {
    type: string
    sql: ${TABLE}."DESRIPTION" ;;
  }

  dimension: expense_account_extid {
    type: string
    sql: ${TABLE}."EXPENSE_ACCOUNT_EXTID" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: is_including_child_subs {
    type: string
    sql: ${TABLE}."IS_INCLUDING_CHILD_SUBS" ;;
  }

  dimension: is_summary {
    type: string
    sql: ${TABLE}."IS_SUMMARY" ;;
  }

  dimension: isinactive {
    type: string
    sql: ${TABLE}."ISINACTIVE" ;;
  }

  dimension: legal_name {
    type: string
    sql: ${TABLE}."LEGAL_NAME" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      expense_account_id,
      name,
      full_name,
      legal_name,
      items.count,
      vendors.count
    ]
  }
}
