/*
Question: What are the optimal skills to learn(high in-demand and high paying skills)
- Identify the top skills that are high in demand and associated with high average salaries for data analyst roles.
- Focus on remote job postings with specified salaries.
- Why? To provide insights into the skills that are both frequently required and command higher salaries, for job security and financial benefit.
*/
-- Using CTEs

WITH top_demand_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_dim.skills) AS skill_count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = True AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), top_paying_skills AS (
    SELECT 
    skills_job_dim.skill_id,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL 
        AND job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    top_demand_skills.skill_id,
    top_demand_skills.skills,
    skill_count,
    avg_salary
FROM
    top_demand_skills
INNER JOIN
    top_paying_skills ON top_demand_skills.skill_id = top_paying_skills.skill_id

WHERE
    skill_count > 10
ORDER BY
    avg_salary DESC, skill_count DESC
LIMIT 25;