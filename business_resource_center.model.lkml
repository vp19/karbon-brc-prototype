connection: "hpc_postgres_datamart"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: workpercentagecomplete {}

explore: work_items {}

explore: work_items_by_assignee {}

# - explore: email_response_time_summary
