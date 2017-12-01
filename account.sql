DROP TABLE IF EXISTS account;

/* This is a very simple table for a mysql-php example */
CREATE TABLE account (
    id INT NOT NULL AUTO_INCREMENT,
    hashedpass VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
	email VARCHAR(300) NOT NULL,
	location VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID)
);

INSERT INTO account (hashedpass, username, email, location) values ('$2a$12$s7h33TRR.wjhdKVdNIGON.pBVHlr2rancX6TxExL2UpLjTu.0TdbK', 'jqmeyers', 'jeremiah-meyers@uiowa.edu', 'Chicago');
INSERT INTO account (hashedpass, username, email, location) values ('$2a$12$4W4ej8SBkW6Z7wwEnG885OFemfYEPBTD1abWdg9ep0DqvZGc8LwyO','rjbauer','robert-j-bauer@uiowa.edu','Cary');
INSERT INTO account (hashedpass, username, email, location) values ('$2a$12$FqVuPRs7P3A3mlzneMnzC.FRUB6bLqk6mhGpQT00XY7kdD1.XZSuq','ddy', 'yu-dai@uiowa.edu', 'China');                                               |          |
)