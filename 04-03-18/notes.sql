---- 04-03-18 ----

-- disk is slow (reading databases from disk into memory takes a long time)

-- Sequential read (N pages)
	-- seek + rotational latency + (N*transfer time)

-- Random I/O (N pages)
	-- N * (seek + rotational latency + transfer time)

----------------------------------------------
-- ex: 	avg seek + rotational latency -> 9ms
-- 		transfer time per page -> 0.03ms

-- Sequential
	-- N = 100
	-- 9 + 100*0.03 = 12
-- Random
	-- N = 100
	-- 100 * (9 + 0.03) = 903
-- Factor of 100 (or so) different

------------------------------------------------
-- Primary Access
-- read all pages of a relation
-- #pages in a relation (R), but mostly sequential I/O

-- index: so we dont have to read the whole relation

-- ex (from hw db):
	-- avg size of tuple: 50 bytes
	-- avg page size (default from postgres): 8k
	-- now we can figure out how many tuples go in each page, 
		-- and then how many pages each relation needs
	-- about 163 tuples per page.
	-- we know 'athletes' has 27030 tuples,
		-- so the relation needs 166 pages.
	-- 'summer_medals' needs 191 pages.
	-- we dont know if the tuple is on one page entirely, or split
		-- it doesnt really matter for our calculations

-- SPARSE INDEX:
-- Cycling, Cycling, Page: 45
-- Cycling, Cycling, Page: 67
-- Cycling, Cycling, Page: 89
-- Cycling, Cycling, Page: 100
-- Biking, Biking, Page: 56

-- DENSE INDEX:
-- Cycling, Cycling, Page: 45, 67, 89, 100
-- Biking, Biking, Page: 56

-------------------------------------
-- Next, we can built a structure to search through the index
-- MULTI-LEVEL INDEX

-- overview:
-- MULTI-LEVEL (root level) -> INDEX (leaf level) -> TABLE

-- How we do multi-level indices -> Binary-tree indices

-- B-tree index (multi-level index)
	-- each index page is stored in a disk page
	-- capacity of B-tree -> n (maximum)
	-- each node must have between [n/2 (half), n(full)] entries.
	-- except for the root -> (2,n) entries

-- leaf node contains (key value, tuple pointed pairs)
-- +1 pointer to the next leaf node 
-- Internal nodes contain key values + pointers to index pages at level below

--	+-----+-----+-----+
--	|  4  |  8  |  12 |
--  +-----+-----+-----+
--	|	  |     |     |
--  +-----+-----+-----+
-- blocks below have pointers to (things between 4 and 8), for example

-- Two types of search (we've done so far):
-- equality search, and range search

-- range search:
	-- go from root to leaf, find the node with value >= x
	-- scan leaf nodes left to right until your inequality is no longer valid
	-- done

-- suppose index on (A,B)

-- BIG PLAYS: check otu adali's handwritten notes. they have great drawings

-- double B-tree (A,B)
	-- A = 5, B = 5 (just like normal)
	-- A = 5  (search for A, then accept all B's)
	-- B = 5 (find first leaf node + scan all leaf)
	-- 1 <= A <= 2 and 3 <= B <= 5 (start where A is 1, then scan though until A > 2, sift for correct B's)

-- Insertion with B-trees
	-- if there is space in leaf, just insert. done
	-- if it is full, then you need to split (and then update b-tree node right above)
	-- this updating nodes needs to be recursive because you might run out of pointers in node above

-- Deletion (intuitively, it is a reverse)
	-- search for value to delete
	-- if the leaf is at least half full, stop
	-- if the leaf is less than half full, you need to borrow from next sibling and then adjust leaf above
		-- if you cant borrow from other leaf, then you need to merge (recursively)

-----------------------------
-- ex: we have a relation with 10^7 (1,000,000) tuples.
-- index -> 100 entries per node
-- leaf level -> 10^7/100 -> 10^5 leaf nodes
-- internal level above -> 10^5/100 -> 10^3 nodes
-- next level above -> 10^3/100 -> 10 nodes.
-- a single root node: 10 pointers

-- for 10 million nodes, we only have 4(!!!!!!!!!!) levels. 
	-- this is because we have 100 pointers, which is a lot.
	-- log_n(#tuples)

-- b-trees are extremely useful, make accessing 10 million tuples actually possible.
	-- we can get to where we want quickly
	-- we can keep the highest level or two in memory, because there aren't that many of them.