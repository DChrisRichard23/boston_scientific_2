view: ship_date_table {

  sql_table_name: `mw-data-analytics-sandbox.super_store.ship_date_table`
    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: date_c {
    primary_key: yes
    type: string
    sql: ${TABLE}.date_c ;;
  }

  dimension: date_char {
    type: string
    sql: ${TABLE}.date_char ;;
  }

  dimension: date_key {
    type: number
    sql: ${TABLE}.date_key ;;
  }

  dimension: day_of_week_name {
    type: string
    sql: ${TABLE}.day_of_week_name ;;
  }

  dimension: day_of_week_num {
    type: number
    sql: ${TABLE}.day_of_week_num ;;
  }

  dimension: day_of_week_num_name {
    type: string
    sql: ${TABLE}.day_of_week_num_name ;;
  }

  dimension: day_of_week_short {
    type: string
    sql: ${TABLE}.day_of_week_short ;;
  }

  dimension: full_date_description {
    type: string
    sql: ${TABLE}.full_date_description ;;
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
  }

  dimension: month_name_short {
    type: string
    sql: ${TABLE}.month_name_short ;;
  }

  dimension: month_num {
    type: number
    sql: ${TABLE}.month_num ;;
  }

  dimension: month_num_name {
    type: string
    sql: ${TABLE}.month_num_name ;;
  }

  dimension: month_year {
    type: string
    sql: ${TABLE}.month_year ;;
  }

  dimension: quarter_name {
    type: string
    sql: ${TABLE}.quarter_name ;;
  }

  dimension: quarter_num {
    type: number
    sql: ${TABLE}.quarter_num ;;
  }

  dimension: quarter_year_name {
    type: string
    sql: ${TABLE}.quarter_year_name ;;
  }

  dimension: this_month_flag {
    type: number
    sql: ${TABLE}.this_month_flag ;;
  }

  dimension: this_week_flag {
    type: number
    sql: ${TABLE}.this_week_flag ;;
  }

  dimension: this_year_flag {
    type: number
    sql: ${TABLE}.this_year_flag ;;
  }

  dimension: today_flag {
    type: number
    sql: ${TABLE}.today_flag ;;
  }

  dimension: week_name {
    type: string
    sql: ${TABLE}.week_name ;;
  }

  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
  }

  dimension: week_year_name {
    type: string
    sql: ${TABLE}.week_year_name ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: year_month {
    type: string
    sql: ${TABLE}.year_month ;;
  }

  dimension: year_quarter {
    type: string
    sql: ${TABLE}.year_quarter ;;
  }

  dimension: year_week {
    type: string
    sql: ${TABLE}.year_week ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      month_name,
      quarter_year_name,
      week_year_name,
      month_num_name,
      day_of_week_num_name,
      day_of_week_name,
      quarter_name,
      week_name
    ]
  }
}
