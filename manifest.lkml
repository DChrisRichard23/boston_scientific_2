project_name: "Boston_Scientific"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

# constants to compute a relative url based on a franchise value

constant: relative_url_family_view {
  value: "/dashboards-next/{% if value == 'Imaging' %}142{% elsif value == 'Optometry' %}143{% elsif value == 'Pathology' %}141{% endif %}"
}

constant: relative_url_sku_profitability_view {
  value: "/dashboards-next/{% if value == 'Imaging' %}162{% elsif value == 'Optometry' %}163{% elsif value == 'Pathology' %}164{% endif %}"
}

constant: relative_url_sku_view_franchise_only {
  value: "/dashboards-next/144?Franchise={{ value }}"
}

constant: relative_url_sku_profitability_view_sku_view_franchise_only {
  value: "/dashboards-next/166?Franchise={{ value }}"
}

# constants to generate href html based on a franchise value

constant: href_family_view {
  value: "<a href=@{relative_url_sku_profitability_view}>{{ value }}</a>"
}

constant: href_sku_profitability_view {
  value: "<a href=@{relative_url_family_view}>{{ value }}</a>"
}

constant: href_sku_view_franchise_only {
  value: "<a href=@{relative_url_sku_view_franchise_only}>{{ value }}</a>"
}

constant: href_sku_profitability_view_sku_view_franchise_only {
  value: "<a href=@{relative_url_sku_profitability_view_sku_view_franchise_only}>{{ value }}</a>"
}
