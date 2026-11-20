-- 2. (2.5 pts) Créez un index pertinent sur commandes, activez le
-- partitionnement RANGE, et réécrivez la requête de façon SARGable (sans
-- SELECT *).

CREATE INDEX idx_commandes_date_statut ON commandes (statut, date_commande);
INCLUDE (client_id, montant_total);


