view: departments {
  sql_table_name: "NETSUITE"."DEPARTMENTS"
    ;;
  drill_fields: [department_id]

  dimension: department_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."DEPARTMENT_ID" ;;
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

  dimension: department_extid {
    type: string
    sql: ${TABLE}."DEPARTMENT_EXTID" ;;
  }

  dimension: department_modified_time {
    type: number
    sql: ${TABLE}."DEPARTMENT_MODIFIED_TIME" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."FULL_NAME" ;;
  }

  dimension: is_including_child_subs {
    type: string
    sql: ${TABLE}."IS_INCLUDING_CHILD_SUBS" ;;
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


  dimension: parent_department_name {

    sql: case

      when ${name} = 'Engineering' then 'Research & Development'
      when ${name} = 'Product Development' then 'Research & Development'
      when ${name} = 'Security & Compliance' then 'Research & Development'
      when ${name} = 'Systems Engineering' then 'Research & Development'
      when ${name} = 'Support' then 'Research & Development'
      when ${name} = 'Business Operations' then 'General and Administrative'
      when ${name} = 'Human Resources' then 'General and Administrative'
      when ${name} = 'Finance' then 'General and Administrative'
      when ${name} = 'Information Technology' then 'General and Administrative'
      when ${name} = 'Marketing' then 'Sales & Marketing'
      when ${name} = 'Enterprise' then 'Sales & Marketing'
      when ${name} = 'Professional Service' then 'Sales & Marketing'
      when ${name} = 'Business Development' then 'Sales & Marketing'
      when ${name} = 'Customer Success' then 'Sales & Marketing'
      when ${name} = 'Paymentsfn' then 'Sales & Marketing'

                             else ''
                                end
                              ;;
  }







  measure: count {
    type: count
    drill_fields: [department_id, full_name, name, items.count]
  }
}
