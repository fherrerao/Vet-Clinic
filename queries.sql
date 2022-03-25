/*Queries that provide answers to the questions from all projects.*/
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon%';

SELECT
  *
FROM
  animals
WHERE
  date_of_birth BETWEEN '01-01-2016'
  AND '31-12-2019';

SELECT
  *
FROM
  animals
WHERE
  neutered = true
  AND escape_attempts < 3;

SELECT
  date_of_birth
FROM
  animals
WHERE
  name = 'Agumon'
  OR name = 'Pikachu';

SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weigth_kg > 10.5;

SELECT
  *
FROM
  animals
WHERE
  neutered = true;

SELECT
  *
FROM
  animals
WHERE
  name != 'Gabumon';

SELECT
  *
FROM
  animals
WHERE
  weigth_kg BETWEEN 10.4
  AND 17.3;

/*MILESTONE-2*/
-- Inside a transaction update the animals table by setting the species column to unspecified. 
BEGIN;

UPDATE
  animals
SET
  species = 'unspecified';

-- Verify that change was made. 
SELECT
  *
FROM
  animals;

-- Then roll back the change and verify that species columns went back to the state before transaction.
ROLLBACK;

SELECT
  *
FROM
  animals;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;

UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon%';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species is NULL;

-- Commit the transaction.
COMMIT;

-- Verify that change was made and persists after commit.
SELECT
  *
FROM
  animals;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

DELETE FROM
  animals;

ROLLBACK;

-- After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)
SELECT
  *
FROM
  animals;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
BEGIN;

DELETE FROM
  animals
WHERE
  date_of_birth > '01-01-2022';

-- Create a savepoint for the transaction.
SAVEPOINT SP1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE
  animals
SET
  weigth_kg = weigth_kg * - 1;

-- Rollback to the savepoint
ROLLBACK TO SP1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE
  animals
SET
  weigth_kg = weigth_kg * -1
WHERE
  weigth_kg < 0;

-- Commit transaction
COMMIT;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT
  COUNT(*)
FROM
  animals;

-- How many animals have never tried to escape?
SELECT
  *
FROM
  animals
WHERE
  escape_attempts = 0;

-- What is the average weight of animals?
SELECT
  AVG(weigth_kg)
FROM
  animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
  neutered,
  SUM(escape_attempts)
FROM
  animals
GROUP BY
  neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT
  species,
  MIN(weigth_kg),
  MAX(weigth_kg)
FROM
  animals
GROUP BY
  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '01-01-1990'
  AND '31-12-2000'
GROUP BY
  species;

-- MILESTONE 3
-- What animals belong to Melody Pond?
SELECT
  full_name,
  name
FROM
  animals
  JOIN owners ON animals.owner_id = owners.id
WHERE
  full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
  animals.name,
  species.name
FROM
  animals
  JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
  full_name,
  name
FROM
  animals
  RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT
  s.name,
  COUNT(s.name)
FROM
  animals a
  JOIN species s ON a.species_id = s.id
GROUP BY
  s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
  o.full_name,
  a.name,
  s.name
FROM
  animals a
  JOIN species s ON a.species_id = s.id
  JOIN owners o ON a.owner_id = o.id
WHERE
  s.name = 'Digimon'
  AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
  o.full_name,
  a.name
FROM
  animals a
  JOIN owners o ON a.owner_id = o.id
WHERE
  o.full_name = 'Dean Winchester'
  AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT
  o.full_name,
  COUNT(a.owner_id)
FROM
  animals a
  JOIN owners o ON a.owner_id = o.id
GROUP BY
  o.full_name,
  a.owner_id
ORDER BY
  COUNT(a.owner_id) DESC
LIMIT
  1;

-- MILESTONE 4
-- Who was the last animal seen by William Tatcher?
SELECT
  a.name,
  v.name,
  vi.date_of_visit
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
WHERE
  v.name = 'William Tatcher'
ORDER BY
  vi.date_of_visit DESC
LIMIT
  1;

-- How many different animals did Stephanie Mendez see?
SELECT
  v.name,
  COUNT(DISTINCT a.name)
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
WHERE
  v.name = 'Stephanie Mendez'
GROUP BY
  v.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT
  v.name,
  s.name
FROM
  vets v
  LEFT JOIN specializations sp ON v.id = sp.vets_id
  LEFT JOIN species s ON s.id = sp.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  v.name,
  a.name,
  vi.date_of_visit
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
WHERE
  v.name = 'Stephanie Mendez'
  AND vi.date_of_visit BETWEEN '01-04-2020'
  AND '30-08-2020';

-- What animal has the most visits to vets?
SELECT
  a.name,
  COUNT(a.name)
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
GROUP BY
  a.name
ORDER BY
  COUNT(a.name) DESC
LIMIT
  1;

-- Who was Maisy Smith's first visit?
SELECT
  a.name,
  v.name,
  vi.date_of_visit
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
WHERE
  v.name = 'Maisy Smith'
ORDER BY
  vi.date_of_visit
LIMIT
  1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  a.name,
  v.name,
  vi.date_of_visit
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
ORDER BY
  vi.date_of_visit DESC
LIMIT
  1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(*)
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
  JOIN specializations sp ON sp.vets_id = v.id
  JOIN species s ON s.id = sp.species_id
WHERE
  a.species_id <> sp.species_id;

-- What specialty should Maisy Smith consider getting ? Look for the species she gets the most.
SELECT
  s.name,
  COUNT(s.name)
FROM
  animals a
  JOIN visits vi ON a.id = vi.animals_id
  JOIN vets v ON v.id = vi.vets_id
  JOIN species s ON s.id = a.species_id
WHERE
  v.name = 'Maisy Smith'
GROUP BY
  s.name
ORDER BY
  COUNT(s.name) DESC
LIMIT
  1;
