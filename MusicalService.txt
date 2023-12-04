# Домашнее задание к лекции «Работа с SQL. Создание БД»

CREATE DATABASE Music_Service;

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE artists_genres (
  artist_id INT,
  genre_id INT,
  FOREIGN KEY (artist_id) REFERENCES artists(id),
  FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  release_year INT NOT NULL
);

CREATE TABLE artists_albums (
  artist_id INT,
  album_id INT,
  FOREIGN KEY (artist_id) REFERENCES artists(id),
  FOREIGN KEY (album_id) REFERENCES albums(id)
);

CREATE TABLE tracks (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  duration INT NOT NULL,
  album_id INT NOT NULL,
  FOREIGN KEY (album_id) REFERENCES albums(id)
);

CREATE TABLE compilation (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  release_year INT NOT NULL
);

CREATE TABLE tracks_compilations (
  track_id INT,
  compilation_id INT,
  FOREIGN KEY (track_id) REFERENCES tracks(id),
  FOREIGN KEY (compilation_id) REFERENCES compilations(id)
);