

SELECT
d.dream_id,
d.title,
d.dream_date,
d.stars,
d.description,
t.tag_id,
t.tag_name,
dt.dreamtag_id
FROM dreams AS d
JOIN dream_tags AS dt
ON d.dream_id = dt.dream_id
JOIN tags as t
ON t.tag_id = dt.tag_id
ORDER BY dream_id ASC;