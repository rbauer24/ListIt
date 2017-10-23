DROP TABLE IF EXISTS account;

/* This is a very simple table for a mysql-php example */
CREATE TABLE account (
    id INT NOT NULL AUTO_INCREMENT,
    hashedpass VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID)
);