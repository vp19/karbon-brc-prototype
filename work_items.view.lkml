view: work_items {
  label: "work_items"
# for prototyping only

  derived_table: {
    sql: select
            s.date,
            s.started,
            coalesce(c.completed,0) as completed
         from
          (
            select d.dt date,
              count(work_perma_key) as started
            from etl.date_dimension d
            left join  sql_server_karbon.workpercentagecomplete a
            on  d.dt = date_trunc('day' ,start_date)::date
            where d.dt < current_date
            and a.tenant_perma_key = '3BB12xkdfwHQ'
            group by d.dt
            order by  d.dt desc
          ) s
        full outer join
          (
            select d.dt date,
                count(work_perma_key) as completed
            from etl.date_dimension d
            left join  sql_server_karbon.workpercentagecomplete a
            on  d.dt = date_trunc('day' ,completed_date)::date
            where d.dt < current_date
            and primary_status = 'Completed'
            and a.tenant_perma_key = '3BB12xkdfwHQ'
            group by d.dt
            order by  d.dt desc
          ) c
          on s.date = c.date
       ;;
  }

  dimension_group: date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.date ;;
  }

  measure: started {
    type: sum
    sql: ${TABLE}.started ;;
  }

  measure: completed {
    type: sum
    sql: ${TABLE}.completed ;;
  }

}

# view: work_items {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
