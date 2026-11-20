-- 4. (2 pts) On vous soumet une table brute affectations_brutes(employe_id,
-- employe_nom, dept_nom, projets_liste, chef_projet, chef_projet_tel).
-- Passez-la en 3FN en explicitant les dépendances fonctionnelles et les clés
-- primaires/étrangères.

-- Dépendances fonctionnelles :
--   employe_id      -> employe_nom, dept_id
--   dept_id         -> dept_nom
--   projet_id       -> projet_nom, chefs_projet_id
--   chefs_projet_id -> chefs_projet_nom, chefs_projet_tel
--
-- Passage en 3FN :
-- 1FN : On supprime projets_liste pour créer la table affectations.
-- 2FN : On sépare employes et projets pour que chaque colonne dépende de toute la clé primaire.
-- 3FN : On isole departements et chefs_projets pour supprimer les dépendances transitives.






























-- Partie SQL (un peu la flemme de perdre tout mon code SQL) :

-- CREATE TABLE departements (
--     dept_id INT PRIMARY KEY,
--     dept_nom VARCHAR(100) NOT NULL UNIQUE
-- );

-- CREATE TABLE employes_3fn (
--     employe_id INT PRIMARY KEY,
--     employe_nom VARCHAR(100) NOT NULL,
--     dept_id INT NOT NULL,
--     FOREIGN KEY (dept_id) REFERENCES departements(dept_id)
-- );

-- CREATE TABLE chefs_projets (
--     chefs_projet_id INT PRIMARY KEY,
--     chefs_projet_nom VARCHAR(100) NOT NULL UNIQUE,
--     chefs_projet_tel VARCHAR(20) NOT NULL
-- );

-- CREATE TABLE projets (
--     projet_id INT PRIMARY KEY,
--     projet_nom VARCHAR(100) NOT NULL UNIQUE,
--     chef_projet_id INT NOT NULL,
--     FOREIGN KEY (chef_projet_id) REFERENCES chefs_projets(chefs_projet_id)
-- );

-- CREATE TABLE affectations (
--     employe_id INT NOT NULL,
--     projet_id INT NOT NULL,
--     PRIMARY KEY (employe_id, projet_id),
--     FOREIGN KEY (employe_id) REFERENCES employes_3fn(employe_id),
--     FOREIGN KEY (projet_id) REFERENCES projets(projet_id)
-- );