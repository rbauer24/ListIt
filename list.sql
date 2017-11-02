
-- the code is  from JP and modified a bit   -- dy

-- drop the table if it already exists
DROP TABLE IF EXISTS attribute;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS list;

-- this is the table for lists
CREATE TABLE list (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL, 		-- the name of each list
    PRIMARY KEY (id)
);

CREATE TABLE item (
    id INT NOT NULL AUTO_INCREMENT,
    list_id INT NOT NULL,
    name VARCHAR(120) NOT NULL,
    ordernumber INT NOT NULL,
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

-- insert some records
	-- Soccer players
INSERT INTO list (name) VALUES ('Soccer players');		-- 1st element in list

INSERT INTO item (list_id, name, ordernumber) VALUES (1, 'Lionel Messi', 0);		-- 1st element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1, 0, 'club', 'text', 'FC Barcelona');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1, 1, 'national team', 'text', 'Argentina');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1, 2, 'video', 'video', "<iframe src='https://www.youtube.com/embed/0NQL3qZKrTE' frameborder='0' allowfullscreen></iframe>");

INSERT INTO item (list_id, name, ordernumber) VALUES (1, 'Neymar Jr.', 1);		-- 2nd element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (2, 0, 'club', 'text', 'PSG');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (2, 1, 'national team', 'text', 'Brazil');

	-- Songs
INSERT INTO list (name) VALUES ('Songs');		-- 2nd element in list

INSERT INTO item (list_id, name, ordernumber) VALUES (2, 'Integral', 0);		-- 3rd element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (3, 0, 'artist', 'text', 'Pet Shop Boys');

INSERT INTO item (list_id, name, ordernumber) VALUES (2, 'Phantoms', 1);		-- 4th element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (4, 0, 'artist', 'text', 'Alphaville');
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (4, 1, 'video', 'video', '<iframe width="560" height="315" src="https://www.youtube.com/embed/VS4Enm-y8EM" frameborder="0" allowfullscreen></iframe>');

	-- Top NBA Players
INSERT INTO list (name) VALUES ('Top NBA Players');		-- 3rd element in list

INSERT INTO item (list_id, name, ordernumber) VALUES (3, 'Kevin Durant', 0);		-- 5th element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (5, 0, 'team', 'text', 'Warriors');

INSERT INTO item (list_id, name, ordernumber) VALUES (3, 'LeBron James', 1);		-- 6th element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (6, 0, 'team', 'text', 'Cavs');

INSERT INTO item (list_id, name, ordernumber) VALUES (3, 'Russell Westbrook', 2);		-- 7th element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (7, 0, 'team', 'text', 'Thunder');

INSERT INTO item (list_id, name, ordernumber) VALUES (3, 'Kawhi Leonard', 3);		-- 8th element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (8, 0, 'team', 'text', 'Spurs');

INSERT INTO item (list_id, name, ordernumber) VALUES (3, 'James Harden', 3);		-- 9th element in item
INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (9, 0, 'team', 'text', 'Rockets');