-- 3. (2.5 pts) Créez une vue matérialisée mv_synthese_segments calculant le
-- nombre de commandes et le CA total par segment client.
-- Insérez une nouvelle commande test, constatez que la vue est marquée
-- obsolète (stale), puis rafraîchissez-la et vérifiez la mise à jour.


-- Eviter l'erreur "Table 'mv_synthese_segments' already exists"
DROP TABLE IF EXISTS mv_synthese_segments;


CREATE TABLE mv_synthese_segments AS
SELECT c.segment, COUNT(cmd.id) AS nb_commandes, ROUND(SUM(cmd.montant_total), 2) AS ca_total
FROM clients c
JOIN commandes cmd ON cmd.client_id = c.id
GROUP BY c.segment;

INSERT INTO commandes (client_id, date_commande, montant_total, statut)
VALUES (1, '2026-11-20 11:00:00', 5000.00, 'LIVREE');

SELECT segment, nb_commandes, ca_total FROM mv_synthese_segments;

DROP TABLE mv_synthese_segments;

CREATE TABLE mv_synthese_segments AS
SELECT c.segment, COUNT(cmd.id) AS nb_commandes, ROUND(SUM(cmd.montant_total), 2) AS ca_total
FROM clients c
JOIN commandes cmd ON cmd.client_id = c.id
GROUP BY c.segment;

SELECT segment, nb_commandes, ca_total FROM mv_synthese_segments;