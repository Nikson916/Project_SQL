WITH top_paying_jobs AS (
    SELECT
            job_id,
            job_title_short,
            salary_year
        FROM project
        WHERE job_title_short = 'Data Analyst' AND location LIKE 'Remote' AND salary_year IS NOT NULL
        ORDER BY salary_year DESC
        LIMIT 10
)
SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title_short,
    top_paying_jobs.salary_year,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/*
Создаём временный набор данных (CTE) в котором будет ID, наименование вакансии и средняя ЗП.
Оставляем только вакансии Data Analyst работающин удаленно где указана ЗП (NOT NULL).
В основном запросе выводим столбцы ID вакансии, короткое наименование вакансии,
ЗП и скиллы необходимые для вакансии. Выводится только топ 10 вакансий по ЗП.

Благодаря этому запросу узнаем какие скиллы необходимы для вакансий с наивысшей ЗП.
*/