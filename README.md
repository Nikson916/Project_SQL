# Введение
В этом проекте будет изучен рынок вакансий аналитиков данных. Фокус будет на поиске:
- Самой высокой заработной платы;
- Самых востребованных навыках;
- И пересечении востребываемых навыков и высокой заработной платы.

В вкладке Основной Анализ будет анализироваться вакансия аналитик данных работающих удаленно.

В вкладке Дополнительная Работа будет анализ для других вакансий.

Все запросы SQL можно будет найти в [Project_SQL folder]()

Источник базы данных [Hugging Face/Luke Barousse](https://huggingface.co/datasets/lukebarousse/data_jobs)

# Вопросы

1. Какая наивысшая заработная плата у аналитиков данных работающих удаленно?
2. Какие навыки необходимы для работы аналитиком данных удалённо для получения наибольшой заработной платы?
3. Какие 5 самых востребованных навыков для аналитика данных на удалённой работе?
4. Какие 10 навыков для аналитика данных работающего удаленно приносят наибольшую заработную плату?
5. Какие 25 навыков являются самыми оптимальными для аналитика данных на удалённой работе?

# Инструменты

- MySQL - база данных
- Visual Studio Code - инструмент для программирования
- Excel - визуализация данных

# Основной Анализ

### 1. 10 Самых Высокооплачиваемых Вакансий Среди Аналитиков Данных

Код SQL:

``` sql
SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_schedule_type,
    salary_year
FROM project
LEFT JOIN company_dim ON project.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND location LIKE 'Remote' AND salary_year IS NOT NULL
ORDER BY salary_year DESC
LIMIT 10;
```


![10 Самых Высокооплачиваемых Вакансий Среди Аналитиков Данных](Project_SQL/Query_1/Query_1.png)



### 2. Необходимые Навыки для 10 Самых Высокооплачиваемых Вакансий Аналитиков Данных

Код SQL:

```sql
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
```

![Частота Упоминания Навыков в 10 Самых Высокооплачиваемых Вакансиях Аналитиков Данных](Project_SQL/Query_2/Query_2.png)

На графике указаны навыки появляющиеся 2 и более раз

### 3. 10 Самых Популярных Навыков для Аналитика Данных

Код SQL:

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM project
LEFT JOIN skills_job_dim ON project.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND location = 'Remote'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;
```

![10 Самых Популярных Навыков для Аналитика Данных](Project_SQL/Query_3/Query_3.png)



### 4. 10 Навыков Приносящих Наивысшую Заработную Плату для Аналитика Данных

Код SQL:

```sql
SELECT
    skills,
    ROUND(AVG(project.salary_year), 0) AS avg_salary_for_skill
FROM skills_dim
LEFT JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
LEFT JOIN project ON skills_job_dim.job_id = project.job_id
WHERE job_title_short = 'Data Analyst' AND location = 'Remote' AND project.salary_year IS NOT NULL
GROUP BY skills
ORDER BY avg_salary_for_skill DESC
LIMIT 10;
```

### 5. Самые Оптимальные Навыки для Изучения на Аналитика Данных

Код SQL:

```sql
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
```


# Выводы


# Дополнительная Работа

Больше практики с другими вводными для тренировки в использовании SQL и обучению анализу и подведении выводов из полученных результатов.

# English

## Intro


## Questions


## Tools


## Main Analysis


## Conclusion


## Additional Work
