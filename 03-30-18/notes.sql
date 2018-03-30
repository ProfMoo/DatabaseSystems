--Indexing + Secondary Storage
-- HDD is cheap, but slow (mechanical)
-- SSD is faster, but more expensive
-- RAM is even quicker, but doesn't work for large storage

----------------------------------------------
-- HDD

-- Seek time takes a long time, and is the biggest reason why HDD are slow
-- Seek -> move arm to the right track. Takes 0 - 17.38ms
-- Basically, just review CANOS notes (sector, seek time, cylinder, head, layers)
-- 7200rpm -> one rotation takes 8.3ms

-- Seek time: up to 17.38ms
-- Rotational latency: 8.3ms
-- Read sector 4: 0.03ms

-- Reading a page (page size is a multiple of the sector size):
-- 1 seek + 1 rotational latency + transfer time
-- 17.38/3 + 8.3/2 + 0.03*#sectors

-- Regular disk
-- 16 surfaces
-- 2^16 tracks per surface
-- 2^12 sectors/track

-- how much space on this ^^ disk?
-- 2^4 * 2^16 * 2^12 -> 2^32 -> 1TB disc

-- ex:
-- Read 1000 pages from disc. How long does it take?
	-- all this info is on the disk sequentially, so this is a great scenario.

	-- avg seek time -> 6ms
	-- avg rotational latency -> 4ms
	-- avg tt/page -> 0.03ms
	-- seek + RL + 1000*TT
		-- 6 + 4 + 1000*0.03 = 40ms

-- ex:
-- Read 1000 pages from disc. With random acces
	-- #pages(avg seek time + avg rot. lat + avg tt/page)
	-- 1000(6 + 4 + 0.03)
	-- 10,000ms (about).

-- Sequential read: multiple pages read with a single seek and rational latency
-- vs
-- Random I/O: each 

-----------------------------------------------
-- SSD

-- Transfer cost is a 

------------------------------------------------
-- Disk page = multiple tuples
--> DISK SLOW -> sequential vs. random I/O matters
--> MEMORY FAST -> complexity in memory is still much smaller a factor than disk reads.
-- COST OF OPERATIONS -> #DISK PAGES READ TO MEMORY + WRITTEN TO DISK

---------------------------------------------------------------------
-- RAID -> Redundant Array Of Inexpensive Disks
-- (D. Patterson) -> 2017 Turing Award

-- Addresses on a HDD.
-- surface# + track# + sector#.

-- When you have more than one disk, or a ton (like google):
-- data center# + cluster# + disk# + surface# + track# + sector#.

-- RAID-0 has no redundancy, so it's very quick.
	-- ex: 5 discs with RAID-0, you can read something like 5x as quickly.
	-- but you have no redundancy, so if one crashes, you're in trouble.

-- RAID-1 is a MIRROR. 
	-- ex: 4 discs with RAID-0, you have two discs for each copy of the info.
	-- you need to write on two things each time, it's very slow. you need to write slow
	-- read 2x as fast through parallelism
	-- can recover if one of the discs fails

-- RAID-4
	-- Store four discs normally.
	-- Then, the last one is some operation of all the first four.
	-- ex: 
		-- first four disks: P1, P2, P3, P4
		-- P1 XOR P2 XOR P3 XOR P4
	-- this is called the parity page ^^
	-- slower writes because parity is bottlenecking
	-- if any one of these discs fails, you can reconstruct

	-- RAID 4 ex:
	-- P1 0 1 1 0 
	-- P2 1 0 1 0
	-- P3 0 0 1 1
	-- P4 1 0 0 0
	-- Parity: 0 1 1 1
		
		-- P2 dies

	-- P1 0 1 1 0 

	-- P3 0 0 1 1
	-- P4 1 0 0 0
	-- Parity: 0 1 1 1

		-- we can get it back
		-- the recovery takes a long time (you have to read from 4)
		-- so a failure is a bit of a task, and slows system

-- RAID-5
	-- Exactly like RAID-4 except parity is split between HDD.

	-- ex:
	-- []	[]	[]	[]	[]
	-- P1	P2	P3	P4	par
	-- par 	P5	P6	P7	P8
	-- ect.

-- RAID-6 
	-- incase two fails.
	-- we aren't gonna talk about it.

-----------------------------------------------------
-- INDEXING

-- Sequential Read -> following the data from first part to end, in order.
-- Primary Access ^^

-- Primary Access means you need to go through all the pages.
-- [Cost = #Pages in Table] (less random I/O, more sequential hopefully)

-- Secondary Index
-- You get things like (discipline and sport) and then sort, with a page number associated.

-- So then how do we find things?: 
	-- read index and find pages with those tuples (#pages for index) 
	-- then, we need to read the tuple (random I/O for each tuple)