
-- Before test this
select 'num medals in Biathlon, Bobsleigh, Curling, Ice Hockey' ;

select count(*) from winter_medals w, events e, sports s
where w.eid = e.id and e.sid = s.id and
s.name in ('Biathlon', 'Bobsleigh', 'Curling', 'Ice Hockey');

select 'num medals in Football, Volleyball, Basketball' ;

select count(*) from summer_medals w, events e, sports s
where w.eid = e.id and e.sid = s.id and
s.name in ('Football','Volleyball','Basketball');

select 'select count(*) from events ;';
select count(*) from events ;

select 'select count(*) from summer_medals;';
select count(*) from summer_medals;

select 'select count(*) from winter_medals ;';
select count(*) from winter_medals ;

