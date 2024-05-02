-- Creation of 'Music_Player' database
CREATE DATABASE MUSIC_PLAYER;
USE MUSIC_PLAYER;

-- Creation of 'Songs' table
CREATE TABLE Songs (
    song_ID int NOT NULL PRIMARY KEY,
    song_title varchar(100) NOT NULL,
    artist_ID int,
    album_ID int,
    genre varchar(50),
    duration TIME,
    release_date DATE,
    FOREIGN KEY(artist_ID) REFERENCES Artists(artist_ID),
    FOREIGN KEY(album_ID) REFERENCES Albums(album_ID)
);

-- Creation of 'Artists' table
CREATE TABLE Artists (
    artist_ID int NOT NULL PRIMARY KEY,
    artist_name varchar(100) NOT NULL,
    nationality varchar(100),
    debut_year YEAR
);

-- Creation of 'Albums' table
CREATE TABLE Albums (
    album_ID int NOT NULL PRIMARY KEY,
    album_title varchar(100) NOT NULL,
    artist_ID int,
    release_year YEAR,
    FOREIGN KEY(artist_ID) REFERENCES Artists(artist_ID)
);

-- Creation of 'Playlists' table
CREATE TABLE Playlists (
    playlist_ID int NOT NULL PRIMARY KEY,
    playlist_name varchar(100) NOT NULL
);

-- Creation of 'Playlist_Songs' table to map songs to playlists
CREATE TABLE Playlist_Songs (
    playlist_ID int,
    song_ID int,
    FOREIGN KEY(playlist_ID) REFERENCES Playlists(playlist_ID),
    FOREIGN KEY(song_ID) REFERENCES Songs(song_ID)
);

-- Creation of 'User' table for storing user information
CREATE TABLE User (
    user_ID int NOT NULL PRIMARY KEY,
    username varchar(100) NOT NULL,
    email varchar(100),
    password varchar(100)
);

-- Creation of 'User_Playlists' table to map users to playlists
CREATE TABLE User_Playlists (
    user_ID int,
    playlist_ID int,
    FOREIGN KEY(user_ID) REFERENCES User(user_ID),
    FOREIGN KEY(playlist_ID) REFERENCES Playlists(playlist_ID)
);

-- Sample value insertion (You can insert more values)
INSERT INTO Artists VALUES (1, 'Ed Sheeran', 'British', 2004);
INSERT INTO Albums VALUES (1, '÷', 1, 2017);
INSERT INTO Songs VALUES (1, 'Shape of You', 1, 1, 'Pop', '03:53', '2017-01-06');
INSERT INTO Playlists VALUES (1, 'Favorites');
INSERT INTO Playlist_Songs VALUES (1, 1);
INSERT INTO User VALUES (1, 'example_user', 'user@example.com', 'password');
INSERT INTO User_Playlists VALUES (1, 1);

Table for storing user song preferences:
sql
Copy code
CREATE TABLE User_Song_Preferences (
    user_ID int,
    song_ID int,
    rating int,
    FOREIGN KEY(user_ID) REFERENCES User(user_ID),
    FOREIGN KEY(song_ID) REFERENCES Songs(song_ID)
);
This table allows users to rate songs, and you can use this information for personalized recommendations.

Table for storing user listening history:
sql
Copy code
CREATE TABLE Listening_History (
    user_ID int,
    song_ID int,
    play_datetime DATETIME,
    FOREIGN KEY(user_ID) REFERENCES User(user_ID),
    FOREIGN KEY(song_ID) REFERENCES Songs(song_ID)
);
This table records when users listen to songs, which can be used to generate playlists like "Recently Played" or "Most Played".

Functionality to add songs to a playlist:
sql
Copy code
-- Add song to a playlist
INSERT INTO Playlist_Songs (playlist_ID, song_ID) VALUES (1, 2);
Functionality to create a new playlist:
sql
Copy code
-- Create a new playlist
INSERT INTO Playlists (playlist_name) VALUES ('Chill Vibes');
Functionality to delete a playlist:
sql
Copy code
-- Delete a playlist
DELETE FROM Playlists WHERE playlist_ID = 2;
Functionality to get top-rated songs:
sql
Copy code
-- Get top-rated songs
SELECT Songs.song_title, AVG(User_Song_Preferences.rating) AS avg_rating
FROM Songs
JOIN User_Song_Preferences ON Songs.song_ID = User_Song_Preferences.song_ID
GROUP BY Songs.song_ID
ORDER BY avg_rating DESC
LIMIT 10;
Functionality to get recently played songs by a user:
sql
Copy code
-- Get recently played songs by a user
SELECT Songs.song_title, Listening_History.play_datetime
FROM Listening_History
JOIN Songs ON Listening_History.song_ID = Songs.song_ID
WHERE Listening_History.user_ID = 1
ORDER BY Listening_History.play_datetime DESC
LIMIT 10;
Functionality to get songs by a specific artist:
sql
Copy code
-- Get songs by a specific artist
SELECT Songs.song_title
FROM Songs
JOIN Artists ON Songs.artist_ID = Artists.artist_ID
WHERE Artists.artist_name = 'Ed Sheeran';