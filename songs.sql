-- this is the table for songs
DROP TABLE IF Exists songs;

CREATE TABLE songs (
    id INT NOT NULL AUTO_INCREMENT, 
    name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    album VARCHAR(100) NOT NULL,
    year_released INT UNSIGNED NOT NULL,
    video VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO songs(name, artist, album, year_released, video) VALUES('When the Levee Breaks', 'Led Zeppelin', 'Led Zeppelin IV', 1971, '<iframe src="https://www.youtube.com/embed/ddpl1zl5sYg" frameborder="0" allowfullscreen></iframe>');
INSERT INTO songs(name, artist, album, year_released, video) VALUES('Standing Outside a Broken Phone Booth', 'Primitive Radio Gods', 'Rocket', 1996, '<iframe src="https://www.youtube.com/embed/4XJxFAoiWSY" frameborder="0" allowfullscreen></iframe>');
INSERT INTO songs(name, artist, album, year_released, video) VALUES('Can I Kick It?', 'A Tribe Called Quest', "People's Instinctive Travels and the Paths of Rhythm", 1990, '<iframe src="https://www.youtube.com/embed/ZrlJX7DzLhI" frameborder="0" allowfullscreen></iframe>');
INSERT INTO songs(name, artist, album, year_released, video) VALUES('Backseat Freestyle', 'Kendrick Lamar', 'Good kid, m.A.A.d city', 2012, '<iframe src="https://www.youtube.com/embed/IYjFYDvXrVc" frameborder="0" allowfullscreen></iframe>');
INSERT INTO songs(name, artist, album, year_released, video) VALUES('Low Life', 'Future', 'Evol', 2016, '<iframe src="https://www.youtube.com/embed/K_9tX4eHztY" frameborder="0" allowfullscreen></iframe>');
