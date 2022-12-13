include: "/views/transaction_lines.view.lkml"

view: +transaction_lines {

  parameter: source_breakdown {
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
    allowed_value: {
      label: "Customer Revenue Tier"
      value: "revenue_tier"
    }
  }

  dimension: source_category {
    sql:
      {% if source_breakdown._parameter_value == 'business_model' %}
      CASE WHEN ${account_salesforce.business_model_c} in ('MA', 'MOR', 'Both') THEN ${account_salesforce.business_model_c} ELSE NULL END
      {% elsif source_breakdown._parameter_value == 'region' %}
      ${cbit_clearbit_c.cbit_geo_region}
      {% elsif source_breakdown._parameter_value == 'plan' %}
      CASE WHEN ${account_salesforce.current_chargify_product_name_c} in ('Scaling Plan', 'Growing Plan', 'Starting Plan', 'Enterprise - Annual') THEN ${account_salesforce.current_chargify_product_name_c} ELSE NULL END
      {% elsif source_breakdown._parameter_value == 'revenue_tier' %}
      ${cbit_clearbit_c.master_customer_revenue_tier}
      {% else %}
      ${account_salesforce.current_chargify_product_name_c}
      {% endif %};;


  }
}
