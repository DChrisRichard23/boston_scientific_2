view: one_row_table {
  derived_table: {
    sql: SELECT
         'Back' AS back_button
       , 'Back' AS back_button_2
       , 'Logo' AS logo
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: back_button {
    type: string
    sql: ${TABLE}.back_button ;;
    html: <a href="/dashboards-next/138">{{ value }}</a> ;;
  }

  dimension: back_button_2 {
    type: string
    sql: ${TABLE}.back_button_2 ;;
    html: <a href="/dashboards-next/139">{{ value }}</a> ;;
  }

  dimension: logo {
    type: string
    sql: ${TABLE}.logo ;;
    html: <img src="https://logos-download.com/wp-content/uploads/2018/06/Boston_Scientific_logo_blue-700x700.png"> ;;
  }

  set: detail {
    fields: [back_button, back_button_2, logo]
  }
}
