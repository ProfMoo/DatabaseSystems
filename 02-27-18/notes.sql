-- More on SQL...

--->Find students who got an A, find students who got a grade that is not A

select
	student_id
from
	transcript
where
	grade = 'A';

select
	student_id
from
	transcript
where
	grade <> 'A';

--->There does not exist queries; find students who never got an A
--->this means there does not exist a tuple for this student with grade A.

select id from students where id not in 
	(select student_id from transcript where grade = 'A')

--->different method


-->CORRECT
select
	s.id
from
	students s left join transcript t
	on s.id = t.student_id and t.grade = 'A'
where
	t.student_id is null;

--INCORRECT. finding students who took no courses and there will be no grade for them, so no tuples returned
select
	s.id
from
	students s left join transcript t
	on s.id = t.student_id
where
	t.student_id is null
	and t.grade = 'A'

-- Find all students who took a course with prereqs and also
-- took all the reuires courses for that course

-->FOR ALL QUERIES: student took ALL courses that are required.
-->Return students such that
-->there does not exist a prerequisite for a course they took -->except
-->they haven't taken -->
-->We have two exception/subtraction clauses in the same problem

-->Find all students for whom
-->	there does not exists a prerequisite for a course they took
-->		for which there does not exist a transcript tuple for this
-->			student and this required course

select
	distinct
from
	students s 
	, transcript t
	, requires r
where
	s.id = t.student_id
	and t.course_id = r.course_id
	and not exists
		(select
			*
		from
			requires r2
		where
			r2.course_id = t.course_id
			and not exists
				(
				select 
					*
				from
					transcript t2
				where
					t2.student_id = s.id
					and t2.course_id = r.prereq_id)


-->just because we can doesnt mean we should

select distinct
	s.id
	, s.name
from
	students s 
	, transcript t
	, transcript t2
	, requires r
where
	s.id = t.student_id
	and t.course_id = r.course_id
	and t2.course_id = r.prereq_id
	and t2.student_id = s.id
group by
	s.id
	, t.course_id
having
	count(distinct r.prereq_id) =
		(select 
			count(*)
		from 
			requires r2
		where
			r2.course_id = t.course_id;

--> 'with' keyword

WITH 	r1name AS (SELECT FROM WHERE query),
		r2name AS (SELECT FROM WHERE query)
SELECT
FROM
	r1name, r2name
WHERE
	...

--> not very useful in many situations, but we will give an examples
--> Find students who took more than 1 course in Spring 2015 and
--> had at least one incimplete grade (in any semester)

WITH morethan1 AS 
		(SELECT
			*
		FROM
			transcript t
		WHERE
			t.semester = 'Spring'
			and t.year = 2015
		GROUP BY
			t.student_id
		HAVING
			count(*) > 1),
	hasincomplete AS 
		(SELECT
			t.student_id as id
		FROM
			transcript t
			, morethan1 m
		WHERE
			t.grade = 'I'
			and t.student_id = m.id)
SELECT
	s.id
	, s.name
FROM
	students s
	, hasincomplete h
WHERE
	s.id = m.id

---DONT DO THIS UNLESS YOU HAVE TO ^^^
---DO IT THIS WAY? VVV

SELECT
	s.id
	, s.name
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
	and t.semester = 'Spring'
	and t.year = 2015
	and EXISTS ( SELECT 1 FROM transcript t2 WHERE t2.student_id = s.id and t2.grade = 'I')
GROUP BY
	s.id
HAVING
	count(*) > 1;

--RULES

--Write simplest possible query
--Almost always....
		--favor joins over subqueries
		--favor group by/having over multiple joins
--Sometimes
		--use set operations
--and order of preference
		--no subqueries > uncorrelated subqueries > correlated subqueries
--Avoid
		--anonymous relations and relations in WITH statement (not good for optimizer)
		--using DSITINCT/GROUP BY unless you have to
		--using ORDER BY unless you have to
		--do not use LIKE when you don't have to

--TRANSACTIONS
--up until now, we write a query, and we get a return
--transactions change the data
--transactions should be atomic, meaning they all execute or not of them
	--ex: you can't delete, then stop. you need to delete, then add new value

--Transactions: operation 1,2,3
--Atomicity: EIther all of 1,2,3 are excuted and recorded [COMMIT] or
	--operations 1,2,3 have no effect on the database [ROLLBACK]

--we want to insert a tuple into two different tables. if one fails, both do.

insert into tablename values(...);

insert into movies(id, name, year, show_id, actor_id)
	values(1,'a',2018,1,1);

insert into movies(id, name, year)
	values(1,'a',2018);

--ex:
begin ; -- start transaction
insert into t1 values(1);
insert into t2 values(1);
end; --commit

--now, both values are in both table or not