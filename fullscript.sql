drop table if exists Human CASCADE;
drop table if exists Pet CASCADE;
drop table if exists House CASCADE;
drop table if exists House_type CASCADE;
drop table if exists Family CASCADE;
drop table if exists Furnitures_house CASCADE;
drop table if exists Furniture_types CASCADE;
drop table if exists Plumbob CASCADE;
drop table if exists Vehicle CASCADE;
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


DROP TRIGGER IF EXISTS check_owner_age_trigger ON Vehicle;
DROP TRIGGER IF EXISTS check_pet_age_trigger ON Pet;
DROP PROCEDURE IF EXISTS change_job(INT, INT);


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
	floor INT NOT NULL CHECK (floor >= 0)
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
	length INT NOT NULL CHECK (length > 0),
    width INT NOT NULL CHECK (length > 0)
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



-- Триггеры
--1) Проверка возраста владельца авто
CREATE OR REPLACE FUNCTION check_owner_age_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.type = 'Car' AND (SELECT age FROM Human WHERE ID = NEW.owner_id) < 18 THEN
        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_owner_age_trigger
BEFORE INSERT ON Vehicle
FOR EACH ROW
EXECUTE FUNCTION check_owner_age_trigger();


CREATE OR REPLACE FUNCTION check_human_age_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.age < 0 THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_human_age_trigger
BEFORE INSERT OR UPDATE ON Human
FOR EACH ROW
EXECUTE FUNCTION check_human_age_trigger();


--2)Проверка возраста питомца
CREATE OR REPLACE FUNCTION check_pet_age_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.age < 0 THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_pet_age_trigger
BEFORE INSERT OR UPDATE ON Pet
FOR EACH ROW
EXECUTE FUNCTION check_pet_age_trigger();

--3) размеры дома неотрицательны
CREATE OR REPLACE FUNCTION prevent_negative_house_dimensions_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.length < 0 OR NEW.width < 0 THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_negative_house_dimensions_trigger
BEFORE INSERT OR UPDATE ON House
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_house_dimensions_function();

--4) триггер для проверки пола
CREATE OR REPLACE FUNCTION check_valid_gender_function()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.name NOT IN ('Male', 'Female') THEN
        RAISE EXCEPTION 'Недопустимый пол';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_valid_gender_trigger
BEFORE INSERT OR UPDATE ON Genders
FOR EACH ROW
EXECUTE FUNCTION check_valid_gender_function();

--5)Триггер для проверки, что количество продуктов в магазине неотрицательное
CREATE OR REPLACE FUNCTION check_non_negative_grocery_count()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверка, что количество продуктов в магазине неотрицательное
    IF NEW.count < 0 THEN
        RAISE EXCEPTION 'Количество продуктов в магазине не может быть отрицательным.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_non_negative_grocery_count_trigger
BEFORE INSERT ON Grocery_store
FOR EACH ROW
EXECUTE FUNCTION check_non_negative_grocery_count();

--6)Триггер для проверки, что зарплата человека больше МРОТ:
CREATE OR REPLACE FUNCTION check_non_negative_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary < 16242 THEN
        RAISE EXCEPTION 'Зарплата человека не может быть меньше МРОТ';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--7)Триггер для проверки, что размер гаража неотрицательный
CREATE OR REPLACE FUNCTION check_non_negative_garage_size()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверка, что размер гаража неотрицательный
    IF NEW.size < 0 THEN
        RAISE EXCEPTION 'Размер гаража не может быть отрицательным.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_non_negative_garage_size_trigger
BEFORE INSERT ON Garage
FOR EACH ROW
EXECUTE FUNCTION check_non_negative_garage_size();


--Процедуры и функции
--1) Процедура смены работы
CREATE OR REPLACE PROCEDURE change_job(IN human_id INT, IN new_job_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Обновляем информацию о работе у человека
    UPDATE Human
    SET job_id = new_job_id
    WHERE ID = human_id;

    -- Выводим сообщение об успешном изменении работы
    RAISE NOTICE 'Job changed successfully for Human with ID %', human_id;
END;
$$;

--2) Процедура покупки мебели
CREATE OR REPLACE PROCEDURE buy_furniture_by_ids(
    IN furniture_id INT,
    IN human_id INT
)
AS $$
DECLARE
    furniture_price INT;
BEGIN
    -- Получаем цену мебели по её айди
    SELECT price INTO furniture_price
    FROM Furniture_types
    WHERE ID = furniture_id;

    -- Проверка наличия средств у человека для покупки мебели
    IF furniture_price IS NOT NULL AND furniture_price <= (SELECT money FROM Human WHERE ID = human_id) THEN
        -- Выполнение операции покупки мебели
        INSERT INTO Furnitures_house (house_id, furniture_type_id, floor)
        VALUES (
            (SELECT living_house_id FROM Family WHERE ID = (SELECT family_id FROM Human WHERE ID = human_id)),
            furniture_id, 1
        );

        -- Уменьшение средств у человека
        UPDATE Human
        SET money = money - furniture_price
        WHERE ID = human_id;
    END IF;
END;
$$ LANGUAGE plpgsql;


--3) Процедура создания родственных связей
CREATE OR REPLACE PROCEDURE create_relationship(
    IN human1_id INT,
    IN human2_id INT,
    IN relationship_type_id INT
)
AS $$
BEGIN
    INSERT INTO Relationship (human1_id, human2_id, relationship_type_id)
    VALUES (human1_id, human2_id, relationship_type_id);
END;
$$ LANGUAGE plpgsql;

-- 4) Функция для подсчет общей суммы денег семьи
CREATE OR REPLACE FUNCTION calculate_family_money(
    p_family_id INT
)
RETURNS INT AS $$
DECLARE
    total_money INT;
BEGIN
    SELECT SUM(money) INTO total_money FROM Human WHERE family_id = p_family_id;
    RETURN COALESCE(total_money, 0);
END;
$$ LANGUAGE plpgsql;



-- 5) Функция для смена цвета машины
CREATE OR REPLACE FUNCTION change_car_color(car_id INT, new_color_id INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Vehicle SET color_id = new_color_id WHERE ID = car_id;
END;
$$ LANGUAGE plpgsql;

-- 6) Функция для получение членов семьи
CREATE OR REPLACE FUNCTION get_family_members(
    p_family_id INT
)
RETURNS TABLE (
    member_name VARCHAR(50),
    member_surname VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY SELECT name, surname FROM Human WHERE family_id = p_family_id;
END;
$$ LANGUAGE plpgsql;

--7)Функция для обновления местоположения человека
CREATE OR REPLACE FUNCTION update_human_location(
    p_human_id INT,
    p_x_coordinate INT,
    p_y_coordinate INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE Human SET x_coordinate = p_x_coordinate, y_coordinate = p_y_coordinate WHERE ID = p_human_id;
END;
$$ LANGUAGE plpgsql;


--8) Функция проверки нахождения человека в доме

CREATE OR REPLACE FUNCTION is_person_at_home(
    p_human_id INT
)
RETURNS BOOLEAN AS $$
DECLARE
    at_home BOOLEAN;
BEGIN
    -- Проверяем, находится ли человек в своем доме
    SELECT CASE
               WHEN p.x_coordinate >= h.x_coordinate - h.width / 2 AND
                    p.x_coordinate <= h.x_coordinate + h.width / 2 AND
                    p.y_coordinate >= h.y_coordinate - h.length / 2 AND
                    p.y_coordinate <= h.y_coordinate + h.length / 2
               THEN TRUE
               ELSE FALSE
           END
    INTO at_home
    FROM Human p
    JOIN Family f ON p.family_id = f.ID
    JOIN House h ON f.living_house_id = h.ID
    WHERE p.ID = p_human_id;

    RETURN at_home;
END;
$$ LANGUAGE plpgsql;

-- Удаление данных

DELETE FROM Relationship;
DELETE FROM Garage;
DELETE FROM Clothes;
DELETE FROM Vehicle;
DELETE FROM Human;
DELETE FROM Family;
DELETE FROM Grocery_store;
DELETE FROM Plumbob;
DELETE FROM Furnitures_house;
DELETE FROM Furniture_types;
DELETE FROM House;
DELETE FROM Street;
DELETE FROM Job;
DELETE FROM Food;
DELETE FROM Clothes_type;
DELETE FROM House_type;
DELETE FROM Relationship_type;
DELETE FROM Breed;
DELETE FROM Engine_type;
DELETE FROM Color;
DELETE FROM Hunger;
DELETE FROM Genders;

--Добавление данных

INSERT INTO Genders (name) 
VALUES ('Male'), ('Female');

INSERT INTO Hunger (name) 
VALUES ('Not Hungry'), ('Hungry');

INSERT INTO Color (name) 
VALUES ('Red'), ('Blue'), ('Green'), ('Yellow'), ('Black'), ('White');

INSERT INTO Engine_type (name) 
VALUES ('Gasoline'), ('Electric'), ('Diesel');

INSERT INTO Breed (name) 
VALUES ('Dog'), ('Cat'), ('Bird'), ('Fish'), ('Parrot'), ('Hamster');

INSERT INTO Relationship_type (name) 
VALUES ('Friend'), ('Family Member'), ('Colleague');

INSERT INTO House_type (name) 
VALUES ('Apartment'), ('House'), ('Mansion');

INSERT INTO Clothes_type (name) 
VALUES ('Shirt'), ('Pants'), ('Dress'), ('Jacket'), ('Sweater'), ('Skirt'), ('Hat'), ('Gloves'), ('Socks'), ('Coat');

INSERT INTO Food (name) 
VALUES ('Bread'), ('Milk'), ('Vegetables'), ('Fruits'), ('Meat'), ('Egg'), ('Rice'), ('Pasta'), ('Cheese'), ('Fish');

INSERT INTO Job (name, salary) 
VALUES ('Engineer', 50000), ('Teacher', 40000), ('Doctor', 70000), ('Programmer', 60000), ('Nurse', 45000), ('Chef', 55000), ('Lawyer', 80000), ('Artist', 48000), ('Electrician', 52000), ('Writer', 45000);

INSERT INTO Street (name) 
VALUES ('Lomonosovo'), ('Kronverk Avenue'), ('Nevsky Prospekt'), ('Bolshaya Morskaya Street'), ('Liteyny Prospekt'), ('Vasileostrovsky Island'), ('Fontanka River Embankment'), ('Moskovsky Prospekt'), ('Sadovaya Street'), ('Alpine lane');

INSERT INTO House (type_id, address_id, floor_number, room_number, x_coordinate, y_coordinate, length, width)
VALUES (1, 1, 2, 3, 100, 200, 10, 15),
       (2, 2, 1, 4, 150, 250, 12, 18),
       (3, 3, 3, 5, 200, 300, 15, 20),
       (1, 4, 2, 2, 120, 180, 8, 12),
	   (1, 8, 2, 2, 120, 180, -8, 12);
	   
INSERT INTO Furniture_types (furniture_type, price) 
VALUES ('Chair', 500), ('Bed', 2000), ('Table', 1200), ('Sofa', 3000), ('Wardrobe', 2500), ('Desk', 800), ('Dining Table', 1500), ('Bookshelf', 1000), ('Couch', 2800), ('Coffee Table', 900);

INSERT INTO Furnitures_house (house_id, furniture_type_id, floor) 
VALUES (1, 1, 1), (1, 2, 1), (1, 3, 1),
       (2, 2, 2), (2, 4, 2), (2, 5, 2),
       (3, 3, 1), (3, 5, 1), (3, 8, 1),
       (4, 1, 1), (4, 6, 1);

INSERT INTO Plumbob (color_id) 
VALUES (1), (2), (3), (4);

INSERT INTO Grocery_store (food_id, count, price, address_id, x_coordinate, y_coordinate, length, width)
VALUES (1, 10, 2, 3, 300, 400, 8, 10),
       (2, 5, 3, 1, 100, 300, 6, 8),
       (3, 8, 4, 2, 200, 350, 10, 12),
       (4, 12, 3, 4, 250, 400, 12, 15);
	   
INSERT INTO Family (living_house_id) VALUES (1), (2), (3);

INSERT INTO Human (name, surname, gender_id, age, job_id, money, family_id, plumbob_id, hunger_id, x_coordinate, y_coordinate)
VALUES ('John', 'Doe', 1, 19, 1, 60000, 1, 1, 1, 100, 200),
       ('Jane', 'Doe', 2, 28, 2, 55000, 1, 2, 2, 200, 100),
       ('Bob', 'Johnson', 1, 35, 4, 75000, 2, 3, 1, 150, 250),
       ('Alice', 'Johnson', 2, 32, 3, 60000, 2, 4, 2, 250, 350),
       ('Mike', 'Smith', 1, 40, 5, 80000, 3, 3, 1, 180, 270),
       ('Emily', 'Smith', 2, 17, 6, 70000, 3, 4, 2, 220, 320);
	   
INSERT INTO Vehicle (type, model, size, owner_id, engine_type_id, color_id)
VALUES ('Car', 'Compact', 'Small', 1, 1, 3),
       ('Bike', 'Mountain Bike', 'Small', 2, 2, 4),
       ('Truck', 'Pickup', 'Large', 3, 3, 5),
       ('Motorcycle', 'Sport Bike', 'Medium', 4, 1, 6),
       ('SUV', 'Crossover', 'Large', 5, 2, 1),
       ('Car', 'Vespa', 'Small', 6, 1, 2);
	   
INSERT INTO Clothes (type_id, model, size, owner_id, color_id)
VALUES (1, 'T-shirt', 'Medium', 1, 5),
       (2, 'Jeans', '32', 2, 6),
       (3, 'Summer Dress', 'Medium', 3, 1),
       (4, 'Leather Jacket', '34', 4, 2),
       (5, 'Sweatpants', 'Large', 5, 3),
       (6, 'Skirt', 'Small', 6, 4);
	   
INSERT INTO Pet (gender_id, age, breed_id, plumbob_id, x_coordinate, y_coordinate)
VALUES
    (1, -2, 1, 1, 120, 250),
    (2, 3, 2, 2, 180, 300),
    (1, 1, 3, 1, 90, 200),
    (2, 4, 1, 2, 200, 400),
    (1, 2, 2, 1, 150, 350);
	
INSERT INTO Garage (size, stored_vehicle_id, house_id) 
VALUES (2, 1, 1),
	   (3, 2, 2),
	   (4, 3, 3);

INSERT INTO Relationship (human1_id, human2_id, relationship_type_id) 
VALUES (1, 3, 2), (2, 4, 3),
       (3, 5, 1), (4, 6, 2);
	   
--change_job
SELECT ID, job_id FROM Human;
CALL change_job(1, 2);
SELECT ID, job_id FROM Human;

--buy_furniture_by_ids
SELECT * FROM Furnitures_house;
CALL buy_furniture_by_ids(4, 1);
SELECT * FROM Furnitures_house;

--create_relationship
SELECT * FROM Pet;
SELECT * FROM Relationship;
CALL create_relationship(1, 2, 1);
SELECT * FROM Relationship;

--calculate_family_money
SELECT calculate_family_money(1);

--get_family_members
SELECT get_family_members(2);

--update_human_location
SELECT ID, x_coordinate, y_coordinate FROM Human;
SELECT update_human_location(1, 1, 1);
SELECT ID, x_coordinate, y_coordinate FROM Human;

--change_car_color
SELECT ID, color_id FROM Vehicle;
SELECT change_car_color(1, 1);
SELECT ID, color_id FROM Vehicle;

--is_person_at_home
SELECT is_person_at_home(1);
SELECT is_person_at_home(3);


--проверка триггеров
SELECT * FROM Pet;
SELECT * FROM House;--НОРМ?????


--CREATE INDEX index_family_id ON Family USING HASH(ID);
CREATE INDEX index_human_id ON Human USING HASH(ID);
EXPLAIN ANALYZE
SELECT * FROM Human;

--DROP INDEX IF EXISTS index_human_id;
EXPLAIN ANALYZE
SELECT * FROM Human
JOIN Vehicle ON Human.ID = Vehicle.owner_id AND Vehicle.type = 'Car';