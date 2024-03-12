# The name of this view in Looker is "Transaction History"
view: transaction_history {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: "NETSUITE"."TRANSACTION_HISTORY"
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called " Fivetran Deleted" in Explore.

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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
    sql: ${TABLE}.CAST(${TABLE}."_FIVETRAN_SYNCED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}."ACCOUNT_ID" ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}."ACTION" ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}."AMOUNT" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
  }

  measure: average_amount {
    type: average
    sql: ${amount} ;;
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
    sql: ${TABLE}.CAST(${TABLE}."DATE_DELETED" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.CAST(${TABLE}."DATE_TIME" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: date_transaction {
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
    sql: ${TABLE}.CAST(${TABLE}."DATE_TRANSACTION" AS TIMESTAMP_NTZ) ;;
  }

  dimension: document_number {
    type: string
    sql: ${TABLE}."DOCUMENT_NUMBER" ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}."ENTITY_ID" ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}."TRANSACTION_ID" ;;
  }

  dimension: transaction_number {
    type: string
    sql: ${TABLE}."TRANSACTION_NUMBER" ;;
  }

  dimension: transaction_type {
    type: string
    sql: ${TABLE}."TRANSACTION_TYPE" ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
