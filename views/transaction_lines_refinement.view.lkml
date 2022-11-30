include: "/views/transaction_lines.view.lkml"

view: +transaction_lines {

  parameter: revenue_breakdown {
    type: unquoted
    allowed_value: {
      label: "Business Model"
      value: "business_model"
    }
    allowed_value: {
      label: "Geographic Region"
      value: "region"
    }
    allowed_value: {
      label: "Plan"
      value: "plan"
    }
  }

  dimension: revenue_source {
    sql:
      {% if revenue_breakdown._parameter_value == 'business_model' %}
      CASE WHEN ${account_salesforce.business_model_c} in ('MA', 'MOR', 'Both') THEN ${account_salesforce.business_model_c} ELSE NULL END
      {% elsif revenue_breakdown._parameter_value == 'region' %}
      ${cbit_clearbit_c.cbit_geo_region}
      {% elsif revenue_breakdown._parameter_value == 'plan' %}
      CASE WHEN ${account_salesforce.current_chargify_product_name_c} in ('Scaling Plan', 'Growing Plan', 'Starting Plan', 'Enterprise - Annual') THEN ${account_salesforce.current_chargify_product_name_c} ELSE NULL END
      {% else %}
      ${account_salesforce.current_chargify_product_name_c}
      {% endif %};;


  }
}
