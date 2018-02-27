SELECT 'Student: Shane OBrien (obries6@rpi.edu)';

/*
SELECT 'Query 1';

SELECT
	e.name
	, e.etype
FROM
	sports s
	, events e
WHERE
	s.id = e.sid
	and s.discipline like '%Figure skating%'
ORDER BY
	e.name, e.etype


SELECT 'Query 2';

SELECT DISTINCT
	c.code
	, c.name
FROM
	olympics o
	, winter_medals w
	, countries c
	, athletes a
WHERE
	o.id = w.oid
	and o.city like '%Chamonix%'
	and o.otype like '%winter%'
	and o.year = 1924
	and w.aid = a.id
	and a.country = c.code
ORDER BY 
	c.code, c.name

*/

SELECT 'Query 3';

SELECT DISTINCT
	o.year
	, count(distinct a.country)
FROM
	olympics o
	, winter_medals w
	, athletes a
WHERE
	o.id = w.oid
	and w.aid = a.id
	and o.otype like '%winter%'
	and a.country IS NOT NULL
GROUP BY
	o.year
ORDER BY
	o.year desc
	, count(distinct a.country) desc;