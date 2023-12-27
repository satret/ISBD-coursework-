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