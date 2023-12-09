-- Название и продолжительность самого длительного трека
SELECT name, duration
FROM tracks
ORDER BY duration DESC
LIMIT 1

-- Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM tracks
WHERE duration >= 210

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM compilations
WHERE release_year BETWEEN 2018 AND 2021

-- Исполнители, чьё имя состоит из одного слова
SELECT name
FROM artists
WHERE name NOT LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM tracks
WHERE name LIKE '%My%'