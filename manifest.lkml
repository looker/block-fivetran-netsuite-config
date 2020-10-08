project_name: "block-fivetran-netsuite-config-spreedly"

constant: CONNECTION_NAME {
  value: "snowflake"
}

constant: SCHEMA_NAME {
  value: "netsuite"
}

constant: CORE_PROJECT_NAME {
  value: "block-fivetran-netsuite-spreedly"
}


local_dependency: {
  project: "@{CORE_PROJECT_NAME}"

  override_constant: SCHEMA_NAME {
    value: "@{SCHEMA_NAME}"
  }
  override_constant: CONNECTION_NAME {
    value: "@{CONNECTION_NAME}"
  }
}
