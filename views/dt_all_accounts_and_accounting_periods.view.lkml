view: dt_all_accounts_and_accounting_periods {
  derived_table: {
    sql: SELECT account_id, accounting_period_id, department_id
        FROM NETSUITE.ACCOUNTS
        CROSS JOIN NETSUITE.ACCOUNTING_PERIODS
        CROSS JOIN NETSUITE.DEPARTMENTS;;
    persist_for: "24 hours"
  }


  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${account_id}, ${accounting_period_id}) ;;
    # sql: concat(${account_id}, ${accounting_period_id}, ${customer_id}) ;;
  }

  dimension: account_id {
    hidden: no
    type: number
    sql: ${TABLE}."ACCOUNT_ID" ;;
  }

  dimension: accounting_period_id {
    hidden: no
    type: number
    sql: ${TABLE}."ACCOUNTING_PERIOD_ID" ;;
  }

 dimension: department_id {
    hidden: no
    type: number
    sql: ${TABLE}."DEPARTMENT_ID" ;;
  }


  # dimension: customer_id {
  #   hidden: no
  #   type: number
  #   sql: ${TABLE}."CUSTOMER_ID" ;;
  # }


}
