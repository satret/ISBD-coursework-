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


--2)Проверка наличия типа мебели при вставке мебели в дом
CREATE OR REPLACE FUNCTION check_existing_furniture_trigger()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверка наличия такого типа мебели в доме
    IF EXISTS (
        SELECT 1
        FROM Furnitures_house
        WHERE house_id = NEW.house_id
          AND furniture_type_id = NEW.furniture_type_id
    ) THEN
        RAISE EXCEPTION 'Мебель такого типа уже есть в этом доме.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_existing_furniture_trigger
BEFORE INSERT ON Furnitures_house
FOR EACH ROW
EXECUTE FUNCTION check_existing_furniture_trigger();

--3)Триггер для автоматического обновления координат питомца при изменении координат его владельца
CREATE OR REPLACE FUNCTION update_pet_coordinates_trigger()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Pet
    SET x_coordinate = NEW.x_coordinate,
        y_coordinate = NEW.y_coordinate
    WHERE plumbob_id = NEW.plumbob_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_pet_coordinates_trigger
AFTER UPDATE ON Human
FOR EACH ROW
WHEN (NEW.x_coordinate IS DISTINCT FROM OLD.x_coordinate OR NEW.y_coordinate IS DISTINCT FROM OLD.y_coordinate)
EXECUTE FUNCTION update_pet_coordinates_trigger();

--4)Триггер для проверки, что зарплата человека меньше МРОТ, то поднять до МРОТ:
CREATE OR REPLACE FUNCTION update_job_salary()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверяем, что зарплата меньше МРОТ
    IF NEW.salary < 16242 THEN
        -- Устанавливаем зарплату в МРОТ
        NEW.salary := 16242;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_job_salary_trigger
BEFORE INSERT OR UPDATE ON Job
FOR EACH ROW
EXECUTE FUNCTION update_job_salary();


--5)Триггер проверяющий что семейные отношения не могут смениться на любовные
CREATE OR REPLACE FUNCTION prevent_love_relationship()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверяем, что новое отношение не является сменой семейных на любовные
    IF NEW.relationship_type_id = (SELECT ID FROM Relationship_type WHERE name = 'Love') AND
       OLD.relationship_type_id = (SELECT ID FROM Relationship_type WHERE name = 'Family Member') THEN
        RAISE EXCEPTION 'Невозможно сменить семейные отношения на любовные.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_love_relationship_trigger
BEFORE UPDATE ON Relationship
FOR EACH ROW
EXECUTE FUNCTION prevent_love_relationship();


--6)Триггер проверяющий что у одного человека не может быть 2 и более транспортов одного типа
CREATE OR REPLACE FUNCTION check_unique_vehicle_type()
RETURNS TRIGGER AS $$
DECLARE
    vehicle_count INTEGER;
BEGIN
    -- Проверяем количество транспортных средств данного типа у владельца
    SELECT COUNT(*) INTO vehicle_count
    FROM Vehicle
    WHERE owner_id = NEW.owner_id AND type = NEW.type;

    -- Если уже есть транспорт данного типа у владельца, выбрасываем исключение
    IF vehicle_count > 0 THEN
        RAISE EXCEPTION 'У владельца уже есть транспорт данного типа';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создаем триггер для таблицы Vehicle
CREATE TRIGGER check_unique_vehicle_type_trigger
BEFORE INSERT
ON Vehicle
FOR EACH ROW
EXECUTE FUNCTION check_unique_vehicle_type();

--7)Создаем функцию для проверки того, что все члены семьи имеют одну фамилию
CREATE OR REPLACE FUNCTION check_family_surname()
RETURNS TRIGGER AS $$
DECLARE
    family_surname VARCHAR(50);
BEGIN
    -- Получаем фамилию первого члена семьи
    SELECT surname INTO family_surname
    FROM Human
    WHERE family_id = NEW.family_id
    LIMIT 1;

    -- Проверяем, совпадает ли фамилия нового члена семьи с фамилией первого члена
    IF NEW.surname <> family_surname THEN
        RAISE EXCEPTION 'У всех членов семьи должна быть одна фамилия.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Создаем триггер, который вызывает функцию check_family_surname перед вставкой новой строки
CREATE TRIGGER before_insert_check_family_surname
BEFORE INSERT ON Human
FOR EACH ROW
EXECUTE FUNCTION check_family_surname();