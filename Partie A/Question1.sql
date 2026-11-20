-- 1. (2 pts) Exécutez avec EXPLAIN ANALYZE une requête listant les 10 plus
-- grosses commandes LIVREE passées en 2026 en utilisant
-- YEAR(date_commande) = 2026.
-- Identifiez les 2 défauts du plan obtenu

EXPLAIN ANALYZE
SELECT *
FROM commandes
WHERE EXTRACT(YEAR FROM date_commande) = 2026
    AND statut = 'LIVREE'
ORDER BY montant_total DESC
LIMIT 10;

-- Défauts 1 :L'application d'une fonction directement sur la colonne rend le prédicat non-SARGable,
-- ce qui fait qu'on ne peut pas utiliser un index sur la colonne date_commande, entraînant un scan complet de la table.

-- Défauts 2 : L'instruction SELECT * oblige le moteur à effectuer des accès aléatoires vers la table principale pour
-- récupérer toutes les colonnes et alourdit l'étape de tri dans la mémoire vive.
