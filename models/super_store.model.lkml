connection: "super_store"

# include all the views
include: "/views/**/*.view"

datagroup: super_store_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: super_store_default_datagroup

explore: superstore_orders {
  join: one_row_table {
    type: left_outer
    relationship: many_to_one
    sql_on: 1 = 1 ;;
  }
}
