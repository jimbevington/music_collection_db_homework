DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;

CREATE TABLE artists(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE albums(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  genre VARCHAR(255),
  artist_id INT REFERENCES artists(id) -- ON DELETE CASCADE -- this deletes entry where the foreign key entry is deleted
);
