include: "/views/transaction_lines.view"
#This view is used to store any parameters, dimensions and measures specifically used for the Monthly and YTD tabs of the monthly board package
view: +transaction_lines {
  parameter: selector_date  {
    view_label: "Monthly YTD Financials"
    type: date
  }

  dimension: is_this_month {
    view_label: "Monthly YTD Financials"
    type: yesno
    sql: EXTRACT(MONTH FROM ${accounting_periods.ending_raw}) = EXTRACT(MONTH from {% parameter selector_date %})
      AND EXTRACT(YEAR FROM ${accounting_periods.ending_raw}) = EXTRACT(YEAR from {% parameter selector_date %});;
  }

  dimension: is_this_month_prior_year {
    view_label: "Monthly YTD Financials"
    type: yesno
    sql: EXTRACT(MONTH FROM ${accounting_periods.ending_raw}) = EXTRACT(MONTH from {% parameter selector_date %})
      AND EXTRACT(YEAR FROM ${accounting_periods.ending_raw})+1 = EXTRACT(YEAR from {% parameter selector_date %});;
  }

  dimension: is_this_month_ytd {
    view_label: "Monthly YTD Financials"
    type: yesno
    sql: EXTRACT(MONTH FROM ${accounting_periods.ending_raw}) <= EXTRACT(MONTH from {% parameter selector_date %})
      AND EXTRACT(YEAR FROM ${accounting_periods.ending_raw}) = EXTRACT(YEAR from {% parameter selector_date %});;
  }

  dimension: is_this_month_prior_year_ytd {
    view_label: "Monthly YTD Financials"
    type: yesno
    sql: EXTRACT(MONTH FROM ${accounting_periods.ending_raw}) <= EXTRACT(MONTH from {% parameter selector_date %})
      AND EXTRACT(YEAR FROM ${accounting_periods.ending_raw})+1 = EXTRACT(YEAR from {% parameter selector_date %});;
  }




######################## Monthly tab measures ########################
  measure: sum_transaction_amount_this_month {
    view_label: "Monthly YTD Financials"
    label: "Selected Month Actual"
    group_label: "Actuals"
    type: sum
    value_format_name: usd_0
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [is_this_month: "Yes"]
    drill_fields: [transaction_lines..detail*]
  }

  measure: sum_transaction_amount_this_month_prior_year {
    view_label: "Monthly YTD Financials"
    label: "Prior Year Actual"
    group_label: "Actuals"
    type: sum
    value_format_name: usd_0
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [is_this_month_prior_year: "Yes"]
    drill_fields: [transaction_lines..detail*]
  }

  measure: budget_sum_amount_this_month {
    view_label: "Monthly YTD Financials"
    label: "Selected Month Plan"
    group_label: "Budget"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    value_format_name: usd_0
    sql: ${budget.amount} ;;
    filters: [is_this_month: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: budget_variance {
    view_label: "Monthly YTD Financials"
    label: "Variance to Plan ($ Change)"
    group_label: "Variance"
    type: number
    value_format_name: usd_0
    sql: ${sum_transaction_amount_this_month} - ${budget_sum_amount_this_month} ;;
  }

  measure: budget_variance_pct {
    view_label: "Monthly YTD Financials"
    label: "Variance to Plan (%)"
    group_label: "Variance"
    type: number
    value_format_name: percent_0
    sql: ${budget_variance} / NULLIF(${budget_sum_amount_this_month},0) ;;
  }

  measure: yoy_variance {
    view_label: "Monthly YTD Financials"
    label: "YoY Growth ($ Change)"
    group_label: "Variance"
    type: number
    value_format_name: usd_0
    sql: ${sum_transaction_amount_this_month} - ${sum_transaction_amount_this_month_prior_year} ;;
  }

  measure: yoy_variance_pct {
    view_label: "Monthly YTD Financials"
    label: "YoY Growth (%)"
    group_label: "Variance"
    type: number
    value_format_name: percent_0
    sql: ${yoy_variance} / NULLIF(${sum_transaction_amount_this_month_prior_year},0) ;;
  }

  measure: total_income_this_month{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Income" , is_this_month: "Yes"]
  }

  measure: total_cos_this_month{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Cost of Sales", is_this_month: "Yes"]
  }

  measure: total_expenses_this_month{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.name_group: "Headcount Expense, Non Headcount Expense", is_this_month: "Yes"]
  }

  measure: gross_profit_this_month{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: number
    value_format_name: usd_0
    sql: ${total_income_this_month}-${total_cos_this_month} ;;
  }

  measure: total_income_this_month_prior_year{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Income" , is_this_month_prior_year: "Yes"]
  }

  measure: total_cos_this_month_prior_year{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Cost of Sales", is_this_month_prior_year: "Yes"]
  }

  measure: total_expenses_this_month_prior_year{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.name_group: "Headcount Expense, Non Headcount Expense", is_this_month_prior_year: "Yes"]
  }

  measure: gross_profit_this_month_prior_year{
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: number
    value_format_name: usd_0
    sql: ${total_income_this_month_prior_year}-${total_cos_this_month_prior_year} ;;
  }

  measure: total_income_budget_this_month {
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    sql: ${budget.amount} ;;
    value_format_name: usd_0
    filters: [accounts.category: "Income" , is_this_month: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: total_cos_budget_this_month {
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    sql: ${budget.amount} ;;
    value_format_name: usd_0
    filters: [accounts.category: "Cost of Sales", is_this_month: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: total_expenses_budget_this_month {
    view_label: "Monthly YTD Financials"
    group_label: "Actuals"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    sql: ${budget.amount} ;;
    value_format_name: usd_0
    filters: [accounts.name_group: "Headcount Expense, Non Headcount Expense", is_this_month: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: budget_gross_profit_this_month {
    view_label: "Monthly YTD Financials"
    label: "Selected Month Gross Profit Budget"
    group_label: "Budget"
    type: number
    value_format_name: usd_0
    sql: ${total_income_budget_this_month}-${total_cos_budget_this_month} ;;
  }

  measure: gross_profit_budget_variance {
    view_label: "Monthly YTD Financials"
    label: "Gross Profit Variance to Plan ($ Change)"
    group_label: "Variance"
    type: number
    value_format_name: usd_0
    sql: ${gross_profit_this_month} - ${budget_gross_profit_this_month} ;;
  }

  measure: gross_profit_budget_variance_pct {
    view_label: "Monthly YTD Financials"
    label: "Gross Profit Variance to Plan (%)"
    group_label: "Variance"
    type: number
    value_format_name: percent_0
    sql: ${gross_profit_budget_variance} / NULLIF(${budget_gross_profit_this_month},0) ;;
  }

  measure: gross_profit_yoy_variance {
    view_label: "Monthly YTD Financials"
    label: "Gross Profit YoY Growth ($ Change)"
    group_label: "Variance"
    type: number
    value_format_name: usd_0
    sql: ${gross_profit_this_month} - ${gross_profit_this_month_prior_year} ;;
  }

  measure: yoy_variance_pct {
    view_label: "Monthly YTD Financials"
    label: "Gross Profit YoY Growth (%)"
    group_label: "Variance"
    type: number
    value_format_name: percent_0
    sql: ${gross_profit_yoy_variance} / NULLIF(${gross_profit_this_month_prior_year},0) ;;
  }





######################## YTD tab measures ########################
  measure: sum_transaction_amount_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Actual"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd_0
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [is_this_month_ytd: "Yes"]
    drill_fields: [transaction_lines..detail*]
  }

  measure: sum_transaction_amount_this_month_prior_year_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Prior Year Actual"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd_0
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [is_this_month_prior_year_ytd: "Yes"]
    drill_fields: [transaction_lines..detail*]
  }

  measure: budget_sum_amount_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Selected Month Plan"
    group_label: "YTD Budget"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    value_format_name: usd_0
    sql: ${budget.amount} ;;
    filters: [is_this_month_ytd: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: budget_variance_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Variance to Plan ($ Change)"
    group_label: "YTD Variance"
    type: number
    value_format_name: usd_0
    sql: ${sum_transaction_amount_this_month_ytd} - ${budget_sum_amount_this_month_ytd} ;;
  }

  measure: budget_variance_pct_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Variance to Plan (%)"
    group_label: "YTD Variance"
    type: number
    value_format_name: percent_0
    sql: ${budget_variance_ytd} / NULLIF(${budget_sum_amount_this_month_ytd},0) ;;
  }

  measure: yoy_variance_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD YoY Growth ($ Change)"
    group_label: "YTD Variance"
    type: number
    value_format_name: usd_0
    sql: ${sum_transaction_amount_this_month_ytd} - ${sum_transaction_amount_this_month_prior_year_ytd} ;;
  }

  measure: yoy_variance_pct_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD YoY Growth (%)"
    group_label: "YTD Variance"
    type: number
    value_format_name: percent_0
    sql: ${yoy_variance_ytd} / NULLIF(${sum_transaction_amount_this_month_prior_year_ytd},0) ;;
  }

  measure: total_income_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Income"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Income" , is_this_month_ytd: "Yes"]
  }

  measure: total_cos_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD COS"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Cost of Sales", is_this_month_ytd: "Yes"]
  }

  measure: total_expenses_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Expenses"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.name_group: "Headcount Expense, Non Headcount Expense", is_this_month_ytd: "Yes"]
  }

  measure: gross_profit_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Gross Profit"
    group_label: "YTD Actuals"
    type: number
    value_format_name: usd_0
    sql: ${total_income_this_month_ytd}-${total_cos_this_month_ytd} ;;
  }

  measure: total_income_this_month_prior_year_ytd{
    view_label: "Monthly YTD Financials"
    label: "YTD Income Prior Year"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Income" , is_this_month_prior_year_ytd: "Yes"]
  }

  measure: total_cos_this_month_prior_year_ytd{
    view_label: "Monthly YTD Financials"
    label: "YTD COS Prior Year"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.category: "Cost of Sales", is_this_month_prior_year_ytd: "Yes"]
  }

  measure: total_expenses_this_month_prior_year_ytd{
    view_label: "Monthly YTD Financials"
    label: "YTD Expenses Prior Year"
    group_label: "YTD Actuals"
    type: sum
    value_format_name: usd
    sql: ${transaction_lines.transaction_amount} ;;
    filters: [accounts.name_group: "Headcount Expense, Non Headcount Expense", is_this_month_prior_year_ytd: "Yes"]
  }

  measure: gross_profit_this_month_prior_year_ytd{
    view_label: "Monthly YTD Financials"
    label: "YTD Gross Profit Prior Year"
    group_label: "YTD Actuals"
    type: number
    value_format_name: usd_0
    sql: ${total_income_this_month_prior_year_ytd}-${total_cos_this_month_prior_year_ytd} ;;
  }

  measure: total_income_budget_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Income Budget"
    group_label: "YTD Actuals"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    sql: ${budget.amount} ;;
    value_format_name: usd_0
    filters: [accounts.category: "Income" , is_this_month_ytd: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: total_cos_budget_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD COS Budget"
    group_label: "YTD Actuals"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    sql: ${budget.amount} ;;
    value_format_name: usd_0
    filters: [accounts.category: "Cost of Sales", is_this_month_ytd: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: total_expenses_budget_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Expenses Budget"
    group_label: "YTD Actuals"
    type: sum_distinct
    sql_distinct_key: ${budget.budget_id} ;;
    sql: ${budget.amount} ;;
    value_format_name: usd_0
    filters: [accounts.name_group: "Headcount Expense, Non Headcount Expense", is_this_month_ytd: "Yes", budget_category.name: "Annual Budget"]
  }

  measure: budget_gross_profit_this_month_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Selected Month Gross Profit Budget"
    group_label: "YTD Budget"
    type: number
    value_format_name: usd_0
    sql: ${total_income_budget_this_month_ytd}-${total_cos_budget_this_month_ytd} ;;
  }

  measure: gross_profit_budget_variance_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Gross Profit Variance to Plan ($ Change)"
    group_label: "YTD Variance"
    type: number
    value_format_name: usd_0
    sql: ${gross_profit_this_month_ytd} - ${budget_gross_profit_this_month_ytd} ;;
  }

  measure: gross_profit_budget_variance_pct_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Gross Profit Variance to Plan (%)"
    group_label: "YTD Variance"
    type: number
    value_format_name: percent_0
    sql: ${gross_profit_budget_variance_ytd} / NULLIF(${budget_gross_profit_this_month_ytd},0) ;;
  }

  measure: gross_profit_yoy_variance_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Gross Profit YoY Growth ($ Change)"
    group_label: "YTD Variance"
    type: number
    value_format_name: usd_0
    sql: ${gross_profit_this_month_ytd} - ${gross_profit_this_month_prior_year_ytd} ;;
  }

  measure: yoy_gross_profit_variance_pct_ytd {
    view_label: "Monthly YTD Financials"
    label: "YTD Gross Profit YoY Growth (%)"
    group_label: "YTD Variance"
    type: number
    value_format_name: percent_0
    sql: ${gross_profit_yoy_variance_ytd} / NULLIF(${gross_profit_this_month_prior_year_ytd},0) ;;
  }

}
