
-- After

select 'select count(*) from events ;';
select count(*) from events ;


select 'select count(*) from events where category is not null;';
select count(*) from events where category is not null;


select 'select count(*) from summer_medals;';
select count(*) from summer_medals;


select 'select count(*) from winter_medals ;';
select count(*) from winter_medals ;

select 'num medals in Biathlon, Bobsleigh, Curling, Ice Hockey' ;

select count(*) from winter_medals s, events e where s.eid = e.id and
e.sport in ('Biathlon', 'Bobsleigh', 'Curling', 'Ice Hockey');

select 'num medals in Football, Volleyball, Basketball' ;

select count(*) from summer_medals s, events e where s.eid = e.id and
e.sport in ('Football','Volleyball','Basketball');

