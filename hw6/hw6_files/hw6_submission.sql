

drop function hw6() ;

create function hw6() returns void AS $$
DECLARE
    num INTEGER ;
BEGIN
    -- replace these with your code
    num = 1;
    create table ids (id int) ;
    insert into ids values(1) ;
    drop table ids ;
END ;
$$ LANGUAGE plpgsql ;
