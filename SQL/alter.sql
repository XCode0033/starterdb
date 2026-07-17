

-- look at box 2 in documentation
-- altered because adding date to ejs is too much effort
-- also changed createDream to match

ALTER TABLE dreams ALTER COLUMN dream_date TYPE VARCHAR(50);

-- 7/16/26 changed id in dream table to dream_id

ALTER TABLE dreams RENAME COLUMN id TO dream_id;