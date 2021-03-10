view: accounts_netsuite {
  sql_table_name: @{SCHEMA_NAME}."ACCOUNTS"
    ;;
  drill_fields: [account_id]

  dimension: account_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ACCOUNT_ID" ;;
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

  dimension: account_extid {
    type: string
    sql: ${TABLE}."ACCOUNT_EXTID" ;;
  }

  dimension: account_modified_time {
    type: number
    sql: ${TABLE}."ACCOUNT_MODIFIED_TIME" ;;
  }

  dimension: account_subgroup_id {
    type: number
    sql: ${TABLE}."ACCOUNT_SUBGROUP_ID" ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}."ACCOUNTNUMBER" ;;
  }

  dimension: bank_account_number {
    type: string
    sql: ${TABLE}."BANK_ACCOUNT_NUMBER" ;;
  }

  dimension: cashflow_rate_type {
    type: string
    sql: ${TABLE}."CASHFLOW_RATE_TYPE" ;;
  }

  dimension: category_1099_misc {
    type: string
    sql: ${TABLE}."CATEGORY_1099_MISC" ;;
  }

  dimension: category_1099_misc_mthreshold {
    type: number
    sql: ${TABLE}."CATEGORY_1099_MISC_MTHRESHOLD" ;;
  }

  dimension: class_id {
    type: number
    sql: ${TABLE}."CLASS_ID" ;;
  }

  dimension: currency_id {
    type: number
    sql: ${TABLE}."CURRENCY_ID" ;;
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

  dimension: deferral_account_id {
    type: number
    sql: ${TABLE}."DEFERRAL_ACCOUNT_ID" ;;
  }

  dimension: department_id {
    type: number
    sql: ${TABLE}."DEPARTMENT_ID" ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }

  dimension: full_description {
    type: string
    sql: ${TABLE}."FULL_DESCRIPTION" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: general_rate_type {
    type: string
    sql: ${TABLE}."GENERAL_RATE_TYPE" ;;
  }

  dimension: is_balancesheet {
    type: string
    sql: ${TABLE}."IS_BALANCESHEET" ;;
  }

  dimension: is_included_in_elimination {
    type: string
    sql: ${TABLE}."IS_INCLUDED_IN_ELIMINATION" ;;
  }

  dimension: is_included_in_reval {
    type: string
    sql: ${TABLE}."IS_INCLUDED_IN_REVAL" ;;
  }

  dimension: is_including_child_subs {
    type: string
    sql: ${TABLE}."IS_INCLUDING_CHILD_SUBS" ;;
  }

  dimension: is_leftside {
    type: string
    sql: ${TABLE}."IS_LEFTSIDE" ;;
  }

  dimension: is_account_leftside {
    type: yesno
    sql: lower(${is_leftside})='t' ;;
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

  dimension: location_id {
    type: number
    sql: ${TABLE}."LOCATION_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }


  dimension: name_group {

    sql: case


                when ${name} = 'COS Salary' then 'Headcount - COS'
                when ${name} = 'Hosting' then 'Operating Expense - COS'
                when ${name} = 'COS Account Updater Fees' then 'Operating Expense - COS'
                when ${name} = 'Continuing Education' then 'Operating Expense - COS'
                when ${name} = 'COS Merchant Account Fees' then 'Operating Expense - COS'
                when ${name} = 'COS Consulting' then 'Operating Expense - COS'
                when ${name} = 'COS Online Services' then 'Operating Expense - COS'
                when ${name} = 'COS PCI' then 'Operating Expense - COS'
                when ${name} = 'COS EE Insurance' then 'Headcount - COS'
                when ${name} = 'COS Payroll Taxes' then 'Headcount - COS'
                when ${name} = 'COS Phone Bills' then 'Operating Expense - COS'
                when ${name} = 'COS Bonus' then 'Headcount - COS'
                when ${name} = '401k Employer Match' then 'Headcount - COS'
                when ${name} = 'Employee Insurance' then 'Headcount - COS'
                when ${name} = 'Computer and Internet Expenses' then 'Operating Expense - COS'
                when ${name} = 'Expense - Ask my Accountant' then 'Operating Expense - COS'


                       else ''
                          end
                        ;;
  }


# when ${name} = 'Online services' then 'Operating Expense - COS'
  # when ${name} = 'Conferences' then 'Operating Expense - COS'



  dimension: parent_account_name {
    type: string
    sql: coalesce(${parent_account.name},${accounts.name}) ;;
  }

  dimension: category {
    type: string
    sql: CASE WHEN ${parent_account_name} in ('Contract Revenue', 'MtM Subscription Rev') THEN 'Subscription Revenue'
    WHEN ${parent_account_name} in ('Account Updater Revenue', 'Conference Income', 'Gateway Revenue Share', 'Professional Services - Income') THEN 'Income'
    WHEN ${parent_account_name} in ('', '') THEN 'Cost of Sales'
    END
    ;;
  }

  dimension: is_account_intercompany {
    type: yesno
    sql: lower(${name}) like '%intercompany%' ;;
  }

  dimension: openbalance {
    type: number
    sql: ${TABLE}."OPENBALANCE" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  dimension: type_name {
    type: string
    sql: ${TABLE}."TYPE_NAME" ;;
  }

  dimension: is_accounts_payable {
    type: yesno
    sql: lower(${type_name}) like 'accounts payable%' ;;
  }

  dimension: is_accounts_receivable {
    type: yesno
    sql: lower(${type_name}) like 'accounts receivable%' ;;
  }

  dimension: type_sequence {
    type: number
    sql: ${TABLE}."TYPE_SEQUENCE" ;;
  }

  measure: count {
    type: count
    drill_fields: [account_id, name, type_name, legal_name, full_name]
  }
}
