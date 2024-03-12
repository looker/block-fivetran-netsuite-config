view: accounting_books {
  sql_table_name: @{SCHEMA_NAME}."ACCOUNTING_BOOKS"
    ;;
  drill_fields: [accounting_book_id]

  dimension: accounting_book_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ACCOUNTING_BOOK_ID" ;;
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

  dimension: accounting_book_extid {
    type: string
    sql: ${TABLE}."ACCOUNTING_BOOK_EXTID" ;;
  }

  dimension: accounting_book_name {
    type: string
    sql: ${TABLE}."ACCOUNTING_BOOK_NAME" ;;
  }

  dimension: base_book_id {
    type: number
    sql: ${TABLE}."BASE_BOOK_ID" ;;
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

  dimension: effective_period_id {
    type: number
    sql: ${TABLE}."EFFECTIVE_PERIOD_ID" ;;
  }

  dimension: form_template_component_id {
    type: string
    sql: ${TABLE}."FORM_TEMPLATE_COMPONENT_ID" ;;
  }

  dimension: form_template_id {
    type: number
    sql: ${TABLE}."FORM_TEMPLATE_ID" ;;
  }

  dimension: is_adjustment_only {
    type: string
    sql: ${TABLE}."IS_ADJUSTMENT_ONLY" ;;
  }

  dimension: is_arrangement_level_reclass {
    type: string
    sql: ${TABLE}."IS_ARRANGEMENT_LEVEL_RECLASS" ;;
  }

  dimension: is_consolidated {
    type: string
    sql: ${TABLE}."IS_CONSOLIDATED" ;;
  }

  dimension: is_contingent_revenue_handling {
    type: string
    sql: ${TABLE}."IS_CONTINGENT_REVENUE_HANDLING" ;;
  }

  dimension: is_include_child_subsidiaries {
    type: string
    sql: ${TABLE}."IS_INCLUDE_CHILD_SUBSIDIARIES" ;;
  }

  dimension: is_primary {
    type: string
    sql: ${TABLE}."IS_PRIMARY" ;;
  }

  dimension: is_two_step_revenue_allocation {
    type: string
    sql: ${TABLE}."IS_TWO_STEP_REVENUE_ALLOCATION" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: unbilled_receivable_grouping {
    type: string
    sql: ${TABLE}."UNBILLED_RECEIVABLE_GROUPING" ;;
  }

  measure: count {
    type: count
    drill_fields: [accounting_book_id, accounting_book_name, consolidated_exchange_rates.count, transactions.count]
  }
}
