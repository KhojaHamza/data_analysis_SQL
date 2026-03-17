/*
 Answer: What are the top skills based on salary?
 - Look at the average salary associated with each skill for Data Analyst positions
 - Focuses on roles with specified salaries, regardless of location
 - Why? It reveals how different skills impact salary levels for Data Analysts and
 helps identify the most financially rewarding skills to acquire or improve
 */
SELECT skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
/*
Big Data & Machine Learning skills (like PySpark, Pandas, NumPy, Jupyter) are highly valued and lead to higher salaries because companies need strong data processing and prediction abilities.

Software development and deployment tools (GitLab, Kubernetes, Airflow) are important since they help automate workflows and manage data pipelines efficiently.

Cloud computing knowledge (Databricks, Elasticsearch, GCP) is increasingly important because many data analytics systems now run in cloud environments.
*/