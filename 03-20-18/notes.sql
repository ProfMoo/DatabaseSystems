-- what happens is something you are trying to do fails?
-- abort whole transaction

-- Assertions at the database level

create assertion notemptyuniversity as check (select count(*) from students) > 0;
-- assertions can be costly because we check them for every database change
-- instead, we can use triggers to check only specific events

-- Triggers
--> based on event: insert/update/delete of tuples from tables
--> BEFORE/AFTER/INSTEAD OF THE EVENTS
--> and completes a procedure

--ex: 

alter table classes add enrollment int;

update classes
set enrollment = (select count (*) from transcript t
			where t.course_id = classes.courses
			and t.semester = classes.semester
			and t.year = classes.year
			and t.section = classes.section);

CREATE OR REPLACE FUNCTION enrollf() RETURNS trigger AS $$
BEGIN
update classes
set enrollment = enrollment + 1
where course_id = NEW.course_id
			and semester = NEW.semester
			and year = NEW.year
			and section = NEW.section;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enrollt AFTER INSERT ON transcript
FOR EACH ROW EXECUTE PROCEDURE enrollf();

--- now, we can use our trigger. if we add a class, it will update automatically

insert into transcript(student_id, course_id, semester, year, section)
values (111, 6, 'Spring', 2016, 2);

-- but ^^^ this only works on insert. maybe let's change it
-------------------------------------------

CREATE OR REPLACE FUNCTION enrollf() RETURNS trigger AS $$
BEGIN
update classes
set enrollment = (select count(*)
				from transcript t
				where t.course_id = NEW.courses
				and t.semester = NEW.semester
				and t.year = NEW.year
				and t.section = NEW.section);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enrollt AFTER INSERT, UPDATE, DELETE ON transcript
FOR EACH ROW EXECUTE PROCEDURE enrollf();

------ let's update it again

CREATE OR REPLACE FUNCTION enrollf() RETURNS trigger AS $$
DECLARE
	numstudents INT;
	maxstudents INT;
BEGIN
	select count(*) INTO numstudents
	from transcript t
	where t.course_id = NEW.courses
	and t.semester = NEW.semester
	and t.year = NEW.year
	and t.section = NEW.section);

select
	cr.numseats into maxstudents
from classes c, classrooms cr
WHERE c.classroom_id = cr.id and
	c.course_id = NEW.courses
	and c.semester = NEW.semester
	and c.year = NEW.year
	and c.section = NEW.section

if numstudents > maxstudents then
	RAISE NOTICE 'Max enrollment is reached for this class'
else
	update classes
	set enrollment = numstudents
	where course_id = NEW.course_id
		and semester = NEW.semester
		and year = NEW.year
		and section - NEW.section;

END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enrollt AFTER INSERT, UPDATE, DELETE ON transcript
FOR EACH ROW EXECUTE PROCEDURE enrollf();

-- we can have triggers go to functions that check for bad info. it can raise
-- an exception if there is a problem.

-- we can also have triggers that call other triggers. as a programmer, we have to
-- make sure that we don't turn them into cyclic recursive programs.

-- OLD and NEW
-- insert tuple t -> NEW is t
-- delete tuple t -> OLD is t
-- update tuple t -> have access to OLD and NEW.

------------------------------------
--------- CLASS BREAK --------------
------------------------------------

-- VIEWS

SELECT
	*
FROM
	(SELECT course_id, semester, year, section 
		FROM classes 
		WHERE semester = 'Spring' and year = 2016) as c1
	, transcript t
WHERE
	c1.semester = t.semester
	and c1.yer = t.year
	and c1.course_id = t.course_id
	and c1.section = t.section

-- Anonymous views only exist when you execute the query
-- we can get this and make it an object that we can reference after

CREATE VIEW curclasses(id, semester, year, section) (AS
SELECT course_id, semester, year, section 
		FROM classes 
		WHERE semester = 'Spring' and year = 2016)

SELECT 
	*
FROM curclasses c1
	, transcript t
WHERE
	c1.semester = t.semester
	and c1.year = t.year
	and c1.id = t.course_id
	and c1.section = t.section;


-- views are virtual, no tuples are stores, it is only saved as query text
-- non-virtual views are called materialized views

-- this is helpful because we can give a certain user/programmer access to certain
-- views. this way, we only need to worry about a certain part of the whole database.
-- a programmer only needs access to a few relations in the database, not all hundreds.

-- You can change data through a view

-- Updateable views -> you can update a table through a view ....
-- if the view only accesses one table in the from (view can only be of one table)
-- if the view has all attributes of the table that are not null
-- there is no distinct/group by in the view definition: there is one to one
-- correspondance between tuples in the view and tuples in the relation

insert into curclasses values(7, 'Spring', 2016, 1);
-- this will update classes with this info
-- we can also insert info into curclasses that goes to classes that doesn't even show up in curclasses.

-- to drop the view:
drop view curclasses;

-------------------------------------
----------- Indices -----------------
-------------------------------------

-- indices are additional copy of the data that you use for lookups.
-- a view is not a copy.

Create index classes_idx1 on classes(instructor_id, classroom_id)
-- now, this is a new index that depends on classes
-- if you create more indices, you need to update more things -> makes it slower
-- however, this will alow us to go to the smaller and smaller indices when we only need that info.
-- similar to a cache 

-- can form a hierarchy (full -> primary key (4 items) -> just ids)

-- indices are essentially just used to speed up queries
-- select * from classes;

--indices help with speedup sometimes, but not always. we will learn more about that.

-------------------------------------
---------- Access Control -----------
-------------------------------------

-- databases access under a complex access control system.
-- server contains:
	-- databases
	-- schemas
	-- users/roles

create role sibel;
-- we can give access rights to this role
create role sibelstudent password 'sibelstudent';
create role sibelprof password 'sibelprof';

create role dbta noinherit; -- you need to set role
create role dbstudent inherit;

grant dbstudent to sibelstudent
grant dbstudent to sibelprof;
grant dbta to sibelprof;
-- we are assigning access to the roles
-- sibelprof has access to student and prof
-- sibelstudent has acces to just student
-- we are inheriting permissions from other roles

revoke dbstudent from sibelprof;

-- what can different roles do?
---> any database objects: tables, indices, foreign_keys, functions...

create role sibelstudent password 'sibelstudent' inherit login;
create role sibelprof password 'sibelprof' inherit login createdb;

create database temp owner sibelstudent;
grant select on classes to dbstudent;
grant update on classes to dbstudent;	
grant select on classes to dbstudent with grant option;

remove cascade -> takes care of stuff lower down the line
remove restrict -> wont attempt anything if there is stuff down the line

--
-- END OF EXAM INFO
--