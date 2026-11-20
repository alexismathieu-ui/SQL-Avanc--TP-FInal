-- 2. (2.5 pts) Créez un index pertinent sur commandes, activez le
-- partitionnement RANGE, et réécrivez la requête de façon SARGable (sans
-- SELECT *).

DROP INDEX idx_commandes_statut_date ON commandes;

CREATE INDEX idx_commandes_statut_date
ON commandes (statut, date_commande, montant_total, client_id);

ALTER TABLE commandes DROP FOREIGN KEY fk_commandes_client;
ALTER TABLE commandes DROP PRIMARY KEY, ADD PRIMARY KEY (id, date_commande);

ALTER TABLE commandes
PARTITION BY RANGE (YEAR(date_commande)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027)
);

EXPLAIN ANALYZE
SELECT id, client_id, date_commande, montant_total, statut
FROM commandes
WHERE statut = 'LIVREE'
    AND date_commande >= '2026-01-01' AND date_commande < '2027-01-01'
ORDER BY montant_total DESC
LIMIT 10;
