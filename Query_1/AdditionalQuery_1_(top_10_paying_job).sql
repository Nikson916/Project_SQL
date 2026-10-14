SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_schedule_type,
    salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND job_location LIKE 'Anywhere' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;


/* Запрос такой же как и Query_1 только для оригинальной таблицы
Из-за перевода ЗП по часам в ЗП годовую в оригинальной таблице меньше значений

Дальше идут запросы повторяющий запрос из Query_1, но немного изменены условия.
*/;


SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_schedule_type,
    salary_year
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE job_title_short LIKE 'Data Scientist' AND location LIKE 'EU' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Наименование вакансии 'Data Scientist', местоположение 'EU' */;


SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_schedule_type,
    salary_year
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE job_title_short LIKE 'Data Engineer' AND location LIKE 'USA' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Наименование вакансии 'Data Engineer', местоположение 'USA' */;



SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_title_short,
    job_schedule_type,
    salary_year
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE location LIKE 'Russia' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Наименование вакансии любое, местоположение 'Russia' */;


SELECT
    job_title,
    job_title_short,
    company_dim.name AS company_name,
    location,
    salary_year
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE salary_year IS NOT NULL AND job_title_short LIKE 'Data%'
ORDER BY salary_year DESC
LIMIT 25;

/*
Наименование вакансии любое начинающиеся на Data (Data Engineer, Data Scientist и Data Analyst), местоположеине 'Russia'
Без ограничений по местоположению. Топ 25.
*/;