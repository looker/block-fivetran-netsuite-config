# The name of this view in Looker is "Entity"
view: entity {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: "NETSUITE"."ENTITY"
    ;;
  drill_fields: [tax_entity_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: tax_entity_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."TAX_ENTITY_ID" ;;
  }

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

  dimension_group: account_status {
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
    sql: ${TABLE}.CAST(${TABLE}."ACCOUNT_STATUS_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: account_status_id {
    type: number
    sql: ${TABLE}."ACCOUNT_STATUS_ID" ;;
  }

  dimension: account_updater_enabled {
    type: string
    sql: ${TABLE}."ACCOUNT_UPDATER_ENABLED" ;;
  }

  dimension_group: active_until {
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
    sql: ${TABLE}.CAST(${TABLE}."ACTIVE_UNTIL_DATE" AS TIMESTAMP_NTZ) ;;
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

  dimension: allow_letters_to_be_emailed {
    type: string
    sql: ${TABLE}."ALLOW_LETTERS_TO_BE_EMAILED" ;;
  }

  dimension: allow_letters_to_be_printed {
    type: string
    sql: ${TABLE}."ALLOW_LETTERS_TO_BE_PRINTED" ;;
  }

  dimension: annual_revenue {
    type: number
    sql: ${TABLE}."ANNUAL_REVENUE" ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_annual_revenue {
    type: sum
    sql: ${annual_revenue} ;;
  }

  measure: average_annual_revenue {
    type: average
    sql: ${annual_revenue} ;;
  }

  dimension: assess_use_tax_on_billavatax {
    type: string
    sql: ${TABLE}."ASSESS_USE_TAX_ON_BILLAVATAX" ;;
  }

  dimension: bcc_email_to_sales_representa {
    type: string
    sql: ${TABLE}."BCC_EMAIL_TO_SALES_REPRESENTA" ;;
  }

  dimension: bill_com_customer_name {
    type: string
    sql: ${TABLE}."BILL_COM_CUSTOMER_NAME" ;;
  }

  dimension: bill_com_last_updated_by_impo {
    type: string
    sql: ${TABLE}."BILL_COM_LAST_UPDATED_BY_IMPO" ;;
  }

  dimension: bill_com_shortname {
    type: string
    sql: ${TABLE}."BILL_COM_SHORTNAME" ;;
  }

  dimension: bill_com_vendor_info_id {
    type: number
    sql: ${TABLE}."BILL_COM_VENDOR_INFO_ID" ;;
  }

  dimension: bill_com_vendor_name {
    type: string
    sql: ${TABLE}."BILL_COM_VENDOR_NAME" ;;
  }

  dimension: billing_page {
    type: string
    sql: ${TABLE}."BILLING_PAGE" ;;
  }

  dimension: brn {
    type: string
    sql: ${TABLE}."BRN" ;;
  }

  dimension: chargify_cancellation_type {
    type: string
    sql: ${TABLE}."CHARGIFY_CANCELLATION_TYPE" ;;
  }

  dimension: chargify_customer_id {
    type: string
    sql: ${TABLE}."CHARGIFY_CUSTOMER_ID" ;;
  }

  dimension: chargify_subdomain {
    type: string
    sql: ${TABLE}."CHARGIFY_SUBDOMAIN" ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: collection_notes {
    type: string
    sql: ${TABLE}."COLLECTION_NOTES" ;;
  }

  dimension: collection_status {
    type: string
    sql: ${TABLE}."COLLECTION_STATUS" ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension_group: create {
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
    sql: ${TABLE}.CAST(${TABLE}."CREATE_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: customer_activation {
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
    sql: ${TABLE}.CAST(${TABLE}."CUSTOMER_ACTIVATION_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: customer_industry {
    type: string
    sql: ${TABLE}."CUSTOMER_INDUSTRY" ;;
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
    sql: ${TABLE}.CAST(${TABLE}."DATE_LAST_MODIFIED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: default_department_id {
    type: number
    sql: ${TABLE}."DEFAULT_DEPARTMENT_ID" ;;
  }

  dimension: default_payment_method_id {
    type: number
    sql: ${TABLE}."DEFAULT_PAYMENT_METHOD_ID" ;;
  }

  dimension: dic {
    type: string
    sql: ${TABLE}."DIC" ;;
  }

  dimension: do_not_send_letters_to_custom {
    type: string
    sql: ${TABLE}."DO_NOT_SEND_LETTERS_TO_CUSTOM" ;;
  }

  dimension: dunning_level_id {
    type: number
    sql: ${TABLE}."DUNNING_LEVEL_ID" ;;
  }

  dimension: dunning_manager_id {
    type: number
    sql: ${TABLE}."DUNNING_MANAGER_ID" ;;
  }

  dimension: dunning_notifications_for_gro {
    type: string
    sql: ${TABLE}."DUNNING_NOTIFICATIONS_FOR_GRO" ;;
  }

  dimension: dunning_pause_reason_detail_id {
    type: number
    sql: ${TABLE}."DUNNING_PAUSE_REASON_DETAIL_ID" ;;
  }

  dimension: dunning_pause_reason_id {
    type: number
    sql: ${TABLE}."DUNNING_PAUSE_REASON_ID" ;;
  }

  dimension: dunning_procedure_id {
    type: number
    sql: ${TABLE}."DUNNING_PROCEDURE_ID" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: employee_planning_category_id {
    type: number
    sql: ${TABLE}."EMPLOYEE_PLANNING_CATEGORY_ID" ;;
  }

  dimension: entity_extid {
    type: string
    sql: ${TABLE}."ENTITY_EXTID" ;;
  }

  dimension: entity_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."ENTITY_ID" ;;
  }

  dimension: entity_type {
    type: string
    sql: ${TABLE}."ENTITY_TYPE" ;;
  }

  dimension: exclude_from_bill_com {
    type: string
    sql: ${TABLE}."EXCLUDE_FROM_BILL_COM" ;;
  }

  dimension: exemption_certificate_no {
    type: string
    sql: ${TABLE}."EXEMPTION_CERTIFICATE_NO" ;;
  }

  dimension: feature_level {
    type: string
    sql: ${TABLE}."FEATURE_LEVEL" ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: gateway_type {
    type: string
    sql: ${TABLE}."GATEWAY_TYPE" ;;
  }

  dimension: global_subscription_status {
    type: number
    sql: ${TABLE}."GLOBAL_SUBSCRIPTION_STATUS" ;;
  }

  dimension: hubspot_link {
    type: string
    sql: ${TABLE}."HUBSPOT_LINK" ;;
  }

  dimension: ico {
    type: string
    sql: ${TABLE}."ICO" ;;
  }

  dimension: id_number_in_the_country_of_r {
    type: string
    sql: ${TABLE}."ID_NUMBER_IN_THE_COUNTRY_OF_R" ;;
  }

  dimension: id_type_in_the_country_of_r_id {
    type: number
    sql: ${TABLE}."ID_TYPE_IN_THE_COUNTRY_OF_R_ID" ;;
  }

  dimension: industry_id {
    type: number
    sql: ${TABLE}."INDUSTRY_ID" ;;
  }

  dimension: is_inactive {
    type: string
    sql: ${TABLE}."IS_INACTIVE" ;;
  }

  dimension: is_online_bill_pay {
    type: string
    sql: ${TABLE}."IS_ONLINE_BILL_PAY" ;;
  }

  dimension: is_unavailable {
    type: string
    sql: ${TABLE}."IS_UNAVAILABLE" ;;
  }

  dimension: last_dunning_evaluation_res_id {
    type: number
    sql: ${TABLE}."LAST_DUNNING_EVALUATION_RES_ID" ;;
  }

  dimension_group: last_email_sent {
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
    sql: ${TABLE}.CAST(${TABLE}."LAST_EMAIL_SENT" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}.CAST(${TABLE}."LAST_MODIFIED_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension_group: last_sales_activity {
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
    sql: ${TABLE}.CAST(${TABLE}."LAST_SALES_ACTIVITY" AS TIMESTAMP_NTZ) ;;
  }

  dimension: lava_organization {
    type: string
    sql: ${TABLE}."LAVA_ORGANIZATION" ;;
  }

  dimension: login_access {
    type: string
    sql: ${TABLE}."LOGIN_ACCESS" ;;
  }

  dimension: lsa_link {
    type: string
    sql: ${TABLE}."LSA_LINK" ;;
  }

  dimension: lsa_link_name {
    type: string
    sql: ${TABLE}."LSA_LINK_NAME" ;;
  }

  dimension: middle_name {
    type: string
    sql: ${TABLE}."MIDDLE_NAME" ;;
  }

  dimension: most_recent_communication {
    type: string
    sql: ${TABLE}."MOST_RECENT_COMMUNICATION" ;;
  }

  dimension: mt_employee_default_address {
    type: string
    sql: ${TABLE}."MT_EMPLOYEE_DEFAULT_ADDRESS" ;;
  }

  dimension: multiple_emails {
    type: string
    sql: ${TABLE}."MULTIPLE_EMAILS" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: next_action_lead_id {
    type: number
    sql: ${TABLE}."NEXT_ACTION_LEAD_ID" ;;
  }

  dimension: next_collection_action {
    type: string
    sql: ${TABLE}."NEXT_COLLECTION_ACTION" ;;
  }

  dimension: no__of_employees {
    type: number
    sql: ${TABLE}."NO__OF_EMPLOYEES" ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}."NOTES" ;;
  }

  dimension: originator_id {
    type: string
    sql: ${TABLE}."ORIGINATOR_ID" ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}."PARENT_ID" ;;
  }

  dimension: pause_dunning {
    type: string
    sql: ${TABLE}."PAUSE_DUNNING" ;;
  }

  dimension: payroll_id {
    type: string
    sql: ${TABLE}."PAYROLL_ID" ;;
  }

  dimension: personal_email {
    type: string
    sql: ${TABLE}."PERSONAL_EMAIL" ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}."PHONE" ;;
  }

  dimension: planning__budgeting_categor_id {
    type: number
    sql: ${TABLE}."PLANNING__BUDGETING_CATEGOR_ID" ;;
  }

  dimension: preferred_name {
    type: string
    sql: ${TABLE}."PREFERRED_NAME" ;;
  }

  dimension: reactivation_flag {
    type: string
    sql: ${TABLE}."REACTIVATION_FLAG" ;;
  }

  dimension: restrict_access_to_expensify {
    type: string
    sql: ${TABLE}."RESTRICT_ACCESS_TO_EXPENSIFY" ;;
  }

  dimension_group: revenue_churn {
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
    sql: ${TABLE}.CAST(${TABLE}."REVENUE_CHURN_DATE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: salesforce_id {
    type: string
    sql: ${TABLE}."SALESFORCE_ID" ;;
  }

  dimension: salutation {
    type: string
    sql: ${TABLE}."SALUTATION" ;;
  }

  dimension: spreedly_billing_id {
    type: string
    sql: ${TABLE}."SPREEDLY_BILLING_ID" ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension_group: subscription_customer_revenu_0 {
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
    sql: ${TABLE}.CAST(${TABLE}."SUBSCRIPTION_CUSTOMER_REVENU_0" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: subscription_customer_revenue {
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
    sql: ${TABLE}.CAST(${TABLE}."SUBSCRIPTION_CUSTOMER_REVENUE" AS TIMESTAMP_NTZ) ;;
  }

  dimension: subscription_plan_id {
    type: number
    sql: ${TABLE}."SUBSCRIPTION_PLAN_ID" ;;
  }

  dimension: subsidiary {
    type: number
    sql: ${TABLE}."SUBSIDIARY" ;;
  }

  dimension: tax_contact_first_name {
    type: string
    sql: ${TABLE}."TAX_CONTACT_FIRST_NAME" ;;
  }

  dimension: tax_contact_id {
    type: number
    sql: ${TABLE}."TAX_CONTACT_ID" ;;
  }

  dimension: tax_contact_last_name {
    type: string
    sql: ${TABLE}."TAX_CONTACT_LAST_NAME" ;;
  }

  dimension: tax_contact_middle_name {
    type: string
    sql: ${TABLE}."TAX_CONTACT_MIDDLE_NAME" ;;
  }

  dimension: tax_number {
    type: string
    sql: ${TABLE}."TAX_NUMBER" ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}."TEAM_ID" ;;
  }

  dimension: type_id {
    type: number
    sql: ${TABLE}."TYPE_ID" ;;
  }

  dimension: uen {
    type: string
    sql: ${TABLE}."UEN" ;;
  }

  dimension: unsubscribed {
    type: string
    sql: ${TABLE}."UNSUBSCRIBED" ;;
  }

  dimension: vat_registration_no {
    type: string
    sql: ${TABLE}."VAT_REGISTRATION_NO" ;;
  }

  dimension: vendor_billing_information {
    type: string
    sql: ${TABLE}."VENDOR_BILLING_INFORMATION" ;;
  }

  dimension: vendor_payment_information {
    type: string
    sql: ${TABLE}."VENDOR_PAYMENT_INFORMATION" ;;
  }

  dimension: vendor_planning_category_id {
    type: number
    sql: ${TABLE}."VENDOR_PLANNING_CATEGORY_ID" ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}."ZIPCODE" ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      tax_entity_id,
      bill_com_shortname,
      bill_com_customer_name,
      tax_contact_middle_name,
      name,
      tax_contact_last_name,
      last_name,
      lsa_link_name,
      bill_com_vendor_name,
      full_name,
      middle_name,
      first_name,
      tax_contact_first_name,
      preferred_name,
      entity.bill_com_shortname,
      entity.bill_com_customer_name,
      entity.tax_contact_middle_name,
      entity.name,
      entity.tax_contact_last_name,
      entity.last_name,
      entity.lsa_link_name,
      entity.bill_com_vendor_name,
      entity.full_name,
      entity.middle_name,
      entity.first_name,
      entity.tax_entity_id,
      entity.tax_contact_first_name,
      entity.preferred_name,
      entity.count
    ]
  }
}
