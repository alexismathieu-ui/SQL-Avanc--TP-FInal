-- 6. (2 pts) Rédigez une requête WITH RECURSIVE affichant tout l'organigramme
-- de employes depuis la CTO (manager_id IS NULL), avec le niveau
-- hiérarchique (niveau) et le chemin complet (chemin).

WITH RECURSIVE organigramme AS (

    SELECT
        id,
        nom,
        poste,
        departement,
        1 AS niveau,
        CAST(nom AS CHAR(1000)) AS chemin
    FROM employes
    WHERE manager_id IS NULL
    UNION ALL

    SELECT
        e.id,
        e.nom,
        e.poste,
        e.departement,
        o.niveau + 1 AS niveau,
        CONCAT(o.chemin, ' > ', e.nom) AS chemin
    FROM employes e
    INNER JOIN organigramme o ON e.manager_id = o.id
    WHERE o.niveau < 20
)
SELECT id, nom, poste, departement, niveau, chemin
FROM organigramme
ORDER BY niveau ASC, id ASC;

