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
  full_name varchar(200),
  age INT
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name varchar(200)
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
