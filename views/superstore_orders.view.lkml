view: superstore_orders {
  sql_table_name: `super_store.superstore_orders`
    ;;

  dimension: category {
    label: "Franchise"
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: country_region {
    label: "Country/Region"
    type: string
    sql: ${TABLE}.Country_Region ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.Customer_ID ;;
  }

  measure: customers {
    type: count_distinct
    sql: ${customer_id} ;;
    value_format: "#,###"
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.Customer_Name ;;
  }

  dimension: discount_in {
    hidden: yes
    type: number
    sql: ${TABLE}.Discount ;;
  }

  measure: discount_percent {
    type: number
    sql: (SUM(${discount_in}*${sales_in})/SUM(${sales_in}))*100.00 ;;
    value_format: "0.00\%"
  }

  dimension_group: order {
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
    sql: ${TABLE}.Order_Date ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.Order_ID ;;
  }

  measure: orders {
    type: count_distinct
    sql: ${order_id} ;;
    value_format: "#,###"
  }

  dimension: postal_code {
    type: number
    sql: ${TABLE}.Postal_Code ;;
  }

  dimension: product_id {
    label: "SKU"
    type: string
    sql: ${TABLE}.Product_ID ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.Product_Name ;;
  }

  dimension: profit_in {
    hidden: yes
    type: number
    sql: ${TABLE}.Profit ;;
  }

  measure: total_profit {
    type: sum
    sql: ${profit_in} ;;
    value_format: "#,###.00"
  }

  measure: average_profit {
    type: average
    sql: ${profit_in} ;;
    value_format: "$#,###.00"
  }

  dimension: quantity_in {
    hidden: yes
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity_in} ;;
    value_format: "#,###"
  }

  measure: average_quantity {
    type: average
    sql: ${quantity_in} ;;
    value_format: "#,###.00"
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: row_id {
    type: number
    sql: ${TABLE}.Row_ID ;;
  }

  dimension: sales_in {
    hidden: yes
    type: number
    sql: ${TABLE}.Sales ;;
  }

  measure: total_sales {
    type: sum
    sql: ${sales_in} ;;
    value_format: "$#,###.00"
  }

  measure: adjusted_margin {
    type: number
    sql: 3.5000*(${total_profit}/${total_sales})  ;;
    value_format: "#.0000"
  }

  measure: average_sales {
    type: average
    sql: ${sales_in} ;;
    value_format: "$#,###.00"
  }

  dimension: segment {
    type: string
    sql: ${TABLE}.Segment ;;
  }

  dimension_group: ship {
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
    sql: ${TABLE}.Ship_Date ;;
  }

  dimension: ship_mode {
    type: string
    sql: ${TABLE}.Ship_Mode ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.Sub_Category ;;
  }

  dimension: family {
    type: string
    sql: CASE
            WHEN ${sub_category} = 'Accessories' THEN 'Bridge'
            WHEN ${sub_category} = 'Appliances' THEN 'Bandage'
            WHEN ${sub_category} = 'Art' THEN 'Funnel'
            WHEN ${sub_category} = 'Binders' THEN 'Catheter'
            WHEN ${sub_category} = 'Bookcases' THEN 'Consumable'
            WHEN ${sub_category} = 'Chairs' THEN 'Knife'
            WHEN ${sub_category} = 'Copiers' THEN 'Accessories'
            WHEN ${sub_category} = 'Envelopes' THEN 'Joint'
            WHEN ${sub_category} = 'Fasteners' THEN 'Stent'
            WHEN ${sub_category} = 'Furnishings' THEN 'Wide Clip'
            WHEN ${sub_category} = 'Labels' THEN 'Wire'
            WHEN ${sub_category} = 'Machines' THEN 'Stent'
            WHEN ${sub_category} = 'Paper' THEN 'Consumable'
            WHEN ${sub_category} = 'Phones' THEN 'Joint'
            WHEN ${sub_category} = 'Storage' THEN 'Funnel'
            WHEN ${sub_category} = 'Supplies' THEN 'Catheter'
            WHEN ${sub_category} = 'Tables' THEN 'Wire'
        END;;
  }

  measure: count {
    type: count
    drill_fields: [customer_name, product_name]
  }
}
