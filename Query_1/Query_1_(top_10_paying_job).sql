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
WHERE job_title_short = 'Data Analyst' AND location LIKE 'Remote' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;

/* Выводим столбцы ID, наименование вакансии, наименование компании, полное наименование вакансии, местоположение, тип графика работы, ЗП, дату вакансии.
По задаче интерисует только вакансии относящиеся к 'Data Analyst',
с удаленным типом работы и где указанна ЗП.
Сортировка происходит по ЗП по убыванию и интерисуют только 10 верхних значений.

Благодаря этому запросу мы можем выяснить
Какие компании предоставляют наивысшую зарплату для вакансии Data Analyst при работе удаленно*/;
