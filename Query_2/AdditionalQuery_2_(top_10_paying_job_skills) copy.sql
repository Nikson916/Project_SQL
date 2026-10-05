SELECT
    skills_dim.skills,
    COUNT(skills_dim.skill_id) AS count_skills
FROM skills_dim
INNER JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN project ON skills_job_dim.job_id = project.job_id
WHERE project.job_id IN
    (SELECT job_id FROM (
        SELECT
            job_id
        FROM project
        WHERE job_title_short = 'Data Analyst' AND location LIKE 'Remote' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 10) AS subquery
    ) 
GROUP BY skills
ORDER BY count_skills DESC;


/*
Запрос для подсчёта сколько раз повторялся тот или иной скилл из Query_2.
*/;

WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title_short,
            salary_year
        FROM project
        WHERE job_title_short LIKE 'Data Scientist' AND location LIKE 'EU' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 10
)
SELECT
    top_paying_jobs.job_title_short,
    top_paying_jobs.salary_year,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/*Как основной запрос (Query_2) но только вакансии Data Scientist из Европы*/;




WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title_short,
            salary_year
        FROM project
        WHERE job_title_short LIKE 'Data Engineer' AND location LIKE 'USA' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 10
)
SELECT
    top_paying_jobs.job_title_short,
    top_paying_jobs.salary_year,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/*Как основной запрос (Query_2) но только вакансии Data Engineer из США*/;


WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title_short,
            salary_year
        FROM project
        WHERE location LIKE 'Russia' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 10
)
SELECT
    top_paying_jobs.job_title_short,
    top_paying_jobs.salary_year,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/*Как основной запрос (Query_2) но только Россия*/;


WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title_short,
            salary_year
        FROM project
        WHERE job_title_short LIKE 'Data%' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 25
)
SELECT
    top_paying_jobs.job_title_short,
    top_paying_jobs.salary_year,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/*
Создаём временный набор данных (CTE) в котором будет ID, наименование вакансии и средняя ЗП.
Оставляем только вакансии начинающиеся на Data где указана ЗП (NOT NULL).
В основном запросе выводим столбцы короткое наименование вакансии, ЗП и скиллы необходимые для вакансии.
Выводится только топ 25 вакансий по ЗП.
*/;


WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title_short,
            salary_year
        FROM project
        WHERE job_title_short LIKE 'Data%' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 25
)
SELECT
    skills_dim.skills,
    COUNT(top_paying_jobs.job_id) AS count_skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY count_skills DESC;

/*
Запрос для подсчёта сколько раз повторялся тот или иной скилл из запроса выше.
*/;
