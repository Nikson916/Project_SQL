SELECT * FROM skills_dim
LIMIT 10;

SELECT * FROM company_dim
LIMIT 10;

SELECT * FROM job_postings_fact
LIMIT 10;

SELECT * FROM skills_job_dim
LIMIT 10;

/* Информация по таблице skills_dim
1) skill_id - уникальный номер скилла
2) skills - наименование скилла
3) type - к какому типу относится скилл (программирование, работа с данными, аналитические инструменты и т.д.)
*/;

/* Информация по таблице company_dim
1) company_id - уникальный номер компании
2) name - наименование компании
3) link - ссылка на сайт компании (если есть)
4) link_google - поиск через гугл
*/;

/*Информация по таблице skills_job_dim
1) job_id - уникальный номер вакансии
2) skill_id - уникальный номер скилла
(таблица существует для соединения таблицы job_postings_fact с skills_dim)
*/;

/*Оригинальная таблица job_postings_fact
1) job_id - уникальный номер вакансии
2) company_id - уникальный номер компании
3) job_title_short - короткое наименование вакансии (всего 10 видов)
4) job_title - полное наименование вакансии
5) job_location - место откуда будет работать соискатель
6) job_via - сайт размещения вакансии
7) job_schedule_type - тип работы (полный рабочия день, неполный рабочий день, контракт и т.д.)
8) job_work_from_home - работа из дома или нет
9) search_location - в какой стране (городе) показывается вакансия
10) job_posted_date - дата вакансии
11) job_no_degree_mention - наличие или отсутствие высшего образования
12) job_health_insurance - наличие отсутствие мед страхования
13) job_country - страна из столбца job_location/search_location
14) salary_rate - ЗП почасовая или годовая
15) salary_year_avg - размер ЗП
16) salary_hour_avg - размер ЗП
(В дальнейшем эта таблица будет модифицирована)*/;


SELECT
    job_title_short,
    job_location,
    search_location,
    salary_rate,
    salary_hour_avg,
    salary_year_avg
FROM job_postings_fact
WHERE search_location LIKE '%United States';


SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 0) AS avg_year_salary,
    ROUND(AVG(salary_hour_avg), 0) AS avg_hour_salary,
    COUNT(*) AS count_with_na,
    COUNT(salary_year_avg) AS count_y_no_na,
    COUNT(salary_hour_avg) AS count_h_no_na
FROM job_postings_fact
WHERE search_location LIKE '%Russia'
GROUP BY job_title_short;


/*
Так как по Россси недостаточное количество данных
(Всего 10 видов вакансий из них только у 3 есть указанная ЗП
 и то в количестве 1-2 штук что недостаточно для исследования)
Для проведения исследования решено исследовать рынок США, ЕС и удалёнку
(Anywhere, изначальная страна учитываться не будет) (Россия останется чисто кодом)
В ЕС входит 27 стран:
Austria, Belgium, Bulgaria, Croatia, Cyprus, Czechia, Denmar, Estonia, Finland, France,
Germany, Greece, Hungary, Ireland, Italy, Latvia, Lithuania, Luxembo, Malta, Netherlands,
Poland, Portugal, Romania, Slovakia, Slovenia, Spain, Sweden, */;

SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 0) AS avg_year_salary,
    ROUND(AVG(salary_hour_avg), 0) AS avg_hour_salary,
    COUNT(*) AS count_with_na,
    COUNT(salary_year_avg) AS count_y_no_na,
    COUNT(salary_hour_avg) AS count_h_no_na
FROM job_postings_fact
WHERE search_location LIKE '%United States'
GROUP BY job_title_short;


SELECT * FROM job_postings_fact
WHERE search_location IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus',
'Czechia', 'Denmar', 'Estonia', 'Finland', 'France', 'Germany', 'Greece',
'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembo', 'Malta',
'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia',
'Spain', 'Sweden');

SELECT DISTINCT(search_location) FROM job_postings_fact
WHERE search_location IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus',
'Czechia', 'Denmar', 'Estonia', 'Finland', 'France', 'Germany', 'Greece',
'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembo', 'Malta',
'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia',
'Spain', 'Sweden')
ORDER BY search_location;

/* Данные по Denmar и Luxembo отсутствуют в будущем убраны из кода*/;

SELECT
    search_location,
    ROUND(AVG(salary_year_avg), 0) AS avg_year_salary,
    ROUND(AVG(salary_hour_avg), 0) AS avg_hour_salary,
    COUNT(*) AS count_with_na,
    COUNT(salary_hour_avg) AS count_h_without_na,
    COUNT(salary_year_avg) AS count_y_without_na
FROM job_postings_fact
WHERE search_location IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus',
'Czechia', 'Estonia', 'Finland', 'France', 'Germany', 'Greece','Hungary',
'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Malta','Netherlands', 'Poland',
'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
GROUP BY search_location
ORDER BY search_location;

SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 0) AS avg_year_salary,
    ROUND(AVG(salary_hour_avg), 0) AS avg_hour_salary,
    COUNT(*) AS count_with_na,
    COUNT(salary_hour_avg) AS count_h_without_na,
    COUNT(salary_year_avg) AS count_y_without_na
FROM job_postings_fact
WHERE search_location IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus',
'Czechia', 'Estonia', 'Finland', 'France', 'Germany', 'Greece','Hungary',
'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Malta','Netherlands', 'Poland',
'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
GROUP BY job_title_short;


SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 0) AS avg_year_salary,
    ROUND(AVG(salary_hour_avg), 0) AS avg_hour_salary,
    COUNT(*) AS count_with_na,
    COUNT(salary_hour_avg) AS count_h_without_na,
    COUNT(salary_year_avg) AS count_y_without_na
FROM job_postings_fact
WHERE job_location LIKE 'Anywhere'
GROUP BY job_title_short;

/*
Создадим отдельную таблицу где:
1) Уберем данные по странам не относящимся к исследованию
2) объединим колонки salary_year_avg и salary_hour_avg в одну оставив только годовую,
колонка будет называться salary_year (в 2023 году было 253 раб дня по 8 часов)
и уберем колонки 
3) Создадим колонку location где будет учитывать местоположение работы
(в нее будет входить USA, EU, Russia и Remote)
4) Удалим колонки salary_year_avg, salary_hour_avg, salary rate, job_location и
 search_location (остается колонка job_country, остальное можно узнать по колонке location)
*/;

CREATE TABLE project LIKE job_postings_fact;

INSERT INTO project
SELECT * FROM job_postings_fact
WHERE
    search_location IN ('Russia', 'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus',
    'Czechia', 'Estonia', 'Finland', 'France', 'Germany', 'Greece','Hungary',
    'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Malta','Netherlands', 'Poland',
    'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
    OR search_location LIKE '%United States'
    OR job_location LIKE 'Anywhere'
;

SELECT * FROM project;

ALTER TABLE project
ADD location VARCHAR(100);

UPDATE project
SET location = 'Russia'
WHERE search_location LIKE 'Russia';

UPDATE project
SET location = 'USA'
WHERE search_location LIKE '%United States%';

UPDATE project
SET location = 'EU'
WHERE search_location IN ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus',
    'Czechia', 'Estonia', 'Finland', 'France', 'Germany', 'Greece','Hungary',
    'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Malta','Netherlands', 'Poland',
    'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
;

UPDATE project
SET location = 'Remote'
WHERE job_location LIKE 'Anywhere';

SELECT
    job_location,
    search_location,
    location
FROM project;


ALTER TABLE project
DROP COLUMN job_location,
DROP COLUMN search_location;


ALTER TABLE project
ADD salary_year DECIMAL(10,0);

UPDATE project
SET salary_year = salary_year_avg
WHERE salary_rate = 'year';

UPDATE project
SET salary_year = (salary_hour_avg * 253*8)
WHERE salary_rate = 'hour';


SELECT
    salary_year,
    salary_year_avg,
    salary_hour_avg
FROM project
WHERE salary_year IS NOT NULL;


ALTER TABLE project
DROP COLUMN salary_year_avg,
DROP COLUMN salary_hour_avg,
DROP COLUMN salary_rate;

SELECT * FROM project
LIMIT 100;

/*Таблица project (модифицированная job_postings_fact)
1) job_id - уникальный номер вакансии
2) company_id - уникальный номер компании
3) job_title_short - короткое наименование вакансии (всего 10 видов)
4) job_title - полное наименование вакансии
5) job_via - сайт размещения вакансии
6) job_schedule_type - тип работы (полный рабочия день, неполный рабочий день, контракт и т.д.)
7) job_work_from_home - работа из дома или нет
8) job_posted_date - дата вакансии
9) job_no_degree_mention - наличие или отсутствие высшего образования
10) job_health_insurance - наличие отсутствие мед страхования
11) job_country - страна (относится к удаленным работам или странам ЕС)
12) location - наименование местоположения разделенное на 4 категории:
- USA все вакансии из США (без удаленной работы);
- EU все вакансии из стран ЕС (без удаленной работы);
- Russia все вакансии из России (без удаленной работы);
- Remote любая удаленная работа (если изначальная страна являлась США, но вакансия удаленная учитывается только в этой категории);
13) salary_year - размер ЗП (только годовые, значения указанные в часах были также пересчитаны в годовые, из-за этого не NULL значений больше)
*/;


/*Найти среднюю ЗП, количество вакансий с указанной ЗП и количество ваканский без указанной ЗП*/;


SELECT
    job_title_short,
    ROUND(AVG(salary_year), 0) AS avg_salary,
    COUNT(*) AS count,
    COUNT(salary_year) AS count_no_na
FROM project
WHERE location LIKE 'USA'
GROUP BY job_title_short;

SELECT
    job_title_short,
    ROUND(AVG(salary_year), 0) AS avg_salary,
    COUNT(*) AS count,
    COUNT(salary_year) AS count_no_na
FROM project
WHERE location LIKE 'EU'
GROUP BY job_title_short;

SELECT
    job_title_short,
    ROUND(AVG(salary_year), 0) AS avg_salary,
    COUNT(*) AS count,
    COUNT(salary_year) AS count_no_na
FROM project
WHERE location LIKE 'Russia'
GROUP BY job_title_short;

SELECT
    job_title_short,
    ROUND(AVG(salary_year), 0) AS avg_salary,
    COUNT(*) AS count,
    COUNT(salary_year) AS count_no_na
FROM project
WHERE location LIKE 'Remote'
GROUP BY job_title_short;

SELECT
    location,
    job_title_short,
    ROUND(AVG(salary_year), 0) AS avg_salary,
    COUNT(*) AS count,
    COUNT(salary_year) AS count_no_na
FROM project
GROUP BY location, job_title_short
ORDER BY location, job_title_short;




