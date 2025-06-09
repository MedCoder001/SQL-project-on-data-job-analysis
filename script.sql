WITH skill_dim AS (
    SELECT
        skill_id,
        skills AS skill_list,
        type AS skill_type
    FROM
        skills_dim
)
SELECT 
    skill_dim.skill_list,
    skill_dim.skill_type,
    AVG(q1_jobs.salary_year_avg) AS average_salary
FROM (
    SELECT
        job_id,
        salary_year_avg
    FROM january_jobs
    UNION ALL
    SELECT
        job_id,
        salary_year_avg
    FROM february_jobs
    UNION ALL
    SELECT
        job_id,
        salary_year_avg
    FROM march_jobs) AS q1_jobs

LEFT JOIN skills_job_dim ON q1_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skill_dim ON skills_job_dim.skill_id = skill_dim.skill_id
WHERE
    q1_jobs.salary_year_avg IS NOT NULL
GROUP BY 
    skill_dim.skill_list, 
    skill_dim.skill_type
ORDER BY average_salary DESC;