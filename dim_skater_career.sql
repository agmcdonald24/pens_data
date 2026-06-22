WITH career_totals AS (

    SELECT
        nhl_player_id,
        MAX(player_name) AS player_name,
        MAX(position_group) AS position_group,
        SUM(gp) AS career_games_played,
        SUM(goals) AS career_goals,
        SUM(assists) AS career_assists,
        SUM(points) AS career_points,
        SUM(toi_seconds) AS career_toi_seconds
    FROM skater_seasons
    WHERE nhl_player_id IS NOT NULL
    GROUP BY nhl_player_id

)

SELECT
    nhl_player_id,
    player_name,
    position_group,
    career_games_played,
    career_goals,
    career_assists,
    career_points,
    career_toi_seconds,
    career_toi_seconds / 60.0 AS career_toi_minutes,
    career_points * 3600.0
        / NULLIF(career_toi_seconds, 0) AS career_points_per_60
FROM career_totals
WHERE career_toi_seconds >= 30000
