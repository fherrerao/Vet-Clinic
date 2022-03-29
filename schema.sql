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

-- MILESTONE 4
-- Create a table named vets 
CREATE TABLE vets (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	name VARCHAR(255),
	age INT,
	date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
	species_id INT,
	vets_id INT,
	FOREIGN KEY(species_id) REFERENCES species(id),
	FOREIGN KEY(vets_id) REFERENCES vets(id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits (
	animals_id INT,
	vets_id INT,
	date_of_visit DATE,
	FOREIGN KEY(animals_id) REFERENCES animals(id),
	FOREIGN KEY(vets_id) REFERENCES vets(id)
);

-- DATABASE PERFORMANCE AUDIT
-- SELECT COUNT(*) FROM visits where animal_id = 4;
-- SELECT * FROM visits where vet_id = 2;
-- SELECT * FROM owners where email = 'owner_18327@mail.com';
-- Find a way to decrease the execution time of the first query. Look for hints in the previous lessons.
CREATE INDEX visits_animals_id ON visits(animals_id);

-- Find a way to improve execution time of the other two queries.
CREATE INDEX visits_vets_id ON visits(vets_id);
