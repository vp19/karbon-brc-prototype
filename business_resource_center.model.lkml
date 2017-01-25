connection: "hpc_postgres_datamart"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: workpercentagecomplete {}

explore: work_items {}

# - explore: email_response_time_summary

# - explore: fivetran_audit

# - explore: work_summary
