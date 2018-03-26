drop function hw6();

create function hw6() returns void AS $$
DECLARE
	num INTEGER ;
BEGIN
	--a
	alter table events add sport varchar(255);
	alter table events add discipline varchar(255);
	alter table events add stype varchar(6);

	update events set sport = (	SELECT
									s.name
								FROM
									sports s
								WHERE
									s.id = events.sid);
	update events set discipline = (SELECT
									s.discipline
								FROM
									sports s
								WHERE
									s.id = events.sid);
	update events set stype = (SELECT
									s.stype
								FROM
									sports s
								WHERE
									s.id = events.sid);

	--b
	alter table events add category varchar(255);

	update events set category = (SELECT
									w.etype
								FROM
									winter_eventcategories w
								WHERE
									w.eid = events.id);

	update events set category = (SELECT
									e2.category
								FROM
									events e2
								WHERE
									events.etype = e2.etype
									and events.discipline = e2.discipline
									and events.name = e2.name
									and e2.id <> events.id
									and e2.category is not null
	 								)
	where events.category is null;
	
	--c
	create table new_events as (
		SELECT
			e1.*
		FROM
			events e1 inner join (
			SELECT
				e.name
				, e.discipline
				, e.etype
			FROM
				events e
			GROUP BY
				e.name
				, e.discipline
				, e.etype
			HAVING
				count(*) > 1) as e2
			on (e1.name = e2.name
				and e1.discipline = e2.discipline
				and e1.etype = e2.etype
				));

	CREATE TABLE to_keep AS (
		SELECT
			events.*
		FROM
			events);


	CREATE TABLE to_delete AS (
		SELECT
			new_events.*
		FROM
			new_events);

	DELETE FROM to_delete
	WHERE id IN 
		(SELECT
			n1.id
		FROM
			new_events n1
			, new_events n2
		WHERE
			n1.id < n2.id
			and n1.name = n2.name
			and n1.discipline = n2.discipline
			and n1.etype = n2.etype
		);

	DELETE FROM to_keep 
	WHERE id IN 
		(SELECT
			d.id
		FROM
			to_delete d
		);

	-- fixing winter_medals
	UPDATE winter_medals
	SET eid = (
		SELECT
			tk.id
		FROM
			to_keep tk
			, to_delete td
		WHERE
			tk.name = td.name
			and tk.discipline = td.discipline
			and tk.etype = td.etype
			and td.id = eid
		)
	WHERE eid IN (
		SELECT
			td.id
		FROM 
			to_delete td
		WHERE
			td.id = eid
		)
	;

	-- fixing summer_medals
	UPDATE summer_medals
	SET eid = (
		SELECT
			tk.id
		FROM
			to_keep tk
			, to_delete td
		WHERE
			tk.name = td.name
			and tk.discipline = td.discipline
			and tk.etype = td.etype
			and td.id = eid
		)
	WHERE eid IN (
		SELECT
			td.id
		FROM 
			to_delete td
		WHERE
			td.id = eid
		)
	;

	DROP TABLE winter_eventcategories;

	-- fixing events
	DELETE FROM events
	WHERE id IN 
		(SELECT
			d.id
		FROM
			to_delete d
		);

	drop table to_keep;
	drop table new_events;
	drop table to_delete;

END;
$$ LANGUAGE plpgsql ;