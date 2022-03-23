/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id 	INT	PRIMARY KEY GENERATED ALWAYS AS IDENTITY	NOT NULL,
	name TEXT		NOT NULL,
	date_of_birth 	date,
	escape_attempts	INT,
	neutered		BOOLEAN,
	weigth_kg		DECIMAL
);

ALTER TABLE animals ADD COLUMN species text;
