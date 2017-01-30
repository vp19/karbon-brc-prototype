view: work_items_by_assignee {
  label: "Work Items by Assignee"
# for prototyping only

  derived_table: {
    sql: select a.assignee ,
            sum(case when  a.start_date < current_date and a.start_date > current_date - 30 then 1 else 0 end ) as started,
            sum(case when  a.completed_date < current_date and a.completed_date > current_date - 30 then 1 else 0 end ) as completed,
            sum(case when  a.due_date < current_date and primary_status != 'Completed' then 1 else 0 end ) as overdue,
            sum(case when  a.due_date > current_date and primary_status != 'Completed' then 1 else 0 end ) as outstanding
          from   sql_server_karbon.workpercentagecomplete a
          where a.tenant_perma_key = '3BB12xkdfwHQ'
          group by a.assignee
          order by a.assignee
       ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.assignee ;;
  }

  measure: started {
    type: sum
    sql: ${TABLE}.started ;;
  }

  measure: completed {
    type: sum
    sql: ${TABLE}.completed ;;
  }

  measure: overdue {
    type: sum
    sql: ${TABLE}.overdue ;;
  }

  measure: outstanding {
    type: sum
    sql: ${TABLE}.outstanding ;;
  }

}
