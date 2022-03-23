/* Populate database with sample data. */
INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Agumon', '03-02-2020', 0, true, 10.23);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Gabumon', '15-11-2018', 2, true, 8);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Pikachu', '07-01-2021', 1, false, 15.04);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Devimon', '12-05-2017', 5, true, 11);

/*NEW DATA*/
INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Plantmon', '15-11-2021', 2, true, -5.7);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Squirtle', '02-04-1993', 3, false, -12.13);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Angemon', '12-06-2005', 1, true, -45);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Boarmon', '07-06-2005', 7, true, 20.4);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Blossmon', '13-10-1998', 3, true, 17);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Ditto', '14-05-2022', 4, true, 22);

-- MILESTONE 3
-- Insert the following data into the owners table:
INSERT INTO
  owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Modify your inserted animals so it includes the species_id value: If the name ends in "mon" it will be Digimon 
UPDATE
  animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name = 'Digimon'
  )
WHERE
  name LIKE '%mon';

-- All other animals are Pokemon.
UPDATE
  animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name = 'Pokemon'
  )
WHERE
  name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Sam Smith'
  )
WHERE
  name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Jennifer Orwell'
  )
WHERE
  name = 'Gabumon'
  OR name = 'Pikachu';

-- Bob owns Devimon and Plantmon.
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Bob'
  )
WHERE
  name = 'Devimon'
  OR name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Melody Pond'
  )
WHERE
  name = 'Charmander'
  OR name = 'Squirtle'
  OR name = 'Blossmon';

-- Dean Winchester owns Angemon and Boarmon.
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Dean Winchester'
  )
WHERE
  name = 'Angemon'
  OR name = 'Boarmon';
