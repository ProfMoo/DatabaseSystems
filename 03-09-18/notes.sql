-- Quiz 4 Answers

-- 1
-- given relation actorroles(actor_id, hero_id)
-- insert tuples into this relation for each hero the actor played in a tv show or movie

insert into actorroles
select
from actor_id, hero_id from heroesintvshow;
from actor_id, hero_id from heroesinmovie;

-- 2
-- delete heroes tuples fo rheroes who have never appeared in a movie or a tv show.
-- you can use the actorroles relation from above to simplify this statement

delete from heroes
where id not in
	(select hero_id from heroesintvshow
	union select hero_id from heroesinmovie);

-- 3
-- update the actors relation that if there is a single hero this ever played,
-- then the actors.mainheroname should be the nameo f this hero. otherwise, this attribute
-- should remain unchanged.

update actors
set mainheroname = 
	(select h.name
	from actorroles a, heroes h
	where a.actor_id = actors.id and a.hero_id = h.id)
where 1 = (select count(*)
			from actorroles a
			where a.actor_id = actors.id);

-----------------------------------------------------------
-- Procedural SQL

-- how to decide when to start splitting up your queries?

-- Databasing systems:
-- RAILS, Django, Flask, OCCI, ProC, Plpgsql, DB2API

-- Two classes
-- Client side vs. Server side (means where does your program execute?)

-- Client side: not transfering big data, runs natively. network cost and processing cost is not
-- an issue on server side, while you worry about these for the client.

-- CLI (call lever interface) vs. Adaptor based programming			
-- CLI: make direct calls to the database, exposes all functionality of the database
-- , not a standard: ProC, OCCI (Oracle C Interface)

-- Q: difference between PostgreSQL, SQL, Django

-- Adaptor Based Interfaces: Standard library/module interface to a 
-- known programming languages (C++, Java, Python)
-- ex: if you want to use python with a database, you need to implement certain functions
-- JDBC -> Java, DB2API -> Python

-- Three levels:
-- C with extra functions
-- C with extra stuff, chunks of SQL
-- Opening a stream of the relation

-- Relations become streams once you query in a programming language

-- Prepared statements -> getting rid of SQL injection problrm by having previous statements

--------------------------------------------------------------------
-- SQL INJECTIONS

-- "select * from olympics where" + userinput
-- userinput can be anything (DROP TABLES???). ex: "; drop table STUDENTS"

--"select * from olympics where a = ?"
-- ^^ put ? with user input. if they try to drop, nothing happens)

---> Prepared statements, cursors, etc.
-- PLPGSQL: server side, postgresql specific, functions/procedures

----------------------------------------
-- FUNCTIONS

create function nummedals(year int) returns INTEGER AS $$
DECLARE
	count INTEGER;
BEGIN
	SELECT 
		count(distinct a.country) 
	FROM
		athletes a
		, winter_medals wm
		, olympics o
	WHERE
		m.oid = o.id
		and o.year = inputyear
		and m.aid = a.id;
	return count;
END ;
$$ LANGUAGE plpssql;

-- lots of things not done: what is the query returns nothing? error checking?

create function medalwinners(inputyear int, countrycode varchar) returns TEXT AS $$
DECLARE
	myrow RECORD;
	outstr TEXT;
BEGIN
	outstr = '';
	FOR myrow IN
		SELECT DISTINCT
			a.name 
			, m.medal
		FROM
			athletes a
			, winter_medals wm
			, olympics o
		WHERE
			m.oid = o.id
			and o.year = inputyear
			and m.aid = a.id
			and a.country = countrycode;
	LOOP
		outstr = outstr || myrow.name || '-' || myrow.medal || E'\n';
	END LOOP;
	RETURN outstr;
END ;
$$ LANGUAGE plpssql;

-- you can run this in the PSQL shell ^^
-- $$ $$ means that your function is between the dollar signs

------------------------------------------------------------------
-- TRIGGERS
-- they are active database elements
-- active element ex: cascade on delete

-- triggers are actively trying to solve your problems
-- they sit and watch all db operations

-- triggering actions are INSERT, UPDATE, DELETE
--								from tables

-- ex:
-- CREATE trigger on UPDATE of athletes

-- execute for BEFORE/AFTER/INSTEAD of TRIGGERING ACTION
-- kind of like inception (lol)

-- ex: delete 5 tuples
DELETE from TABLEA
	where id <= 5;

-- this will happen for each statement/row
CREATE TRIGGER BEFORE DELETE of TABLEA
	FOR EACH ROW
	INSERT INTO TABLEB VALUES (...) -- we can reference old tuple in here

-- soooo VVV
DELETE from TABLEA
	where id <= 5;

-- you get the info that is going to be deleted and put it somewhere else
-- for a little bit of time, you have access to old info and new info

-- what can we do with this?

BEFORE deleting, delete/fix all other tuples that reference the tuple being deleted

AFTER inserting, i can create create a log entry in a table