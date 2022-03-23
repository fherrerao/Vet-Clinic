/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	name TEXT NOT NULL,
	date_of_birth date,
	escape_attempts INT,
	neutered BOOLEAN,
	weigth_kg DECIMAL
);

ALTER TABLE
	animals
ADD
	COLUMN species text;

-- MULTI TABLES
-- Create a table named owners.
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
	full_name VARCHAR(255),
	age INT
);

-- Create a table named species.
CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
	name VARCHAR(255)
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE
	animals
ADD
	PRIMARY KEY(id);

ALTER TABLE
	animals
ALTER COLUMN
ADD
	GENERATED ALWAYS AS IDENTITY;

\ d animals -- Remove column species
ALTER TABLE
	animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE
	animals
ADD
	COLUMN species_id INT;

ALTER TABLE
	animals
ADD
	CONSTRAINT species_id FOREIGN KEY(species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE
	animals
ADD
	COLUMN owner_id INT;

ALTER TABLE
	animals
ADD
	CONSTRAINT owner_id FOREIGN KEY(owner_id) REFERENCES owners(id);
