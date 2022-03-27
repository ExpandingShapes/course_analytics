WITH all_quests AS
(
	SELECT
		q.quest_rk,
		q.quest_nm,
		EXTRACT (MONTH FROM g.game_dttm) AS month,
		COUNT(*)
	FROM
		cource_analytics.quest q
		INNER JOIN cource_analytics.game g
			ON q.quest_rk = g.quest_rk
	GROUP BY
		q.quest_rk,
		EXTRACT (MONTH FROM g.game_dttm)
),
started_quests AS
(
	SELECT 
	q.quest_rk,
	q.quest_nm,
	EXTRACT (MONTH FROM g.game_dttm) AS month,
	COUNT(*)
FROM
	cource_analytics.quest q
	INNER JOIN cource_analytics.game g
		on q.quest_rk = g.quest_rk
WHERE
	g.game_flg = 1 
GROUP BY
	q.quest_rk,
	EXTRACT (MONTH from g.game_dttm)
)
SELECT
	a.quest_nm,
	ABS
	(
		SUM
		(
			CASE WHEN a.month = 1 THEN (s.count / a.count::float) ELSE -(s.count / a.count::float) END
		)
	) AS january_february_difference
FROM
	all_quests a
	inner join started_quests s
		on a.quest_rk = s.quest_rk and a.month = s.month
WHERE
	a.month = 1 OR
	a.month = 2
GROUP BY a.quest_nm
ORDER BY
	january_february_difference DESC
LIMIT
	1
	
