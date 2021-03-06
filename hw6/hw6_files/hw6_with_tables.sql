-- create tables

DROP TABLE winter_eventcategories;
DROP TABLE winter_medals;
DROP TABLE summer_medals;
DROP TABLE events;
DROP TABLE sports;
DROP TABLE olympics;
DROP TABLE athletes;
DROP TABLE to_delete;
DROP TABLE to_keep;
DROP TABLE new_events;

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

create table winter_eventcategories(
       eid int  primary key
       , etype    char(6)
       , check (etype in ('single','multi','team'))
       , foreign key (eid) references events(id)
) ;

-- add data 
insert into olympics values(1, 1924, 'Chamonix', 'winter');
insert into olympics values(2, 1928, 'St.Moritz', 'winter');
insert into olympics values(3, 1932, 'Lake Placid', 'winter');
insert into olympics values(4, 1936, 'Garmisch Partenkirchen', 'winter');
insert into olympics values(5, 1948, 'St.Moritz', 'winter');
insert into olympics values(6, 1952, 'Oslo', 'winter');
insert into olympics values(7, 1956, 'Cortina d''Ampezzo', 'winter');
insert into olympics values(8, 1960, 'Squaw Valley', 'winter');
insert into olympics values(9, 1964, 'Innsbruck', 'winter');
insert into olympics values(10, 1968, 'Grenoble', 'winter');
insert into olympics values(11, 1972, 'Sapporo', 'winter');
insert into olympics values(12, 1976, 'Innsbruck', 'winter');
insert into olympics values(13, 1980, 'Lake Placid', 'winter');
insert into olympics values(14, 1984, 'Sarajevo', 'winter');
insert into olympics values(15, 1988, 'Calgary', 'winter');
insert into olympics values(16, 1992, 'Albertville', 'winter');
insert into olympics values(17, 1994, 'Lillehammer', 'winter');
insert into olympics values(18, 1998, 'Nagano', 'winter');
insert into olympics values(19, 2002, 'Salt Lake City', 'winter');
insert into olympics values(20, 2006, 'Turin', 'winter');
insert into olympics values(21, 2010, 'Vancouver', 'winter');
insert into olympics values(22, 2014, 'Sochi', 'winter');
insert into olympics values(23, 1896, 'Athens', 'summer');
insert into olympics values(24, 1900, 'Paris', 'summer');
insert into olympics values(25, 1904, 'St Louis', 'summer');
insert into olympics values(26, 1908, 'London', 'summer');
insert into olympics values(27, 1912, 'Stockholm', 'summer');
insert into olympics values(28, 1920, 'Antwerp', 'summer');
insert into olympics values(29, 1924, 'Paris', 'summer');
insert into olympics values(30, 1928, 'Amsterdam', 'summer');
insert into olympics values(31, 1932, 'Los Angeles', 'summer');
insert into olympics values(32, 1936, 'Berlin', 'summer');
insert into olympics values(33, 1948, 'London', 'summer');
insert into olympics values(34, 1952, 'Helsinki', 'summer');
insert into olympics values(35, 1956, 'Melbourne / Stockholm', 'summer');
insert into olympics values(36, 1960, 'Rome', 'summer');
insert into olympics values(37, 1964, 'Tokyo', 'summer');
insert into olympics values(38, 1968, 'Mexico', 'summer');
insert into olympics values(39, 1972, 'Munich', 'summer');
insert into olympics values(40, 1976, 'Montreal', 'summer');
insert into olympics values(41, 1980, 'Moscow', 'summer');
insert into olympics values(42, 1984, 'Los Angeles', 'summer');
insert into olympics values(43, 1988, 'Seoul', 'summer');
insert into olympics values(44, 1992, 'Barcelona', 'summer');
insert into olympics values(45, 1996, 'Atlanta', 'summer');
insert into olympics values(46, 2000, 'Sydney', 'summer');
insert into olympics values(47, 2004, 'Athens', 'summer');
insert into olympics values(48, 2008, 'Beijing', 'summer');
insert into olympics values(49, 2012, 'London', 'summer');
insert into olympics values(50, 2018, 'PyeongChang', 'winter');
insert into sports values(1, 'Biathlon', 'Biathlon', 'winter');
insert into sports values(2, 'Bobsleigh', 'Bobsleigh', 'winter');
insert into sports values(3, 'Curling', 'Curling', 'winter');
insert into sports values(4, 'Ice Hockey', 'Ice Hockey', 'winter');
insert into sports values(5, 'Skating', 'Figure skating', 'winter');
insert into sports values(6, 'Skating', 'Speed skating', 'winter');
insert into sports values(7, 'Skiing', 'Cross Country Skiing', 'winter');
insert into sports values(8, 'Skiing', 'Nordic Combined', 'winter');
insert into sports values(9, 'Skiing', 'Ski Jumping', 'winter');
insert into sports values(10, 'Bobsleigh', 'Skeleton', 'winter');
insert into sports values(11, 'Skiing', 'Alpine Skiing', 'winter');
insert into sports values(12, 'Luge', 'Luge', 'winter');
insert into sports values(13, 'Skating', 'Short Track Speed Skating', 'winter');
insert into sports values(14, 'Skiing', 'Freestyle Skiing', 'winter');
insert into sports values(15, 'Skiing', 'Snowboard', 'winter');
insert into sports values(16, 'Aquatics', 'Swimming', 'summer');
insert into sports values(17, 'Athletics', 'Athletics', 'summer');
insert into sports values(18, 'Cycling', 'Cycling Road', 'summer');
insert into sports values(19, 'Cycling', 'Cycling Track', 'summer');
insert into sports values(20, 'Fencing', 'Fencing', 'summer');
insert into sports values(21, 'Gymnastics', 'Artistic G.', 'summer');
insert into sports values(22, 'Shooting', 'Shooting', 'summer');
insert into sports values(23, 'Tennis', 'Tennis', 'summer');
insert into sports values(24, 'Weightlifting', 'Weightlifting', 'summer');
insert into sports values(25, 'Wrestling', 'Wrestling Gre-R', 'summer');
insert into sports values(26, 'Aquatics', 'Water polo', 'summer');
insert into sports values(27, 'Archery', 'Archery', 'summer');
insert into sports values(31, 'Equestrian', 'Jumping', 'summer');
insert into sports values(32, 'Football', 'Football', 'summer');
insert into sports values(34, 'Polo', 'Polo', 'summer');
insert into sports values(35, 'Rowing', 'Rowing', 'summer');
insert into sports values(36, 'Rugby', 'Rugby', 'summer');
insert into sports values(37, 'Sailing', 'Sailing', 'summer');
insert into sports values(38, 'Tug of War', 'Tug of War', 'summer');
insert into sports values(39, 'Aquatics', 'Diving', 'summer');
insert into sports values(40, 'Boxing', 'Boxing', 'summer');
insert into sports values(43, 'Wrestling', 'Wrestling Free.', 'summer');
insert into sports values(44, 'Hockey', 'Hockey', 'summer');
insert into sports values(47, 'Skating', 'Figure skating', 'summer');
insert into sports values(50, 'Equestrian', 'Eventing', 'summer');
insert into sports values(51, 'Modern Pentathlon', 'Modern Pentath.', 'summer');
insert into sports values(54, 'Basketball', 'Basketball', 'summer');
insert into sports values(55, 'Canoe / Kayak', 'Canoe / Kayak F', 'summer');
insert into sports values(56, 'Handball', 'Handball', 'summer');
insert into sports values(57, 'Judo', 'Judo', 'summer');
insert into sports values(58, 'Volleyball', 'Volleyball', 'summer');
insert into sports values(59, 'Canoe / Kayak', 'Canoe / Kayak S', 'summer');
insert into sports values(60, 'Aquatics', 'Synchronized S.', 'summer');
insert into sports values(61, 'Gymnastics', 'Rhythmic G.', 'summer');
insert into sports values(62, 'Table Tennis', 'Table Tennis', 'summer');
insert into sports values(63, 'Badminton', 'Badminton', 'summer');
insert into sports values(66, 'Softball', 'Softball', 'summer');
insert into sports values(67, 'Volleyball', 'Beach volley.', 'summer');
insert into sports values(68, 'Gymnastics', 'Trampoline', 'summer');
insert into sports values(69, 'Taekwondo', 'Taekwondo', 'summer');
insert into sports values(73, 'Aquatics', 'Synchronized Swimming', 'summer');
insert into sports values(74, 'Aquatics', 'Water Polo', 'summer');
insert into sports values(76, 'Canoe', 'Canoe Sprint', 'summer');
insert into sports values(79, 'Gymnastics', 'Gymnastics Rhythmic', 'summer');
insert into events values(2, 2, 'Four-Man', 'm');
insert into events values(3, 3, 'Curling', 'm');
insert into events values(4, 4, 'Ice Hockey', 'm');
insert into events values(5, 5, 'Individual', 'm');
insert into events values(6, 5, 'Individual', 'w');
insert into events values(7, 5, 'Pairs', 'w');
insert into events values(8, 5, 'Pairs', 'm');
insert into events values(9, 6, '10000M', 'm');
insert into events values(10, 6, '1500M', 'm');
insert into events values(11, 6, '5000M', 'm');
insert into events values(12, 6, '500M', 'm');
insert into events values(15, 7, '50KM', 'm');
insert into events values(16, 8, 'Individual', 'm');
insert into events values(17, 9, 'K90 Individual (70M)', 'm');
insert into events values(19, 10, 'Individual', 'm');
insert into events values(20, 2, 'Two-Man', 'm');
insert into events values(21, 11, 'Alpine Combined', 'm');
insert into events values(22, 11, 'Alpine Combined', 'w');
insert into events values(23, 7, '4X10KM Relay', 'm');
insert into events values(24, 11, 'Downhill', 'm');
insert into events values(25, 11, 'Downhill', 'w');
insert into events values(26, 11, 'Slalom', 'm');
insert into events values(27, 11, 'Slalom', 'w');
insert into events values(28, 11, 'Giant Slalom', 'm');
insert into events values(29, 11, 'Giant Slalom', 'w');
insert into events values(30, 7, '10KM', 'w');
insert into events values(31, 7, '15KM', 'm');
insert into events values(32, 7, '30KM Mass Start', 'm');
insert into events values(35, 6, '1000M', 'w');
insert into events values(36, 6, '1500M', 'w');
insert into events values(37, 6, '3000M', 'w');
insert into events values(38, 6, '500M', 'w');
insert into events values(39, 12, 'Doubles', 'm');
insert into events values(40, 12, 'Singles', 'm');
insert into events values(41, 12, 'Singles', 'w');
insert into events values(42, 7, '5KM', 'w');
insert into events values(43, 9, 'K120 Individual (90M)', 'm');
insert into events values(44, 1, '4X7.5KM Relay', 'm');
insert into events values(45, 5, 'Ice Dancing', 'm');
insert into events values(46, 5, 'Ice Dancing', 'w');
insert into events values(47, 6, '1000M', 'm');
insert into events values(48, 7, '4X5KM Relay', 'w');
insert into events values(49, 1, '10KM', 'm');
insert into events values(51, 6, '5000M', 'w');
insert into events values(52, 11, 'Super-G', 'm');
insert into events values(53, 11, 'Super-G', 'w');
insert into events values(54, 8, 'Team', 'm');
insert into events values(55, 9, 'K120 Team (90M)', 'm');
insert into events values(56, 1, '15KM', 'w');
insert into events values(57, 1, '4X7.5KM Relay', 'w');
insert into events values(58, 1, '7.5KM', 'w');
insert into events values(59, 13, '1000M', 'm');
insert into events values(60, 13, '3000M Relay', 'w');
insert into events values(61, 13, '5000M Relay', 'm');
insert into events values(65, 7, '30KM', 'w');
insert into events values(67, 7, 'Combined 5KM + 10KM Pursuit', 'w');
insert into events values(68, 14, 'Moguls', 'm');
insert into events values(69, 14, 'Moguls', 'w');
insert into events values(70, 13, '1000M', 'w');
insert into events values(71, 13, '500M', 'm');
insert into events values(73, 14, 'Aerials', 'w');
insert into events values(74, 3, 'Curling', 'w');
insert into events values(75, 4, 'Ice Hockey', 'w');
insert into events values(78, 15, 'Half-Pipe', 'm');
insert into events values(79, 15, 'Half-Pipe', 'w');
insert into events values(80, 1, '10KM Pursuit', 'w');
insert into events values(82, 2, 'Two-Man', 'w');
insert into events values(86, 7, '5Km Pursuit', 'w');
insert into events values(88, 7, 'Sprint 1.5KM', 'w');
insert into events values(91, 15, 'Giant Parallel Slalom', 'w');
insert into events values(92, 1, '12.5KM Mass Start', 'w');
insert into events values(93, 1, '15KM Mass Start', 'm');
insert into events values(94, 1, '4X6KM Relay', 'w');
insert into events values(95, 6, 'Team Pursuit', 'm');
insert into events values(96, 6, 'Team Pursuit', 'w');
insert into events values(99, 7, 'Team Sprint', 'm');
insert into events values(100, 7, 'Team Sprint', 'w');
insert into events values(107, 14, 'Ski Cross', 'w');
insert into events values(116, 5, 'Team', 'm');
insert into events values(118, 7, 'Combined 15+15K', 'm');
insert into events values(119, 7, 'Combined7.5+7.5', 'w');
insert into events values(124, 8, 'Ind. K90 (70M)', 'm');
insert into events values(128, 9, 'K90 Individual', 'w');
insert into events values(129, 15, 'Giant Parall.S.', 'm');
insert into events values(131, 15, 'Slopestyle', 'm');
insert into events values(138, 16, '400M Freestyle', 'm');
insert into events values(142, 17, '400M', 'm');
insert into events values(144, 17, 'Discus Throw', 'm');
insert into events values(147, 17, 'Marathon', 'm');
insert into events values(149, 17, 'Shot Put', 'm');
insert into events values(152, 19, '100KM', 'm');
insert into events values(159, 20, 'Sabre Individual', 'm');
insert into events values(163, 21, 'Rings', 'm');
insert into events values(167, 21, 'Vault', 'm');
insert into events values(169, 22, '25M Rapid Fire Pistol (60 Shots)', 'm');
insert into events values(170, 22, '50M Pistol (60 Shots)', 'm');
insert into events values(173, 23, 'Doubles', 'm');
insert into events values(183, 16, '4000M Freestyle', 'm');
insert into events values(185, 26, 'Water Polo', 'm');
insert into events values(194, 17, '3000M Steeplechase', 'm');
insert into events values(196, 17, '400M Hurdles', 'm');
insert into events values(212, 20, 'Epee Individual', 'm');
insert into events values(216, 32, 'Football', 'm');
insert into events values(219, 21, 'Individual All-Round', 'm');
insert into events values(220, 34, 'Polo', 'm');
insert into events values(221, 35, 'Eight With Coxswain (8+)', 'm');
insert into events values(222, 35, 'Four-Oared Shell With Coxswain (4-)', 'm');
insert into events values(223, 35, 'Pair-Oared Shell With Coxswain (2+)', 'm');
insert into events values(224, 35, 'Single Sculls (1X)', 'm');
insert into events values(225, 36, 'Rugby', 'm');
insert into events values(230, 22, '50M Army Pistol, Team', 'm');
insert into events values(231, 22, 'Army Rifle, 300M, 3 Positions', 'm');
insert into events values(240, 38, 'Tug Of War', 'm');
insert into events values(241, 39, '10M Platform', 'm');
insert into events values(244, 16, '400M Breaststroke', 'm');
insert into events values(254, 17, '4Miles Team', 'm');
insert into events values(272, 20, 'Foil Team', 'm');
insert into events values(278, 21, 'Team Competition', 'm');
insert into events values(281, 35, 'Coxless Pair (2-)', 'm');
insert into events values(282, 35, 'Double Sculls (2X)', 'm');
insert into events values(283, 35, 'Four Without Coxswain (4-)', 'm');
insert into events values(288, 43, '52.16 - 56.7KG (Bantamweight)', 'm');
insert into events values(293, 16, '200M Breaststroke', 'm');
insert into events values(294, 16, '4X200M Freestyle Relay', 'm');
insert into events values(302, 17, '4X400M Relay', 'm');
insert into events values(311, 19, '1980 Yards Pursuit, Team', 'm');
insert into events values(312, 19, '2000M Tandem', 'm');
insert into events values(316, 20, 'Epee Team', 'm');
insert into events values(317, 20, 'Sabre Team', 'm');
insert into events values(318, 44, 'Hockey', 'm');
insert into events values(329, 22, '100M Running Deer, Single Shots, Team', 'm');
insert into events values(334, 22, '50M Rifle Prone (60 Shots)', 'm');
insert into events values(336, 22, 'Clay Pigeons, Team', 'm');
insert into events values(339, 47, 'Individual', 'w');
insert into events values(341, 47, 'Pairs', 'w');
insert into events values(345, 23, 'Singles Indoor', 'w');
insert into events values(356, 25, '66.6 - 73KG (Middleweight)', 'm');
insert into events values(360, 16, '100M Freestyle', 'w');
insert into events values(361, 16, '4X100M Freestyle Relay', 'w');
insert into events values(363, 17, '10000M Walk', 'm');
insert into events values(365, 17, '4X100M Relay', 'm');
insert into events values(374, 18, 'Team Time Trial', 'm');
insert into events values(377, 50, 'Team', 'm');
insert into events values(378, 31, 'Team', 'm');
insert into events values(397, 16, '400M Freestyle', 'w');
insert into events values(402, 27, 'Moving Bird Target 28M Teams', 'm');
insert into events values(418, 19, 'Team Pursuit (4000M)', 'm');
insert into events values(426, 37, '12M (Rating 1919)', 'm');
insert into events values(440, 22, '50M Small Bore Rifle, Standing, Individual', 'm');
insert into events values(456, 16, '100M Backstroke', 'w');
insert into events values(459, 20, 'Foil Individual', 'w');
insert into events values(475, 43, '79 - 87KG (Light-Heavyweight)', 'm');
insert into events values(479, 17, '100M', 'w');
insert into events values(480, 17, '4X100M Relay', 'w');
insert into events values(482, 17, 'Discus Throw', 'w');
insert into events values(486, 31, 'Individual', 'w');
insert into events values(487, 21, 'Team Competition', 'w');
insert into events values(492, 24, '60 - 67.5KG, Total (Lightweight)', 'm');
insert into events values(493, 24, '67.5 - 75KG, Total (Middleweight)', 'm');
insert into events values(498, 17, 'Javelin Throw', 'w');
insert into events values(501, 21, 'Floor Exercises', 'm');
insert into events values(504, 37, 'Two-Person Keelboat Open (Star)', 'm');
insert into events values(507, 25, '56 - 61KG (Featherweight)', 'm');
insert into events values(512, 54, 'Basketball', 'm');
insert into events values(515, 55, 'C-2 1000M (Canoe Double)', 'm');
insert into events values(521, 55, 'K-2 1000M (Kayak Double)', 'm');
insert into events values(522, 56, 'Handball', 'm');
insert into events values(523, 17, '200M', 'w');
insert into events values(525, 17, 'Shot Put', 'w');
insert into events values(539, 24, '- 56KG, Total (Bantamweight)', 'm');
insert into events values(542, 43, '52 - 57KG (Bantamweight)', 'm');
insert into events values(543, 43, '57 - 63KG (Featherweight)', 'm');
insert into events values(548, 25, '52 - 57KG (Bantamweight)', 'm');
insert into events values(558, 40, '67 - 71KG (Light-Middleweight)', 'm');
insert into events values(559, 40, '71-75KG', 'm');
insert into events values(563, 21, 'Balance Beam', 'w');
insert into events values(565, 21, 'Individual All-Round', 'w');
insert into events values(567, 21, 'Uneven Bars', 'w');
insert into events values(568, 21, 'Vault', 'w');
insert into events values(569, 51, 'Team Competition', 'm');
insert into events values(573, 37, 'Single-Handed Dinghy (Finn)', 'm');
insert into events values(578, 16, '100M Butterfly', 'w');
insert into events values(579, 16, '200M Butterfly', 'm');
insert into events values(582, 37, 'Sharpie 12M2', 'm');
insert into events values(584, 16, '4X100M Medley Relay', 'w');
insert into events values(586, 55, 'K-2 500M (Kayak Double)', 'w');
insert into events values(587, 20, 'Foil Team', 'w');
insert into events values(588, 37, 'Flying Dutchman', 'm');
insert into events values(591, 16, '4X100M Freestyle Relay', 'm');
insert into events values(592, 17, '400M', 'w');
insert into events values(594, 55, 'K-4 1000M (Kayak Four)', 'm');
insert into events values(599, 57, 'Open Category', 'm');
insert into events values(600, 58, 'Volleyball', 'm');
insert into events values(601, 58, 'Volleyball', 'w');
insert into events values(610, 25, '70 - 78KG (Welterweight)', 'm');
insert into events values(614, 16, '100M Breaststroke', 'w');
insert into events values(620, 16, '200M Individual Medley', 'w');
insert into events values(623, 40, '48 - 51KG (Flyweight)', 'm');
insert into events values(624, 22, 'Skeet (125 Targets)', 'm');
insert into events values(629, 17, '4X400M Relay', 'w');
insert into events values(632, 59, 'K-1 (Kayak Single)', 'm');
insert into events values(639, 37, 'Fleet/Match Race Keelboat Open (Soling)', 'm');
insert into events values(641, 22, '50M Running Target (30+30 Shots)', 'm');
insert into events values(643, 24, '+ 110KG, Total (Super Heavyweight)', 'm');
insert into events values(644, 24, '52 - 56KG, Total (Bantamweight)', 'm');
insert into events values(647, 43, '+ 100KG (Super Heavyweight)', 'm');
insert into events values(648, 43, '48 - 52KG (Flyweight)', 'm');
insert into events values(655, 25, '- 48KG (Light-Flyweight)', 'm');
insert into events values(664, 54, 'Basketball', 'w');
insert into events values(667, 55, 'K-1 500M (Kayak Single)', 'm');
insert into events values(668, 55, 'K-2 500M (Kayak Double)', 'm');
insert into events values(669, 56, 'Handball', 'w');
insert into events values(671, 35, 'Eight With Coxswain (8+)', 'w');
insert into events values(675, 35, 'Quadruple Sculls Without Coxswain (4X)', 'm');
insert into events values(680, 44, 'Hockey', 'w');
insert into events values(681, 57, '- 60 KG', 'm');
insert into events values(683, 57, '60 - 65KG (Half-Lightweight)', 'm');
insert into events values(684, 57, '65 - 71KG (Lightweight)', 'm');
insert into events values(690, 60, 'Duet', 'w');
insert into events values(707, 22, '50M Rifle 3 Positions (3X20 Shots)', 'w');
insert into events values(711, 17, '10000M', 'w');
insert into events values(713, 35, 'Quadruple Sculls Without Coxswain (4X)', 'w');
insert into events values(714, 37, '470 - Two Person Dinghy', 'w');
insert into events values(721, 62, 'Singles', 'w');
insert into events values(725, 27, 'Individual (Fita Olympic Round - 70M)', 'w');
insert into events values(727, 27, 'Team (Fita Olympic Round - 70M)', 'w');
insert into events values(729, 63, 'Doubles', 'm');
insert into events values(732, 63, 'Singles', 'w');
insert into events values(735, 57, '- 48KG (Extra-Lightweight)', 'w');
insert into events values(742, 35, 'Coxless Four (4-)', 'w');
insert into events values(747, 16, '4X200M Freestyle Relay', 'w');
insert into events values(748, 60, 'Team', 'w');
insert into events values(757, 32, 'Football', 'w');
insert into events values(758, 61, 'Group Competition', 'w');
insert into events values(759, 57, '+ 100KG (Heavyweight)', 'm');
insert into events values(762, 57, '73 - 81KG (Half-Middleweight)', 'm');
insert into events values(767, 35, 'Lightweight Double Sculls (2X)', 'w');
insert into events values(773, 66, 'Softball', 'w');
insert into events values(775, 67, 'Beach Volleyball', 'w');
insert into events values(787, 39, 'Synchronized Diving 10M Platform', 'w');
insert into events values(796, 19, 'Madison', 'm');
insert into events values(799, 68, 'Individual', 'w');
insert into events values(802, 57, '57 - 63KG (Half-Middleweight)', 'w');
insert into events values(803, 57, '63 - 70KG (Middleweight)', 'w');
insert into events values(816, 69, '58 - 68 KG', 'm');
insert into events values(828, 24, '63KG', 'w');
insert into events values(831, 24, '75KG', 'w');
insert into events values(845, 25, '58 - 63KG', 'm');
insert into events values(846, 25, '63 - 69KG', 'm');
insert into events values(889, 62, 'Team', 'm');
insert into events values(904, 16, '4X100M Medley', 'w');
insert into events values(905, 16, '4X200M Freestyle', 'm');
insert into events values(908, 73, 'Team', 'w');
insert into events values(910, 74, 'Water Polo', 'w');
insert into events values(913, 27, 'Team', 'm');
insert into events values(931, 76, 'C-1 1000M', 'm');
insert into events values(942, 76, 'K-4 500M', 'w');
insert into events values(970, 79, 'Group Competition', 'w');
insert into events values(978, 57, '63 - 70KG', 'w');
insert into events values(993, 35, 'Lightweight 4', 'm');
insert into events values(1001, 37, '470', 'w');
insert into events values(1027, 24, '+75KG', 'w');
insert into events values(1047, 1, 'Combined 2x6km  + 2x7.5km  Mixed Relay', 'w');
insert into events values(1049, 7, '4X10KM Relay', 'm');
insert into events values(1050, 3, 'Curling', 'w');
insert into events values(1051, 4, 'Ice Hockey', 'm');
insert into events values(1052, 13, '3000M Relay', 'w');
insert into events values(1053, 2, 'Four-Man', 'm');
insert into events values(1054, 4, 'Ice Hockey', 'w');
insert into events values(1055, 1, '4X7.5KM Relay', 'm');
insert into events values(1056, 7, '4X5KM Relay', 'w');
insert into events values(1057, 1, '4X7.5KM Relay', 'w');
insert into events values(1058, 11, 'Downhill', 'm');
insert into events values(1059, 13, '5000M Relay', 'm');
insert into events values(1060, 21, 'Team Competition', 'm');
insert into events values(1061, 44, 'Hockey', 'w');
insert into events values(1062, 58, 'Volleyball', 'w');
insert into events values(1063, 17, '4X400M Relay', 'm');
insert into events values(1064, 19, 'Team Pursuit (4000M)', 'm');
insert into events values(1065, 32, 'Football', 'm');
insert into events values(1066, 54, 'Basketball', 'm');
insert into events values(1067, 58, 'Volleyball', 'm');
insert into events values(1068, 17, '4X100M Relay', 'm');
insert into events values(1069, 44, 'Hockey', 'm');
insert into events values(1070, 32, 'Football', 'w');
insert into events values(1071, 26, 'Water Polo', 'm');
insert into athletes values(32, 'AIKMAN, T.', 'GBR');
insert into athletes values(86, 'BRUNET, Pierre', 'FRA');
insert into athletes values(90, 'JAKOBSSON, Walter', 'FIN');
insert into athletes values(99, 'GROTTUMSBRAATEN, Johan', 'NOR');
insert into athletes values(128, 'MARTIGNONI, Arnold', 'SUI');
insert into athletes values(158, 'HENIE, Sonja', 'NOR');
insert into athletes values(184, 'MEHLHHORN, Hans', 'GER');
insert into athletes values(188, 'STEVENS, J. Hubert', 'USA');
insert into athletes values(189, 'ASHFORTH, Albert', 'USA');
insert into athletes values(190, 'BRYANT, Precy D.', 'USA');
insert into athletes values(194, 'HORTON, Edmund C', 'USA');
insert into athletes values(201, 'CAPADRUTT, Reto', 'SUI');
insert into athletes values(212, 'JANECKE, Gustav', 'GER');
insert into athletes values(215, 'ROMER, Erich', 'GER');
insert into athletes values(292, 'ARCHER, Alexander', 'GBR');
insert into athletes values(319, 'HULTEN, Vivi-Anne', 'SWE');
insert into athletes values(329, 'KROG, Georg', 'NOR');
insert into athletes values(345, 'NURMELA, Sulo', 'FIN');
insert into athletes values(349, 'ENGLUND, Nils-Joel', 'SWE');
insert into athletes values(359, 'RIMKUS, Edward', 'USA');
insert into athletes values(385, 'RUEDI, Beat', 'SUI');
insert into athletes values(421, 'ZABRODSKY, Vladimir', 'TCH');
insert into athletes values(438, 'FARSTAD, Sverre', 'NOR');
insert into athletes values(447, 'MOLITOR, Karl', 'SUI');
insert into athletes values(487, 'ALMQVIST, Gote', 'SWE');
insert into athletes values(504, 'ABEL, George Gordon', 'CAN');
insert into athletes values(525, 'HARRISON, Clifford', 'USA');
insert into athletes values(559, 'BUCHNER, Mirl', 'FRG');
insert into athletes values(578, 'HAKULINEN, Veikko', 'FIN');
insert into athletes values(584, 'FALKANGER, Torbjorn', 'NOR');
insert into athletes values(671, 'SAILER, Anton', 'AUT');
insert into athletes values(680, 'SOLLANDER, Stig', 'SWE');
insert into athletes values(742, 'HURLEY, Harold', 'CAN');
insert into athletes values(762, 'GUSEVA, Klara', 'URS');
insert into athletes values(764, 'STENIN, Boris', 'URS');
insert into athletes values(765, 'PILEJCZYK, Helena', 'POL');
insert into athletes values(769, 'STENINA, Valentina', 'URS');
insert into athletes values(774, 'PERILLAT, Guy', 'FRA');
insert into athletes values(778, 'BIEBL, Heidi', 'EUA');
insert into athletes values(780, 'HINTERSEER, Ernst', 'AUT');
insert into athletes values(782, 'STIEGLER, Josef', 'AUT');
insert into athletes values(804, 'GUSAKOV, Nikolay', 'URS');
insert into athletes values(812, 'RIGONI, Benito', 'ITA');
insert into athletes values(831, 'GOLONKA, Josef', 'TCH');
insert into athletes values(847, 'KONOVALENKO, Viktor', 'URS');
insert into athletes values(848, 'KOUSKINE, Viktor', 'URS');
insert into athletes values(852, 'STARSHINOV, Viacheslav', 'URS');
insert into athletes values(911, 'BONLIEU, Francois', 'FRA');
insert into athletes values(930, 'TIAINEN, Arto', 'FIN');
insert into athletes values(973, 'O''SHEA, Danny', 'CAN');
insert into athletes values(975, 'PINDER, Herbert', 'CAN');
insert into athletes values(991, 'KOCHTA, Jiri', 'TCH');
insert into athletes values(1022, 'SCHENK, Ard', 'NED');
insert into athletes values(1063, 'RASKA, Jiri', 'TCH');
insert into athletes values(1064, 'PREIML, Baldur', 'AUT');
insert into athletes values(1074, 'SAIRA, Esko', 'FIN');
insert into athletes values(1079, 'ZIMMERER, Wolfgang', 'FRG');
insert into athletes values(1102, 'PACHKOV, Aleksandr', 'URS');
insert into athletes values(1113, 'CURRAN, Michael', 'USA');
insert into athletes values(1127, 'FIEDLER, Wolfram', 'GDR');
insert into athletes values(1130, 'HILDGARTNER, Paul', 'ITA');
insert into athletes values(1134, 'SCHUMANN, Margit', 'GDR');
insert into athletes values(1152, 'CLAESSON, Goran', 'SWE');
insert into athletes values(1158, 'COLLOMBIN, Roland', 'SUI');
insert into athletes values(1212, 'BENZ, Joseph', 'SUI');
insert into athletes values(1218, 'FUNK, Lorenz', 'FRG');
insert into athletes values(1227, 'REINDL, Franz', 'FRG');
insert into athletes values(1276, 'KLEINE, Piet', 'NED');
insert into athletes values(1289, 'PRIESTNER, Cathy', 'CAN');
insert into athletes values(1293, 'MITTERMAIER, Rosi', 'FRG');
insert into athletes values(1302, 'GIORDANI, Claudia', 'ITA');
insert into athletes values(1312, 'TEURAJARVI, Pertti', 'FIN');
insert into athletes values(1345, 'MUSIOL, Bogdan', 'GDR');
insert into athletes values(1374, 'MORROW, Kenneth', 'USA');
insert into athletes values(1385, 'BILJALETDINOV, Zinetula', 'URS');
insert into athletes values(1403, 'AMANTOVA, Ingrida', 'URS');
insert into athletes values(1412, 'HOFFMANN, Jan', 'GDR');
insert into athletes values(1421, 'HEIDEN, Eric', 'USA');
insert into athletes values(1426, 'PETRUSEVA, Natalya', 'URS');
insert into athletes values(1430, 'BORCKINK, Annie', 'NED');
insert into athletes values(1442, 'EPPLE, Irene', 'FRG');
insert into athletes values(1455, 'AUNLI, Berit', 'NOR');
insert into athletes values(1456, 'BOE, Anette', 'NOR');
insert into athletes values(1465, 'PUIKKONEN, Jari', 'FIN');
insert into athletes values(1482, 'STORSVEEN, Rolf', 'NOR');
insert into athletes values(1488, 'SCHAUERHAMMER, Dietmar', 'GDR');
insert into athletes values(1516, 'KOZHERNIKOV, Aleksandr', 'URS');
insert into athletes values(1517, 'LARIONOV, Igor', 'URS');
insert into athletes values(1524, 'HORAVA, Miloslav', 'TCH');
insert into athletes values(1585, 'WALLISER, Maria', 'SUI');
insert into athletes values(1592, 'KONZETT, Ursula', 'LIE');
insert into athletes values(1608, 'SCHVUBOVA, Dagmar', 'TCH');
insert into athletes values(1648, 'JASJIN, Sergei', 'URS');
insert into athletes values(1651, 'LOMAKIN, Andrei', 'URS');
insert into athletes values(1667, 'MIKKOLAINEN, Reijo', 'FIN');
insert into athletes values(1670, 'OJANEN, Janne', 'FIN');
insert into athletes values(1699, 'HADSCHIEFF, Michael', 'AUT');
insert into athletes values(1709, 'YKEMA, Jan', 'NED');
insert into athletes values(1717, 'PERCY, Karen', 'CAN');
insert into athletes values(1724, 'ERIKSSON, Lars-Borje', 'SWE');
insert into athletes values(1726, 'WOLF, Sigrid', 'AUT');
insert into athletes values(1728, 'SMIRNOV, Vladimir', 'URS');
insert into athletes values(1729, 'DEVYATYAROV, Mikhail', 'URS');
insert into athletes values(1731, 'TIKHONOVA, Tamara', 'URS');
insert into athletes values(1762, 'FIDJESTOL, Ole Gunnar', 'NOR');
insert into athletes values(1773, 'BEDARD, Myriam', 'CAN');
insert into athletes values(1781, 'BRIAND BOUTHIAUX, Anne', 'FRA');
insert into athletes values(1786, 'ANDERSSON, Leif', 'SWE');
insert into athletes values(1808, 'LANGEN, Christoph', 'GER');
insert into athletes values(1832, 'BAOUTINE, Sergei', 'EUN');
insert into athletes values(1842, 'KOMUTOV, Andrei', 'EUN');
insert into athletes values(1863, 'JUNEAU, Joe', 'CAN');
insert into athletes values(1866, 'LINDBERG, Chris', 'CAN');
insert into athletes values(1878, 'HUBER, Norbert', 'ITA');
insert into athletes values(1887, 'ERDMANN, Susi-Lisa', 'GER');
insert into athletes values(1892, 'KLIMOVA, Marina', 'EUN');
insert into athletes values(1903, 'EISLER, Lloyd', 'CAN');
insert into athletes values(1924, 'ISHIHARA, Tatsuyoshi', 'JPN');
insert into athletes values(1946, 'NIEMANN-STIRNEMANN, Gunda', 'GER');
insert into athletes values(1957, 'MARTIN, Gianfranco', 'ITA');
insert into athletes values(1967, 'WIBERG, Pernilla', 'SWE');
insert into athletes values(1978, 'ALBARELLO, Marco', 'ITA');
insert into athletes values(1980, 'EGOROVA, Ljubov', 'EUN');
insert into athletes values(1982, 'BELMONDO, Stefania', 'ITA');
insert into athletes values(1984, 'DAEHLIE, Bjorn', 'NOR');
insert into athletes values(2001, 'ALLAMAND, Olivier', 'FRA');
insert into athletes values(2009, 'KONO, Takanori', 'JPN');
insert into athletes values(2028, 'FISCHER, Sven', 'GER');
insert into athletes values(2040, 'TALANOVA, Nadejda', 'RUS');
insert into athletes values(2060, 'KOIVU, Saku', 'FIN');
insert into athletes values(2062, 'LAUKKANEN, Janne', 'FIN');
insert into athletes values(2081, 'JONSSON, Jorgen', 'SWE');
insert into athletes values(2082, 'JONSSON, Kenny', 'SWE');
insert into athletes values(2085, 'LOOB, Haakan', 'SWE');
insert into athletes values(2089, 'SALO, Tommy', 'SWE');
insert into athletes values(2105, 'PARKS, Greg', 'CAN');
insert into athletes values(2126, 'GORDEYEVA, Yekaterina', 'RUS');
insert into athletes values(2143, 'MURTHA, Andrew', 'AUS');
insert into athletes values(2163, 'BAJANOVA, Svetlana', 'RUS');
insert into athletes values(2170, 'KJUS, Lasse', 'NOR');
insert into athletes values(2194, 'MOEN, Anita', 'NOR');
insert into athletes values(2204, 'MCINTYRE, Elizabeth', 'USA');
insert into athletes values(2215, 'THOMA, Dieter', 'GER');
insert into athletes values(2222, 'BJOERNDALEN, Ole Einar', 'NOR');
insert into athletes values(2235, 'POIREE, Liv Grete', 'NOR');
insert into athletes values(2236, 'SIKVELAND, Annette', 'NOR');
insert into athletes values(2242, 'KOUKLEVA, Galina', 'RUS');
insert into athletes values(2244, 'ROMASKO, Olga', 'RUS');
insert into athletes values(2255, 'ROHNER, Marcel', 'SUI');
insert into athletes values(2297, 'SELANNE, Teemu', 'FIN');
insert into athletes values(2336, 'KRIVOKRASSOV, Serguei', 'RUS');
insert into athletes values(2337, 'MIRONOV, Boris', 'RUS');
insert into athletes values(2338, 'MIRONOV, Dmitri', 'RUS');
insert into athletes values(2370, 'BLAHOSKI, Alana', 'USA');
insert into athletes values(2384, 'RUGGIERO, Angela', 'USA');
insert into athletes values(2385, 'TUETING, Sarah', 'USA');
insert into athletes values(2394, 'GOYETTE, Danielle', 'CAN');
insert into athletes values(2398, 'MCCORMACK, Katheryn', 'CAN');
insert into athletes values(2401, 'RHEAUME, Manon', 'CAN');
insert into athletes values(2414, 'NIEDERNHUBER, Barbara', 'GER');
insert into athletes values(2415, 'ANISSINA, Marina', 'FRA');
insert into athletes values(2427, 'BEDARD, Eric', 'CAN');
insert into athletes values(2430, 'YANG (S), Yang', 'CHN');
insert into athletes values(2431, 'VICENT, Tania', 'CAN');
insert into athletes values(2436, 'YANG (A), Yang', 'CHN');
insert into athletes values(2440, 'CAMPBELL, Derrick', 'CAN');
insert into athletes values(2445, 'NISHITANI, Takafumi', 'JPN');
insert into athletes values(2446, 'ROMME, Gianni', 'NED');
insert into athletes values(2454, 'FRIESINGER-POSTMA, Anna', 'GER');
insert into athletes values(2478, 'JEVNE, Erling', 'NOR');
insert into athletes values(2483, 'SKARI, Bente', 'NOR');
insert into athletes values(2537, 'ISHMOURATOVA, Svetlana', 'RUS');
insert into athletes values(2545, 'LANGE, Andre', 'GER');
insert into athletes values(2548, 'JONES, Randy', 'USA');
insert into athletes values(2549, 'SCHUFFENHAUER, Bill', 'USA');
insert into athletes values(2555, 'BAKKEN, Jill', 'USA');
insert into athletes values(2594, 'ROETHLISBERGER, Nadia', 'SUI');
insert into athletes values(2605, 'NIKOLISHIN, Andrei', 'RUS');
insert into athletes values(2615, 'GAGNE, Simon', 'CAN');
insert into athletes values(2624, 'PECA, Mike', 'CAN');
insert into athletes values(2632, 'CHELIOS, Chris', 'USA');
insert into athletes values(2680, 'SMALL, Sami Jo', 'CAN');
insert into athletes values(2683, 'CHU, Julie', 'USA');
insert into athletes values(2688, 'WENDELL, Krissy', 'USA');
insert into athletes values(2689, 'IVES, Clay', 'USA');
insert into athletes values(2699, 'PLYUSHCHENKO, Evgeny', 'RUS');
insert into athletes values(2702, 'SHEN, Xue', 'CHN');
insert into athletes values(2707, 'OHNO, Apolo Anton', 'USA');
insert into athletes values(2715, 'JOO, Min-Jin', 'KOR');
insert into athletes values(2725, 'SMITH, Rusty', 'USA');
insert into athletes values(2734, 'KLASSEN, Cindy', 'CAN');
insert into athletes values(2739, 'CARPENTER, Kip', 'USA');
insert into athletes values(2741, 'RAICH, Benjamin', 'AUT');
insert into athletes values(2748, 'PAERSON, Anja', 'SWE');
insert into athletes values(2751, 'PEQUEGNOT, Laure', 'FRA');
insert into athletes values(2765, 'DI CENTA, Giorgio', 'ITA');
insert into athletes values(2773, 'BAUER, Viola', 'GER');
insert into athletes values(2777, 'BJOERGEN, Marit', 'NOR');
insert into athletes values(2781, 'SCOTT, Beckie', 'CAN');
insert into athletes values(2793, 'GOTTWALD, Felix', 'AUT');
insert into athletes values(2799, 'HETTICH, Georg', 'GER');
insert into athletes values(2804, 'MALYSZ, Adam', 'POL');
insert into athletes values(2824, 'GLAGOW, Martina', 'GER');
insert into athletes values(2828, 'BAILLY, Sandrine', 'FRA');
insert into athletes values(2833, 'ZAITSEVA, Olga', 'RUS');
insert into athletes values(2846, 'VOEVODA, Alexey', 'RUS');
insert into athletes values(2852, 'ROHBOCK, Shauna', 'USA');
insert into athletes values(2858, 'BAIRD, Scott', 'USA');
insert into athletes values(2865, 'HOWARD, Russ', 'CAN');
insert into athletes values(2879, 'LINDAHL, Cathrine', 'SWE');
insert into athletes values(2882, 'SVAERD, Anna', 'SWE');
insert into athletes values(2883, 'BEELI, Binia', 'SUI');
insert into athletes values(2890, 'ERAT, Martin', 'CZE');
insert into athletes values(2915, 'MODIN, Fredrik', 'SWE');
insert into athletes values(2922, 'SUNDIN, Ronnie', 'SWE');
insert into athletes values(2934, 'LAAKSONEN, Antti', 'FIN');
insert into athletes values(2935, 'LYDMAN, Toni', 'FIN');
insert into athletes values(2938, 'NIITTYMAKI, Antero', 'FIN');
insert into athletes values(2939, 'NORRENA, Fredrik', 'FIN');
insert into athletes values(2963, 'ASSERHOLT, Jenni', 'SWE');
insert into athletes values(2979, 'HUEFNER, Tatjana', 'GER');
insert into athletes values(2994, 'AHN, Hyun-Soo', 'KOR');
insert into athletes values(2995, 'LEE, Ho-Suk', 'KOR');
insert into athletes values(2996, 'JIN, Sun-Yu', 'KOR');
insert into athletes values(3002, 'BYUN, Chun-Sa', 'KOR');
insert into athletes values(3014, 'VERHEIJEN, Carl', 'NED');
insert into athletes values(3015, 'HEDRICK, Chad', 'USA');
insert into athletes values(3019, 'WUST, Ireen', 'NED');
insert into athletes values(3033, 'MORRISON, Denny', 'CAN');
insert into athletes values(3041, 'ANSCHUETZ THOMS, Daniela', 'GER');
insert into athletes values(3049, 'KERNEN, Bruno', 'SUI');
insert into athletes values(3064, 'FREDRIKSSON, Mathias', 'SWE');
insert into athletes values(3082, 'CRAWFORD, Chandra', 'CAN');
insert into athletes values(3084, 'ROTCHEV, Vassili', 'RUS');
insert into athletes values(3100, 'HEIL, Jennifer', 'CAN');
insert into athletes values(3107, 'KOFLER, Andreas', 'AUT');
insert into athletes values(3117, 'MEULI, Daniela', 'SUI');
insert into athletes values(3133, 'BRUNET, Marie Laure', 'FRA');
insert into athletes values(3140, 'BERGER, Tora', 'NOR');
insert into athletes values(3142, 'HURAJT, Pavol', 'SVK');
insert into athletes values(3144, 'FOURCADE, Martin', 'FRA');
insert into athletes values(3151, 'SHIPULIN, Anton', 'RUS');
insert into athletes values(3187, 'MORRIS, John', 'CAN');
insert into athletes values(3193, 'LIU, Yin', 'CHN');
insert into athletes values(3206, 'LEPISTO, Sami', 'FIN');
insert into athletes values(3209, 'PITKANEN, Joni', 'FIN');
insert into athletes values(3222, 'NASH, Rick', 'CAN');
insert into athletes values(3228, 'TOEWS, Jonathan', 'CAN');
insert into athletes values(3244, 'PAVELSKI, Joe', 'USA');
insert into athletes values(3248, 'SUTER, Ryan', 'USA');
insert into athletes values(3262, 'SAARINEN, Mari', 'FIN');
insert into athletes values(3273, 'MIKKELSON, Meaghan', 'CAN');
insert into athletes values(3276, 'WARD, Catherine', 'CAN');
insert into athletes values(3284, 'MARVIN, Gigi', 'USA');
insert into athletes values(3287, 'STACK, Kelli', 'USA');
insert into athletes values(3293, 'SICS, Andris', 'LAT');
insert into athletes values(3301, 'MOIR, Scott', 'CAN');
insert into athletes values(3318, 'ZHOU, Yang', 'CHN');
insert into athletes values(3320, 'BAVER, Allison', 'USA');
insert into athletes values(3323, 'GEHRING, Lana', 'USA');
insert into athletes values(3334, 'KIM, Seoung-Il', 'KOR');
insert into athletes values(3342, 'BOKKO, Havard', 'NOR');
insert into athletes values(3350, 'BLOKHUIJSEN, Jan', 'NED');
insert into athletes values(3373, 'MYHRER, Andre', 'SWE');
insert into athletes values(3380, 'KALLA, Charlotte', 'SWE');
insert into athletes values(3382, 'COLOGNA, Dario', 'SUI');
insert into athletes values(3391, 'NORTHUG, Petter', 'NOR');
insert into athletes values(3396, 'STEIRA, Kristin Stoermer', 'NOR');
insert into athletes values(3423, 'McIVOR, Ashleigh', 'CAN');
insert into athletes values(3431, 'FRENZEL, Eric', 'GER');
insert into athletes values(3459, 'MORAVEC, Ondrej', 'CZE');
insert into athletes values(3464, 'PEIFFER, Arnd', 'GER');
insert into athletes values(3465, 'SCHEMPP, Simon', 'GER');
insert into athletes values(3500, 'ANTOINE, Matthew', 'USA');
insert into athletes values(3523, 'WALL, Kirsten', 'CAN');
insert into athletes values(3527, 'MUIRHEAD, Eve', 'GBR');
insert into athletes values(3606, 'NABHOLZ, Katrin', 'SUI');
insert into athletes values(3619, 'KESSEL, Amanda', 'USA');
insert into athletes values(3641, 'SOLOVIEV, Dmitri', 'RUS');
insert into athletes values(3642, 'ABBOTT, Jeremy', 'USA');
insert into athletes values(3660, 'GRIGOREV, Vladimir', 'RUS');
insert into athletes values(3694, 'SZYMANSKI, Jan', 'POL');
insert into athletes values(3707, 'MAYER, Matthias', 'AUT');
insert into athletes values(3718, 'FENNINGER, Anna', 'AUT');
insert into athletes values(3720, 'SHIFFRIN, Mikaela', 'USA');
insert into athletes values(3723, 'GAILLARD, Jean Marc', 'FRA');
insert into athletes values(3730, 'NELSON, Lars', 'SWE');
insert into athletes values(3767, 'DUFOUR-LAPOINTE, Justine', 'CAN');
insert into athletes values(3770, 'HOLMLUND, Anna', 'SWE');
insert into athletes values(3778, 'KROG, Magnus', 'NOR');
insert into athletes values(3796, 'VOGT, Carina', 'GER');
insert into athletes values(3798, 'KOSIR, Zan', 'SLO');
insert into athletes values(3801, 'HIRAOKA, Taku', 'JPN');
insert into athletes values(3812, 'FARRINGTON, Kaitlyn', 'USA');
insert into athletes values(3927, 'MARTIN, Louis', 'FRA');
insert into athletes values(4180, 'MOLLER, Adolf', 'GER');
insert into athletes values(4241, 'KREUZER, Hermann', 'GER');
insert into athletes values(4405, 'CORAY, Albert', 'ZZX');
insert into athletes values(4435, 'MERZ, William', 'USA');
insert into athletes values(4474, 'COSTGROVE, Cormic F.', 'USA');
insert into athletes values(4578, 'JOACHIM, John', 'USA');
insert into athletes values(4651, 'STREBLER, Zenon B.', 'USA');
insert into athletes values(4698, 'GRISOT, EugA ne G.', 'FRA');
insert into athletes values(4710, 'WEBB, Ernest', 'GBR');
insert into athletes values(4731, 'BACON, Charles Joseph', 'USA');
insert into athletes values(4790, 'BARTLETT, Charles Henry', 'GBR');
insert into athletes values(4803, 'NEUMER, Karl', 'GER');
insert into athletes values(4857, 'HUNT, Kenneth Reginald Gunnery', 'GBR');
insert into athletes values(4905, 'CARLBERG, G. Vilhelm', 'SWE');
insert into athletes values(5082, 'JERWOOD, Frank Harold', 'GBR');
insert into athletes values(5253, 'FLETCHER, Mylie E.', 'CAN');
insert into athletes values(5292, 'RENDSCHMIDT, Else', 'GER');
insert into athletes values(5297, 'JOHNSON, Phyllis', 'GBR');
insert into athletes values(5317, 'ADLERSTRAHLE, Martha', 'SWE');
insert into athletes values(5341, 'GREGGAN, William', 'GBR');
insert into athletes values(5368, 'ANDERSEN, Anders', 'DEN');
insert into athletes values(5408, 'STINDT, Hermine', 'GER');
insert into athletes values(5426, 'GOULDING, George', 'CAN');
insert into athletes values(5479, 'BYRD, Richard Leslie', 'USA');
insert into athletes values(5497, 'GITSHAM, Christian W.', 'RSA');
insert into athletes values(5654, 'HALMOS, Gyozo', 'HUN');
insert into athletes values(5948, 'SKOGEN, Engebret', 'NOR');
insert into athletes values(6045, 'BLEIBTREY, Ethelda', 'USA');
insert into athletes values(6051, 'MALMROT, Hakan', 'SWE');
insert into athletes values(6076, 'BLITZ, Maurice', 'BEL');
insert into athletes values(6088, 'FAUVEL, Pascal', 'FRA');
insert into athletes values(6097, 'VAN GASTEL, Johannes Jacobus', 'NED');
insert into athletes values(6139, 'BUTLER, Guy Montagu', 'GBR');
insert into athletes values(6147, 'MURCHISON, Loren', 'USA');
insert into athletes values(6253, 'VON BRAUN, Georg', 'SWE');
insert into athletes values(6409, 'MASTROMARINO, Michele', 'ITA');
insert into athletes values(6557, 'STRAUWEN, Rene', 'BEL');
insert into athletes values(6578, 'BLACH, Svend', 'DEN');
insert into athletes values(6652, 'SANDBORN, Allen Ream', 'USA');
insert into athletes values(6746, 'HASSEL, Kaspar Fredrik', 'NOR');
insert into athletes values(6869, 'ROTHROCK, Arthur', 'USA');
insert into athletes values(7003, 'CHARLTON, Andrew', 'AUS');
insert into athletes values(7017, 'HATCH, J. E.', 'GBR');
insert into athletes values(7224, 'MORICCA, Oreste', 'ITA');
insert into athletes values(7229, 'HECKSCHER, Grete', 'DEN');
insert into athletes values(7321, 'SUPCIK, Bedrich', 'TCH');
insert into athletes values(7341, 'GUEST, Fred', 'GBR');
insert into athletes values(7483, 'LEPATEY, L.', 'FRA');
insert into athletes values(7522, 'BOLES, John Keith', 'USA');
insert into athletes values(7629, 'BRAUN, Maria Johanna', 'NED');
insert into athletes values(7724, 'NEUMANN, Otto', 'GER');
insert into athletes values(7805, 'SOUTHALL, Michael George', 'GBR');
insert into athletes values(7930, 'MACK, Eugen', 'SUI');
insert into athletes values(7932, 'HANGGI, Hermann', 'SUI');
insert into athletes values(7984, 'BOCHE, Bruno', 'GER');
insert into athletes values(8254, 'STRIKE-SISSON, Hilda', 'CAN');
insert into athletes values(8263, 'CARR, William Arthur', 'USA');
insert into athletes values(8424, 'GEREVICH, Aladar', 'HUN');
insert into athletes values(8442, 'PAKARINEN, Veikko Ilmari', 'FIN');
insert into athletes values(8448, 'JOCHIM, Alfred', 'USA');
insert into athletes values(8616, 'KARLSSON, Einar', 'SWE');
insert into athletes values(8716, 'WILLIAMS, Archibald Franklin', 'USA');
insert into athletes values(8737, 'HARBIG, Rudolf', 'GER');
insert into athletes values(8791, 'CHOPERENA IRIZARRI, Rodolfo', 'MEX');
insert into athletes values(8897, 'GEORGET, Pierre', 'FRA');
insert into athletes values(9015, 'WERGINZ, Walter', 'AUT');
insert into athletes values(9156, 'PETER, Heinrich', 'GER');
insert into athletes values(9292, 'MESBAH, Anwar Mohamed Ahmed', 'EGY');
insert into athletes values(9310, 'FRIDELL, Knut', 'SWE');
insert into athletes values(9344, 'ANDERSEN, Greta Marie', 'DEN');
insert into athletes values(9350, 'VERDEUR, Joseph Thomas', 'USA');
insert into athletes values(9424, 'WINT, Arthur', 'JAM');
insert into athletes values(9428, 'WHITE, Duncan', 'SRI');
insert into athletes values(9430, 'PERRUCCONI, Enrico', 'ITA');
insert into athletes values(9577, 'LYSAK, Steven John', 'USA');
insert into athletes values(9590, 'BJORKLOF, Nils', 'FIN');
insert into athletes values(9716, 'NORDAHL, Bertil', 'SWE');
insert into athletes values(9738, 'MOGYOROSI-KLENCS, Janos', 'HUN');
insert into athletes values(9756, 'THALMANN, Melchior', 'SUI');
insert into athletes values(9947, 'SCHNYDER, Rudolf', 'SUI');
insert into athletes values(10145, 'CHUDINA, Aleksandra', 'URS');
insert into athletes values(10162, 'O, William Patrick Jr.', 'USA');
insert into athletes values(10291, 'BURGESS, Donald Christopher', 'GBR');
insert into athletes values(10372, 'KOCSIS, Sandor', 'HUN');
insert into athletes values(10393, 'CHUKARIN, Viktor Ivanovich', 'URS');
insert into athletes values(10450, 'TAYLOR, John Paskin', 'GBR');
insert into athletes values(10658, 'TOBIAN, Gary Milburn', 'USA');
insert into athletes values(10780, 'KOCH, Desmond Dalworth', 'USA');
insert into athletes values(11100, 'ABDUL, Hamid', 'PAK');
insert into athletes values(11131, 'GARDINER, James Arthur', 'USA');
insert into athletes values(11211, 'BLACKALL, Jasper Roy', 'GBR');
insert into athletes values(11213, 'CROPP, John Urquhart', 'NZL');
insert into athletes values(11235, 'OUELLETTE, Gerald Raymond', 'CAN');
insert into athletes values(11407, 'WHITEHEAD, Joseph Nicholas Neville', 'GBR');
insert into athletes values(11445, 'MANOLIU, Lia', 'ROU');
insert into athletes values(11476, 'BISPO DOS SANTOS, Edson', 'BRA');
insert into athletes values(11498, 'KORNEEV, Yuri', 'URS');
insert into athletes values(11728, 'CASLAVSKA, Vera', 'TCH');
insert into athletes values(11759, 'SINGH, Prithipal', 'IND');
insert into athletes values(11885, 'RUBASHVILI, Vladimir', 'URS');
insert into athletes values(12245, 'SCHRIDDE, Hermann', 'EUA');
insert into athletes values(12289, 'GEISLER, Manfred', 'EUA');
insert into athletes values(12374, 'WOOD, Graham', 'AUS');
insert into athletes values(12406, 'GEESINK, Antonius Johannes', 'NED');
insert into athletes values(12471, 'BOS, Jan Justus', 'NED');
insert into athletes values(12550, 'PAULUS, Karel', 'TCH');
insert into athletes values(12594, 'FOLDI, Imre', 'HUN');
insert into athletes values(12599, 'OHUCHI, Masashi', 'JPN');
insert into athletes values(12633, 'NYSTROM, Bertil', 'SWE');
insert into athletes values(12690, 'HALL, Gary Wayne', 'USA');
insert into athletes values(12726, 'MOLNAR, Endre', 'HUN');
insert into athletes values(12751, 'KEINO, Kipchoge', 'KEN');
insert into athletes values(12781, 'POPKOVA, Vera', 'URS');
insert into athletes values(12838, 'CHIZHOVA, Nadezhda', 'URS');
insert into athletes values(12876, 'SOLMAN, Damir', 'YUG');
insert into athletes values(12936, 'CSIZMADIA, Istvan', 'HUN');
insert into athletes values(12938, 'BERGER, Tore', 'NOR');
insert into athletes values(12953, 'FAGLUM-PETTERSSON, Tomas', 'SWE');
insert into athletes values(12999, 'SCHMITT, Pal', 'HUN');
insert into athletes values(13041, 'YAMAGUCHI, Yoshitada', 'JPN');
insert into athletes values(13084, 'VORONINA, Zinaida', 'URS');
insert into athletes values(13091, 'KOSTE, Klaus', 'GDR');
insert into athletes values(13104, 'TURISCHEVA, Lyudmila', 'URS');
insert into athletes values(13214, 'WIENESE, Henri-Jan', 'NED');
insert into athletes values(13245, 'WIKEN, Per Olav', 'NOR');
insert into athletes values(13286, 'SATO, Tetsuo', 'JPN');
insert into athletes values(13384, 'AOKI, Mayumi', 'JPN');
insert into athletes values(13629, 'TIEPOLD, Peter', 'GDR');
insert into athletes values(13725, 'MOORE, Ann Elizabeth', 'GBR');
insert into athletes values(13755, 'MONTANO, Mario Aldo', 'ITA');
insert into athletes values(14003, 'PETRICEK, Vladimir', 'TCH');
insert into athletes values(14117, 'YAMASHITA, Noriko', 'JPN');
insert into athletes values(14121, 'BONK, Gerd', 'GDR');
insert into athletes values(14145, 'KATO, Kiyomi', 'JPN');
insert into athletes values(14173, 'KAZAKOV, Rustem', 'URS');
insert into athletes values(14204, 'KOSHEVAYA, Marina', 'URS');
insert into athletes values(14500, 'RISKIEV, Rufat', 'URS');
insert into athletes values(14523, 'SZABO, Istvan', 'HUN');
insert into athletes values(14542, 'NOWICKI, Mieczyslaw', 'POL');
insert into athletes values(14560, 'CROKER, Robin', 'GBR');
insert into athletes values(14683, 'BRUCKNER, Roland', 'GDR');
insert into athletes values(14788, 'BORREN, Thurman', 'NZL');
insert into athletes values(14841, 'MARACSKO, Tibor', 'HUN');
insert into athletes values(14887, 'GREIG, Marion', 'USA');
insert into athletes values(15013, 'BALASHOV, Andrei', 'URS');
insert into athletes values(15064, 'WOJTOWICZ, Tomasz', 'POL');
insert into athletes values(15182, 'BARON, Bengt', 'SWE');
insert into athletes values(15320, 'MURAVYOV, Vladimir', 'URS');
insert into athletes values(15330, 'SMALLWOOD-COOK, Kathryn', 'GBR');
insert into athletes values(15593, 'BOISSE, Philippe', 'FRA');
insert into athletes values(15773, 'ALLAN, Schofield', 'IND');
insert into athletes values(15826, 'GEORGE, Maureen Jean', 'ZIM');
insert into athletes values(15830, 'PHILLIPS, Brenda Joan', 'ZIM');
insert into athletes values(15862, 'SOLODUKHIN, Nikolai', 'URS');
insert into athletes values(15892, 'KROPPELIEN, Klaus', 'GDR');
insert into athletes values(15894, 'STANULOV, Milorad', 'YUG');
insert into athletes values(16031, 'WILKINS, David', 'IRL');
insert into athletes values(16106, 'MAKOGONOVA, Irina', 'URS');
insert into athletes values(16127, 'DEMBONCZYK, Tadeusz', 'POL');
insert into athletes values(16154, 'SANDURSKI, Adam', 'POL');
insert into athletes values(16157, 'STECYK, Wladyslaw', 'POL');
insert into athletes values(16179, 'SERES, Ferenc', 'HUN');
insert into athletes values(16256, 'COCHRAN, Neil', 'GBR');
insert into athletes values(16302, 'WALDO, Carolyn', 'CAN');
insert into athletes values(16546, 'REDZEPOVSKI, Redzep', 'YUG');
insert into athletes values(16661, 'NICHOLS, Kevin', 'AUS');
insert into athletes values(16689, 'FARGIS, Joseph Halpin, Iv', 'USA');
insert into athletes values(16805, 'GUSHIKEN, Koji', 'JPN');
insert into athletes values(16807, 'TONG, Fei', 'CHN');
insert into athletes values(16851, 'RNIC, Momir', 'YUG');
insert into athletes values(17001, 'KIM, Jae-Yup', 'KOR');
insert into athletes values(17009, 'BROWN, Kerrith', 'GBR');
insert into athletes values(17026, 'MASSULLO, Carlo', 'ITA');
insert into athletes values(17242, 'HUANG, Shi-Ping', 'CHN');
insert into athletes values(17258, 'REBAUDENGO, Piero', 'ITA');
insert into athletes values(17271, 'TIMMONS, Steve Dennis', 'USA');
insert into athletes values(17319, 'WEISHOFF, Paula Jo', 'USA');
insert into athletes values(17421, 'BOGOMILOVA-DANGALAKOVA, Tania', 'BUL');
insert into athletes values(17478, 'MELIEN, Lori', 'CAN');
insert into athletes values(17504, 'BEZMALINOVIC, Mislav', 'YUG');
insert into athletes values(17523, 'KIM, Soo-Nyung', 'KOR');
insert into athletes values(17555, 'DA SILVA, Robson', 'BRA');
insert into athletes values(17567, 'NAZAROVA, Olga', 'URS');
insert into athletes values(17663, 'ROBINSON, David Maurice', 'USA');
insert into athletes values(17669, 'MARCHULENIS, Raimundas', 'URS');
insert into athletes values(17691, 'LEONOVA, Aleksandra', 'URS');
insert into athletes values(17782, 'GYULAY, Zsolt', 'HUN');
insert into athletes values(17797, 'BLUHM, Kay', 'GDR');
insert into athletes values(17821, 'JASKULA, Zenon', 'POL');
insert into athletes values(17914, 'BOMMER, Rudolf', 'FRG');
insert into athletes values(18065, 'TOVSTOGAN, Yevgeniya', 'URS');
insert into athletes values(18126, 'CAPES-HAGER, Michelle Edith', 'AUS');
insert into athletes values(18145, 'HAN, Ok-Kyung', 'KOR');
insert into athletes values(18242, 'PUTTLITZ, Jorg', 'FRG');
insert into athletes values(18243, 'BRUDEL, Ralf', 'GDR');
insert into athletes values(18291, 'FROLOVA, Inna', 'URS');
insert into athletes values(18310, 'BANK, Jesper', 'DEN');
insert into athletes values(18375, 'HYUN, Jung Hwa', 'KOR');
insert into athletes values(18417, 'PARTIE, Robert Douglas', 'USA');
insert into athletes values(18702, 'TULU, Derartu', 'ETH');
insert into athletes values(18732, 'MUTWOL, William', 'KEN');
insert into athletes values(18753, 'IMOH, Chidi', 'NGR');
insert into athletes values(18806, 'SCHULT, Jurgen', 'GER');
insert into athletes values(18865, 'TANG, Jiuhong', 'CHN');
insert into athletes values(18945, 'MALONE, Karl', 'USA');
insert into athletes values(19046, 'ROBINSON, Clint', 'AUS');
insert into athletes values(19050, 'FISCHER, Birgit', 'GER');
insert into athletes values(19051, 'BIALKOWSKI, Dariusz', 'POL');
insert into athletes values(19053, 'BLUHM, Kay', 'GER');
insert into athletes values(19086, 'LETTMANN, Jochen', 'GER');
insert into athletes values(19148, 'RYAN, Matthew Morgan', 'AUS');
insert into athletes values(19203, 'CARLESCU BADEA, Laura Gabriela', 'ROU');
insert into athletes values(19261, 'MILLER, Shannon', 'USA');
insert into athletes values(19454, 'OLIVE VANCELLS, Nuria', 'ESP');
insert into athletes values(19473, 'WOLLSCHLAGER, Susanne', 'GER');
insert into athletes values(19474, 'SAVON, Amarilys', 'CUB');
insert into athletes values(19545, 'ECKERT, Cynthia L.', 'USA');
insert into athletes values(19615, 'TOMKINS, James', 'AUS');
insert into athletes values(19635, 'CORONA, Alessandro', 'ITA');
insert into athletes values(19652, 'BURCICA, Constanta', 'ROU');
insert into athletes values(19665, 'ISLER, Jennifer', 'USA');
insert into athletes values(19724, 'LEE, Eun-Chul', 'KOR');
insert into athletes values(19780, 'CARVALHO, Janelson', 'BRA');
insert into athletes values(19786, 'NEGRAO, Marcelo', 'BRA');
insert into athletes values(19946, 'SMITH, Michelle Marie', 'IRL');
insert into athletes values(19967, 'BUSCHSCHULTE, Antje', 'GER');
insert into athletes values(19977, 'KLIM, Michael', 'AUS');
insert into athletes values(20139, 'DAVIS, Pauline Elaine', 'BAH');
insert into athletes values(20319, 'FALLON, Trish', 'AUS');
insert into athletes values(20527, 'TOUYA, Damien', 'FRA');
insert into athletes values(20543, 'LUIZAO', 'BRA');
insert into athletes values(20611, 'HAMM, Mia', 'USA');
insert into athletes values(20869, 'VAN BARNEVELD, Harry', 'BEL');
insert into athletes values(20944, 'PANKINA, Aleksandra', 'BLR');
insert into athletes values(21070, 'VOKHMIANINE, Vladimir', 'KAZ');
insert into athletes values(21123, 'AN, Zhongxin', 'CHN');
insert into athletes values(21144, 'CHEN, Jing', 'TPE');
insert into athletes values(21147, 'WOODBRIDGE, Todd', 'AUS');
insert into athletes values(21252, 'RI, Yong Sam', 'PRK');
insert into athletes values(21285, 'ASCUY AGUILERA, Feliberto', 'CUB');
insert into athletes values(21307, 'HEYMANS, Emilie', 'CAN');
insert into athletes values(21337, 'PARKIN, Terence', 'RSA');
insert into athletes values(21386, 'WHITE, Tarnee', 'AUS');
insert into athletes values(21393, 'DUSING, Nate', 'USA');
insert into athletes values(21436, 'VASOVIC, Jugoslav', 'YUG');
insert into athletes values(21517, 'LAWRENCE, Tanya', 'JAM');
insert into athletes values(21575, 'NAZAROVA, Natalya', 'RUS');
insert into athletes values(21581, 'BURGHER, Michelle', 'JAM');
insert into athletes values(22059, 'SLATON, Danielle', 'USA');
insert into athletes values(22125, 'COCKBURN, Karen', 'CAN');
insert into athletes values(22214, 'BOOIJ, Minke', 'NED');
insert into athletes values(22270, 'VERANES, Sibelis', 'CUB');
insert into athletes values(22274, 'CAMILO, Tiago', 'BRA');
insert into athletes values(22504, 'HUANG, Chih Hsiung', 'TPE');
insert into athletes values(22552, 'BEDE, Shelda', 'BRA');
insert into athletes values(22555, 'FEI, Alessandro', 'ITA');
insert into athletes values(22660, 'SAMURGASHEV, Varteres', 'RUS');
insert into athletes values(22702, 'PHELPS, Michael', 'USA');
insert into athletes values(22720, 'LOCHTE, Ryan', 'USA');
insert into athletes values(22754, 'PELLICIARI, Matteo', 'ITA');
insert into athletes values(22780, 'JASONTEK, Rebecca', 'USA');
insert into athletes values(22793, 'TATSUMI, Juri', 'JPN');
insert into athletes values(22863, 'CHEN, Li Ju', 'TPE');
insert into athletes values(22896, 'HARRIS, Otis', 'USA');
insert into athletes values(22946, 'DIBABA, Tirunesh', 'ETH');
insert into athletes values(23002, 'LIMPELE, Flandy', 'INA');
insert into athletes values(23096, 'HERRMANN, Walter', 'ARG');
insert into athletes values(23137, 'SNELL, Belinda', 'AUS');
insert into athletes values(23242, 'BROWN, Graeme', 'AUS');
insert into athletes values(23245, 'IGNATYEV, Mikhail', 'RUS');
insert into athletes values(23399, 'ANDREIA', 'BRA');
insert into athletes values(23400, 'CRISTIANE', 'BRA');
insert into athletes values(23416, 'PONOR, Catalina', 'ROU');
insert into athletes values(23488, 'BALIC, Ivano', 'CRO');
insert into athletes values(23604, 'MUELLER, Silke', 'GER');
insert into athletes values(23635, 'ZOLNIR, Urska', 'SLO');
insert into athletes values(23636, 'TANIMOTO, Ayumi', 'JPN');
insert into athletes values(23770, 'JAANSON, Jueri', 'EST');
insert into athletes values(23837, 'KEMPPAINEN, Marko', 'FIN');
insert into athletes values(23881, 'WANG, Hao', 'CHN');
insert into athletes values(23933, 'DINEYKIN, Stanislav', 'RUS');
insert into athletes values(23942, 'GODOY FILHO, Gilberto', 'BRA');
insert into athletes values(24002, 'BATSIUSHKA, Hanna', 'BLR');
insert into athletes values(24008, 'THONGSUK, Pawina', 'THA');
insert into athletes values(24079, 'WU, Melissa', 'AUS');
insert into athletes values(24093, 'SONI, Rebecca', 'USA');
insert into athletes values(24185, 'LUO, Xi', 'CHN');
insert into athletes values(24227, 'SMITH, Jesse', 'USA');
insert into athletes values(24348, 'BROWN, Christopher', 'BAH');
insert into athletes values(24431, 'YULIANTI, Maria Kristin', 'INA');
insert into athletes values(24778, 'SOSA, Jose', 'ARG');
insert into athletes values(24803, 'KRAHN, Annike', 'GER');
insert into athletes values(24860, 'HE, Kexin', 'CHN');
insert into athletes values(24875, 'TUMILOVICH, Alina', 'BLR');
insert into athletes values(24883, 'LU, Yuanyang', 'CHN');
insert into athletes values(24925, 'GUDMUNDSSON, Hreidar Levy', 'ISL');
insert into athletes values(24943, 'PARK, Chunghee', 'KOR');
insert into athletes values(24951, 'JOHANSEN, Kari Mette', 'NOR');
insert into athletes values(25243, 'CRUZ, Eglys', 'CUB');
insert into athletes values(25395, 'SYKORA, Stacy', 'USA');
insert into athletes values(25527, 'FRANKLIN, Missy', 'USA');
insert into athletes values(25646, 'ARMSTRONG, Betsey', 'USA');
insert into athletes values(25678, 'ELLISON, Brady', 'USA');
insert into athletes values(25741, 'CALVERT, Schillonie', 'JAM');
insert into athletes values(25951, 'BRENDEL, Sebastian', 'GER');
insert into athletes values(25988, 'FAZEKAS, Krisztina', 'HUN');
insert into athletes values(26197, 'CHAPMAN, Candace Marie', 'CAN');
insert into athletes values(26253, 'BLIZNYUK, Anastasia', 'RUS');
insert into athletes values(26351, 'JOLIE, Wouter', 'NED');
insert into athletes values(26434, 'ALVEAR, Yuri', 'COL');
insert into athletes values(26535, 'WINTHER, Kasper', 'DEN');
insert into athletes values(26576, 'POWRIE, Olivia', 'NZL');
insert into athletes values(26737, 'HODGE, Megan', 'USA');
insert into athletes values(26759, 'KASHIRINA, Tatiana', 'RUS');
insert into athletes values(26760, 'JANG, Mi-ran', 'KOR');
insert into athletes values(26902, 'GLEIRSCHER, David', 'AUT');
insert into athletes values(26919, 'HUSKOVA, Hanna', 'BLR');
insert into athletes values(26963, 'PARROT, Max', 'CAN');
insert into athletes values(27020, 'Japan', 'JPN');
insert into athletes values(27025, 'Norway', 'NOR');
insert into summer_medals values(179, 24, 3927, 183, 'Bronze');
insert into summer_medals values(468, 24, 4180, 222, 'Bronze');
insert into summer_medals values(530, 24, 4241, 225, 'Silver');
insert into summer_medals values(766, 25, 4405, 254, 'Silver');
insert into summer_medals values(895, 25, 4474, 216, 'Gold');
insert into summer_medals values(981, 25, 4435, 163, 'Silver');
insert into summer_medals values(1036, 25, 4578, 281, 'Bronze');
insert into summer_medals values(1122, 25, 4651, 288, 'Bronze');
insert into summer_medals values(1223, 26, 4731, 196, 'Gold');
insert into summer_medals values(1301, 26, 4790, 152, 'Gold');
insert into summer_medals values(1314, 26, 4803, 311, 'Silver');
insert into summer_medals values(1607, 26, 5082, 221, 'Bronze');
insert into summer_medals values(1797, 26, 5253, 336, 'Silver');
insert into summer_medals values(1845, 26, 5292, 339, 'Silver');
insert into summer_medals values(1876, 26, 5317, 345, 'Bronze');
insert into summer_medals values(1900, 26, 5341, 240, 'Silver');
insert into summer_medals values(1932, 26, 5368, 356, 'Bronze');
insert into summer_medals values(1982, 27, 5408, 361, 'Silver');
insert into summer_medals values(2020, 27, 5426, 363, 'Gold');
insert into summer_medals values(2021, 27, 4710, 363, 'Silver');
insert into summer_medals values(2096, 27, 5479, 144, 'Silver');
insert into summer_medals values(2123, 27, 5497, 147, 'Silver');
insert into summer_medals values(2323, 27, 5654, 278, 'Silver');
insert into summer_medals values(2673, 27, 4905, 230, 'Silver');
insert into summer_medals values(2696, 27, 5948, 231, 'Bronze');
insert into summer_medals values(2845, 28, 6045, 360, 'Gold');
insert into summer_medals values(2854, 28, 6051, 244, 'Gold');
insert into summer_medals values(2904, 28, 6076, 185, 'Silver');
insert into summer_medals values(2930, 28, 6088, 402, 'Bronze');
insert into summer_medals values(2931, 28, 4698, 402, 'Bronze');
insert into summer_medals values(2940, 28, 6097, 402, 'Gold');
insert into summer_medals values(3178, 28, 6253, 377, 'Gold');
insert into summer_medals values(3382, 28, 6409, 278, 'Gold');
insert into summer_medals values(3546, 28, 6557, 318, 'Bronze');
insert into summer_medals values(3568, 28, 6578, 318, 'Silver');
insert into summer_medals values(3645, 28, 6652, 221, 'Gold');
insert into summer_medals values(3745, 28, 6746, 426, 'Gold');
insert into summer_medals values(3939, 28, 6869, 440, 'Silver');
insert into summer_medals values(4024, 28, 5297, 341, 'Bronze');
insert into summer_medals values(4157, 29, 7003, 138, 'Bronze');
insert into summer_medals values(4176, 29, 7017, 361, 'Silver');
insert into summer_medals values(4457, 29, 7224, 316, 'Bronze');
insert into summer_medals values(4474, 29, 7229, 459, 'Bronze');
insert into summer_medals values(4641, 29, 7341, 220, 'Bronze');
insert into summer_medals values(4806, 29, 7483, 225, 'Silver');
insert into summer_medals values(4863, 29, 7522, 329, 'Bronze');
insert into summer_medals values(5043, 30, 7629, 397, 'Silver');
insert into summer_medals values(5153, 30, 7724, 302, 'Silver');
insert into summer_medals values(5251, 30, 7805, 418, 'Bronze');
insert into summer_medals values(5448, 30, 7321, 278, 'Silver');
insert into summer_medals values(5491, 30, 7984, 318, 'Bronze');
insert into summer_medals values(5811, 31, 8254, 479, 'Silver');
insert into summer_medals values(5825, 31, 8263, 142, 'Gold');
insert into summer_medals values(6054, 31, 8424, 317, 'Gold');
insert into summer_medals values(6110, 31, 8448, 167, 'Silver');
insert into summer_medals values(6446, 32, 8716, 142, 'Gold');
insert into summer_medals values(6653, 32, 8897, 312, 'Bronze');
insert into summer_medals values(6819, 32, 9015, 216, 'Silver');
insert into summer_medals values(6821, 32, 7930, 501, 'Bronze');
insert into summer_medals values(7156, 32, 9292, 492, 'Gold');
insert into summer_medals values(7182, 32, 9310, 475, 'Gold');
insert into summer_medals values(7190, 32, 8616, 507, 'Bronze');
insert into summer_medals values(7233, 33, 9350, 293, 'Gold');
insert into summer_medals values(7252, 33, 9344, 361, 'Silver');
insert into summer_medals values(7328, 33, 9428, 196, 'Silver');
insert into summer_medals values(7502, 33, 9577, 515, 'Silver');
insert into summer_medals values(7520, 33, 9590, 521, 'Bronze');
insert into summer_medals values(7771, 33, 9738, 167, 'Bronze');
insert into summer_medals values(7949, 33, 9947, 170, 'Silver');
insert into summer_medals values(8219, 34, 10145, 498, 'Silver');
insert into summer_medals values(8384, 34, 10291, 418, 'Bronze');
insert into summer_medals values(8460, 34, 8424, 272, 'Bronze');
insert into summer_medals values(9091, 35, 10780, 144, 'Bronze');
insert into summer_medals values(9125, 35, 10162, 149, 'Gold');
insert into summer_medals values(9451, 35, 10393, 219, 'Gold');
insert into summer_medals values(9602, 35, 11131, 282, 'Silver');
insert into summer_medals values(9688, 35, 11211, 582, 'Bronze');
insert into summer_medals values(9690, 35, 11213, 582, 'Gold');
insert into summer_medals values(9719, 35, 11235, 334, 'Gold');
insert into summer_medals values(9795, 36, 10658, 241, 'Silver');
insert into summer_medals values(9957, 36, 11407, 365, 'Bronze');
insert into summer_medals values(10011, 36, 11445, 482, 'Bronze');
insert into summer_medals values(10074, 36, 11498, 512, 'Silver');
insert into summer_medals values(10410, 36, 11728, 487, 'Silver');
insert into summer_medals values(10636, 36, 11885, 543, 'Bronze');
insert into summer_medals values(10955, 37, 11476, 512, 'Bronze');
insert into summer_medals values(11143, 37, 12245, 378, 'Gold');
insert into summer_medals values(11224, 37, 12289, 216, 'Bronze');
insert into summer_medals values(11371, 37, 11100, 318, 'Silver');
insert into summer_medals values(11401, 37, 12406, 599, 'Gold');
insert into summer_medals values(11481, 37, 12471, 223, 'Bronze');
insert into summer_medals values(11574, 37, 12550, 600, 'Silver');
insert into summer_medals values(11676, 37, 12633, 610, 'Bronze');
insert into summer_medals values(11912, 38, 12781, 480, 'Bronze');
insert into summer_medals values(12104, 38, 12936, 594, 'Bronze');
insert into summer_medals values(12129, 38, 12953, 374, 'Silver');
insert into summer_medals values(12206, 38, 12999, 316, 'Gold');
insert into summer_medals values(12334, 38, 13084, 565, 'Silver');
insert into summer_medals values(12519, 38, 13214, 224, 'Gold');
insert into summer_medals values(12553, 38, 13245, 504, 'Silver');
insert into summer_medals values(12661, 38, 12599, 493, 'Silver');
insert into summer_medals values(12744, 39, 13384, 578, 'Gold');
insert into summer_medals values(12769, 39, 12690, 579, 'Silver');
insert into summer_medals values(12889, 39, 12726, 185, 'Silver');
insert into summer_medals values(12930, 39, 12751, 194, 'Gold');
insert into summer_medals values(13118, 39, 13629, 558, 'Bronze');
insert into summer_medals values(13157, 39, 12938, 594, 'Bronze');
insert into summer_medals values(13249, 39, 13725, 486, 'Silver');
insert into summer_medals values(13472, 39, 13104, 568, 'Bronze');
insert into summer_medals values(13674, 39, 14003, 223, 'Silver');
insert into summer_medals values(13812, 39, 14117, 601, 'Silver');
insert into summer_medals values(13817, 39, 14121, 643, 'Bronze');
insert into summer_medals values(13821, 39, 12594, 644, 'Gold');
insert into summer_medals values(13881, 39, 14173, 548, 'Gold');
insert into summer_medals values(13922, 40, 14204, 614, 'Bronze');
insert into summer_medals values(14209, 40, 12838, 525, 'Silver');
insert into summer_medals values(14324, 40, 14500, 559, 'Silver');
insert into summer_medals values(14357, 40, 14523, 521, 'Bronze');
insert into summer_medals values(14398, 40, 14542, 374, 'Silver');
insert into summer_medals values(14412, 40, 14560, 418, 'Bronze');
insert into summer_medals values(14532, 40, 13755, 317, 'Silver');
insert into summer_medals values(14762, 40, 14788, 318, 'Gold');
insert into summer_medals values(14820, 40, 14841, 569, 'Bronze');
insert into summer_medals values(14876, 40, 14887, 671, 'Bronze');
insert into summer_medals values(15098, 40, 14145, 601, 'Gold');
insert into summer_medals values(15954, 41, 14683, 278, 'Silver');
insert into summer_medals values(16088, 41, 15773, 318, 'Gold');
insert into summer_medals values(16142, 41, 15826, 680, 'Gold');
insert into summer_medals values(16146, 41, 15830, 680, 'Gold');
insert into summer_medals values(16178, 41, 15862, 683, 'Gold');
insert into summer_medals values(16221, 41, 15892, 282, 'Gold');
insert into summer_medals values(16393, 41, 16031, 588, 'Silver');
insert into summer_medals values(16395, 41, 15013, 573, 'Bronze');
insert into summer_medals values(16485, 41, 16106, 601, 'Gold');
insert into summer_medals values(16506, 41, 16127, 539, 'Bronze');
insert into summer_medals values(16536, 41, 16154, 647, 'Bronze');
insert into summer_medals values(16541, 41, 16157, 648, 'Silver');
insert into summer_medals values(16563, 41, 16179, 655, 'Bronze');
insert into summer_medals values(16674, 42, 15182, 591, 'Bronze');
insert into summer_medals values(16723, 42, 16256, 294, 'Bronze');
insert into summer_medals values(16831, 42, 15330, 592, 'Bronze');
insert into summer_medals values(17035, 42, 16546, 623, 'Silver');
insert into summer_medals values(17176, 42, 16661, 418, 'Gold');
insert into summer_medals values(17231, 42, 15593, 212, 'Gold');
insert into summer_medals values(17397, 42, 16807, 278, 'Silver');
insert into summer_medals values(17422, 42, 16805, 167, 'Silver');
insert into summer_medals values(17455, 42, 16851, 522, 'Gold');
insert into summer_medals values(17624, 42, 17009, 684, 'Bronze');
insert into summer_medals values(17652, 42, 17026, 569, 'Gold');
insert into summer_medals values(17663, 42, 15894, 282, 'Bronze');
insert into summer_medals values(17881, 42, 17242, 641, 'Bronze');
insert into summer_medals values(17899, 42, 17258, 600, 'Bronze');
insert into summer_medals values(18074, 43, 17421, 614, 'Gold');
insert into summer_medals values(18171, 43, 17478, 584, 'Bronze');
insert into summer_medals values(18209, 43, 16302, 690, 'Gold');
insert into summer_medals values(18229, 43, 17504, 185, 'Gold');
insert into summer_medals values(18371, 43, 17567, 629, 'Gold');
insert into summer_medals values(18481, 43, 17691, 664, 'Bronze');
insert into summer_medals values(18583, 43, 17782, 667, 'Gold');
insert into summer_medals values(18607, 43, 17797, 594, 'Bronze');
insert into summer_medals values(18645, 43, 17821, 374, 'Silver');
insert into summer_medals values(18717, 43, 16689, 378, 'Silver');
insert into summer_medals values(18986, 43, 18065, 669, 'Bronze');
insert into summer_medals values(19082, 43, 18126, 680, 'Gold');
insert into summer_medals values(19101, 43, 18145, 680, 'Silver');
insert into summer_medals values(19113, 43, 17001, 681, 'Gold');
insert into summer_medals values(19226, 43, 18242, 283, 'Bronze');
insert into summer_medals values(19227, 43, 18243, 283, 'Gold');
insert into summer_medals values(19301, 43, 18291, 713, 'Silver');
insert into summer_medals values(19325, 43, 18310, 639, 'Bronze');
insert into summer_medals values(19453, 43, 18417, 600, 'Gold');
insert into summer_medals values(19889, 44, 18732, 194, 'Bronze');
insert into summer_medals values(19980, 44, 18806, 144, 'Silver');
insert into summer_medals values(20049, 44, 18865, 732, 'Bronze');
insert into summer_medals values(20131, 44, 18945, 512, 'Gold');
insert into summer_medals values(20134, 44, 17663, 512, 'Gold');
insert into summer_medals values(20310, 44, 19086, 632, 'Bronze');
insert into summer_medals values(20390, 44, 19148, 377, 'Gold');
insert into summer_medals values(20450, 44, 19203, 587, 'Bronze');
insert into summer_medals values(20588, 44, 19261, 567, 'Bronze');
insert into summer_medals values(20780, 44, 19474, 735, 'Bronze');
insert into summer_medals values(20857, 44, 19545, 742, 'Silver');
insert into summer_medals values(20974, 44, 19635, 675, 'Bronze');
insert into summer_medals values(21011, 44, 19665, 714, 'Bronze');
insert into summer_medals values(21083, 44, 19724, 334, 'Gold');
insert into summer_medals values(21114, 44, 18375, 721, 'Bronze');
insert into summer_medals values(21155, 44, 19780, 600, 'Gold');
insert into summer_medals values(21161, 44, 19786, 600, 'Gold');
insert into summer_medals values(21187, 44, 17319, 601, 'Bronze');
insert into summer_medals values(21370, 45, 19946, 620, 'Gold');
insert into summer_medals values(21894, 45, 20319, 664, 'Bronze');
insert into summer_medals values(22004, 45, 19053, 521, 'Silver');
insert into summer_medals values(22202, 45, 20527, 159, 'Bronze');
insert into summer_medals values(22291, 45, 20611, 757, 'Gold');
insert into summer_medals values(22378, 45, 19261, 487, 'Gold');
insert into summer_medals values(22620, 45, 20869, 759, 'Bronze');
insert into summer_medals values(22718, 45, 20944, 671, 'Bronze');
insert into summer_medals values(22877, 45, 21070, 169, 'Bronze');
insert into summer_medals values(22937, 45, 21123, 773, 'Silver');
insert into summer_medals values(22969, 45, 21144, 721, 'Silver');
insert into summer_medals values(22972, 45, 21147, 173, 'Gold');
insert into summer_medals values(23111, 45, 21252, 542, 'Bronze');
insert into summer_medals values(23184, 46, 21307, 787, 'Silver');
insert into summer_medals values(23234, 46, 21337, 293, 'Silver');
insert into summer_medals values(23274, 46, 19977, 591, 'Gold');
insert into summer_medals values(23338, 46, 21386, 584, 'Silver');
insert into summer_medals values(23356, 46, 19967, 747, 'Bronze');
insert into summer_medals values(23494, 46, 17523, 725, 'Bronze');
insert into summer_medals values(23525, 46, 21517, 479, 'Silver');
insert into summer_medals values(23543, 46, 20139, 523, 'Gold');
insert into summer_medals values(23609, 46, 21575, 629, 'Bronze');
insert into summer_medals values(23617, 46, 21581, 629, 'Silver');
insert into summer_medals values(23960, 46, 19051, 594, 'Bronze');
insert into summer_medals values(24290, 46, 22059, 757, 'Silver');
insert into summer_medals values(24612, 46, 22270, 803, 'Gold');
insert into summer_medals values(24641, 46, 19615, 281, 'Bronze');
insert into summer_medals values(24745, 46, 19652, 767, 'Gold');
insert into summer_medals values(25014, 46, 22555, 600, 'Bronze');
insert into summer_medals values(25160, 46, 22660, 845, 'Gold');
insert into summer_medals values(25163, 46, 21285, 846, 'Gold');
insert into summer_medals values(25284, 47, 21393, 591, 'Bronze');
insert into summer_medals values(25356, 47, 22754, 294, 'Bronze');
insert into summer_medals values(25407, 47, 22780, 748, 'Bronze');
insert into summer_medals values(25429, 47, 22793, 748, 'Silver');
insert into summer_medals values(25524, 47, 22863, 727, 'Bronze');
insert into summer_medals values(25536, 47, 18702, 711, 'Bronze');
insert into summer_medals values(25615, 47, 22896, 302, 'Gold');
insert into summer_medals values(25717, 47, 23002, 729, 'Bronze');
insert into summer_medals values(25827, 47, 23096, 512, 'Gold');
insert into summer_medals values(25963, 47, 19046, 668, 'Silver');
insert into summer_medals values(25968, 47, 19050, 586, 'Silver');
insert into summer_medals values(26058, 47, 23242, 418, 'Gold');
insert into summer_medals values(26292, 47, 23416, 563, 'Gold');
insert into summer_medals values(26553, 47, 23604, 680, 'Gold');
insert into summer_medals values(26598, 47, 23635, 802, 'Bronze');
insert into summer_medals values(26599, 47, 23636, 802, 'Gold');
insert into summer_medals values(26775, 47, 23770, 224, 'Silver');
insert into summer_medals values(26874, 47, 23837, 624, 'Silver');
insert into summer_medals values(26967, 47, 22504, 816, 'Silver');
insert into summer_medals values(27003, 47, 22552, 775, 'Silver');
insert into summer_medals values(27007, 47, 23933, 600, 'Bronze');
insert into summer_medals values(27102, 47, 24002, 828, 'Silver');
insert into summer_medals values(27110, 47, 24008, 831, 'Gold');
insert into summer_medals values(27198, 48, 24079, 787, 'Silver');
insert into summer_medals values(27253, 48, 22702, 579, 'Gold');
insert into summer_medals values(27550, 48, 22946, 711, 'Gold');
insert into summer_medals values(27633, 48, 24348, 302, 'Silver');
insert into summer_medals values(27744, 48, 24431, 732, 'Bronze');
insert into summer_medals values(27888, 48, 23137, 664, 'Silver');
insert into summer_medals values(28045, 48, 23245, 796, 'Bronze');
insert into summer_medals values(28287, 48, 23399, 757, 'Silver');
insert into summer_medals values(28358, 48, 24860, 487, 'Gold');
insert into summer_medals values(28391, 48, 24883, 758, 'Silver');
insert into summer_medals values(28403, 48, 22125, 799, 'Silver');
insert into summer_medals values(28437, 48, 24925, 522, 'Silver');
insert into summer_medals values(28459, 48, 24943, 669, 'Bronze');
insert into summer_medals values(28467, 48, 24951, 669, 'Gold');
insert into summer_medals values(28631, 48, 22274, 762, 'Bronze');
insert into summer_medals values(28868, 48, 25243, 707, 'Bronze');
insert into summer_medals values(28947, 48, 23881, 889, 'Gold');
insert into summer_medals values(29262, 49, 25527, 456, 'Gold');
insert into summer_medals values(29390, 49, 24093, 904, 'Gold');
insert into summer_medals values(29404, 49, 22720, 905, 'Gold');
insert into summer_medals values(29469, 49, 24185, 908, 'Silver');
insert into summer_medals values(29521, 49, 25646, 910, 'Gold');
insert into summer_medals values(29568, 49, 25678, 913, 'Silver');
insert into summer_medals values(29656, 49, 25741, 480, 'Silver');
insert into summer_medals values(29936, 49, 25951, 931, 'Gold');
insert into summer_medals values(29990, 49, 25988, 942, 'Gold');
insert into summer_medals values(30369, 49, 26253, 970, 'Gold');
insert into summer_medals values(30380, 49, 24875, 970, 'Silver');
insert into summer_medals values(30427, 49, 23488, 522, 'Bronze');
insert into summer_medals values(30508, 49, 26351, 318, 'Silver');
insert into summer_medals values(30614, 49, 26434, 978, 'Bronze');
insert into summer_medals values(30743, 49, 26535, 993, 'Bronze');
insert into summer_medals values(30793, 49, 26576, 1001, 'Gold');
insert into summer_medals values(31030, 49, 26737, 601, 'Silver');
insert into summer_medals values(31053, 49, 26759, 1027, 'Silver');
insert into summer_medals values(31054, 49, 26760, 1027, 'Bronze');
insert into summer_medals values(1378, 26, 4857, 1065, 'Gold');
insert into summer_medals values(3046, 28, 6139, 1063, 'Gold');
insert into summer_medals values(4281, 29, 6147, 1068, 'Gold');
insert into summer_medals values(5438, 30, 7932, 1060, 'Gold');
insert into summer_medals values(6091, 31, 8442, 1060, 'Bronze');
insert into summer_medals values(6476, 32, 8737, 1063, 'Bronze');
insert into summer_medals values(6540, 32, 8791, 1066, 'Bronze');
insert into summer_medals values(6996, 32, 9156, 1069, 'Silver');
insert into summer_medals values(7330, 33, 9430, 1068, 'Bronze');
insert into summer_medals values(7684, 33, 9716, 1065, 'Gold');
insert into summer_medals values(8179, 34, 9424, 1063, 'Gold');
insert into summer_medals values(8518, 34, 10372, 1065, 'Gold');
insert into summer_medals values(8586, 34, 9756, 1060, 'Silver');
insert into summer_medals values(8658, 34, 10450, 1069, 'Bronze');
insert into summer_medals values(11355, 37, 12374, 1069, 'Bronze');
insert into summer_medals values(12031, 38, 12876, 1066, 'Silver');
insert into summer_medals values(12279, 38, 13041, 1065, 'Bronze');
insert into summer_medals values(12402, 38, 11759, 1069, 'Bronze');
insert into summer_medals values(13432, 39, 13091, 1060, 'Bronze');
insert into summer_medals values(13764, 39, 13286, 1067, 'Gold');
insert into summer_medals values(15069, 40, 15064, 1067, 'Gold');
insert into summer_medals values(15418, 41, 15320, 1068, 'Gold');
insert into summer_medals values(17912, 42, 17271, 1067, 'Gold');
insert into summer_medals values(18457, 43, 17669, 1066, 'Gold');
insert into summer_medals values(18792, 43, 17914, 1065, 'Bronze');
insert into summer_medals values(19916, 44, 18753, 1068, 'Silver');
insert into summer_medals values(20760, 44, 19454, 1061, 'Gold');
insert into summer_medals values(20779, 44, 19473, 1061, 'Silver');
insert into summer_medals values(21641, 45, 17555, 1068, 'Bronze');
insert into summer_medals values(22223, 45, 20543, 1065, 'Bronze');
insert into summer_medals values(23422, 46, 21436, 1071, 'Bronze');
insert into summer_medals values(26276, 47, 23400, 1070, 'Silver');
insert into summer_medals values(27480, 48, 24227, 1071, 'Silver');
insert into summer_medals values(28231, 48, 24778, 1065, 'Gold');
insert into summer_medals values(28259, 48, 24803, 1070, 'Bronze');
insert into summer_medals values(28556, 48, 22214, 1061, 'Gold');
insert into summer_medals values(29058, 48, 23942, 1067, 'Silver');
insert into summer_medals values(29098, 48, 25395, 1062, 'Silver');
insert into summer_medals values(30284, 49, 26197, 1070, 'Bronze');
insert into winter_medals values(32, 1, 32, 3, 'Gold');
insert into winter_medals values(86, 1, 86, 8, 'Bronze');
insert into winter_medals values(90, 1, 90, 8, 'Silver');
insert into winter_medals values(110, 1, 99, 15, 'Bronze');
insert into winter_medals values(144, 2, 128, 4, 'Bronze');
insert into winter_medals values(216, 3, 184, 2, 'Bronze');
insert into winter_medals values(223, 3, 188, 2, 'Gold');
insert into winter_medals values(224, 3, 189, 2, 'Silver');
insert into winter_medals values(242, 3, 201, 20, 'Silver');
insert into winter_medals values(256, 3, 215, 4, 'Bronze');
insert into winter_medals values(381, 4, 319, 6, 'Bronze');
insert into winter_medals values(382, 4, 158, 6, 'Gold');
insert into winter_medals values(401, 4, 329, 12, 'Silver');
insert into winter_medals values(418, 4, 345, 23, 'Gold');
insert into winter_medals values(423, 4, 349, 15, 'Bronze');
insert into winter_medals values(438, 5, 359, 2, 'Gold');
insert into winter_medals values(466, 5, 385, 4, 'Bronze');
insert into winter_medals values(520, 5, 438, 10, 'Gold');
insert into winter_medals values(590, 6, 487, 4, 'Bronze');
insert into winter_medals values(607, 6, 504, 4, 'Gold');
insert into winter_medals values(668, 6, 559, 25, 'Silver');
insert into winter_medals values(707, 6, 584, 17, 'Silver');
insert into winter_medals values(808, 7, 671, 28, 'Gold');
insert into winter_medals values(813, 7, 680, 26, 'Bronze');
insert into winter_medals values(826, 7, 578, 32, 'Gold');
insert into winter_medals values(902, 8, 742, 4, 'Silver');
insert into winter_medals values(928, 8, 762, 35, 'Gold');
insert into winter_medals values(930, 8, 764, 10, 'Bronze');
insert into winter_medals values(933, 8, 765, 36, 'Bronze');
insert into winter_medals values(938, 8, 769, 37, 'Silver');
insert into winter_medals values(952, 8, 778, 25, 'Gold');
insert into winter_medals values(954, 8, 780, 28, 'Bronze');
insert into winter_medals values(999, 8, 804, 16, 'Bronze');
insert into winter_medals values(1048, 9, 847, 4, 'Gold');
insert into winter_medals values(1055, 9, 852, 4, 'Gold');
insert into winter_medals values(1133, 9, 782, 28, 'Bronze');
insert into winter_medals values(1134, 9, 911, 28, 'Gold');
insert into winter_medals values(1175, 9, 930, 15, 'Bronze');
insert into winter_medals values(1261, 10, 831, 4, 'Silver');
insert into winter_medals values(1308, 10, 1022, 10, 'Silver');
insert into winter_medals values(1328, 10, 774, 24, 'Silver');
insert into winter_medals values(1386, 10, 1064, 17, 'Bronze');
insert into winter_medals values(1387, 10, 1063, 17, 'Gold');
insert into winter_medals values(1402, 11, 1074, 44, 'Silver');
insert into winter_medals values(1419, 11, 1079, 20, 'Gold');
insert into winter_medals values(1444, 11, 848, 4, 'Gold');
insert into winter_medals values(1464, 11, 1113, 4, 'Silver');
insert into winter_medals values(1479, 11, 1127, 39, 'Bronze');
insert into winter_medals values(1487, 11, 1134, 41, 'Bronze');
insert into winter_medals values(1508, 11, 1152, 10, 'Bronze');
insert into winter_medals values(1528, 11, 1158, 24, 'Silver');
insert into winter_medals values(1616, 12, 1212, 20, 'Bronze');
insert into winter_medals values(1625, 12, 1218, 4, 'Bronze');
insert into winter_medals values(1634, 12, 1227, 4, 'Bronze');
insert into winter_medals values(1732, 12, 1289, 38, 'Silver');
insert into winter_medals values(1744, 12, 1293, 29, 'Silver');
insert into winter_medals values(1750, 12, 1302, 27, 'Silver');
insert into winter_medals values(1829, 13, 1345, 20, 'Bronze');
insert into winter_medals values(1863, 13, 1374, 4, 'Gold');
insert into winter_medals values(1874, 13, 1385, 4, 'Silver');
insert into winter_medals values(1902, 13, 1403, 41, 'Bronze');
insert into winter_medals values(1913, 13, 1412, 5, 'Silver');
insert into winter_medals values(1924, 13, 1421, 9, 'Gold');
insert into winter_medals values(1925, 13, 1276, 9, 'Silver');
insert into winter_medals values(1937, 13, 1430, 36, 'Gold');
insert into winter_medals values(1948, 13, 1426, 38, 'Bronze');
insert into winter_medals values(1962, 13, 1442, 29, 'Silver');
insert into winter_medals values(1991, 13, 1456, 48, 'Bronze');
insert into winter_medals values(2034, 14, 1482, 44, 'Silver');
insert into winter_medals values(2041, 14, 1488, 2, 'Gold');
insert into winter_medals values(2081, 14, 1516, 4, 'Gold');
insert into winter_medals values(2120, 14, 1130, 40, 'Gold');
insert into winter_medals values(2185, 14, 1592, 27, 'Bronze');
insert into winter_medals values(2216, 14, 1455, 48, 'Gold');
insert into winter_medals values(2222, 14, 1608, 48, 'Silver');
insert into winter_medals values(2236, 14, 1465, 17, 'Bronze');
insert into winter_medals values(2301, 15, 1648, 4, 'Gold');
insert into winter_medals values(2305, 15, 1516, 4, 'Gold');
insert into winter_medals values(2309, 15, 1651, 4, 'Gold');
insert into winter_medals values(2373, 15, 1699, 9, 'Silver');
insert into winter_medals values(2397, 15, 1709, 12, 'Silver');
insert into winter_medals values(2404, 15, 1585, 22, 'Bronze');
insert into winter_medals values(2425, 15, 1724, 52, 'Bronze');
insert into winter_medals values(2428, 15, 1717, 53, 'Bronze');
insert into winter_medals values(2429, 15, 1726, 53, 'Gold');
insert into winter_medals values(2435, 15, 1729, 31, 'Gold');
insert into winter_medals values(2442, 15, 1728, 32, 'Silver');
insert into winter_medals values(2472, 15, 1731, 42, 'Silver');
insert into winter_medals values(2489, 15, 1762, 55, 'Bronze');
insert into winter_medals values(2521, 16, 1786, 44, 'Bronze');
insert into winter_medals values(2558, 16, 1524, 4, 'Bronze');
insert into winter_medals values(2577, 16, 1832, 4, 'Gold');
insert into winter_medals values(2608, 16, 1863, 4, 'Silver');
insert into winter_medals values(2611, 16, 1866, 4, 'Silver');
insert into winter_medals values(2623, 16, 1878, 39, 'Bronze');
insert into winter_medals values(2637, 16, 1892, 46, 'Gold');
insert into winter_medals values(2648, 16, 1903, 8, 'Bronze');
insert into winter_medals values(2716, 16, 1957, 21, 'Silver');
insert into winter_medals values(2764, 16, 1978, 23, 'Silver');
insert into winter_medals values(2768, 16, 1982, 48, 'Bronze');
insert into winter_medals values(2790, 16, 1980, 67, 'Gold');
insert into winter_medals values(2794, 16, 2001, 68, 'Silver');
insert into winter_medals values(2804, 16, 2009, 54, 'Gold');
insert into winter_medals values(2833, 17, 1781, 56, 'Silver');
insert into winter_medals values(2856, 17, 2040, 57, 'Gold');
insert into winter_medals values(2862, 17, 1773, 58, 'Gold');
insert into winter_medals values(2891, 17, 2062, 4, 'Bronze');
insert into winter_medals values(2914, 17, 2081, 4, 'Gold');
insert into winter_medals values(2919, 17, 2085, 4, 'Gold');
insert into winter_medals values(2941, 17, 2105, 4, 'Silver');
insert into winter_medals values(2961, 17, 1887, 41, 'Silver');
insert into winter_medals values(2976, 17, 2126, 7, 'Gold');
insert into winter_medals values(3037, 17, 2163, 37, 'Gold');
insert into winter_medals values(3044, 17, 1946, 51, 'Silver');
insert into winter_medals values(3055, 17, 1967, 22, 'Gold');
insert into winter_medals values(3140, 17, 2204, 69, 'Silver');
insert into winter_medals values(3189, 18, 2222, 44, 'Silver');
insert into winter_medals values(3194, 18, 2236, 57, 'Bronze');
insert into winter_medals values(3201, 18, 2242, 57, 'Silver');
insert into winter_medals values(3203, 18, 2244, 57, 'Silver');
insert into winter_medals values(3205, 18, 2242, 58, 'Gold');
insert into winter_medals values(3217, 18, 1808, 2, 'Gold');
insert into winter_medals values(3220, 18, 2255, 2, 'Silver');
insert into winter_medals values(3263, 18, 2060, 4, 'Bronze');
insert into winter_medals values(3315, 18, 2336, 4, 'Silver');
insert into winter_medals values(3380, 18, 2401, 75, 'Silver');
insert into winter_medals values(3422, 18, 2430, 70, 'Silver');
insert into winter_medals values(3440, 18, 2440, 61, 'Gold');
insert into winter_medals values(3448, 18, 2445, 71, 'Gold');
insert into winter_medals values(3454, 18, 2446, 9, 'Gold');
insert into winter_medals values(3524, 18, 2478, 32, 'Silver');
insert into winter_medals values(3537, 18, 1982, 48, 'Bronze');
insert into winter_medals values(3546, 18, 2194, 48, 'Silver');
insert into winter_medals values(3602, 18, 2215, 55, 'Silver');
insert into winter_medals values(3646, 19, 2537, 57, 'Bronze');
insert into winter_medals values(3670, 19, 2548, 2, 'Silver');
insert into winter_medals values(3671, 19, 2549, 2, 'Silver');
insert into winter_medals values(3680, 19, 2555, 82, 'Gold');
insert into winter_medals values(3719, 19, 2594, 74, 'Silver');
insert into winter_medals values(3736, 19, 2337, 4, 'Bronze');
insert into winter_medals values(3737, 19, 2605, 4, 'Bronze');
insert into winter_medals values(3749, 19, 2615, 4, 'Gold');
insert into winter_medals values(3760, 19, 2624, 4, 'Gold');
insert into winter_medals values(3849, 19, 2689, 39, 'Bronze');
insert into winter_medals values(3860, 19, 2414, 41, 'Silver');
insert into winter_medals values(3863, 19, 2415, 46, 'Gold');
insert into winter_medals values(3869, 19, 2699, 5, 'Silver');
insert into winter_medals values(3895, 19, 2431, 60, 'Bronze');
insert into winter_medals values(3898, 19, 2715, 60, 'Gold');
insert into winter_medals values(3909, 19, 2427, 61, 'Gold');
insert into winter_medals values(3919, 19, 2725, 71, 'Bronze');
insert into winter_medals values(3938, 19, 2454, 36, 'Gold');
insert into winter_medals values(3940, 19, 2734, 37, 'Bronze');
insert into winter_medals values(3949, 19, 2739, 12, 'Bronze');
insert into winter_medals values(3955, 19, 2741, 21, 'Bronze');
insert into winter_medals values(3967, 19, 2170, 28, 'Bronze');
insert into winter_medals values(3978, 19, 2751, 27, 'Silver');
insert into winter_medals values(3985, 19, 1982, 30, 'Bronze');
insert into winter_medals values(4011, 19, 2765, 23, 'Silver');
insert into winter_medals values(4026, 19, 2483, 48, 'Silver');
insert into winter_medals values(4030, 19, 2773, 86, 'Bronze');
insert into winter_medals values(4066, 19, 2799, 54, 'Silver');
insert into winter_medals values(4071, 19, 2804, 43, 'Silver');
insert into winter_medals values(4113, 20, 2824, 56, 'Silver');
insert into winter_medals values(4170, 20, 2852, 82, 'Silver');
insert into winter_medals values(4177, 20, 2858, 3, 'Bronze');
insert into winter_medals values(4184, 20, 2865, 3, 'Gold');
insert into winter_medals values(4198, 20, 2879, 74, 'Gold');
insert into winter_medals values(4202, 20, 2883, 74, 'Silver');
insert into winter_medals values(4210, 20, 2890, 4, 'Bronze');
insert into winter_medals values(4240, 20, 2082, 4, 'Gold');
insert into winter_medals values(4245, 20, 2915, 4, 'Gold');
insert into winter_medals values(4252, 20, 2922, 4, 'Gold');
insert into winter_medals values(4266, 20, 2934, 4, 'Silver');
insert into winter_medals values(4271, 20, 2938, 4, 'Silver');
insert into winter_medals values(4296, 20, 2384, 75, 'Bronze');
insert into winter_medals values(4305, 20, 2394, 75, 'Gold');
insert into winter_medals values(4321, 20, 2963, 75, 'Silver');
insert into winter_medals values(4348, 20, 2979, 41, 'Bronze');
insert into winter_medals values(4363, 20, 2702, 7, 'Bronze');
insert into winter_medals values(4371, 20, 2995, 59, 'Silver');
insert into winter_medals values(4373, 20, 2996, 70, 'Gold');
insert into winter_medals values(4404, 20, 2427, 61, 'Silver');
insert into winter_medals values(4409, 20, 2994, 71, 'Bronze');
insert into winter_medals values(4434, 20, 3015, 11, 'Gold');
insert into winter_medals values(4448, 20, 3014, 95, 'Bronze');
insert into winter_medals values(4464, 20, 3041, 96, 'Gold');
insert into winter_medals values(4477, 20, 2748, 22, 'Bronze');
insert into winter_medals values(4480, 20, 3049, 24, 'Bronze');
insert into winter_medals values(4513, 20, 3064, 23, 'Bronze');
insert into winter_medals values(4550, 20, 3082, 88, 'Gold');
insert into winter_medals values(4553, 20, 3084, 99, 'Bronze');
insert into winter_medals values(4563, 20, 2781, 100, 'Silver');
insert into winter_medals values(4574, 20, 3100, 69, 'Gold');
insert into winter_medals values(4578, 20, 2793, 16, 'Silver');
insert into winter_medals values(4616, 20, 3117, 91, 'Gold');
insert into winter_medals values(4638, 21, 2833, 92, 'Silver');
insert into winter_medals values(4645, 21, 3142, 93, 'Bronze');
insert into winter_medals values(4659, 21, 2828, 94, 'Silver');
insert into winter_medals values(4661, 21, 3133, 94, 'Silver');
insert into winter_medals values(4690, 21, 2846, 20, 'Bronze');
insert into winter_medals values(4717, 21, 3187, 3, 'Gold');
insert into winter_medals values(4730, 21, 2879, 74, 'Gold');
insert into winter_medals values(4755, 21, 3209, 4, 'Bronze');
insert into winter_medals values(4774, 21, 3222, 4, 'Gold');
insert into winter_medals values(4782, 21, 3228, 4, 'Gold');
insert into winter_medals values(4799, 21, 3244, 4, 'Silver');
insert into winter_medals values(4804, 21, 3248, 4, 'Silver');
insert into winter_medals values(4820, 21, 3262, 75, 'Bronze');
insert into winter_medals values(4884, 21, 3301, 45, 'Gold');
insert into winter_medals values(4900, 21, 2707, 59, 'Bronze');
insert into winter_medals values(4912, 21, 3320, 60, 'Bronze');
insert into winter_medals values(4920, 21, 3318, 60, 'Gold');
insert into winter_medals values(4955, 21, 3342, 10, 'Bronze');
insert into winter_medals values(5009, 21, 3373, 26, 'Bronze');
insert into winter_medals values(5031, 21, 3382, 31, 'Gold');
insert into winter_medals values(5077, 21, 3391, 99, 'Gold');
insert into winter_medals values(5098, 21, 3100, 69, 'Silver');
insert into winter_medals values(5103, 21, 3423, 107, 'Gold');
insert into winter_medals values(5130, 21, 3107, 55, 'Gold');
insert into winter_medals values(5165, 22, 3459, 93, 'Bronze');
insert into winter_medals values(5166, 22, 3144, 93, 'Silver');
insert into winter_medals values(5190, 22, 3140, 80, 'Silver');
insert into winter_medals values(5205, 22, 2833, 94, 'Silver');
insert into winter_medals values(5245, 22, 3500, 19, 'Bronze');
insert into winter_medals values(5268, 22, 3523, 74, 'Gold');
insert into winter_medals values(5272, 22, 3527, 74, 'Bronze');
insert into winter_medals values(5317, 22, 3206, 4, 'Bronze');
insert into winter_medals values(5388, 22, 3606, 75, 'Bronze');
insert into winter_medals values(5414, 22, 3287, 75, 'Silver');
insert into winter_medals values(5421, 22, 3293, 39, 'Bronze');
insert into winter_medals values(5458, 22, 3641, 116, 'Gold');
insert into winter_medals values(5460, 22, 3642, 116, 'Bronze');
insert into winter_medals values(5488, 22, 3660, 59, 'Silver');
insert into winter_medals values(5533, 22, 3033, 47, 'Silver');
insert into winter_medals values(5540, 22, 3350, 11, 'Silver');
insert into winter_medals values(5553, 22, 3694, 95, 'Bronze');
insert into winter_medals values(5565, 22, 3019, 51, 'Silver');
insert into winter_medals values(5605, 22, 3720, 27, 'Gold');
insert into winter_medals values(5609, 22, 3718, 53, 'Gold');
insert into winter_medals values(5616, 22, 3723, 23, 'Bronze');
insert into winter_medals values(5624, 22, 3730, 23, 'Gold');
insert into winter_medals values(5631, 22, 3382, 118, 'Gold');
insert into winter_medals values(5644, 22, 3380, 30, 'Silver');
insert into winter_medals values(5647, 22, 3396, 65, 'Bronze');
insert into winter_medals values(5660, 22, 2777, 119, 'Gold');
insert into winter_medals values(5695, 22, 3770, 107, 'Bronze');
insert into winter_medals values(5704, 22, 3778, 124, 'Bronze');
insert into winter_medals values(5740, 22, 3796, 128, 'Gold');
insert into winter_medals values(5745, 22, 3801, 78, 'Bronze');
insert into winter_medals values(5761, 22, 3812, 79, 'Gold');
insert into winter_medals values(5843, 50, 26919, 73, 'Gold');
insert into winter_medals values(5907, 50, 27025, 1047, 'Silver');
insert into winter_medals values(5920, 50, 3431, 16, 'Bronze');
insert into winter_medals values(5939, 50, 27020, 96, 'Gold');
insert into winter_medals values(5993, 50, 3464, 49, 'Gold');
insert into winter_medals values(6004, 50, 3767, 69, 'Silver');
insert into winter_medals values(6006, 50, 26902, 40, 'Gold');
insert into winter_medals values(6018, 50, 26963, 131, 'Silver');
insert into winter_medals values(6056, 50, 3798, 129, 'Bronze');
insert into winter_medals values(6066, 50, 2777, 65, 'Gold');
insert into winter_medals values(225, 3, 190, 1053, 'Silver');
insert into winter_medals values(229, 3, 194, 1053, 'Silver');
insert into winter_medals values(253, 3, 212, 1051, 'Bronze');
insert into winter_medals values(353, 4, 292, 1051, 'Gold');
insert into winter_medals values(503, 5, 421, 1051, 'Silver');
insert into winter_medals values(535, 5, 447, 1058, 'Bronze');
insert into winter_medals values(628, 6, 525, 1051, 'Silver');
insert into winter_medals values(802, 7, 671, 1058, 'Gold');
insert into winter_medals values(1009, 9, 812, 1053, 'Bronze');
insert into winter_medals values(1237, 10, 973, 1051, 'Bronze');
insert into winter_medals values(1239, 10, 975, 1051, 'Bronze');
insert into winter_medals values(1246, 10, 847, 1051, 'Gold');
insert into winter_medals values(1431, 11, 991, 1051, 'Bronze');
insert into winter_medals values(1449, 11, 1102, 1051, 'Gold');
insert into winter_medals values(1767, 12, 1312, 1049, 'Gold');
insert into winter_medals values(2083, 14, 1517, 1051, 'Gold');
insert into winter_medals values(2328, 15, 1667, 1051, 'Silver');
insert into winter_medals values(2587, 16, 1842, 1051, 'Gold');
insert into winter_medals values(2669, 16, 1924, 1059, 'Bronze');
insert into winter_medals values(2897, 17, 1670, 1051, 'Bronze');
insert into winter_medals values(2924, 17, 2089, 1051, 'Gold');
insert into winter_medals values(3003, 17, 2143, 1059, 'Bronze');
insert into winter_medals values(3184, 18, 2028, 1055, 'Gold');
insert into winter_medals values(3193, 18, 2235, 1057, 'Bronze');
insert into winter_medals values(3275, 18, 2297, 1051, 'Bronze');
insert into winter_medals values(3317, 18, 2338, 1051, 'Silver');
insert into winter_medals values(3349, 18, 2370, 1054, 'Gold');
insert into winter_medals values(3377, 18, 2398, 1054, 'Silver');
insert into winter_medals values(3433, 18, 2436, 1052, 'Silver');
insert into winter_medals values(3530, 18, 1984, 1049, 'Gold');
insert into winter_medals values(3768, 19, 2632, 1051, 'Silver');
insert into winter_medals values(3824, 19, 2680, 1054, 'Gold');
insert into winter_medals values(3832, 19, 2683, 1054, 'Silver');
insert into winter_medals values(3846, 19, 2385, 1054, 'Silver');
insert into winter_medals values(4201, 20, 2882, 1050, 'Gold');
insert into winter_medals values(4268, 20, 2935, 1051, 'Silver');
insert into winter_medals values(4272, 20, 2939, 1051, 'Silver');
insert into winter_medals values(4299, 20, 2688, 1054, 'Bronze');
insert into winter_medals values(4385, 20, 3002, 1052, 'Gold');
insert into winter_medals values(4663, 21, 3151, 1055, 'Bronze');
insert into winter_medals values(4687, 21, 2545, 1053, 'Silver');
insert into winter_medals values(4724, 21, 3193, 1050, 'Bronze');
insert into winter_medals values(4752, 21, 2938, 1051, 'Bronze');
insert into winter_medals values(4860, 21, 3284, 1054, 'Silver');
insert into winter_medals values(4915, 21, 3323, 1052, 'Bronze');
insert into winter_medals values(4935, 21, 3334, 1059, 'Silver');
insert into winter_medals values(5178, 22, 3465, 1055, 'Silver');
insert into winter_medals values(5365, 22, 3273, 1054, 'Gold');
insert into winter_medals values(5372, 22, 3276, 1054, 'Gold');
insert into winter_medals values(5404, 22, 3619, 1054, 'Silver');
insert into winter_medals values(5581, 22, 3707, 1058, 'Gold');
insert into winter_eventcategories values(75, 'team  ');
insert into winter_eventcategories values(92, 'single');
insert into winter_eventcategories values(69, 'single');
insert into winter_eventcategories values(26, 'single');
insert into winter_eventcategories values(71, 'single');
insert into winter_eventcategories values(3, 'team  ');
insert into winter_eventcategories values(58, 'single');
insert into winter_eventcategories values(15, 'single');
insert into winter_eventcategories values(49, 'single');
insert into winter_eventcategories values(107, 'single');
insert into winter_eventcategories values(6, 'single');
insert into winter_eventcategories values(10, 'single');
insert into winter_eventcategories values(96, 'team  ');
insert into winter_eventcategories values(28, 'single');
insert into winter_eventcategories values(30, 'single');
insert into winter_eventcategories values(29, 'single');
insert into winter_eventcategories values(74, 'team  ');
insert into winter_eventcategories values(40, 'single');
insert into winter_eventcategories values(116, 'team  ');
insert into winter_eventcategories values(38, 'single');
insert into winter_eventcategories values(56, 'single');
insert into winter_eventcategories values(39, 'multi ');
insert into winter_eventcategories values(11, 'single');
insert into winter_eventcategories values(53, 'single');
insert into winter_eventcategories values(9, 'single');
insert into winter_eventcategories values(16, 'single');
insert into winter_eventcategories values(51, 'single');
insert into winter_eventcategories values(65, 'single');
insert into winter_eventcategories values(36, 'single');
insert into winter_eventcategories values(54, 'team  ');
insert into winter_eventcategories values(21, 'single');
insert into winter_eventcategories values(5, 'single');
insert into winter_eventcategories values(37, 'single');
insert into winter_eventcategories values(47, 'single');
insert into winter_eventcategories values(12, 'single');
insert into winter_eventcategories values(99, 'team  ');
insert into winter_eventcategories values(93, 'single');
insert into winter_eventcategories values(73, 'single');
insert into winter_eventcategories values(59, 'single');
insert into winter_eventcategories values(95, 'team  ');
insert into winter_eventcategories values(45, 'multi ');
insert into winter_eventcategories values(52, 'single');
insert into winter_eventcategories values(70, 'single');
insert into winter_eventcategories values(27, 'single');
insert into winter_eventcategories values(31, 'single');
insert into winter_eventcategories values(94, 'team  ');
insert into winter_eventcategories values(35, 'single');
insert into winter_eventcategories values(8, 'multi ');
insert into winter_eventcategories values(100, 'team  ');
insert into winter_eventcategories values(22, 'single');
insert into winter_eventcategories values(4, 'team  ');
insert into winter_eventcategories values(68, 'single');
insert into winter_eventcategories values(41, 'single');
insert into winter_eventcategories values(20, 'team  ');
insert into winter_eventcategories values(1047, 'team  ');
insert into winter_eventcategories values(131, 'single');
insert into winter_eventcategories values(25, 'single');
insert into winter_eventcategories values(80, 'single');
insert into winter_eventcategories values(78, 'single');
insert into winter_eventcategories values(79, 'single');
insert into winter_eventcategories values(129, 'single');
insert into winter_eventcategories values(1049, 'team  ');
insert into winter_eventcategories values(1050, 'team  ');
insert into winter_eventcategories values(1051, 'team  ');
insert into winter_eventcategories values(1052, 'single');
insert into winter_eventcategories values(1053, 'team  ');
insert into winter_eventcategories values(1054, 'team  ');
insert into winter_eventcategories values(1055, 'team  ');
insert into winter_eventcategories values(1056, 'team  ');
insert into winter_eventcategories values(1058, 'single');
insert into winter_eventcategories values(1059, 'team  ');

-- my code starts here

drop function hw6();
drop function hw6a();
drop function hw6b();
drop function hw6c();

create function hw6a() returns void AS $$
DECLARE
	num INTEGER;
BEGIN
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
END;
$$ LANGUAGE plpgsql;

create function hw6b() returns void AS $$
BEGIN
	alter table events add category varchar(255);

	update events set category = (SELECT
									w.etype
								FROM
									winter_eventcategories w
								WHERE
									w.eid = events.id);

	-- SELECT
	-- 	*
	-- FROM
	-- 	events
	-- WHERE
	-- 	events.category is null;

	-- SELECT DISTINCT
	-- 	e2.category
	-- FROM
	-- 	events e2,
	-- 	events
	-- WHERE
	-- 	events.etype = e2.etype
	-- 	and events.discipline = e2.discipline
	-- 	and events.name = e2.name
	-- 	and e2.id <> events.id
	-- 	and e2.category is not null;

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

END;
$$ LANGUAGE plpgsql;

create function hw6c() returns void AS $$
BEGIN

	-- create table new_events as (
	-- 	id 				int constraint events_pk primary key
	-- 	, sid 			int
	-- 	, name			varchar(255)
	-- 	, etype 		varchar(1)
	-- 	, sport 		varchar(255)
	-- 	, discipline	varchar(255)
	-- 	, stype			varchar(6)
	-- 	, category 		varchar(255)
	-- 	);

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

END;
$$ LANGUAGE plpgsql;

create function hw6() returns void AS $$
DECLARE
	num INTEGER ;
BEGIN
	perform hw6a();
	perform hw6b();
	perform hw6c();
END;
$$ LANGUAGE plpgsql ;

select hw6();