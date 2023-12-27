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