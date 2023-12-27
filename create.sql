CREATE TABLE IF NOT EXISTS Human (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	gender_id INT NOT NULL,
    age INT NOT NULL CHECK (age >= 0),
	job_id INT,
	money INT NOT NULL CHECK (money >= 0),
    family_id INT NOT NULL,
	plumbob_id INT NOT NULL,
	hunger_id INT NOT NULL,
	x_coordinate INT NOT NULL CHECK (x_coordinate >= 0 AND x_coordinate <= 500),
	y_coordinate INT NOT NULL CHECK (y_coordinate >= 0 AND y_coordinate <= 500)
);

CREATE TABLE IF NOT EXISTS Pet (
    ID SERIAL PRIMARY KEY,
    gender_id INT NOT NULL,
	age INT NOT NULL,
    breed_id INT NOT NULL,
    plumbob_id INT NOT NULL,
	x_coordinate INT NOT NULL CHECK (x_coordinate >= 0 AND x_coordinate <= 500),
	y_coordinate INT NOT NULL CHECK (y_coordinate >= 0 AND y_coordinate <= 500)
);

CREATE TABLE IF NOT EXISTS House_type (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS House (
    ID SERIAL PRIMARY KEY,
    type_id INT NOT NULL,
	address_id INT NOT NULL,
	floor_number INT NOT NULL,
	room_number INT NOT NULL,
	x_coordinate INT NOT NULL CHECK (x_coordinate >= 0 AND x_coordinate <= 500),
	y_coordinate INT NOT NULL CHECK (y_coordinate >= 0 AND y_coordinate <= 500),
	length INT NOT NULL,
    width INT NOT NULL
);

-- Таблица "семьи"
CREATE TABLE IF NOT EXISTS Family (
    ID SERIAL PRIMARY KEY,
    living_house_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Furnitures_house (
    ID SERIAL PRIMARY KEY,
    house_id INT NOT NULL,
	furniture_type_id INT NOT NULL,
	floor INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Furniture_types (
    ID SERIAL PRIMARY KEY,
	furniture_type VARCHAR(50) NOT NULL,
	price INT NOT NULL CHECK (price >= 0)
);

CREATE TABLE IF NOT EXISTS Plumbob (
    ID SERIAL PRIMARY KEY,
	color_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Vehicle (
    ID SERIAL PRIMARY KEY,
	type VARCHAR(50) NOT NULL,
	model VARCHAR(50) NOT NULL,
	size VARCHAR(50) NOT NULL,
	owner_id INT NOT NULL,
	engine_type_id INT NOT NULL,
	color_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Clothes (
    ID SERIAL PRIMARY KEY,
    type_id INT NOT NULL,
	model VARCHAR(50) NOT NULL,
	size VARCHAR(50) NOT NULL,
	owner_id INT NOT NULL,
	color_id INT NOT NULL	
);

CREATE TABLE IF NOT EXISTS Clothes_type (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL	
);

CREATE TABLE IF NOT EXISTS Garage (
    ID SERIAL PRIMARY KEY,
    size INT NOT NULL,
	stored_vehicle_id INT NOT NULL,
	house_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Street (
    ID SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Grocery_store (
    ID SERIAL PRIMARY KEY,
    food_id INT NOT NULL,
	count INT NOT NULL,
	price INT NOT NULL CHECK (price >= 0),
	address_id INT NOT NULL,
	x_coordinate INT NOT NULL CHECK (x_coordinate >= 0 AND x_coordinate <= 500),
	y_coordinate INT NOT NULL CHECK (y_coordinate >= 0 AND y_coordinate <= 500),
	length INT NOT NULL,
    width INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Food (
    ID SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Job (
    ID SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	salary INT NOT NULL CHECK (salary >= 0)
);

CREATE TABLE IF NOT EXISTS Color
    (
        ID SERIAL PRIMARY KEY,
        name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Engine_type
    (
        ID SERIAL PRIMARY KEY,
        name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Genders
    (
        ID SERIAL PRIMARY KEY,
        name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Breed
    (
        ID SERIAL PRIMARY KEY,
        name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Hunger (
    ID SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Relationship (
    ID SERIAL PRIMARY KEY,
	human1_id INT NOT NULL,
	human2_id INT NOT NULL,
	relationship_type_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Relationship_type
    (
        ID SERIAL PRIMARY KEY,
        name VARCHAR(32) NOT NULL UNIQUE
);



-- Создание внешних ключей
--ALTER TABLE Human
--ADD CONSTRAINT fk_gender_id
--FOREIGN KEY (gender_id) REFERENCES Genders(ID);



-- Создание внешнего ключа
ALTER TABLE Human
ADD CONSTRAINT gender_id
FOREIGN KEY (gender_id) REFERENCES Genders(ID),
ADD CONSTRAINT job_id
FOREIGN KEY (job_id) REFERENCES Job(ID),
ADD CONSTRAINT family_id
FOREIGN KEY (family_id) REFERENCES Family(ID),
ADD CONSTRAINT plumbob_id
FOREIGN KEY (plumbob_id) REFERENCES Plumbob(ID),
ADD CONSTRAINT hunger_id
FOREIGN KEY (hunger_id) REFERENCES Hunger(ID);

ALTER TABLE Pet
ADD CONSTRAINT gender_id
FOREIGN KEY (gender_id) REFERENCES Genders(ID),
ADD CONSTRAINT plumbob_id
FOREIGN KEY (plumbob_id) REFERENCES Plumbob(ID),
ADD CONSTRAINT breed_id
FOREIGN KEY (breed_id) REFERENCES Breed(ID);


ALTER TABLE House
ADD CONSTRAINT type_id
FOREIGN KEY (type_id) REFERENCES House_type(ID),
ADD CONSTRAINT address_id
FOREIGN KEY (address_id) REFERENCES Street(ID);

ALTER TABLE Family
ADD CONSTRAINT living_house_id
FOREIGN KEY (living_house_id) REFERENCES House(ID);

ALTER TABLE Furnitures_house
ADD CONSTRAINT house_id
FOREIGN KEY (house_id) REFERENCES House(ID),
ADD CONSTRAINT furniture_type_id
FOREIGN KEY (furniture_type_id) REFERENCES Furniture_types(ID);

ALTER TABLE Vehicle
ADD CONSTRAINT owner_id
FOREIGN KEY (owner_id) REFERENCES Human(ID),
ADD CONSTRAINT engine_type_id
FOREIGN KEY (engine_type_id) REFERENCES Engine_type(ID),
ADD CONSTRAINT color_id
FOREIGN KEY (color_id) REFERENCES Color(ID);

ALTER TABLE Clothes
ADD CONSTRAINT type_id
FOREIGN KEY (type_id) REFERENCES Clothes_type(ID),
ADD CONSTRAINT color_id
FOREIGN KEY (color_id) REFERENCES Color(ID),
ADD CONSTRAINT owner_id
FOREIGN KEY (owner_id) REFERENCES Human(ID);

ALTER TABLE Garage
ADD CONSTRAINT stored_vehicle_id
FOREIGN KEY (stored_vehicle_id) REFERENCES Vehicle(ID),
ADD CONSTRAINT house_id
FOREIGN KEY (house_id) REFERENCES House(ID);

ALTER TABLE Grocery_store
ADD CONSTRAINT address_id
FOREIGN KEY (address_id) REFERENCES Street(ID);

ALTER TABLE Relationship
ADD CONSTRAINT human1_id
FOREIGN KEY (human1_id) REFERENCES Human(ID),
ADD CONSTRAINT human2_id
FOREIGN KEY (human2_id) REFERENCES Human(ID),
ADD CONSTRAINT relationship_type_id
FOREIGN KEY (relationship_type_id) REFERENCES Relationship_type(ID);