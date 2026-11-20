-- (2 pts) Dans le simulateur ACID, reproduisez un Non-Repeatable Read sous
-- READ COMMITTED, puis montrez comment REPEATABLE READ le résout.
-- Expliquez le rôle du WAL lors d'une coupure serveur en plein virement

--REPRODUIRE NON-REPITABLE

-- T1 - démarre en READ COMMITTED et lit le solde du premier compte
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT solde FROM comptes_bancaires WHERE id = 1;

-- T2 - en parallèle, débite 1000 € sur le compte 1 et valide
START TRANSACTION;
UPDATE comptes_bancaires SET solde = solde - 1000 WHERE id = 1;
COMMIT;

SELECT solde FROM comptes_bancaires WHERE id = 1;
COMMIT;

-- T1 - démarre en REPEATABLE READ (snapshot MVCC figé au début de T1)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT solde FROM comptes_bancaires WHERE id = 1;

-- T2 -  modifie le compte 1 (-1000 €) et valide
START TRANSACTION;
UPDATE comptes_bancaires SET solde = solde - 1000 WHERE id = 1;
COMMIT;

SELECT solde FROM comptes_bancaires WHERE id = 1;

COMMIT;

-- Role du WAL

-- Le WAL est un journal de secours sur disque où la base note chaque opération avant de modifier les données.
-- Si le serveur coupe en plein virement, la base relit le WAL au redémarrage et annule le débit pour qu'aucun euro ne disparaisse.
-- Si le serveur coupe juste après le COMMIT, le WAL permet de retrouver et conserver le virement validé.