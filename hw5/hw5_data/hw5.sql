SELECT 'Student: Shane OBrien (obries6@rpi.edu)';

SELECT 'Homework 5';

SELECT 'Query 1';

SELECT
	s.name,
	count(distinct wm.oid) as num_winter_games,
	count(distinct sm.oid) as num_summer_games
FROM
	(olympics o
	left join summer_medals sm
	on o.id = sm.oid)
		left join winter_medals wm
		on o.id = wm.oid,
	sports s,
	events e
WHERE
	e.sid = s.id
	and (sm.eid = e.id or wm.eid = e.id)
GROUP BY
	s.name
ORDER BY
	s.name;

SELECT 'Query 2';

SELECT
	a.country,
	ROUND(CAST(CAST(count(distinct wm.id) as float)/count(distinct wm.oid) as numeric), 2) as avg_medals
FROM
	winter_medals wm,
	athletes a
WHERE
	wm.aid = a.id
GROUP BY
	a.country
ORDER BY
	avg_medals desc;

SELECT 'Query 3';

SELECT
	a.name,
	a.country,
	o.year,
	o.city
FROM
	winter_medals wm,
	athletes a,
	winter_eventcategories wec,
	events e,
	sports s,
	olympics o
WHERE
	wm.aid = a.id
	and o.id = wm.oid
	and wm.eid = e.id
	and wec.eid = e.id
	and e.sid = s.id
	and e.name like '%Individual%'
	and a.country = 'JPN'
	and wm.medal = 'Gold'
	and e.etype like '%m%'
	and s.discipline like '%Figure skating%'
ORDER BY
	o.year asc
LIMIT
	1;

SELECT 'Query 4';

SELECT DISTINCT
	one.id1 as id, 
	one.aname1 as name, 
	one.country1 as country, 
	one.city1 as city, 
	one.year1 as year, 
	one.ename1 as name,
	one.discipline1 as discipline
FROM
	(SELECT
		a.id as id1,
		a.name as aname1,
		a.country as country1,
		o.city as city1,
		o.year as year1,
		e.name as ename1,
		e.etype as etype1,
		s.discipline as discipline1
	FROM
		athletes a,
		events e,
		winter_medals wm,
		olympics o,
		sports s
	WHERE
		a.id = wm.aid
		and e.id = wm.eid
		and wm.oid = o.id
		and s.id = e.sid
		and wm.medal = 'Gold') as one
	inner join (SELECT
		a.id as id2,
		a.name as aname2,
		a.country as country2,
		o.city as city2,
		o.year as year2,
		e.name as ename2,
		e.etype as etype2,
		s.discipline as discipline2
	FROM
		athletes a,
		events e,
		winter_medals wm,
		olympics o,
		sports s
	WHERE
		a.id = wm.aid
		and e.id = wm.eid
		and wm.oid = o.id
		and s.id = e.sid
		and wm.medal = 'Gold') as two
	ON (one.country1 <> two.country2
		and one.city1 = two.city2
		and one.year1 = two.year2
		and one.ename1 = two.ename2
		and one.discipline1 = two.discipline2
		and one.etype1 = two.etype2)
ORDER BY
	one.ename1, one.year1, one.city1, one.country1, one.aname1;

SELECT 'Query 5';

SELECT
	total.country,
	sum(total.count) as medal_count	
FROM
	((SELECT
		a.country as country,
		count(*) as count
	FROM
		winter_medals wm,
		winter_eventcategories wec,
		athletes a,
		sports s,
		events e,
		olympics o
	WHERE
		wm.aid = a.id
		and wm.eid = e.id
		and e.sid = s.id
		and wm.oid = o.id
		and o.year = 2018
		and e.id = wec.eid
		and wec.etype = 'single'
	GROUP BY
		a.country)
	UNION
	(SELECT
		a.country as country,
		count(distinct wm.eid) as count
	FROM
		winter_medals wm,
		winter_eventcategories wec,
		athletes a,
		sports s,
		events e,
		olympics o
	WHERE
		wm.aid = a.id
		and wm.eid = e.id
		and e.sid = s.id
		and wm.oid = o.id
		and o.year = 2018
		and e.id = wec.eid
		and wec.etype <> 'single'
	GROUP BY
		a.country)) as total
GROUP BY
	total.country
ORDER BY
	sum(total.count) desc, total.country;

	

SELECT 'Query 6';

--find athletes who won in 2018
--who do not exist in all athletes from 2014 and before

SELECT
	a.country,
	count(*) as num_firsttimers
FROM
	athletes a,
	winter_medals wm,
	olympics o
WHERE
	wm.aid = a.id
	and wm.oid = o.id
	and o.year = 2018
	and wm.medal = 'Gold'
	and NOT EXISTS (SELECT
						1
					FROM
						athletes a2,
						winter_medals wm2,
						olympics o2
					WHERE
						wm2.aid = a2.id
						and wm2.oid = o2.id
						and o2.year <= 2014
						and wm2.medal = 'Gold'
						and a2.id = a.id)
GROUP BY
	a.country
ORDER BY
	num_firsttimers desc, a.country asc;

SELECT 'Query 7';

SELECT
	a.country
FROM
	olympics o,
	winter_medals wm,
	athletes a
WHERE
	wm.oid = o.id
	and wm.aid = a.id
	and o.year >= 1900
GROUP BY
	a.country
HAVING
	count(distinct o.year) = (	SELECT
									count(distinct o.year)
								FROM
									olympics o,
									winter_medals wm
								WHERE
									o.year >= 1900
									and wm.oid = o.id)
ORDER BY
	a.country;

SELECT 'Query 8';

SELECT
	distinct s.name,
	o.year,
	o.city
FROM
	winter_medals wm,
	olympics o,
	sports s,
	events e,
	athletes a,
	(SELECT
		s2.name as sname,
		min(distinct o2.year) as min_num
	FROM 
		winter_medals wm2,
		olympics o2,
		sports s2,
		events e2,
		athletes a2
	WHERE
		wm2.oid = o2.id
		and wm2.aid = a2.id
		and wm2.eid = e2.id
		and e2.sid = s2.id
		and a2.country = 'USA'
		and wm2.medal = 'Gold'
	GROUP BY
		s2.name) as mg
WHERE
	wm.oid = o.id
	and wm.aid = a.id
	and wm.eid = e.id
	and e.sid = s.id
	and a.country = 'USA'
	and wm.medal = 'Gold'
	and s.name = mg.sname
	and o.year = mg.min_num
ORDER BY
	s.name;