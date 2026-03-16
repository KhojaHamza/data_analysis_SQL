SELECT
company_id,
name AS company_name
FROM
company_dim
WHERE company_id IN (
SELECT
 company_id

FROM
 job_postings_fact

WHERE


job_no_degree_mention = true
ORDER BY
company_id

)
-- Définition d'un CTE (Common Table Expression) appelé company_job_count
WITH company_job_count AS (
    -- Sélection de l'identifiant de l'entreprise et du nombre de jobs
    SELECT
        company_id,         -- identifiant de l'entreprise
        COUNT(*) AS job_count  -- nombre d'offres d'emploi
    FROM
        job_postings_fact   -- table contenant les offres d'emploi
    GROUP BY
        company_id          -- on regroupe par entreprise pour compter
)

-- Requête principale qui utilise le CTE
SELECT
    company_dim.name AS company_name,   -- nom de l'entreprise
    company_job_count.job_count         -- nombre de jobs pour cette entreprise
FROM
    company_dim                          -- table des entreprises
JOIN
    company_job_count                    -- CTE contenant le nombre de jobs
ON
    company_dim.company_id = company_job_count.company_id  -- on relie les tables par company_id
ORDER BY
    job_count DESC;   
