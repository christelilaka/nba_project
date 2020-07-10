view: teams {
  sql_table_name: public.teams ;;
  drill_fields: [team_id]

  dimension: team_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.team_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: conference_name {
    type: string
    sql: ${TABLE}.conference_name ;;
  }

  dimension: division_name {
    type: string
    sql: ${TABLE}.division_name ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: isnbafranchise {
    type: yesno
    sql: ${TABLE}.isnbafranchise ;;
  }

  dimension: nickname {
    type: string
    sql: ${TABLE}.nickname ;;
  }

  dimension: tricode {
    type: string
    sql: ${TABLE}.tricode ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      team_id,
      full_name,
      nickname,
      conference_name,
      division_name,
      play_by_play.count,
      players.count
    ]
  }
}
