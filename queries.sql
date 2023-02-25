/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK TRANSACTION; 

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL; 
COMMIT TRANSACTION;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK TRANSACTION;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT  delete_birth;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_birth;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT TRANSACTION;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species , MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name FROM animals JOIN owners ON owners_id = owners.id WHERE owners.id = 4;
SELECT animals.name FROM animals JOIN species ON species_id = species.id WHERE species.id = 1;
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON owners_id = owners.id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT animals.name FROM animals JOIN owners ON owners_id = owners.id 
JOIN species ON species_id = species.id WHERE owners.id = 2 AND species.id = 2;
SELECT animals.name FROM animals JOIN owners ON owners_id = owners.id 
WHERE owners.id = 5 AND animals.escape_attempts = 0;
SELECT owners.full_name, COUNT(animals.name) FROM animals 
JOIN owners ON owners_id = owners.id GROUP BY owners.full_name;

-- Queried the last animal to be seen by William Tatcher
SELECT animals.name, visits.date_of_visits FROM visits 
JOIN vets ON visits.vets_id = vets.id
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY date_of_visits DESC LIMIT 1;

-- Queried the number of different animals  Stephanie Mendez saw
SELECT vets.name, COUNT(animals.name) FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- Listed all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM specializations
JOIN species ON specializations.species_id = species.id
RIGHT JOIN vets ON specializations.vets_id = vets.id;

-- Listed all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

-- Queried the animal with the most visits to the vet
SELECT animals.name, COUNT(animals.id) FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
GROUP BY animals.id
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

-- Queried Maisy Smith's first visit
SELECT animals.name, visits.date_of_visits FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visits ASC
LIMIT 1;

-- Queried details for most recent visit: animal information, vet information, and date of visit.
SELECT vets.id, vets.name, vets.age, vets.date_of_graduation,
animals.id, animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
visits.date_of_visits FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
ORDER BY visits.date_of_visits DESC
LIMIT 1;

-- Queried how many visits were with a vet that did not specialize in that animal's species
SELECT COUNT(*)
FROM visits
LEFT JOIN animals ON visits.animals_id = animals.id
LEFT JOIN vets ON visits.vets_id = vets.id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations
	WHERE specializations.vets_id = vets.id
);

-- Queried What specialty should Maisy Smith consider getting
SELECT species.name ,count(*) FROM visits 
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id=vets.id 
JOIN species ON animals.species_id = species.id
WHERE vets.name='Maisy Smith'
GROUP BY species.name;
