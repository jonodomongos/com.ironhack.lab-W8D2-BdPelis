-- Creamos una BD
CREATE DATABASE IF NOT EXISTS peliculas
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;

USE peliculas;
DROP TABLE IF EXISTS peliculas;

-- Creaamos la tabla PELICULAS
CREATE TABLE peliculas (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  titulo        VARCHAR(150) NOT NULL,
  protagonista  VARCHAR(120) NOT NULL,
  ano           SMALLINT NOT NULL,
  genero        VARCHAR(40) NOT NULL,
  recaudacion   DECIMAL(14,2) NULL
) ENGINE=InnoDB;

-- Añadimos películas
INSERT INTO peliculas (titulo, protagonista, ano, genero, recaudacion) VALUES
('The Dark Knight',              'Christian Bale',   2008, 'Acción',      1005934033.00),
('Inception',                    'Leonardo DiCaprio',2010, 'Ciencia Ficción',  836848102.00),
('Interstellar',                 'Matthew McConaughey',2014, 'Ciencia Ficción', 701729206.00),
('Titanic',                      'Leonardo DiCaprio',1997, 'Romance',     2264740544.00),
('Avatar',                       'Sam Worthington',  2009, 'Ciencia Ficción', 2923706026.00),
('Parasite',                     'Song Kang-ho',     2019, 'Drama',       263000000.00),
('La La Land',                   'Ryan Gosling',     2016, 'Musical',     471100000.00),
('Gladiator',                    'Russell Crowe',    2000, 'Acción',      460583960.00),
('The Godfather',                'Al Pacino',        1972, 'Crimen',      250000000.00),
('The Shawshank Redemption',     'Tim Robbins',      1994, 'Drama',       58300000.00),
('Mad Max: Fury Road',           'Tom Hardy',        2015, 'Acción',      380400000.00),
('Spider-Man: No Way Home',      'Tom Holland',      2021, 'Acción',      1921000000.00);

-- INSERT/UPDATE/DELETE
-- INSERT (añadir una película)
INSERT INTO peliculas (titulo, protagonista, ano, genero, recaudacion)
VALUES ('Oppenheimer', 'Cillian Murphy', 2023, 'Drama', 957000000.00);

-- UPDATE (corregir el protagonista)
UPDATE peliculas
SET protagonista = 'Robert Downey Jr.'
WHERE titulo = 'Oppenheimer';

-- DELETE (borrar un registro)
DELETE FROM peliculas
WHERE titulo = 'Oppenheimer';

-- SELECT (listado general)
SELECT * FROM peliculas;


-- CONSULTAS:
-- 1. Ver solo titulo y año
SELECT titulo AS Título, ano AS Año
FROM peliculas;

-- 2. Todas las películas producidas a partir del año X
SELECT titulo AS Título, ano AS Año, genero AS Género
FROM peliculas
WHERE ano >= 2010
ORDER BY ano ASC, titulo ASC;

-- Mismo filtro pero en orden descendente
SELECT titulo AS Título, ano AS Año, genero AS Género
FROM peliculas
WHERE ano >= 2010
ORDER BY ano DESC, titulo ASC;

-- 3. Ordenar por título
SELECT id, titulo AS Título, protagonista AS Protagonista, ano AS Año, genero AS Género, recaudacion AS RecaudaciónUSD
FROM peliculas
ORDER BY titulo ASC;

-- 4. Agrupar por género
SELECT genero AS Género,
       COUNT(*) AS Cantidad_Películas,
       ROUND(SUM(COALESCE(recaudacion,0)), 2) AS Recaudación_Total
FROM peliculas
GROUP BY genero
ORDER BY Recaudación_Total DESC;

-- 5. Peliculas con recaudación menor que X
SELECT titulo AS Título, genero AS Género, recaudacion AS RecaudaciónEUR
FROM peliculas
WHERE recaudacion < 400000000.00
ORDER BY recaudacion ASC;

-- 6. Películas entre un año y otro
SELECT titulo AS Título, ano AS Año, genero AS Género
FROM peliculas
WHERE ano BETWEEN 2000 AND 2015
ORDER BY ano, titulo;

-- 7. Peliculas totales
SELECT COUNT(*) AS Total_Películas
FROM peliculas;

-- 8. Suma de todas las recaudaciones
SELECT ROUND(SUM(COALESCE(recaudacion,0)), 2) AS Recaudación_Total_EUR
FROM peliculas;

-- 9. Media de las recaudaciones
SELECT ROUND(AVG(COALESCE(recaudacion,0)), 2) AS Recaudación_Media_EUR
FROM peliculas;