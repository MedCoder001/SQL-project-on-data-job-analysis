/*
Question: What are the top skills for data analyst jobs based on salary?
- Join job_postings to inner join table similar to query 2
- Look at the average salary for each skill for data analyst roles.
- Focus on jobs with specified salaries regardless of location.
- Why? To identify the most financially rewarding skills for data analyst roles, providing insights into the skills that command higher salaries in the job market.
*/

SELECT 
    skills_dim.skills,
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
    -- AND job_work_from_home = True
GROUP BY
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
🧠 General Insights:
AI/ML skills like Keras, TensorFlow, PyTorch, Hugging Face are lucrative due to their alignment with deep learning and generative AI.

Infrastructure & DevOps tools (e.g., Terraform, Puppet, Ansible) are increasingly valued as data roles become more full-stack.

Legacy & Niche tools (e.g., SVN, Perl) often pay high due to scarcity of experts.

Languages like Scala and Go show the growing overlap between data analysis and backend engineering.
*/