keep it simple with the queries

today, we will get more complicated with queries so we can tell when we need them.

===========================================
SQL - Group By

	SELECT a1, a2, count(*), min(25), sum(26)     <== returns one tuple per group
	FROM r1, r2, r3
	WHERE selection + join conditions over the cartesian product r1 x r2 x r3
	GROUP BY a1, a2     <== will get the where and group it into tuples. if we 
							select two things, each group will be unique combos of the two
	HAVING count(*) > 5
	ORDER BY a1
	LIMIT 5;

	Order: from -> where -> group -> having -> select -> orderby -> limit

	-----

	Each one of these is a block:
	S
	F
	W
	G
	H

	-----

	We can have several blocks and have operations over them:
	S
	F
	W 
	G
	H

	INTERSECT

	S
	F
	W
	G
	H

	-----

	Then we can put ORDER BY & LIMIT after. This is all one query:
	S
	F
	W 
	G
	H

	INTERSECT

	S
	F
	W
	G
	H

	ORDER BY LIMIT

======================================

1. students who took more than one class

SELECT
	s.id
	, s.name
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
GROUP BY
	s.id
	, s.name (this changes nothing)
HAVING
	count(*) > 1;

to check what the groups looks like:

SELECT
	s.id
	, s.name
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
order by s.id;

2. getting more info about students and courses

SELECT
	s.id
	, s.name
	, count(t.course_id)
	, count(distinct t.course_id)
	, count(t.grade)
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
GROUP BY
	s.id

3. how many times have these people taken the course (as long as it's more than 1)?

SELECT
	s.id
	, s.name
	, t.course_id
	, count(*) as num_attempts
	, count(t.grade) as num_grades
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
GROUP BY
	s.id
	, t.course_id
HAVING
	count(*) > 1;

4. find students who took no classes or took more than one class, return students order by name


(SELECT
	id
	name
FROM
	students
EXCEPT
SELECT
	s.id
	, s.name
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id)
UNION
SELECT
	s.id
	, s.name
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
GROUP BY
	s.id
HAVING
	count(*) > 1;
ORDER BY
	name desc;

5. Reutnr for each students, number of classes they took

SELECT
	s.id
	, s.name
	, count(distinct t.course_id)
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
GROUP BY
	...something

=================================

Let's say you have two relations R and S.

	R 						S
	A	|B 					b_2	|c_1
	a_1	|b_1 				b_3 |c_2
	a_2	|b_2				b_4 |c_5
	a_3	|b_3

	inner join: SELECT * FROM R,S WHERE R.b = S.b

	left outer join: 	INNER JOIN UNION
						TUPLES IN LEFT RELATION THAT DID NOT JOIN

	So what does this look like?

=================================

ex: left outer join

SELECT
FROM
	students s
	LEFT JOIN transcript t
	ON s.id = t.student_id;

	-> this gives us students who didnt even sign up for a course

ex: now we can use it for counting

SELECT
	s.id
	, s.name
	, count(t.student_id) as numclasses
FROM
	students s
	LEFT JOIN transcript t
	ON s.id = t.student_id;
GROUP BY
	s.id;

ex: find students who took no classes or took more than one class, return students order by name

SELECT
	s.id
	, s.name
	, count(t.student_id) as numclasses
FROM
	students s
	LEFT JOIN transcript t
	ON s.id = t.student_id
GROUP BY
	s.id
HAVING
	count(t.student_id) = 0
	or count(distinct t.student_id) > 1;

===========================
Now, we can look at a full join

Full Join -> 	left join UNION right join
				inner join + tuples from left/right relations

ex: Find athletes with no country tuples and countries with no athletes

SELECT DISTINCT
	c.name
	, a.country
FROM
	countries c
	full join athletes a
	on c.code = a.country
WHERE
	c.code is null			<- we are doing a full join, so we can get NULL fields
	or a.country is null
ORDER BY
	c.name
	, a.country

========================
anonymous relation/view -> you can put everything in FROM

SELECT

FROM (SELECT FROM WHERE...) as f

WHERE f...

ex: find courses taught by a faculty who taught two courses in a single semester

SELECT DISTINCT
	f.id
	, f.name
FROM
	classes c
	, faculty f
WHERE
	c.instructor_id = f.id
GROUP BY
	f.id
	, c.semester
	, c.year
HAVING
	count(*) > 1;

ex: lets find these courses that they taught ^^^^^^^
SELECT
	hardworking.id
	, hardworking.name
	, co.crsname
	, c.semester
	, c.year
FROM
	(SELECT DISTINCT
		f.id
		, f.name
	FROM
		classes c
		, faculty f
	WHERE
		c.instructor_id = f.id
	GROUP BY
		f.id
		, c.semester
		, c.year
	HAVING
		count(*) > 1) as hardworking
	, classes c
	, courses co
WHERE
	c.instructor_id = hardworking.id
	and c.course_id = co.id

^^ this is helpful, but can be massively slow. KEEP IT SIMPLE

========================================
--scalar query: query that returns a single NUMBER (not a relation or tuple)

ex: select count(*) from students;
-> 6

ex: select max(year) from classes;
-> 2016

ex: find all faculty who taught more classes than Prof. Sunderland
We divide this into two parts: 
	(1) find the # of course taught by Sunderland

	SELECT
		count(*)
	FROM
		faculty f
		, classes c
	WHERE
		f.id = c.instructor_id
		and f.name like '%Sunderland%';

	(2) find how many courses taught by each faculty

	SELECT
		f.id
		, f.name
		, count(*) as numcourses 
	FROM
		faculty f
		, classes c
	WHERE
		f.id = c.instructor_id
	GROUP BY
		f.id
	HAVING count(*) > [num courses for Sunderland];

--So let's combine them:

	SELECT
		f.id
		, f.name
		, count(*) as numcourses 
	FROM
		faculty f
		, classes c
	WHERE
		f.id = c.instructor_id
	GROUP BY
		f.id
	HAVING count(*) > (	SELECT
							count(*)
						FROM
							faculty f
							, classes c
						WHERE
							f.id = c.instructor_id
							and f.name like '%Sunderland%');

ex: find the ratio of courses for each faculty to those of Prof. Sunderland

	SELECT
		f.id
		, f.name
		, count(*) / (numcourses for Sundeerland)
	FROM
		faculty f
		, classes c
	WHERE
		f.id = c.instructor_id
	GROUP BY
		f.id

	put it in:

	SELECT
		f.id
		, f.name
		, cast(count(*) as float)/ (	SELECT
											count(*)
										FROM
											faculty f
											, classes c
										WHERE
											f.id = c.instructor_id
											and f.name like '%Sunderland%')
	FROM
		faculty f
		, classes c
	WHERE
		f.id = c.instructor_id
	GROUP BY
		f.id

============================================================
Subqueries: 

ex: select * from transcript where grade in ('A','A-','B+','B','B-');

query returns a bag of values <- (SELECT...)

	attr in set/bag
	attr not in set/bag
	attr 	>= set/bag
			< all
			<= all
			= all
			<> all -> not in
			= any -> in

ex: NOT IN -> students who took no classes

SELECT
	id
	, name
FROM 
	students
WHERE
	id not in (select student_id from transcript);

ex: IN -> students who took classes

SELECT
	id
	, name
FROM 
	students
WHERE
	id in (select student_id from transcript);

So is this better than how we learned before? Usually, the old way is because joins are highly optimized.

More things:

		attr not exists -> true if set/bag is empty

ex: 

SELECT
	id
	, name
FROM
	students
WHERE
	NOT EXISTS (select * from transcript);

	explanation: 	if inner query returns nothing, we get all from students.
					if inner query returns something, we get none from students.

=============================================
Correlated Subqueries

ex: students who took no classes

SELECT
	s.id
	, s.name
FROM
	students s
WHERE
	NOT EXISTS (SELECT 
					*
				FROM
					transcript t
				WHERE
					t.student_id = s.id); 

ex: find all students who took a course with prerequisites and also took all the required courses for that courses