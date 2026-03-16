-- Show the first 10 rows from the table company_dim
SELECT * 
FROM company_dim 
LIMIT 10;


-- Convert the text '2023-02-19' into a DATE type
SELECT '2023-02-19'::DATE;


-- Select job information from job_postings_fact
SELECT
    job_title_short AS title, -- rename column job_title_short to "title"
    
    job_location AS location, -- rename job_location to "location"
    
    -- Convert job_posted_date from UTC timezone to EST timezone
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    
    -- Extract the month number (1-12) from job_posted_date
    EXTRACT(MONTH FROM job_posted_date) AS date_month

FROM
    job_postings_fact

-- Only display the first 5 rows
LIMIT 5;



-- Select job information with month and year extracted
SELECT
    job_title_short AS title, -- job title
    
    job_location AS location, -- job location
    
    -- Convert timezone from UTC to EST
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    
    -- Extract the month from the posting date
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    
    -- Extract the year from the posting date
    EXTRACT(YEAR FROM job_posted_date) AS date_year

FROM
    job_postings_fact

-- Show only 5 rows
LIMIT 5;



-- Count how many Data Analyst jobs were posted each month
SELECT
    COUNT(job_id) AS job_posted_count, -- number of jobs posted
    
    -- Extract month from job_posted_date
    EXTRACT(MONTH FROM job_posted_date) AS month

FROM
    job_postings_fact

-- Filter only Data Analyst jobs
WHERE job_title_short = 'Data Analyst'

-- Group results by month
GROUP BY
    MONTH

-- Sort the result by number of jobs posted
ORDER BY
    job_posted_count;