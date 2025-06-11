/*
Question: What are the top paying data analysts jobs?
- Identify the top 10 highest paying data analyst roles that are available remotely.
- Focus on job postings with specified salaries.
- Why? To understand the market demand and compensation for data analyst roles.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
