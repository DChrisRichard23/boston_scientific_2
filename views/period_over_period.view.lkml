include: "superstore_orders.view.lkml"

view: +superstore_orders {
  ###################### Period over Period Reporting Metrics ######################

  parameter: period {
    label: "Timeframe"
    view_label: "Period over Period"
    type: unquoted
    allowed_value: {
      label: "Week to Date"
      value: "Week"
    }
    allowed_value: {
      label: "Month to Date"
      value: "Month"
    }
    allowed_value: {
      label: "Quarter to Date"
      value: "Quarter"
    }
    allowed_value: {
      label: "Year to Date"
      value: "Year"
    }
    default_value: "Period"
  }

  # To get start date we need to get either first day of the year, month or quarter
  dimension: first_date_in_period {
    view_label: "Period over Period"
    type: date
    hidden: no
    sql: DATE_TRUNC(CURRENT_DATE(), {% parameter period %});;
    convert_tz: no
  }

  #Now get the total number of days in the period
  dimension: days_in_period {
    view_label: "Period over Period"
    type: number
    hidden: no
    sql: DATE_DIFF(CURRENT_DATE(),${first_date_in_period}, DAY) ;;
    # convert_tz: no
  }

  #Now get the first date in the prior period
  dimension: first_date_in_prior_period {
    view_label: "Period over Period"
    type: date
    hidden: no
    sql: DATE_TRUNC(DATE_ADD(CURRENT_DATE(), INTERVAL -1 {% parameter period %}),{% parameter period %});;
    convert_tz: no
  }

  #Now get the last date in the prior period
  dimension: last_date_in_prior_period {
    view_label: "Period over Period"
    type: date
    hidden: no
    sql: DATE_ADD(${first_date_in_prior_period}, INTERVAL ${days_in_period} DAY) ;;
    convert_tz: no
  }

  # Now figure out which period each date belongs in
  dimension: period_selected {
    view_label: "Period over Period"
    type: string
    sql:
        CASE
          WHEN ${superstore_orders.order_date} >=  ${first_date_in_period}
          THEN 'This {% parameter period %} to Date'
          WHEN ${superstore_orders.order_date} >= ${first_date_in_prior_period}
          AND ${superstore_orders.order_date} <= ${last_date_in_prior_period}
          THEN 'Prior {% parameter period %} to Date'
          ELSE NULL
          END ;;
  }


  dimension: days_from_period_start {
    view_label: "Period over Period"
    type: number
    sql: CASE WHEN ${period_selected} = 'This {% parameter period %} to Date'
          THEN DATE_DIFF(${superstore_orders.order_date}, ${first_date_in_period}, DAY)
          WHEN ${period_selected} = 'Prior {% parameter period %} to Date'
          THEN DATE_DIFF(${superstore_orders.order_date}, ${first_date_in_prior_period}, DAY)
          ELSE NULL END;;
  }

  measure: total_sales_this_period {
    view_label: "Period over Period"
    type: sum
    sql: ${superstore_orders.sales_in} ;;
    filters: [period_selected: "This {% parameter period %} to Date"]
    value_format_name: usd_0
  }

  measure: total_sales_prior_period {
    view_label: "Period over Period"
    type: sum
    sql: ${superstore_orders.sales_in} ;;
    filters: [period_selected: "Prior {% parameter period %} to Date"]
    value_format_name: usd_0
  }

  measure: total_sales_percent_change {
    view_label: "Period over Period"
    type: number
    sql: 1.0*(${total_sales_this_period}-${total_sales_prior_period})/NULLIF(${total_sales_prior_period},0) ;;
    value_format_name: percent_1
  }

  measure: total_profit_this_period {
    view_label: "Period over Period"
    type: sum
    sql: ${superstore_orders.profit_in} ;;
    filters: [period_selected: "This {% parameter period %} to Date"]
    value_format_name: usd_0
  }

  measure: total_profit_prior_period {
    view_label: "Period over Period"
    type: sum
    sql: ${superstore_orders.profit_in} ;;
    filters: [period_selected: "Prior {% parameter period %} to Date"]
    value_format_name: usd_0
  }

  measure: total_profit_percent_change {
    view_label: "Period over Period"
    type: number
    sql: 1.0*(${total_profit_this_period}-${total_profit_prior_period})/NULLIF(${total_profit_prior_period},0) ;;
    value_format_name: percent_1
  }

  measure: total_customers_this_period {
    view_label: "Period over Period"
    type: count_distinct
    sql: ${superstore_orders.customer_id} ;;
    filters: [period_selected: "This {% parameter period %} to Date"]
    value_format: "#,###"
  }

  measure: total_customers_prior_period {
    view_label: "Period over Period"
    type: count_distinct
    sql: ${superstore_orders.customer_id} ;;
    filters: [period_selected: "Prior {% parameter period %} to Date"]
    value_format: "#,###"
  }

  measure: total_customers_percent_change {
    view_label: "Period over Period"
    type: number
    sql: 1.0*(${total_customers_this_period}-${total_customers_prior_period})/NULLIF(${total_customers_prior_period},0) ;;
    value_format_name: percent_1
  }


}
