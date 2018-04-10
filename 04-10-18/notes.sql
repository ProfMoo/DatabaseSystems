-- 04-10-18

-- Query processing (Recap)
-- HW out later today, due next Tuesday

-- big way to tell how long a query takes: the amount of pages you have to read from disk
-- a database access time becomes important when the DB is very big (cant fit a decent fraction in memory)

-------------a------------------------

-- given an operator -> uses M blocks of memory 
	-- (M means memory unit, usually same size as disk page)
