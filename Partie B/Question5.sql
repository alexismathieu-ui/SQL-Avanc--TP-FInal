-- 5. (2 pts) Rédigez une requête avec CTE + fonction de fenêtrage
-- (DENSE_RANK) affichant pour chaque catégorie les 2 produits les plus
-- chers.

WITH classement AS (
    SELECT
        c.nom AS categorie,
        p.nom AS produit,
        p.prix_unitaire,
        DENSE_RANK() OVER (
            PARTITION BY p.categorie_id
            ORDER BY p.prix_unitaire DESC
        ) AS rang_prix
    FROM produits p
    INNER JOIN categories c ON c.id = p.categorie_id
)
SELECT categorie, produit, prix_unitaire, rang_prix
FROM classement
WHERE rang_prix <= 2
ORDER BY categorie ASC, rang_prix ASC;