

Created database with 

1. -- Initial Data
CREATE TABLE dreams (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) DEFAULT 'untitled',
    dream_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stars INT,
    description TEXT
);

Inserted initial 


INSERT INTO dreams (title, dream_date, stars, description) VALUES
('Moonlit Forest', '2024-01-01 00:00:00', 5, 'A quiet path through glowing trees.'),
('Ocean Staircase', '2023-01-01 00:00:00', 4, 'A golden staircase into the sea.'),
('Flying Circus', '2022-01-01 00:00:00', 3, 'Bright balloons over a sleepy town.'),
('Clocktower Rooftop', '2025-01-01 00:00:00', 5, 'A calm view at sunrise.');

-----------------------------------

2. table as of 7/5/ 5:54pm
CHANGING THE DREAM_DATE TO VARCHAR BECAUSE ITS TOO MUCH EFFORT TO INCLUDE THE TIME IN THE EJS RIGHT NOW.

CREATE TABLE dreams (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) DEFAULT 'untitled',
    dream_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stars INT,
    description TEXT
);
