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


  dimension: cos_name_group {

    sql: case

                when ${name} = 'COS Variable Compensation' then 'Headcount - COS'
                when ${name} = 'COS EE Insurance' then 'Headcount - COS'
                when ${name} = 'COS Salary' then 'Headcount - COS'
                when ${name} = 'COS Payroll Taxes' then 'Headcount - COS'
                when ${name} = 'COS Bonus' then 'Headcount - COS'
                when ${name} = '401k Employer Match' then 'Headcount - COS'
                when ${name} = 'COS Phone Bills' then 'Headcount - COS'
                when ${name} = 'Employee Insurance' then 'Headcount - COS'


                when ${name} = 'Hosting' then 'Operating Expense - COS'
                when ${name} = 'COS Account Updater Fees' then 'Operating Expense - COS'
                when ${name} = 'COS Merchant Account Fees' then 'Operating Expense - COS'
                when ${name} = 'COS Consulting' then 'Operating Expense - COS'
                when ${name} = 'COS Online Services' then 'Operating Expense - COS'
                when ${name} = 'COS PCI' then 'Operating Expense - COS'
                when ${name} = 'COS Computer Fees' then 'Operating Expense - COS'
                when ${name} = 'COS HSA Employer Match' then 'Operating Expense - COS'
                when ${name} = 'COS 401k Employer Match' then 'Operating Expense - COS'
                when ${name} = 'COS Meals' then 'Operating Expense - COS'
                when ${name} = 'COS Training / Conferences' then 'Operating Expense - COS'
                when ${name} = 'Expense - Ask my Accountant' then 'Operating Expense - COS'

                when ${name} = 'Online services' then 'Operating Expense - COS'
                when ${name} = 'Continuing Education' then 'Operating Expense - COS'
                when ${name} = 'Conferences' then 'Operating Expense - COS'
                when ${name} = 'Computer and Internet Expenses' then 'Operating Expense - COS'
                when ${name} = 'Parking' then 'Operating Expense - COS'
                when ${name} = 'Recruitment Expense' then 'Operating Expense - COS'
                when ${name} = 'Loss on Disposal of Asset' then 'Operating Expense - COS'
                when ${name} = 'Depreciation Expense' then 'Operating Expense - COS'
                when ${name} = 'Team Meals' then 'Operating Expense - COS'
                when ${name} = 'Travel Expense' then 'Operating Expense - COS'
                when ${name} = 'Meals and Entertainment' then 'Operating Expense - COS'


                     else ''
                          end
                        ;;
  }

# when ${name} = 'COS HSA Employer Match' then 'Headcount - COS'

  dimension: opex_name_group {

    sql: case

                      when ${name} = 'Commission Expense Contra Account' then 'Headcount Expense'
                      when ${name} = 'Salary' then 'Headcount Expense'
                      when ${name} = 'Payroll taxes - Employer' then 'Headcount Expense'
                      when ${name} = 'Salary Bonus' then 'Headcount Expense'
                      when ${name} = 'Employee Insurance' then 'Headcount Expense'
                      when ${name} = '401k Employer Match' then 'Headcount Expense'
                      when ${name} = 'Sales Commission' then 'Headcount Expense'
                      when ${name} = 'HSA Employer Match' then 'Headcount Expense'
                      when ${name} = 'Contractor Expense' then 'Headcount Expense'

                      when ${name} = 'Online services' then 'Non Headcount Expense'
                      when ${name} = 'Consulting Other' then 'Non Headcount Expense'
                      when ${name} = 'Rent Expense' then 'Non Headcount Expense'
                      when ${name} = 'Recruitment Expense' then 'Non Headcount Expense'
                      when ${name} = 'Business Insurance Expense' then 'Non Headcount Expense'
                      when ${name} = 'Advertising' then 'Non Headcount Expense'
                      when ${name} = 'Legal Expenses' then 'Non Headcount Expense'



                      when ${name} = 'Consulting Other' then 'Non Headcount Expense'
                      when ${name} = 'Telephone Expense' then 'Headcount Expense'
                      when ${name} = 'Professional Fees' then 'Non Headcount Expense'
                      when ${name} = 'Parking' then 'Non Headcount Expense'
                      when ${name} = 'HR & Payroll Service Fees' then 'Non Headcount Expense'
                      when ${name} = 'Taxes Other' then 'Non Headcount Expense'
                      when ${name} = 'Continuing Education' then 'Non Headcount Expense'
                      when ${name} = 'Rewards/Gifts' then 'Non Headcount Expense'
                      when ${name} = 'Computer and Internet Expenses' then 'Non Headcount Expense'
                      when ${name} = 'Marketing' then 'Non Headcount Expense'
                      when ${name} = 'Postage' then 'Non Headcount Expense'
                      when ${name} = 'Dues and Subscriptions' then 'Non Headcount Expense'
                      when ${name} = 'Workers Comp Ins' then 'Non Headcount Expense'
                      when ${name} = 'Payroll Taxes Contra Account' then 'Headcount Expense'
                      when ${name} = 'Meals and Entertainment' then 'Non Headcount Expense'
                      when ${name} = 'Conferences' then 'Non Headcount Expense'
                      when ${name} = 'Office Snacks & Drinks' then 'Non Headcount Expense'
                      when ${name} = 'Office Supplies' then 'Non Headcount Expense'
                      when ${name} = 'Team Meals' then 'Non Headcount Expense'
                      when ${name} = 'Accounting Expense' then 'Non Headcount Expense'
                      when ${name} = 'Office Expense' then 'Non Headcount Expense'
                      when ${name} = 'Bank Service Charges' then 'Non Headcount Expense'
                      when ${name} = 'Automobile Expense' then 'Non Headcount Expense'
                      when ${name} = 'Bad Debt Expense' then 'Non Headcount Expense'
                      when ${name} = 'Business Development Commission' then 'Non Headcount Expense'
                      when ${name} = 'Charitable Contributions - Deductible' then 'Non Headcount Expense'
                      when ${name} = 'Charitable Contributions - Non-Deductible' then 'Non Headcount Expense'
                      when ${name} = 'Cleaning Expense' then 'Non Headcount Expense'
                      when ${name} = 'Event Rentals' then 'Non Headcount Expense'
                      when ${name} = 'Expense - Ask my Accountant' then 'Non Headcount Expense'
                      when ${name} = 'Furniture & Fixtures Expense' then 'Non Headcount Expense'
                      when ${name} = 'Inside Sales Commission' then 'Non Headcount Expense'
                      when ${name} = 'Insurance Expense' then 'Non Headcount Expense'
                      when ${name} = 'Marketing Expense' then 'Non Headcount Expense'
                      when ${name} = 'Property Taxes' then 'Non Headcount Expense'
                      when ${name} = 'Relocation Expense' then 'Non Headcount Expense'
                      when ${name} = 'Severance' then 'Non Headcount Expense'
                      when ${name} = 'Stock Compensation' then 'Non Headcount Expense'
                      when ${name} = 'Swag' then 'Non Headcount Expense'
                      when ${name} = 'Travel Expense' then 'Non Headcount Expense'
                      when ${name} = 'Travel, Meals,and Entertainment' then 'Non Headcount Expense'
                      when ${name} = 'Utilities' then 'Non Headcount Expense'
                            else ''
                                end
                              ;;
  }


  # dimension: parent_account_ps{
  #   type: string
  #   sql: IFF(${parent_account.name} is null AND ${accounts.name} = 'Professional Services - Income', 'Professional Services - Income' ,${parent_account.name}) ;;
  # }

  # dimension: parent_account_name {
  #   type: string
  #   sql: coalesce(${parent_account_ps},${accounts.name}) ;;
  # }

  dimension: parent_account_name {
    type: string
    sql: coalesce(${parent_account.name},${accounts.name}) ;;
  }

# Can we instead try:
# IF(${parent_account.name} is NULL AND ${accounts.name} = "Professional Services"
# , "professional services", ${parent_account.name})


# Professional Services - Income
# So I'm thinking we can start by first changing the sql for the "${parent_account.name}"
# field (or create another field that references the ${parent_account.name}).
# If we're creating that other field, we can write something like IF(${parent_account.name} is NULL, "professional services", ${parent_account.name})
# -- may need to change a bit for your dialect




  dimension: category {
    label: "Financial Line Category"
    description: "Financial line (Income, Cost of Sales, Headcount Expenses, Operating Expenses)"
    type: string
    sql: CASE WHEN ${parent_account_name} in ('Contract Revenue', 'MtM Subscription Rev','Subscription Revenue') THEN 'Income'
          WHEN ${parent_account_name} in ('Account Updater Revenue', 'Conference Income', 'Gateway Revenue Share', 'Professional Services - Income') THEN 'Income'
          WHEN ${type_name} = 'Cost of Goods Sold' OR ( ${type_name} in ('Expense', 'Other Expense') AND ${departments.parent_id} = 2) THEN 'Cost of Sales'
          WHEN ${opex_name_group} = 'Headcount Expense' THEN 'Headcount Expenses'
          WHEN ${opex_name_group} = 'Non Headcount Expense' THEN 'Operating Expenses'
          END
          ;;
  }

  dimension: subcategory {
    label: "Financial Line Subcategory"
    description: "Financial line subcategory (Subscription Revenue, Other Income, Cost of Sales)"
    type: string
    sql: CASE WHEN ${parent_account_name} in ('Contract Revenue', 'MtM Subscription Rev','Subscription Revenue') THEN 'Subscription Revenue'
          WHEN ${parent_account_name} in ('Account Updater Revenue', 'Conference Income', 'Gateway Revenue Share', 'Professional Services - Income') THEN 'Other Income'
          WHEN ${type_name} = 'Cost of Goods Sold' OR ( ${type_name} in ('Expense', 'Other Expense') AND ${departments.parent_id} = 2) THEN 'Cost of Sales'
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
