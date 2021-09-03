connection: "super_store"
label: "Boston Scientific"

# include all the views
include: "/views/**/*.view"

datagroup: super_store_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "3 hours"
}

persist_with: super_store_default_datagroup

explore: superstore_orders {
  label: "Orders"
  join: one_row_table {
    type: left_outer
    relationship: many_to_one
    sql_on: 1 = 1 ;;
  }
  join: order_date_table {
    type: left_outer
    relationship: many_to_one
    sql_on: ${superstore_orders.order_date} = ${order_date_table.date_raw} ;;
  }
  join: ship_date_table {
    type: left_outer
    relationship: many_to_one
    sql_on: ${superstore_orders.ship_date} = ${ship_date_table.date_raw} ;;
  }
}
