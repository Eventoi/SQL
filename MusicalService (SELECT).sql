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
WHERE name NOT LIKE '% %'

-- Название треков, которые содержат слово «мой» или «my»
SELECT name
FROM tracks
WHERE name LIKE '%My%'

-- Количество исполнителей в каждом жанре
SELECT g.name AS genre, COUNT(a.id) AS count
FROM genres AS g
LEFT JOIN artists_genres AS ag ON g.id = ag.genre_id
LEFT JOIN artists AS a ON ag.artist_id = a.id
GROUP BY g.name
ORDER BY count DESC

-- Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id) AS count
FROM tracks AS t
INNER JOIN albums AS a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020

-- Средняя продолжительность треков по каждому альбому
SELECT a.name AS album, AVG(t.duration) AS average_duration
FROM albums AS a
INNER JOIN tracks AS t ON a.id = t.album_id
GROUP BY a.name

-- Все исполнители, которые не выпустили альбомы в 2020 году
SELECT a.name
FROM artists AS a
LEFT JOIN artists_albums AS aa ON a.id = aa.artist_id
LEFT JOIN albums AS al ON aa.album_id = al.id
WHERE al.release_year <> 2020 OR al.release_year IS NULL

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT c.name
FROM compilations AS c
INNER JOIN tracks_compilations AS tc ON c.id = tc.compilation_id
INNER JOIN tracks AS t ON tc.track_id = t.id
INNER JOIN artists_albums AS aa ON t.album_id = aa.album_id
INNER JOIN artists AS a ON aa.artist_id = a.id
WHERE a.name = 'Parkway Drive'

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT a.name
FROM albums AS a
JOIN artists_albums AS aa ON a.id = aa.album_id
JOIN artists_genres AS ag ON aa.artist_id = ag.artist_id
GROUP BY a.name
HAVING COUNT(DISTINCT ag.genre_id) > 1

-- Наименования треков, которые не входят в сборники
SELECT t.name
FROM tracks AS t
LEFT JOIN tracks_compilations AS tc ON t.id = tc.track_id
WHERE tc.track_id IS NULL

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
SELECT a.name
FROM artists AS a
JOIN artists_albums AS aa ON a.id = aa.artist_id
JOIN tracks AS t ON aa.album_id = t.album_id
WHERE t.duration = (
	SELECT MIN(duration)
	FROM tracks
	)

-- Названия альбомов, содержащих наименьшее количество треков
SELECT a.name
FROM albums AS a
JOIN (
    SELECT album_id, COUNT(*) AS track_count
    FROM tracks AS t
    GROUP BY album_id
) AS track_counts ON a.id = track_counts.album_id
WHERE track_counts.track_count = (
    SELECT MIN(track_count)
    FROM (
        SELECT COUNT(*) AS track_count
        FROM tracks AS t
        GROUP BY album_id
    ) AS subquery
)