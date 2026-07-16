

-- CREATE TABLE dreams (
--     id SERIAL PRIMARY KEY,
--     title VARCHAR(100) DEFAULT 'untitled',
--     dream_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     stars INT,
--     description TEXT
-- );

-- DELETE id FROM dreams
-- WHERE id = $1
-- RETURNING * , [id]


CREATE TABLE tags (
    tag_id SERIAL PRIMARY KEY,
    tag_name VARCHAR(20),
    tag_year INT
);

CREATE TABLE dream_tags (
    dreamtag_id SERIAL PRIMARY KEY,
    dream_id INT REFERENCES dreams(dream_id),
    tag_id INT REFERENCES tags(tag_id)
)
