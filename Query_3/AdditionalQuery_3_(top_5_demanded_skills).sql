WITH remote_job_skills AS (
    SELECT
        skills_job_dim.skill_id,
        COUNT(*) AS number_of_skills
    FROM skills_job_dim
    INNER JOIN project ON skills_job_dim.job_id = project.job_id
    WHERE project.job_work_from_home = TRUE AND project.job_title_short = 'Data Analyst'
    GROUP BY skills_job_dim.skill_id
    )

SELECT
    remote_job_skills.skill_id,
    skills_dim.skills,
    number_of_skills
FROM remote_job_skills
JOIN skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY number_of_skills DESC
LIMIT 5;


SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM project
LEFT JOIN skills_job_dim ON project.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND location = 'Remote'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;