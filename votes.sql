DROP TABLE IF EXISTS VOTES;

CREATE TABLE VOTES (
    account_id INT,
    list_id INT,
    vote BIT(1) Default 0 -- this is a boolean that if you don't vote it defaults to zero, if you do vote it sets to one
);