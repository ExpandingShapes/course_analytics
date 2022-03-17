SELECT 
	COUNT(DISTINCT(p.partner_rk))
FROM
	cource_analytics.partner p
	LEFT JOIN cource_analytics.location lo
		ON lo.partner_rk = p.partner_rk
  	INNER JOIN cource_analytics.legend le
  		ON p.partner_rk = le.partner_rk 
WHERE
	lo.partner_rk IS NULL AND
	le.partner_rk IS NOT NULL
