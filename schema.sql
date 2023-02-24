/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
  name  VARCHAR(70),
  date_of_birth DATE,
  escape_attempts INT,
  neutered  BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals ADD species varchar(200);

CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(200),
  age INT
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(200)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals  
ADD CONSTRAINT fk_animals
FOREIGN KEY(species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals ADD COLUMN owners_id INT;
ALTER TABLE animals  
ADD CONSTRAINT fk_owners
FOREIGN KEY(owners_id)
REFERENCES owners(id)
ON DELETE CASCADE;

-- Create a table named vets
CREATE TABLE vets (
 id SERIAL PRIMARY KEY,
 name VARCHAR(200),
 age INT,
 date_of_graduation DATE
);

-- Create a joining between species and vet 
CREATE TABLE specializations (
  species_id INT NOT NULL,
  vets_id INT NOT NULL,
  PRIMARY KEY(species_id, vets_id),
  CONSTRAINT fk_species
   FOREIGN KEY(species_id)
    REFERENCES species(id)
     ON UPDATE CASCADE,
  CONSTRAINT fk_vets
   FOREIGN KEY(vets_id)
    REFERENCES vets(id)
     ON UPDATE CASCADE
);

-- Joining a joining between animals and vets
CREATE TABLE visits (
  animals_id INT NOT NULL,
  vets_id INT NOT NULL,
  date_of_visits DATE,
  PRIMARY KEY(animals_id, vets_id, date_of_visits),
  CONSTRAINT fk_animals
   FOREIGN KEY(animals_id)
    REFERENCES animals(id)
     ON UPDATE CASCADE,
  CONSTRAINT fk_vets
   FOREIGN KEY(vets_id)
    REFERENCES vets(id)
     ON UPDATE CASCADE
);