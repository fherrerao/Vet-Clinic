/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Agumon', '03-02-2020', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Gabumon', '15-11-2018', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Pikachu', '07-01-2021', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Devimon', '12-05-2017', 5, true, 11);

/*NEW DATA*/
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Plantmon', '15-11-2021', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Squirtle', '02-04-1993', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Angemon', '12-06-2005', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Boarmon', '07-06-2005', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Blossmon', '13-10-1998', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weigth_kg) VALUES ('Ditto', '14-05-2022', 4, true, 22);

/*Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.*/

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;



/*Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.*/

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
SELECT * FROM animals;

/*Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)*/

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
