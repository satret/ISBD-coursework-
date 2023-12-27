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