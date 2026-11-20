-- 7. (2 pts) Expliquez le piège de la requête SELECT id, nom FROM employes
-- WHERE id NOT IN (SELECT manager_id FROM employes); et proposez une
-- correction fiable face aux valeurs NULL.

-- Explication :
-- La requête du SELECT contient NULL car la valeur manager_id de Claire est NULL,
-- donc comparer un id avec NULL donne toujours "UNKNOWN" donc un FALSE et comme WHERE ne 
-- garde que ce qui est VRAI, la requête rejette tout et renvoie 0 ligne.

SELECT e.id, e.nom
FROM employes e
WHERE NOT EXISTS (
    SELECT 1
    FROM employes sub
    WHERE sub.manager_id = e.id
);

