-- CTE pour compter les compétences les plus demandées pour les jobs "Data Analyst" à distance
WITH remote_job_skills AS (
    SELECT
        skills_to_job.skill_id,          -- identifiant de la compétence
        COUNT(*) AS skill_count          -- nombre de fois où cette compétence apparaît
    FROM
        skills_job_dim AS skills_to_job  -- table qui relie compétences et jobs
    INNER JOIN 
        job_postings_fact AS job_postings  -- table des offres d'emploi
    ON 
        job_postings.job_id = skills_to_job.job_id  -- relie jobs et compétences
    WHERE
        job_postings.job_work_from_home = TRUE   -- filtre les jobs à distance
        AND job_postings.job_title_short = 'Data Engineer'  -- filtre le titre Data Analyst
    GROUP BY
        skills_to_job.skill_id               -- regroupe par compétence pour compter
)

-- Requête principale pour récupérer le nom des compétences et leur nombre
SELECT
    skills.skill_id,                      -- identifiant de la compétence
    skills AS skill_name ,      -- nom de la compétence
    remote_job_skills.skill_count         -- nombre de fois que la compétence apparaît
FROM
    remote_job_skills                     -- CTE créé ci-dessus
INNER JOIN 
    skills_dim AS skills                  -- table des compétences pour obtenir le nom
ON 
    skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
    LIMIT 7;                      -- tri par popularité de la compétence                                  -- limite aux 5 compétences les plus demandées
