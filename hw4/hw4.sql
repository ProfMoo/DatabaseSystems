SELECT 'Student: Shane OBrien (obries6@rpi.edu)';

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



SELECT 'Query 4';

SELECT
	o2.year
	, o2.city
	, o1.year
	, o1.city
	, a.name
	, a.country
	, e.name
FROM
	athletes a
	, olympics o1
	, olympics o2
	, winter_medals wm1
	, winter_medals wm2
	, events e
WHERE
	wm1.medal = 'Gold'
	and wm2.medal = 'Gold'

	and o1.otype = 'winter'
	and o2.otype = 'winter'

	and o1.year-o2.year >= 12

	and wm1.aid = wm2.aid
	and a.id = wm1.aid

	and wm1.oid = o1.id
	and wm2.oid = o2.id

	and wm1.eid = wm2.eid
	and wm2.eid = e.id
ORDER BY
	o2.year
	, o1.year
	, a.name;

SELECT 'Query 5';

(SELECT
	e.id, e.name, s.discipline
FROM
	events e
	, winter_medals wm
	, olympics o
	, sports s
WHERE
	e.id = wm.eid
	and wm.oid = o.id
	and s.id = e.sid)
EXCEPT
SELECT
	e.id, e.name, s.discipline
FROM
	events e
	, winter_medals wm
	, olympics o
	, sports s
WHERE
	e.id = wm.eid
	and o.year >= 2000
	and wm.oid = o.id
	and s.id = e.sid
ORDER BY
	name
	, discipline;


SELECT 'Query 6';

SELECT DISTINCT
	a.id
	, a.name
	, a.country	
FROM
	athletes a
	, winter_medals wm
	, summer_medals sm
WHERE
	a.id = wm.aid
	and a.id = sm.aid
	and wm.medal = 'Gold'
	and sm.medal = 'Gold'
ORDER BY
	a.name
	, a.country;


SELECT 'Query 7';

SELECT DISTINCT
	a.id
	, a.name
	, a.country	
FROM
	athletes a
	, summer_medals sm
	, olympics o
WHERE
	a.id = sm.aid
	and sm.medal = 'Gold'
	and o.id = sm.oid
GROUP BY
	a.id
	, o.id
HAVING
	count(*) >= 6
ORDER BY
	a.name
	, a.country;


SELECT 'Query 8';

(SELECT
	a.id, a.name, a.country
FROM
	athletes a
	, winter_medals wm
WHERE
	a.id = wm.aid
	and wm.medal = 'Bronze'
	and a.name like '%, Z%'
	and a.country like '%U%')
UNION
(SELECT
	a.id, a.name, a.country
FROM
	athletes a
	, summer_medals sm
WHERE
	a.id = sm.aid
	and sm.medal = 'Bronze'
	and a.name like '%, Z%'
	and a.country like '%U%')
ORDER BY
	name
	, country;


SELECT 'Query 9';

SELECT
	c.code
	, c.name
	, count(*)
	, ROUND(CAST(c.gdp as numeric), 0)
	, ROUND(CAST(count(*)/c.gdp as numeric), 2) as ratio
FROM
	athletes a
	, countries c
	, summer_medals sm
WHERE
	a.country = c.code
	and a.id = sm.aid
	and c.gdp is not NULL
GROUP BY
	c.code
ORDER BY
	ratio desc,
	c.name
LIMIT
	10;


SELECT 'Query 10';

SELECT
	a.name
FROM
	athletes a
	, summer_medals sm
WHERE
	a.id = sm.aid
GROUP BY
	a.name
HAVING
	count(distinct sm.medal) >= 3
	and count(distinct a.country) >= 3;

SELECT 'Query 11';

SELECT
	a1.name, a2.name
FROM
	athletes a1,
	athletes a2
WHERE
	a1.name like '%,%'
	and a2.name like '%,%'
	and lower(substring(a1.name, 0, position(',' in a1.name))) <> lower(substring(a1.name, position(',' in a1.name)+2))
	and lower(substring(a2.name, 0, position(',' in a2.name))) <> lower(substring(a2.name, position(',' in a2.name)+2))
	and lower(substring(a1.name, 0, position(',' in a1.name))) = lower(substring(a2.name, position(',' in a2.name)+2))
	and lower(substring(a2.name, 0, position(',' in a2.name))) = lower(substring(a1.name, position(',' in a1.name)+2))
	and a1.name < a2.name
ORDER BY
	a1.name;

SELECT 'Query 12';

SELECT
	a.id,
	a.name,
	a.country
FROM
	sports s,
	summer_medals sm,
	events e,
	athletes a
WHERE 
	e.id = sm.eid
	and e.sid = s.id
	and sm.aid = a.id
GROUP BY
	a.id
HAVING
	count(distinct s.name) >= 3;