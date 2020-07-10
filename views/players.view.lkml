view: players {
  sql_table_name: public.players ;;
  drill_fields: [player_id]

  dimension: player_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.player_id ;;
  }

  dimension: college_name {
    type: string
    sql: ${TABLE}.college_name ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: date_of_birth {
    type: string
    sql: ${TABLE}.date_of_birth ;;
  }

  dimension: draft_pick_num {
    type: string
    sql: ${TABLE}.draft_pick_num ;;
  }

  dimension: draft_round {
    type: string
    sql: ${TABLE}.draft_round ;;
  }

  dimension: draft_season_year {
    type: string
    sql: ${TABLE}.draft_season_year ;;
  }

  dimension: draft_team_id {
    type: string
    sql: ${TABLE}.draft_team_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: height_feet {
    type: string
    sql: ${TABLE}.height_feet ;;
  }

  dimension: height_inches {
    type: string
    sql: ${TABLE}.height_inches ;;
  }

  dimension: isactive {
    type: string
    sql: ${TABLE}.isactive ;;
  }

  dimension: jersey {
    type: string
    sql: ${TABLE}.jersey ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: position {
    type: string
    sql: ${TABLE}.position ;;
  }

  dimension: team_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.team_id ;;
  }

  dimension: weight_pound {
    type: string
    sql: ${TABLE}.weight_pound ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----------- Custom Dimensions --------------
  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }
  dimension: player_picture {
    type: string
    sql: ${TABLE}.player_id ;;
    html: <img alt="{{full_name._linked_value}}" src="//ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/{{value}}.png" onerror="this.onerror=null;this.src='//www.nba.com/.element/img/2.0/sect/statscube/players/large/default_nba_headshot_v2.png';" class="img-circle">;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      player_id,
      first_name,
      last_name,
      college_name,
      teams.team_id,
      teams.full_name,
      teams.nickname,
      teams.conference_name,
      teams.division_name,
      play_by_play.count
    ]
  }
}
