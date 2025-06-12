
-- 1. How many rows are in the names table? 

SELECT *
FROM names;

Answer: Total rows: 1957046

-- 2. How many total registered people appear in the dataset? 

SELECT COUNT(*)
FROM names;

Answer: 1957046

-- 3. Which name had the most appearances in a single year in the dataset?

SELECT
    name,
    year,
    COUNT(*) AS appearances_in_year
FROM
    names
GROUP BY
    name,
    year
ORDER BY
    appearances_in_year DESC
LIMIT 1;

Answer: Aaden, 2009, appeared twice 

-- 4. What range of years are included?

SELECT 
	MIN(year) AS earliest_year,
	MAX(year) AS latest_year
FROM names;

Answer: Earliest: 1880
		Latest: 2018


-- 5. What year has the largest number of registrations?

SELECT year, COUNT(*) AS largest_num_reg
FROM names
GROUP BY year -- Grouping each year together 
ORDER BY largest_num_reg DESC
LIMIT 1;

Answer: 2008, number of reg. 35079


-- 6. How many different (distinct) names are contained in the dataset?

SELECT DISTINCT(name)
FROM names;

Answer: 98400

-- 7. Are there more males or more females registered?

SELECT COUNT(gender) 
FROM names 
WHERE gender = 'M' or gender = 'F' 
GROUP BY gender;

Answer: There are more males than females registered

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?
-- Using (2) separate queries for Male and Female popular names 

SELECT
    name,
    COUNT(*) AS total_registrations
FROM
    names
WHERE
    gender = 'M'
GROUP BY
    name
ORDER BY
    total_registrations DESC
LIMIT 1;

Hamilton (139) 

SELECT
    name,
    COUNT(*) AS total_registrations
FROM
    names
WHERE
    gender = 'F'
GROUP BY
    name
ORDER BY
    total_registrations DESC
LIMIT 1;

Diana (139)

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT
    name,
    gender,
    total_registrations
FROM (
    SELECT
        name,
        gender,
        COUNT(*) AS total_registrations,
        RANK() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS ranked_names
    FROM names
    WHERE year >= 2000 AND year <= 2009 
        AND (gender = 'M' OR gender = 'F') 
    GROUP BY name, gender) AS ranked_names
	WHERE ranked_names = 1;

-- Need to review formula--

--10. Which year had the most variety in names (i.e. had the most distinct names)?

SELECT
    year,
    COUNT(DISTINCT name) AS number_of_distinct_names
FROM
    names
GROUP BY
    year
ORDER BY
    number_of_distinct_names DESC
LIMIT 1;

Answer: 2008 

-- 11. What is the most popular name for a girl that starts with the letter X?

SELECT
    name,
    COUNT(*) AS total_registrations
FROM
    names
WHERE
    gender = 'F'              
    AND name ILIKE 'x%'      
GROUP BY
    name
ORDER BY
    total_registrations DESC 
LIMIT 1;                      

Answer: Xenia 

-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?

SELECT
    COUNT(DISTINCT name) AS distinct_names
FROM
    names
WHERE
    name ILIKE 'Q%'
    AND name NOT ILIKE '_u%';

Answer: 46 

--13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
