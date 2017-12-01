
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
    PRIMARY KEY (id)
);

CREATE TABLE item (
    id INT NOT NULL AUTO_INCREMENT,
    list_id INT NOT NULL,
    name VARCHAR(120) ,
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
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (3, 2, 'Age', 'text'); -- 11th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (3, 3, 'Position', 'text'); -- 12th in template_attribute

INSERT INTO template (t_name) VALUES ('Athletes W/video');		-- id: 4
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 0, 'NameofPlayer', 'text'); -- 13th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 1, 'NameofTeam', 'text'); -- 14th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 2, 'Age', 'text'); -- 15th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 3, 'Position', 'text'); -- 16th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (4, 4, 'Video', 'video'); -- 17th in template_attribute


INSERT INTO template (t_name) VALUES ('Movies');		-- id: 5
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (5, 0, 'NameofMovie', 'text'); -- 18th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (5, 1, 'NameofDirector', 'text'); -- 19th in template_attribute
INSERT INTO template_attribute (template_id, ordernumber, label, type) VALUES (5, 2, 'YearReleases','text'); -- 20th in template_attribute



-- insert some records
-- when deleteing these tables remember to input template_id
--INSERT INTO list (name, account_id) VALUES ('Favorite Video', 1);		-- 1st element in list

--INSERT INTO item (list_id, name,template_id, ordernumber) VALUES (1, 'J.Cole',2, 0);		-- 1st element in item
--INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1, 0, ' ', 'text', 'FC Barcelona');
--INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1, 1, 'national team', 'text', 'Argentina');
--INSERT INTO attribute (item_id, ordernumber, label, type, value) VALUES (1, 2, 'video', 'video', "<iframe src='https://www.youtube.com/embed/0NQL3qZKrTE' frameborder='0' allowfullscreen></iframe>");

