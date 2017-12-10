
-- the code is  from JP and modified a bit   -- dy

-- drop the table if it already exists
DROP TABLE IF EXISTS attribute;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS list;
DROP TABLE IF EXISTS template;
DROP TABLE IF EXISTS template_attribute;
 

-- this is the table for lists
CREATE TABLE list (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL, 		-- the name of each list
    template_id int,
    account_id INT,
    visible BIT(1) Default 1, -- added this because it allow us to delete without taking anything out actually just won't be shown
    votes INT Default 0, -- this is a running total of how many users liked this list
    PRIMARY KEY (id)
);

CREATE TABLE item (
    id INT NOT NULL AUTO_INCREMENT,
    list_id INT NOT NULL,
    name VARCHAR(120) ,
    ordernumber INT NOT NULL,
    visible BIT(1) Default 1, -- added this because it allow us to delete without taking anything out actually just won't be shown
    PRIMARY KEY (id)
);

CREATE TABLE attribute (
    id INT NOT NULL AUTO_INCREMENT,
    item_id INT NOT NULL,
    ordernumber INT NOT NULL,
    label VARCHAR(120) NOT NULL,
    type VARCHAR(120) NOT NULL,
    value VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)    
);

-- try add a table of template -dy 11/07
CREATE TABLE template (
		id INT NOT NULL AUTO_INCREMENT,
		t_name VARCHAR(120) NOT NULL,
		PRIMARY KEY(id)
);

CREATE TABLE template_attribute (
    id INT NOT NULL AUTO_INCREMENT,
    template_id INT NOT NULL,
    ordernumber INT NOT NULL,
    label VARCHAR(120) NOT NULL,
    type VARCHAR(120) NOT NULL,
    PRIMARY KEY (id)    
);


-- try to insert a template, name default, has one attribute with type text -dy 11/07
INSERT INTO template (t_name) VALUES ('Generic');		-- id: 1
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (1, 0, '1stlabel', 'text'); -- 1st in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (1, 1, '2ndlabel', 'text'); --2nd in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (1, 2, '3rdlabel', 'text'); -- 3rd in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (1, 3, '4thlabel', 'text'); -- 4th in template_attribute

INSERT INTO template (t_name) VALUES ('Music');		-- id: 2

INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (2, 0, 'Artist', 'text'); -- 5th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (2, 1, 'Album', 'text'); -- 6th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (2, 2, 'Song', 'text'); -- 7th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (2, 3, 'Video', 'video'); -- 8th in template_attribute


INSERT INTO template (t_name) VALUES ('Athletes');		-- id: 3
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (3, 0, 'NameofPlayer', 'text'); -- 9th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (3, 1, 'NameofTeam', 'text'); -- 10th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (3, 2, 'DateofBirth', 'text'); -- 11th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (3, 3, 'Position', 'text'); -- 12th in template_attribute

INSERT INTO template (t_name) VALUES ('Athletes W/video');		-- id: 4
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 0, 'NameofPlayer', 'text'); -- 13th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 1, 'NameofTeam', 'text'); -- 14th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 2, 'DateofBirth', 'text'); -- 15th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 3, 'Position', 'text'); -- 16th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 4, 'Video', 'video'); -- 17th in template_attribute


INSERT INTO template (t_name) VALUES ('Movies');		-- id: 5
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (5, 0, 'NameofMovie', 'text'); -- 18th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (5, 1, 'NameofDirector', 'text'); -- 19th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (5, 2, 'YearReleases','text'); -- 20th in template_attribute



-- insert some records
-- when deleteing these tables remember to input template_id
INSERT INTO list (name, template_id, account_id) VALUES ('Top Movies of 2017',5, 1);		-- 1st element in list belongs to jeremiah 

INSERT INTO item ( list_id, ordernumber) VALUES (1,0); -- 1 element in item belongs to jeremiah
INSERT INTO item ( list_id, ordernumber) VALUES (1,1); -- 2 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (1,2); -- 3 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (1,3); -- 4 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (1,4); -- 5 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (1,5); -- 6 element in item belongs to jeremiah
-- This all belongs to Top Movies
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1,0, 'NameofMovie', 'text', 'It'); 
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1,1, 'NameofDirector', 'text', ' Andy Muschietti');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1,2, 'YearReleases', 'text', "2017");
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (2,0, 'NameofMovie', 'text', 'Beauty and the Beast');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (2,1, 'NameofDirector', 'text', 'Bill Condon');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (2,2, 'YearReleases', 'text', "2017");
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (3,0, 'NameofMovie', 'text', 'Wonder Woman');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (3,1, 'NameofDirector', 'text', 'Patty Jenkins');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (3,2, 'YearReleases', 'text', "2017");
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (4,0, 'NameofMovie', 'text', 'Thor: Ragnarok');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (4,1, 'NameofDirector', 'text', 'Taika Waititi');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (4,2, 'YearReleases', 'text', "2017");
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (5,0, 'NameofMovie', 'text', 'Get Out');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (5,1, 'NameofDirector', 'text', ' Jordan');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (5,2, 'YearReleases', 'text', "2017");
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (6,0, 'NameofMovie', 'text', 'Hidden Figures');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (6,1, 'NameofDirector', 'text', 'Theodore Melfi');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (6,2, 'YearReleases', 'text', "2017");

INSERT INTO list (name, template_id, account_id) VALUES ('Top NFL Player all time',3, 1);		-- 2 element in list belongs to jeremiah 

INSERT INTO item ( list_id, ordernumber) VALUES (2,0); -- 7 element in item belongs to jeremiah
INSERT INTO item ( list_id, ordernumber) VALUES (2,1); -- 8 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (2,2); -- 9 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (2,4); -- 10 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (2,5); -- 11 element in item belongs to jeremiah 
INSERT INTO item ( list_id, ordernumber) VALUES (2,6); -- 12 element in item belongs to jeremiah
-- This belongs to Top NFL players
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (7,0, 'NameofPlayer', 'text', 'Jerry Rice');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (7,1, 'NameofTeam ', 'text', '49ers');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (7,2, 'DateofBirth', 'text', '1962');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (7,3, 'Position', 'text', 'WR');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (8,0, 'NameofPlayer', 'text', 'Tom Brady');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (8,1, 'NameofTeam ', 'text', 'Patriots');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (8,2, 'DateofBirth', 'text', '1977');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (8,3, 'Position', 'text', 'QB');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (9,0, 'NameofPlayer', 'text', 'Jim Brown');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (9,1, 'NameofTeam ', 'text', 'Browns');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (9,2, 'DateofBirth', 'text', '1936');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (9,3, 'Position', 'text', 'RB');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (10,0, 'NameofPlayer', 'text', 'Lawrence Taylor');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (10,1, 'NameofTeam ', 'text', 'Giants');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (10,2, 'DateofBirth', 'text', '1959');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (10,3, 'Position', 'text', 'LB');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (11,0, 'NameofPlayer', 'text', 'Walter Payton');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (11,1, 'NameofTeam ', 'text', 'Bears');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (11,2, 'DateofBirth', 'text', '1953');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (11,3, 'Position', 'text', 'RB');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (12,0, 'NameofPlayer', 'text', 'Reggie White');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (12,1, 'NameofTeam ', 'text', 'Packers');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (12,2, 'DateofBirth', 'text', '1961');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (12,3, 'Position', 'text', 'DE');

INSERT INTO list (name, template_id, account_id) VALUES ('Top Xbox one games of 2017',1, 1);		-- 3 element in list belongs to jeremiah 

INSERT INTO item ( list_id, ordernumber) VALUES (3,0); -- 13 element in item belongs to jeremiah

INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (13,0, '1stlabel', 'text', 'Game:NBA 2K18');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (13,1, '2ndlabel', 'text', 'Game:Halo 5');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (13,2, '3rdlabel', 'text', 'Game:Forza Motorsport 7');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (13,3, '4thlabel', 'text', 'Game: Madden 18');
-- List belonging to Bobby accountid 2
INSERT INTO list(name, template_id, account_id) VALUES('Top Basketball Players of All Time', 3, 2); -- 4 element in list belongs to Bobby 

INSERT INTO item( list_id, ordernumber) VALUES(4, 0); --14 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(4, 1); --15 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(4, 2); --16 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(4, 3); --17 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(4, 4); --18 element in item belongs to Bobby

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(14, 0, 'NameofPlayer', 'text', 'Michael Jordan');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(14, 1, 'NameofTeam', 'text', 'Chicago Bulls');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(14, 2, 'DateofBirth', 'text', '1963');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(14, 3, 'Position', 'text', 'SG');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(15, 0, 'NameofPlayer', 'text', 'LeBron James');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(15, 1, 'NameofTeam', 'text', 'Cleveland Cavaliers');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(15, 2, 'DateofBirth', 'text', '1984');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(15, 3, 'Position', 'text', 'SF');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(16, 0, 'NameofPlayer', 'text', 'Wilt Chamberlain');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(16, 1, 'NameofTeam', 'text', 'Philadelphia 76ers / Los Angeles Lakers');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(16, 2, 'DateofBirth', 'text', '1936');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(16, 3, 'Position', 'text', 'C');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(17, 0, 'NameofPlayer', 'text', 'Kareem Abdul-Jabaar');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(17, 1, 'NameofTeam', 'text', 'Los Angeles Lakers');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(17, 2, 'DateofBirth', 'text', '1947');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(17, 3, 'Position', 'text', 'C');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(18, 0, 'NameofPlayer', 'text', 'Kobe Bryant');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(18, 1, 'NameofTeam', 'text', 'Los Angeles Lakers');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(18, 2, 'DateofBirth', 'text', '1978');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(18, 3, 'Position', 'text', 'SG');


INSERT INTO list(name, template_id, account_id) VALUES('Chicago Sports Mount Rushmore', 3, 2); -- 4 element in list belongs to Bobby 

INSERT INTO item( list_id, ordernumber) VALUES(5, 0); --19 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(5, 1); --20 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(5, 2); --21 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(5, 3); --22 element in item belongs to Bobby

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(19, 0, 'NameofPlayer', 'text', 'Michael Jordan');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(19, 1, 'NameofTeam', 'text', 'Chicago Bulls');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(19, 2, 'DateofBirth', 'text', '1963');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(19, 3, 'Position', 'text', 'SG');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(20, 0, 'NameofPlayer', 'text', 'Walter Payton');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(20, 1, 'NameofTeam', 'text', 'Chicago Bears');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(20, 2, 'DateofBirth', 'text', '1953');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(20, 3, 'Position', 'text', 'RB');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(21, 0, 'NameofPlayer', 'text', 'Ernie Banks');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(21, 1, 'NameofTeam', 'text', 'Chicago Cubs');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(21, 2, 'DateofBirth', 'text', '1931');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(21, 3, 'Position', 'text', 'IF');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(22, 0, 'NameofPlayer', 'text', 'Frank Thomas');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(22, 1, 'NameofTeam', 'text', 'Chicago White Sox');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(22, 2, 'DateofBirth', 'text', '1968');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(22, 3, 'Position', 'text', 'IF');


INSERT INTO list(name, template_id, account_id) VALUES('Top U.S. Franchises', 1, 2);--6 element in list belongs to Bobby

INSERT INTO item( list_id, ordernumber) VALUES(6, 0); --23 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(6, 1); --24 element in item belongs to Bobby
INSERT INTO item( list_id, ordernumber) VALUES(6, 2); --25  element in item belongs to Bobby


INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(23 , 0, '1stlabel', 'text', 'New York Yankees');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(23, 1, '2ndlabel', 'text', 'Sport: Baseball');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(23, 2, '3rdlabel', 'text', '# of Championships: 27');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(23, 3, '4thlabel', 'text', 'Most Iconic Player: Babe Ruth');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(24, 0, '1stlabel', 'text', 'Boston Celtics');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(24, 1, '2ndlabel', 'text', 'Sport: Basketball');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(24, 2, '3rdlabel', 'text', '# of Championships: 17');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(24, 3, '4thlabel', 'text', 'Most Iconic Player: Bill Russell');

INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(25, 0, '1stlabel', 'text', 'Los Angeles Lakers');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(25, 1, '2ndlabel', 'text', 'Sport: Basketball');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(25, 2, '3rdlabel', 'text', '# of Championships: 16');
INSERT INTO attribute( item_id, ordernumber, label, type, value) VALUES(25, 3, '4thlabel', 'text', 'Most Iconic Player: Jerry West');
-- End Of Bobby tables


