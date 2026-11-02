/*
Вопрос 2
Какие навыки необходимы для удаленной работы аналитиком данных на наивысшую заработную плату?
*/;



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
Создаём временный набор данных (CTE) в котором будет ID, наименование вакансии и средняя ЗП.
Оставляем только вакансии Data Analyst работающин удаленно где указана ЗП (NOT NULL).
В основном запросе выводим столбцы ID вакансии, короткое наименование вакансии,
ЗП и скиллы необходимые для вакансии. Выводится только топ 10 вакансий по ЗП.

Благодаря этому запросу узнаем какие скиллы необходимы для вакансий с наивысшей ЗП.
*/