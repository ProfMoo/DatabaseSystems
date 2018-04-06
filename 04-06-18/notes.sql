-- 04/06/18

-- B-tree indices
	-- can be used for equality, can be used for ranges
	-- index on R(A)
		-- A = 5 		-> scan internal nodes
		-- 5 <= A <= 10 -> scan leaf nodes left to right until outside of range
	-- index on R(A,B) (or one index for R(A), then one for R(B))
		-- A = 5, B = 5
		-- A = 5, 5 <= B <= 15
		-- 5 <= A <= 15, B = 5
		-- 5 <= A <= 15, 5 <= B <= 15

-- 3 choices when you look at A & B.
	-- R(A)
		-- use index on A conditions, read tuples check for B
	-- R(A) & R(B)
		-- use index on A, then use index on B. then uses bitwise to see wut tuples match
	-- R(A,B)
		-- scan for 5 <= A <= 15, but then check for B too

-- why can't we just use technique 2 and then index EVERYTHING?
	-- indices slow down insertions/updates/deletions
		-- if you change the DB a lot, you are just slowing it down
		-- if you don't change the DB a lot, then maybe just index everything

-- ex:
CREATE INDEX myIdx ON athletes(name); -- this is b-tree
CREATE INDEX myIdx ON sports(name, discipline);
CREATE INDEX myIdx ON athletes(lower(name)); -- an expression is what is indexed

CREATE UNIQUE INDEX ... [default index created for primary keys]
CREATE INDEX myIdx ON athletes(name)
	WHERE name like 'Z%';

SELECT
	e.name
	, e.etype
FROM
	events e
	, sports s
WHERE
	e.sid = s.id
	and s.discipline = 'Figure skating'
ORDER BY
	e.name
	, e.etype;
-- a good index might be s.discipline, becasue we use it to shave stuff of the DB
-- always try to put indices on the biggest relations (by tuple size)
-- postgres will automatically use indices if it will be a bit speed up

--------------------------------------------------------------
-- R-Trees
	-- another kind of index (that is not a b-tree)
	-- can hold anything, not just integers or strings
	-- basically a 2D graph, holding points.
		-- just make a box around the values you want

-- ex:
	-- x_1 <= x <= x_2 && y_1 <= y <= y_2
	-- we will cluster them together, with similar x and y
	-- then make each cluster one leaf page
	-- the nodes above will just group clusters together

-- CHECK SIBEL'S HANDWRITTEN NOTES, THE DESIGNS R GOOD

-- we have to check all possible pointers in this one.
-- we can't say "this one fits, so no others do"

-- Nearest Neighbor Search
	-- scanning an ever expanding radius from the search point
	-- this essentially becomes branch & bound (so we dont have to check every cluster every time)
	-- so we pick one to prioritize and search first.

-----------------------------------------------------------------------
-- GIST
-- postgres supports GIST (generalizes indexed search tree)
	-- supports search for close clusters, etc, that allows someone to use nearest neighbor

-- why does postgress use some indices and not others?
------------------------------------------------------------------------
-- HASHING
	-- some number of buckets (hopefully consecutive)
	-- some aggress mechanism
	-- map each bucket to a disk page

	-- H(x) -> 1...K (then put it in that bucket)
	-- H(t_1) -> 2 (goes to bucket 2)
	-- H(t_2) -> 4 (goes to bucket 4)

	-- but hash can be used only for EQUALITY search (no RANGES)
		-- this is because the storage has no order, we cant follow the pointers
		-- we just read bucket for what we are checking equality for, then see if there is a tuple

	-- it is a one-stop shop. you just hash -> DONE

	-- still has normal problems: collision, needs a good hash function, etc

	-- Collision (two versions: science/engineering)
		-- science (extensible): if we have a collision, double size of directory so we have more space
		-- engineering (linear hashing): if we have collision, split another bucket and use that space

		-- science: best for absolute best performance 
		-- engineering: best for average case
-----------------------------------------------------------------------------
-- QUAD TREES
	-- competitors to R-trees (basically a hashed version of them)
	-- divides a large square into 4 squares, then it keeps going until there are only a few in each square
	-- this could leave it unbalanced

	-- not very efficient for a disk. 
------------------------------------------------------------------------------
-- INVERTED FILE
	-- <b-tree, hash, r-tree> -> take a key value (one or two attr) and map them to tuples that contain those key values
	-- ex: name = 'Bob
	-- an inverted file doesn't do this

	-- inverted file gets attr -> tokenize -> index tokens
	-- ex: 'Michael Phelps' -> 'Michael', 'Phelps'

	--token_1 -> (t_1, l_1, l_2, l_3), (t_2, l_1, l_2, ...)

	-- inverted files are good for keyword searched

	-- basically, you get the thing you are indexing on, then comparing that output.
		-- could be an image and you 'tokenizing' it by getting its main color
-------------------------------------------------------------------------------------
-- QUERY PROCESSING
	-- take a query -> query plan [relational algebra] -> assign query execution plan (it chooses the cheapest one)
	
-- OPERATOR INTERFACE
	-- (1) open() -> allocates memory for this operation + prepates data structures
	-- (2) get_next() -> produce 1 page worth of data by doing its operation
	-- (3) close() -> the opposite of open (de-allocates memory)

-- one pass operations
	-- SEQUENTIAL SCAN 
		-- (M = one block of memory)
		-- scan for the condition in this one block of memory
			-- if there is a hit, put it in the output buffer
		-- keep doign this, reading one block at a time

		-- this is big plays because we only use one block of memory
		-- COST OF OPERATION -> PAGES(R) (a single pass)
		-- but this is a problem because we need to seek a BUNCH of time (one per page)

	-- DUPLICATE REMOVAL (DISTINCT A,B)
		-- M > 1 (we have at least 2 pages of memory for this operation)
		-- if unique values fit in M-1 pages
			-- cost of operation = PAGES(R)