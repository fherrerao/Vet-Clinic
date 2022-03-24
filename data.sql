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

-- MILESTONE 4
INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '23-04-2000'),
  ('Maisy Smith', 26, '17-01-2019'),
  ('Stephanie Mendez', 64, '04-05-1981'),
  ('Jack Karkness', 38, '08-06-2008');

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO
  specializations (species_id, vets_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  );

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO
  specializations (vets_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  );

-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO
  specializations (vets_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  );

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '24-05-2020'
  );

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '22-07-2020'
  );

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Gabumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '02-02-2021'
  );

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '05-01-2020'
  );

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '08-03-2020'
  );

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '14-05-2020'
  );

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Devimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '04-05-2021'
  );

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Charmander'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '24-02-2021'
  );

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '21-12-2019'
  );

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '10-08-2020'
  );

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '07-04-2021'
  );

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Squirtle'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '29-09-2019'
  );

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '03-10-2020'
  );

-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '04-11-2020'
  );

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '24-01-2019'
  );

-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '15-05-2019'
  );

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '27-02-2020'
  );

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '03-08-2020'
  );

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '24-05-2020'
  );

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '11-01-2021'
  );
