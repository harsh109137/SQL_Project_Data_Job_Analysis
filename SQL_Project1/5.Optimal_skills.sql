/*
Questions to Answer
What are the top-paying jobs for my role?
What are the skills required for these top-paying roles?
What are the most in-demand skills for my role?
What are the top skills based on salary for my role?
What are the most optimal skills to learn?
a. Optimal: High Demand AND High Paying

Answer: 
What are the most optimal skills to learn (aka it's in high demand and a high—paying skill)?
Identify skills in high demand and associated with high average salaries for Data Scientist roles
Concentrates on remote positions with specified salaries
Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data science.
*/

with skills_demand as (
    SELECT skills.skill_id,
           skills.skills as skills,
           COUNT(skills_to_job.job_id) as demand_count
    FROM job_postings_fact postings
        INNER JOIN skills_job_dim skills_to_job on skills_to_job.job_id = postings.job_id
        INNER JOIN skills_dim skills on skills.skill_id = skills_to_job.skill_id
    WHERE postings.job_title_short ='Data Scientist' AND
          postings.job_work_from_home = TRUE AND
          postings.salary_year_avg IS NOT NULL
    GROUP BY skills.skill_id
    ),  
     average_salary as (
    SELECT skills_to_job.skill_id,
           round(avg(postings.salary_year_avg),0) as avg_salary
    FROM job_postings_fact postings
        INNER JOIN skills_job_dim skills_to_job on skills_to_job.job_id = postings.job_id
        INNER JOIN skills_dim skills on skills.skill_id = skills_to_job.skill_id
    WHERE postings.job_title_short ='Data Scientist' 
        AND postings.salary_year_avg IS NOT NULL
        AND postings.job_work_from_home = TRUE
    GROUP BY skills_to_job.skill_id
    )

SELECT skills_demand.skill_id,
       skills_demand.skills as skill_name,
       demand_count,
       avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY  avg_salary DESC,demand_count DESC
LIMIT 30;


-- This same query but in a  more concise form:
SELECT skills.skill_id,
       skills.skills as skill_name,
       COUNT(skills_to_job.job_id) as demand_count,
       round(avg(postings.salary_year_avg),0) as avg_salary
FROM 
    job_postings_fact postings
INNER JOIN skills_job_dim skills_to_job on skills_to_job.job_id = postings.job_id
INNER JOIN skills_dim skills on skills.skill_id = skills_to_job.skill_id
WHERE 
    postings.job_title_short ='Data Scientist' 
    AND postings.salary_year_avg IS NOT NULL
    AND postings.job_work_from_home = TRUE
GROUP BY 
    skills.skill_id
HAVING 
    COUNT(skills_to_job.job_id) > 10
ORDER BY 
    avg_salary DESC, demand_count DESC
LIMIT 30;    


