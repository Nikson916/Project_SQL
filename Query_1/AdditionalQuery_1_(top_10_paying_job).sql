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


/* Из-за перевода ЗП по часам в ЗП годовую
в моей таблице появляются дополнительные значения по сравнению с оригинальной таблицей
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