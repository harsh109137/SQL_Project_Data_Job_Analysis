/*
Question: What are the top—paying data science jobs?
— Identify the top 10 highest—paying Data Scienctist roles that are available remotely or in India.
— Focuses on job postings with specified salaries (remove nulls) .
- Why? Highlight the top—paying opportunities for Data Scientist, offering insights into the job market.
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    To_char(salary_year_avg,'FM$999,999,999.00') AS yearly_salary,
    job_posted_date,
    com.name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim com on com.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location in ('Anywhere','India') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;