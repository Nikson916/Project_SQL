WITH demand_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM project
    INNER JOIN skills_job_dim ON project.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND location = 'Remote' AND project.salary_year IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
), average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(project.salary_year), 0) AS avg_salary_for_skill
    FROM skills_dim
    INNER  JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER  JOIN project ON skills_job_dim.job_id = project.job_id
    WHERE job_title_short = 'Data Analyst' AND location = 'Remote' AND project.salary_year IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
)

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    demand_count,
    avg_salary_for_skill
FROM skills_dim
INNER  JOIN demand_skills ON skills_dim.skill_id = demand_skills.skill_id
INNER  JOIN average_salary ON skills_dim.skill_id = average_salary.skill_id
WHERE demand_count >= 10
ORDER BY avg_salary_for_skill DESC, demand_count DESC
LIMIT 25;



WITH demand_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 1 AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
), average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary_for_skill
    FROM skills_dim
    INNER  JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER  JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 1 AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
)

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    demand_count,
    avg_salary_for_skill
FROM skills_dim
INNER  JOIN demand_skills ON skills_dim.skill_id = demand_skills.skill_id
INNER  JOIN average_salary ON skills_dim.skill_id = average_salary.skill_id;

