/*
Questions to Answer
What are the top-paying jobs for my role?
What are the skills required for these top-paying roles?
What are the most in-demand skills for my role?
What are the top skills based on salary for my role?
What are the most optimal skills to learn?
a. Optimal: High Demand AND High Paying

Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Scientist positions.
— Focuses on roles with specified salaries.
— Why? It reveals how different skills impact salary levels for Data Scientist and
helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT skills,
       round(avg(salary_year_avg),0) as avg_salary
FROM job_postings_fact postings
INNER JOIN skills_job_dim skills_to_job on skills_to_job.job_id = postings.job_id
INNER JOIN skills_dim skills on skills.skill_id = skills_to_job.skill_id
WHERE postings.job_title_short ='Data Scientist' 
     AND postings.salary_year_avg IS NOT NULL
      AND postings.job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 30;

/*
Here's a breakdown of the top high-paying skills in Data Science.
Insight:
The highest paying data science roles blend regulatory knowledge (GDPR), system-level programming,
modern A1/ML tools, and data pipeline engineering. Skills beyond traditional Python/SQL are becoming
increasingly lucrative.
*/