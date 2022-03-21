/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (    
	id 	INT 		NOT NULL,
	name TEXT		NOT NULL,
	date_of_birth 	date,
	escape_attempts	INT,
	neutered			BOOLEAN,
	weigth_kg		DECIMAL
);
