--TODO
select 
	l.city_nm,
	e.gender_cd,
 	e.last_name,
 	AVG(time) AS average_time,
	COUNT(l.location_rk)
	--row_number() over (partition by l.location_rk, e.employee_rk) as rownum
from
 	cource_analytics.employee e
 	inner join cource_analytics.game g
 		on e.employee_rk = g.employee_rk
 	inner join cource_analytics.quest q
 		on g.quest_rk = q.quest_rk
 	INNER JOIN cource_analytics.location l
 		on q.location_rk = l.location_rk
GROUP BY l.location_rk, e.employee_rk
ORDER BY
	l.city_nm, average_time 
-- having
-- 	e.gender_cd = 'f'
