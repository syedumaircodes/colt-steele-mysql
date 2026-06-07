-- 1. Database & Schema Setup
CREATE DATABASE IF NOT EXISTS clothing_db;
USE clothing_db;

CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article    VARCHAR(50),
    color      VARCHAR(50),
    shirt_size VARCHAR(5),
    last_worn  INT
);

-- 2. Data Ingestion
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES
    ('t-shirt', 'white', 'L', 10),
    ('t-shirt', 'green', 'L', 200),
    ('polo shirt', 'black', 'M', 10),
    ('button down', 'blue', 'L', 50),
    ('t-shirt', 'Orange', 'L', 0),
    ('polo shirt', 'Green', 'M', 5),
    ('button down', 'white', 'L', 200),
    ('button down', 'blue', 'M', 15);

-- 3. Data Retrieval (Selection)
SELECT article, color FROM shirts;

SELECT * FROM shirts
WHERE shirt_size = 'M';

SELECT article, color, shirt_size, last_worn
FROM shirts
WHERE shirt_size = 'M';

-- 4. Data Updates
-- Update all polo shirts to size L
UPDATE shirts
SET shirt_size = 'L'
WHERE article = 'polo shirt';

-- Reset 'last_worn' for specific items
UPDATE shirts
SET last_worn = 0
WHERE last_worn = 15;

-- Batch update for white shirts (changing to 'off white' and 'XS')
UPDATE shirts
SET color = 'off white',
    shirt_size = 'XS'
WHERE color = 'white';

-- 5. Data Deletion
-- View and then delete shirts not worn in 200 days
SELECT * FROM shirts WHERE last_worn = 200;
DELETE FROM shirts WHERE last_worn = 200;

-- Targeted delete for 'tank top' (even if it doesn't exist)
SELECT * FROM shirts WHERE article = 'tank top';
DELETE FROM shirts WHERE article = 'tank top';

-- 7. Verification
SHOW TABLES;
DESC shirts; -- Note: This will fail if the table was dropped in the previous step
