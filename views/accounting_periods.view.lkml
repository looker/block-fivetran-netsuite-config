view: accounting_periods {
  sql_table_name: @{SCHEMA_NAME}."ACCOUNTING_PERIODS"
    ;;
  drill_fields: [accounting_period_id]

  dimension: accounting_period_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ACCOUNTING_PERIOD_ID" ;;
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

  dimension: closed {
    type: string
    sql: ${TABLE}."CLOSED" ;;
  }

  dimension: is_accounting_period_closed {
    type: yesno
    sql: lower(${closed})='yes' ;;
  }

  dimension: closed_accounts_payable {
    type: string
    sql: ${TABLE}."CLOSED_ACCOUNTS_PAYABLE" ;;
  }

  dimension: closed_accounts_receivable {
    type: string
    sql: ${TABLE}."CLOSED_ACCOUNTS_RECEIVABLE" ;;
  }

  dimension: closed_all {
    type: string
    sql: ${TABLE}."CLOSED_ALL" ;;
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
    sql: CAST(${TABLE}."CLOSED_ON" AS TIMESTAMP_NTZ) ;;
  }

  dimension: closed_payroll {
    type: string
    sql: ${TABLE}."CLOSED_PAYROLL" ;;
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

  dimension_group: ending {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      quarter_of_year,
      year
    ]
    sql: CAST(${TABLE}."ENDING" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: current {
    type: time
    sql: current_timestamp;;
  }

  dimension_group: since_ending{
    description: "This summarizes all dates to the first of the month"
    type: duration
    intervals: [month, quarter, year]
    sql_start: ${ending_month::date} ;;
    sql_end: ${current_month::date} ;;
  }

  dimension: fiscal_calendar_id {
    type: number
    sql: ${TABLE}."FISCAL_CALENDAR_ID" ;;
  }

  dimension: fivetran_index {
    type: string
    sql: ${TABLE}."FIVETRAN_INDEX" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: is_adjustment {
    type: string
    sql: ${TABLE}."IS_ADJUSTMENT" ;;
  }

  dimension: is_accounting_period_adjustment {
    type: yesno
    sql: lower(${is_adjustment})='yes' ;;
  }

  dimension: isinactive {
    type: string
    sql: ${TABLE}."ISINACTIVE" ;;
  }

  dimension: locked_accounts_payable {
    type: string
    sql: ${TABLE}."LOCKED_ACCOUNTS_PAYABLE" ;;
  }

  dimension: locked_accounts_receivable {
    type: string
    sql: ${TABLE}."LOCKED_ACCOUNTS_RECEIVABLE" ;;
  }

  dimension: locked_all {
    type: string
    sql: ${TABLE}."LOCKED_ALL" ;;
  }

  dimension: locked_payroll {
    type: string
    sql: ${TABLE}."LOCKED_PAYROLL" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  dimension: quarter {
    type: string
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension_group: starting {
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
    sql: CAST(${TABLE}."STARTING" AS TIMESTAMP_NTZ) ;;
  }

  dimension: year_0 {
    type: string
    sql: ${TABLE}."YEAR_0" ;;
  }

  dimension: year_id {
    type: number
    sql: ${TABLE}."YEAR_ID" ;;
  }

  measure: count {
    type: count
    drill_fields: [accounting_period_id, name, full_name, consolidated_exchange_rates.count, transactions.count]
  }
}
