DROP TABLE IF EXISTS dreams;

CREATE TABLE dreams (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) DEFAULT 'untitled',
    dream_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stars INT,
    description TEXT
);