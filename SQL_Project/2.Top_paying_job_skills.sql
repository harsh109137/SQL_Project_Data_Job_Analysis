/*Question: What skills are required for the top—paying data scientist jobs?
— Use the top 10 highest-paying Data Scientist jobs
— Add the specific skills required for these roles
— Why? It provides a detailed look at which high—paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries.*/

with top_paying_jobs as 
    (SELECT
        job_id,
        job_title,
        To_char(salary_year_avg,'FM$999,999,999.00') AS yearly_salary,
        com.name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim com on com.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location in ('Anywhere','India') AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10)
SELECT tpj.*,
       skills.skills as skill_name
FROM top_paying_jobs tpj
INNER JOIN skills_job_dim skills_to_job on skills_to_job.job_id = tpj.job_id
INNER JOIN skills_dim skills on skills.skill_id = skills_to_job.skill_id
ORDER BY tpj.yearly_salary DESC
LIMIT 10;

-- Output: This query will return the top 10 highest-paying Data Scientist jobs along with the specific skills required for each role.

/*Top Skills Summary (2023 Data Scientist Roles)
SQL — Most frequently mentioned (3 times); essential for data querying and manipulation.
Python — Highly in-demand (2 times); key for analytics, ML, and automation.
Java — Used in production systems and big data projects.
Tableau — Indicates need for strong data visualization skills.
Cassandra, Spark, Hadoop — Big data technologies mentioned once; valuable in large-scale data
processing.

Insight: SQL and Python are the most required skills, with increasing demand for visualization and big
data tools.*/