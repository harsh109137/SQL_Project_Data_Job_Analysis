/*
Question: What are the most in—demand skills for data scientist?
— Join job postings to inner join table to query 2.
- Identify the top 5 in-demand skills for a data scientist.
- Focus on all job postings.
— Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/
SELECT skills,
       COUNT(skills_to_job.job_id) as demand_count
FROM job_postings_fact postings
INNER JOIN skills_job_dim skills_to_job on skills_to_job.job_id = postings.job_id
INNER JOIN skills_dim skills on skills.skill_id = skills_to_job.skill_id
WHERE postings.job_title_short ='Data Scientist' AND
      postings.job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;