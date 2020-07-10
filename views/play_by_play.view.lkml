view: play_by_play {
  sql_table_name: public.play_by_play ;;

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
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
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.game_date ;;
  }

  dimension: locx {
    type: number
    sql: ${TABLE}.locx ;;
  }

  dimension: locy {
    type: number
    sql: ${TABLE}.locy ;;
  }

  dimension: make_type {
    type: string
    sql: ${TABLE}.make_type ;;
  }

  dimension: pk_id {
    type: number
    sql: ${TABLE}.pk_id ;;
  }

  dimension: player_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.player_id ;;
  }

  dimension: team_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.team_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  #-----------Custom dimensions -------------------
  dimension: is_2pt_attempt {
    description: "2 points Jump shot attempted"
    type: yesno
    sql: ${description} LIKE '%Jump shot%' ;;
  }

  dimension: is_2pt_made {
    description: "2 points jump shot made"
    type: yesno
    sql: ${description} LIKE '%Jump shot: Made%' ;;
  }

  dimension: is_3pt_attempt {
    description: "3 points shot attempted"
    type: yesno
    sql: ${description} LIKE '%3pt Shot%' ;;
  }

  dimension: is_3pt_made {
    description: "3 points shot made"
    type: yesno
    sql: ${description} LIKE '%3pt Shot: Made%' ;;
  }

  dimension: free_throw_attempt {
    description: "Free Throw attempted"
    type: yesno
    sql: ${description} LIKE '%Free Throw%' ;;
  }

  dimension: free_throw_missed {
    description: "Free Throw missed"
    type: yesno
    sql: ${description} LIKE '%Free Throw%' AND ${description} LIKE '%Missed%' ;;
  }

  #------------- Measures -------------------------
  measure: count_2pt_attempted {
    description: "Total number of 2 points jump shot attempted"
    type: count
    filters: [is_2pt_attempt: "yes"]
  }

  measure: count_2pt_made {
    description: "Total number of 2 points jump shot made"
    type: count
    filters: [is_2pt_made: "yes"]
  }

  measure: field_goal_percentage_2pt {
    description: "FGP % 2 point found by taking total made divided by total attempted"
    value_format: "0.00%"
    type: number
    sql: ${count_2pt_made}*1.0/NULLIF(${count_2pt_attempted},0) ;;
  }

  measure: count_3pt {
    description: "Total number of 3 points shot attempted"
    type: count
    filters: [is_3pt_attempt: "yes"]
  }

  measure: count_3pt_made {
    description: "Total number of 3 points shot made"
    type: count
    filters: [is_3pt_made: "yes"]
  }

  measure: field_goal_percentage_3pt {
    description: "FGP % 3 point found by taking total made divided by total attempted"
    value_format: "0.00%"
    type: number
    sql: ${count_3pt_made}*1.0/NULLIF(${count_3pt},0) ;;
  }

  measure: count_free_throw {
    description: "Total number of Free Throw attempted"
    type: count
    filters: [free_throw_attempt: "yes"]
  }

  measure: count_free_throw_missed {
    description: "Total number of Free Throw missed"
    type: count
    filters: [free_throw_missed: "yes"]
  }

  measure: free_throw_percent {
    description: "Free throw Field Goal Percentage"
    value_format: "0.00%"
    type: number
    sql: (${count_free_throw} - ${count_free_throw_missed})*1.0 / NULLIF(${count_free_throw},0) ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      players.player_id,
      players.first_name,
      players.last_name,
      teams.full_name
    ]
  }
}
