connection: "nba_overtime"

# include all the views
include: "/views/**/*.view"

datagroup: nba_6th_man_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: nba_6th_man_default_datagroup

explore: nba_schedule {}

explore: play_by_play {
  label: "NBA 6th Man Project"
  join: players {
    type: left_outer
    sql_on: ${play_by_play.player_id} = ${players.player_id} ;;
    relationship: many_to_one
  }

  join: teams {
    type: left_outer
    sql_on: ${play_by_play.team_id} = ${teams.team_id} ;;
    relationship: many_to_one
  }

  join: nba_schedule {
    type: left_outer
    sql_on: ${play_by_play.game_code} = ${nba_schedule.game_code} ;;
    relationship: many_to_one
  }
}

explore: players {
  join: teams {
    type: left_outer
    sql_on: ${players.team_id} = ${teams.team_id} ;;
    relationship: many_to_one
  }
}

explore: teams {}
