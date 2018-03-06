--figuring out a way to combine relations 

SELECT
	s.id
	, s.name
	, count(*) as num_courses_taken
	--also find number of A's
	, (select count(*) from transcript t2 where t2.student_id = s.id and t2.grade ='A') as num_as
FROM
	students s
	, transcript t
WHERE
	s.id = t.student_id
GROUP BY
	s.id

-- ask about grouping by and when you can and can't do it. also ask about mins

SELECT
	s.id
	, s.name
	, count(*) as num_courses_taken
	, ta.numa
FROM
	students s
	, transcript t

	, (select t2.student_id, count(*) as numa from transcript t2 where t2.grade ='A' group by t2.student_id) as ta
WHERE
	s.id = t.student_id
	and t.student_id = ta.student_id
GROUP BY
	s.id,
	ta.numa;
--DOESNT INCLUDE ZEROES!! ^^^

--we need a left join
SELECT
	s.id
	, s.name
	, count(*) as num_courses_taken
	, case when ta.numa is null then 0 else ta.numa is ta.numa
FROM
	students s
	inner join transcript t on s.id = t.student_id
	left join
	, (select t2.student_id, count(*) as numa from transcript t2 where t2.grade ='A' group by t2.student_id) as ta
	on t.student_id = ta.student_id
WHERE
	s.id = t.student_id
	
GROUP BY
	s.id,
	ta.numa;
--now have NULLS for zeroes. we still need to convert them (did in select with case)

--TODAYS DISCUSSION: TRANSACTIONS
--Transaction: Something that changes the data (insert, update, delete)
--Rule is that all things should happen or nothing should happen
--Atomicity is what this ^^^ is called

--INSERT

create table t1(id int primary key, name varchar(50), val int);

--assumes order and the right amount of values
insert into t1 values(1, 'cat', 5);

--now you are sayign the order
insert into t1(name, id) values ('dog', 2);

--this transaction failed because we dont have a key
insert into t1(name) values('snake');

--this squirrel line doesn't work, so nothing works.
begin;
insert into t1(name, id) values ('moose', 3);
insert into t1(name) values ('squirrel');
end;

----------

--CREATE

create table t2(id int primary key, name varchar(50));

insert into t2(id, name)
select id, name from t1;

--this will fail. we dont have the same num of attributes
insert into t2 select * from t1
-- but if they had the same, it would work

-------------

--DELETE

--delete from table where condition(over attributes of table);

--delete all tuples from table that satisfy the condition

create table t3 as select * from transcript;
delete from transcript where grade is NULL;

--what if we want to delete students who dont have a transcript? this
-- is tougher because it depends on stuff outisde of their own relation

--ex: delete all stduents who took no classes
delete from students left join transcript on s.id=t.student_id
	where t.student_id is null;
--THIS IS INCORRECT ^^, cant be executed

delete from students where students.id not in (select student_id from transcript);
-- this works ^^

----------------------

--UPDATE
-- update table set attribute = value where condition;
-- update all tuples for which condition is true, change attribute to given value

update studentstats
set num_courses_taken = 0
where id not in (select id from s2);

update studentstats
set num_courses_taken = 0, num_as = 10
where id not in (select id from s2);

--with subqueries
update studentstats
set num_courses_taken = (select count(*) from transcript t where t.student_id = s.id),
	num_as = (select count(*) from transcript t where t.student_id = s.id and t.grade = 'A');

drop table t4; --get rid of tables/relations
create table t4(
	id int primary key --unique and not null
	, name varchar(1) not null
	, val int unique
	, id2 int
	, id3 int
	, constraint t4_uc unique(id2, id3) 
	, constraint t3_ck check (id3 in (1,2,3)));

--EXTENDED EXAMPLE
--so then what is a foreign key??
create table st1 (
	id int primary key
	, name varchar(255)
);

create table tr1 (
	student_id int
	, course_id int
	, grade char(1)
	, primary key (student_id, course_id)
	, foreign key (student_id) references student(id) 
	--foreign key just means that if we have student 1 here,
	--there is a student tuple with student 1
	--primary key is the only one we can refer to as a foreign key!
);
--primary key can't be null, but unique can be

insert into st1 values(1, 'Adam')
insert into tr1 values(1,1,'A')
insert into tr1 values(2,1,'A')
--so we cant add the last one because our student ID isnt in the st1.
--so then wut if we change the value after we add it????

--primary key can't be null
--unique value can be null (and you can ahve multiple nulls)

-------------------------------BREAK
--we back

create table student (
	id int primary key
	, name varchar(255)
);

create table faculty (
	id int primary key
	, name varchar(255)
);

create table courses (
	id int primary key
	, instructor_id int
	, foreign key (instructor_id) references faculty(id)
);

create table transcript (
	student_id int
	, course_id int
	, grade char(1)
	, primary key (student_id, course_id)
	, foreign key (student_id) references student(id) 
	, foreign key (course_id) references courses(id)
);

insert into students values(1,'Adam');
insert into students values(2,'Evelyn');
insert into faculty values(1,'Cutler');
insert into faculty values(2,'Malik');
insert into courses values(1,1);
insert into courses values(2,1);
insert into courses values(3,2);
insert into transcript values(1,1,'A');
insert into transcript values(1,2,'A');
insert into transcript values(2,1,'B');
insert into transcript values(2,2,'B');

--so then what if we try to delete stuff that is a foreign key for other things?
delete from students where id = 2;
--^^^we are not allowed, it will fail

--if we try to delete them all at one time, none of them will delete if one fails.

--so then what if we wanna delete something that has a foreign key? we need to cascade delete
--this is deleting everything that depends on the thing you want to delete. need to start from bottom, this
--means you delete the lowest dependency first

create table transcript (
	student_id int
	, course_id int
	, grade char(1)
	, primary key (student_id, course_id)
	, foreign key (student_id) references student(id)
		on delete cascade
		on update cascade
	, foreign key (course_id) references courses(id)
);
--the delete cascade gets rid of tuples that depend on student_id if you want to get rid of it
--the cascade will match if we change the id's

--a good different example is courses. if we delete faculty, we still keep the course
--ex:
--on delete set null
--on update cascade

--on delete cascade (make sure to put it thru whole chain and be careful with these)
--on update cascase (a little bit safer)

------------------------------------------------------
--CHANGING TABLES
alter table students add major varchar(6)
alter table students add constraint suq unique(name);

----------------------------------------------------
--WRTING PROGRAMS
--at what point do you start writing programs instead of just queries?
--programs good at stuff like if statements
--SQL and databases good at stuff like joins (very very quick)

--when we cant do queries anymore, we write PROCEDURAL LANGUAGE
--so that we can get things from program and put into QUERY, then
--get output and put it into program

--ex:
--write top 3 morst frequent y for each x in table R(x,y,z)

Algorithm Top 3 y for each x:
   Run query:
        SELECT x,y, count(*) num
        FROM R
        GROUP BY x,y
        ORDER BY x,y, num;
   In a loop read each tuple such that:
       if a new x is found:
           read the next three y values
           (error handling if less than three y values are found)
           skip remaining x values

--ex: from webpage
