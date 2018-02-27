\i schema.sql
\copy countries(name,code,population,gdp) FROM 'countries.csv' DELIMITER ',' CSV HEADER;
\copy olympics(id,year,city,otype) FROM 'olympics.csv' DELIMITER '|' CSV HEADER;
\copy sports(id,name,discipline,stype) FROM 'sports.csv' DELIMITER '|' CSV HEADER;
\copy events(id,sid,name,etype) FROM 'events.csv' DELIMITER '|' CSV HEADER;
\copy athletes(id,name,country) FROM 'athletes.csv' DELIMITER '|' CSV HEADER;
\copy winter_medals(id,oid,aid,eid,medal) FROM 'winter_medals.csv' DELIMITER '|' CSV HEADER;
\copy summer_medals(id,oid,aid,eid,medal) FROM 'summer_medals.csv' DELIMITER '|' CSV HEADER;
