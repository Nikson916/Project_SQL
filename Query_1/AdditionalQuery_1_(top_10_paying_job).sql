SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND job_location LIKE 'Anywhere' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;


/* Запрос такой же как и Query_1 только для оригинальной таблицы
Из-за перевода ЗП по часам в ЗП годовую в оригинальной таблице меньше значений

Выводим столбцы ID, наименование вакансии, наименование компании, полное наименование вакансии, местоположение, тип графика работы, ЗП, дату вакансии.
По задаче интересует только вакансии относящиеся к 'Data Analyst',
с удаленным типом работы и где указанна ЗП.
Сортировка происходит по ЗП (по убыванию) и только 10 верхних значений.
*/;


SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_title_short,
    location,
    job_schedule_type,
    salary_year,
    job_posted_date
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE job_title_short LIKE 'Data Scientist' AND location LIKE 'EU' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Всё как в запросе выше, только теперь интересует вакансия  Data Scientist в EU
*/;


SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_title_short,
    location,
    job_schedule_type,
    salary_year,
    job_posted_date
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE job_title_short LIKE 'Data Engineer' AND location LIKE 'USA' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Всё как в запросе выше, только теперь интересует вакансия Data Engineer в USA
*/;



SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_title_short,
    location,
    job_schedule_type,
    salary_year,
    job_posted_date
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE location LIKE 'Russia' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Всё вакансии где ЗП не NULL в России
*/;


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
Полное и короткое наименование вакансии, наименование компании и ЗП
Выводит все вакансии начинающиеся на Data (Data Engineer, Data Scientist и Data Analyst)
ЗП не NULL без ограничений по локации. Топ 25 вакансий.
*/;