drop table if exists Human CASCADE;
drop table if exists House CASCADE;
drop table if exists House_type CASCADE;
drop table if exists Family CASCADE;
drop table if exists Furnitures_house CASCADE;
drop table if exists Furniture_types CASCADE;
drop table if exists Plumbob CASCADE;
drop table if exists Vechile CASCADE;
drop table if exists Clothes CASCADE;
drop table if exists Clothes_type CASCADE;
drop table if exists Garage CASCADE;
drop table if exists Street CASCADE;
drop table if exists Grocery_store CASCADE;
drop table if exists Food CASCADE;
drop table if exists Job CASCADE;
drop table if exists Engine_type CASCADE;
drop table if exists Color CASCADE;
drop table if exists Genders CASCADE;
drop table if exists Breed CASCADE;
drop table if exists Hunger CASCADE;
drop table if exists Relationship CASCADE;
drop table if exists Relationship_type CASCADE;

DROP TRIGGER IF EXISTS check_owner_age_trigger ON Vechile;
DROP TRIGGER IF EXISTS check_pet_age_trigger ON Pet;