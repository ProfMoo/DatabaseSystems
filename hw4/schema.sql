
drop table winter_medals ;
drop table summer_medals ;
drop table countries ;
drop table olympics ;
drop table events ;
drop table sports ;
drop table athletes;

create table countries(
      name          varchar(255) not null
      , code        char(3)  primary key
      , population  int 
      , gdp         float  --gross domestic product
) ;      

create table olympics (--all olympic games, winter or summer
       id       int primary key
       , year   int not null
       , city   varchar(255) not null
       , otype  char(6) not null   --winter or summer
       , check (otype in ('winter','summer'))
);

create table sports (--all sports in winter and summer games
       id           int primary key
       , name       varchar(255) not null
       , discipline varchar(255) not null
       , stype      char(6)      not null   --- winter or summer
) ;       

create table events (--all events in winter and summer games
       -- team vs individual events not distinguishable
       id          int primary key
       , sid       int not null -- which sport this event is for
       , name      varchar(255) not null
       , etype     char(1)  -- m or f
       , constraint event_fk foreign key (sid)
              references sports(id)
) ;       

create table athletes (--all athletes who won a medal in an olympic game
       id        int primary key
       , name    varchar(255) not null
       , country char(3)  -- same as countries(code)
       -- but not all countries are present in countries(code)
) ;       

create table summer_medals (--medals given in summer olympics
       id       int primary key
       , oid    int not null  -- olympic game id
       , aid    int not null  -- athlete id
       , eid    int not null  -- event id
       , medal  varchar(6) not null  -- Gold Silver or Bronze
       , constraint sm_fk1 foreign key (oid) references olympics(id)
       , constraint sm_fk2 foreign key (aid) references athletes(id)
       , constraint sm_fk3 foreign key (eid) references events(id)
) ;
       
create table winter_medals (--medals given in summer olympics
       id       int primary key
       , oid    int not null   -- olympic game id
       , aid    int not null   -- athlete id
       , eid    int not null   -- event id
       , medal  varchar(6) not null
       , constraint sm_fk1 foreign key (oid) references olympics(id)
       , constraint sm_fk2 foreign key (aid) references athletes(id)
       , constraint sm_fk3 foreign key (eid) references events(id)
) ;

