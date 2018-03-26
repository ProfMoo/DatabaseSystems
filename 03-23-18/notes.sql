
-- SQL: The advanced features
-- foreign key: what is cascading. what things become part of the same transaction, when to update/delete

-- not responsible for this stuff on the exam
-- this is stuff that is fancy, and not necessarily standard (some are just for postgres)

\d pg_user
-- all the users we are allowed to see

\d pg_tables
-- all tables

-------------------------------------------------------------------------------

select name, day, time, price from events;

select case when name like 's%' then name else 'other' end as newname
	, day
	, time
	, price
from 
	events;
-- just syntactic sugar. could be done like this ^^

select name, day, time, price from events where name like 's%'
union all
select 'other' from events where name not like 's%'
-- other one is much cleaner

--also learned stuff like this
with newevents as (
	select case when name like 's%' then name else 'other' end as newname
	, day
	, time
	, price
from 
	events)
select newname, sum(price)
from newevents
group by newname;

-- and
select
	day
	, time
	, sum(price)
from
	events
group by
	day
	, time;

-- 
select
	day
	, time
	, sum(price)
from
	events
group by
	day
	, time

union

select
	day
	, null
	, sum(price)
from
	events
group by
	day

union

select
	null
	, time
	, sum(price)
from
	events
group by
	time;
-- this is bad and very clunky. lets do it like this:

select
	day
	, time
	, sum(price)
from
	events
group by
	grouping sets((day, time), (day), time);

--and

select
	day
	, time
	, sum(price)
from
	events
group by
	grouping sets((), (day), time);

select
	name
	, day
	, time
	, sum(price)
from
	events
group by
	rollup(day, time, name);
-- this rollu[] is doing grouping sets: (day,time,name), (day,time), (day), ()

----------------------------------------------------------------------------------------
-- one more type of grouping: CUBE

select
	day
	, time
	, sum(price)
from
	events
group by
	cube(day,time);
-- cube(day,time) will have grouping sets (day,time), (day), (time), ()

select
	day
	, sum(price)
	, sum(price) filter(where name like '%s') as nonsum
	, sum(price) filter(where price>10) as biggerthan10sum
from
	events
group by
	day;

---------------------------------------------------------------------------------------------
-- PARTITION

-- gets the grouping by day and gets sum(price)
select
	name
	, day
	, time
	, price
	, sum(price) over (partition by day)
from
	events;

-----------------------------------------------------------------------------------------------
-- RECURSION
-- recursion is SQL standard

parents(parent, child) <- db table
ancestor(a,c) :- parents(p,c) -- somebody is an ancestor if they are a parents

ancestor(a,c) :- ancestor(a,b), parents(b,c) --somebody is an ancestor if they connect by parents after one gen
ancestor(a,c) :- parents(a,b), ancestors(b,c) -- databases see these the same way
ancestor(a,c) :- ancestor(a,b), ancestor(b,c) -- doesn't work in a database. can only have recursive on one side

--let's write it using SQL

with recursive ancestor(a,c,degree) as (
	(select
		parent
		, child
		, 1
	from
		parents)
	union
	(select
		a.a
		, p.child
		, a.degree + 1
	from
		ancestor a,
		parents p
	where
		a.c = p.parent
		and a.degree < (select (count(*) from parents))) -- makes sure it doesn't loop forever
	)
select
	a
	, c
	, degree
from
	ancestor
order by
	degree asc;

-----------------------------------------------------------------------

create table cities (
	name text
	, population float
	, altitude int
);

create table capitals (
	state char(2)

) INHERIT (cities)

insert into cities values('New York City', 8175133, 33);
insert into cities values('Syracuse', 145170, 380);
insert into capitals values('Albany', 97856, 312, 'NY');

select * from capitals; -- just albany
select * from cities; -- all cities (ALBANY INCLUDED)
select * from only cities; -- all cities (without Albany)

---

create table tictactoe (
	squares integer[3][3]
);
insert into tictactoe values ('{{1,2,3}, {4,5,6}, {7,8,9}}');
-- highly non-normalized. you have so much data in here ^^
select squares[1][2] from tictactoe;
--> 2
select squares[1][2:3] from tictactoe;
--> {{2,3}}

---

create table messages(msg text[]);
insert into messages values ('{"hello", "world"}');
-- this is not normalized at all
select msg[1:3] from messages;

--why do all this stuff?
--this is bad on its own, but can lead to good things

--------------------------------------------------------------------------------
-- INVERTED FILE

"this is not totally normalized, it is denormalized"
-- treat all of these words as a token
this 1
is 2,7
not 3
totally 4
normalized 5
it 6
denormalized 8

--this is done by a lot of computers
SELECT to_tsvector('english', 'The & Fat & Rats');