/*
Question: What are the most in-demand skills for data analyst jobs?
- Join job_postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for data analyst roles.
- Focus on all job postings that is remotely available.
- Why? To identify the top 5 skills that are most frequently required in data analyst job postings providing insights into the skills that most valuable to job seekers in this field.
*/

SELECT 
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
    job_work_from_home = True
GROUP BY
    skills_dim.skills
ORDER BY
    skill_count DESC
LIMIT 5;