view: nba_schedule {
  sql_table_name: public.nba_schedule ;;

  dimension: arena {
    type: string
    sql: ${TABLE}.arena ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: game_code {
    type: string
    sql: ${TABLE}.game_code ;;
  }

  dimension_group: game {
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
    sql: ${TABLE}.game_date ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
