-- Create database
CREATE DATABASE cinema_reservation

USE cinema_reservation

-- Create tables
CREATE TABLE cinema (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255)  NOT NULL
)

CREATE TABLE room (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50)  NOT NULL,
    cinema_id INT NOT NULL,
    nb_places INT NOT NULL,
    FOREIGN KEY (cinema_id) REFERENCES cinema (id)
)

CREATE TABLE film (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration_minutes INT NOT NULL,
    year INT,
    classification_id INT,
    FOREIGN KEY (classification_id) REFERENCES classification (id)
)

CREATE TABLE screening ( 
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    film_id INT NOT NULL, 
    room_id INT NOT NULL, 
    start_time DATETIME, 
    end_time DATETIME, 
    FOREIGN KEY (film_id) REFERENCES film (id), 
    FOREIGN KEY (room_id) REFERENCES room (id) 
)

CREATE TABLE price (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
)

CREATE TABLE payment_method (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
)

CREATE TABLE order_status (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
)

CREATE TABLE classification ( 
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(255) NOT NULL 
)

CREATE TABLE users (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
)

CREATE TABLE admin (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    cinema_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (cinema_id) REFERENCES cinema (id)
)

CREATE TABLE orders (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    created_at DATETIME NOT NULL,
    user_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    order_status_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method (id),
    FOREIGN KEY (order_status_id) REFERENCES order_status (id)
)

CREATE TABLE reservation (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    screening_id INT NOT NULL,
    price_id INT NOT NULL,
   	created_at DATETIME NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (screening_id) REFERENCES screening (id),
    FOREIGN KEY (price_id) REFERENCES price (id),
    FOREIGN KEY (order_id) REFERENCES orders (id)
)

-- Insert data
INSERT INTO price (type, amount)
VALUES
	('Plein Tarif', 9.20),
    ('Étudiant', 7.60),
    ('Moins de 14 ans', 5.90)

INSERT INTO payment_method (name)
VALUES 
	('En ligne'),
    ('Sur place')

INSERT INTO order_status (name)
VALUES
	('En cours'),
    ('Terminé'),
    ('Annulé')

INSERT INTO cinema (name)
VALUES
	('Cinéma CGR Bordeaux'),
    ('UGC Ciné Cité Bordeaux'),
    ('Cinéma MEGARAMA Bordeaux'),	
    ('Cinéma Noisette Bordeaux'),	
    ('Cinéma Utopia')

INSERT INTO room (name, cinema_id, nb_places)
VALUES
	('A', 1, 70),
    ('B', 1, 60),	
    ('C', 1, 80), 	
    ('D', 1, 120), 	
    ('A', 2, 70), 	
    ('B', 2, 80), 	
    ('C', 2, 80), 	
    ('D', 2, 120), 	
    ('A', 3, 70), 	
    ('B', 3, 80), 	
    ('A', 4, 70), 	
    ('B', 4, 80), 	
    ('C', 4, 90), 	
    ('A', 5, 80), 	
    ('B', 5, 80)

INSERT INTO classification (name)
VALUES 
	('Tous publics'),
    ('Avertissement'),
    ('Interdit aux moins de 12 ans'),
    ('Interdit aux moins de 16 ans'),
    ('Interdit aux moins de 18 ans')

INSERT INTO film (title, duration_minutes, year, classification_id)
VALUES
	('Un tour chez ma fille', 83, 2021, 1),
    ('Reset', 85, 2021, 1),
    ('Conjuring 3 : sous l\'emprise du diable', 111, 2021, 3),
    ('Les bouchetrous', 84, 2021, 1),
    ('Le discours', 88, 2021, 1),
    ('Chacun chez soi', 83, 2021, 1),
    ('Nobody', 92, 2021, 3),
    ('Billie holiday, une affaire d\'état', 131, 2021, 1),
    ('Villa caprice', 103, 2021, 1)

INSERT INTO users (first_name, last_name, email, password)
VALUES
	('Sylvie','Baillet','sylvie@mail.com','7C6A180B36896A0A8C02787EEAFB0E4C'),
    ('Julie','Weiss','julie@mail.com','F1F16683F3E0208131B46D37A79C8921'),
    ('Timothée','Cabaret','timothee@mail.com','32A3571FA12B39266A58D42234836839'),
    ('Axel','Godin','axel@mail.com','EFDC5B7D8D9F3824230BD7A5F9D094F8'),
    ('Alexandra','Berthaud','alexandra@message.fr','2EC3CCC2FB806F207293685877BA7D6E'),
    ('Thomas','Barry','thomas@message.fr','B1F55F5874BB69A9F55D7217B6F833B1'),
    ('Hermine','Cromer','hermine@message.fr','183EE0913A2CCDE3376ACBA519CA8B22'),
    ('Ludovic','Ferreira','ludovic@message.fr','CF3A2948C797D8C6A9A654B16C27DD99'),
    ('Jessica','Rubio','jessica@message.fr','4CCAECBC9FB436A33D263A5AF2669FFD'),
    ('Hugo','Touron','hugo@message.fr','166335A86348834FFD4D79CD5A73867B'),
    ('Audrey','Lalaurette','audrey@message.fr','E7E355F2A90F53B74E43C130B9AF5FB3'),
    ('Julie','Bénard','julie@message.fr','EEBF9D92578B4212B541FB41F326A8F2'),
    ('Aurélie','Verdier','aurelie@message.fr','A2010545C44148216262DF870BD1A1D5'),
    ('Roxane','Doussain','roxane@message.fr','B2CE85C54035B89D2E5FDEE4E66BE134'),
    ('Benoit','Péjac','benoit@message.fr','76999BC209A0605D88D1429E931F1C11'),
    ('Romain','Coste','romain@message.fr','8585F2C86E81EF3FEBB876B9C8A67935')

INSERT INTO admin (user_id, cinema_id)
VALUES
	( 2, 1),
    ( 5, 2),
    ( 8, 3),
    ( 9, 4),
    ( 10, 5)

INSERT INTO screening (film_id, room_id, start_time, end_time)
VALUES
	( 2, 1, '2021-06-14 18:00:00', '2021-06-14 20:00:00'),
    ( 5, 2, '2021-06-16 17:35:00', '2021-06-16 19:00:00'),
    ( 4, 4, '2021-06-16 18:05:00', '2021-06-16 19:40:00'),
    ( 4, 4, '2021-06-16 20:30:00', '2021-06-16 21:05:00'),
    ( 3, 5, '2021-06-18 20:30:00', '2021-06-18 22:30:00'),
    ( 1, 5, '2021-06-18 15:30:00', '2021-06-18 17:45:00'),
    ( 9, 6, '2021-06-15 18:00:00', '2021-06-15 20:00:00'),
    ( 9, 7, '2021-06-14 17:35:00', '2021-06-14 19:45:00'),
    ( 8, 8, '2021-06-16 19:35:00', '2021-06-16 21:50:00'),
    ( 4, 8, '2021-06-17 18:05:00', '2021-06-17 20:00:00'),
    ( 3, 8, '2021-06-19 21:35:00', '2021-06-19 23:45:00'),
    ( 2, 9, '2021-06-14 17:00:00', '2021-06-14 19:00:00'),
    ( 8, 9, '2021-06-15 18:00:00', '2021-06-15 20:20:00'),
    ( 6, 12, '2021-06-15 19:00:00', '2021-06-15 20:45:00'),
    ( 7, 11, '2021-06-15 19:25:00', '2021-06-15 21:05:00'),
    ( 9, 13, '2021-06-14 16:00:00', '2021-06-14 18:10:00')

INSERT INTO orders (created_at, user_id, payment_method_id, order_status_id)
VALUES
	( '2021-06-12 18:00:00:00', 12, 1, 1),
    ( '2021-06-12 17:38:00:00', 11, 2, 2),
    ( '2021-06-07 13:39:00:00', 15, 1, 1),
    ( '2021-05-25 12:05:00:00', 4, 1, 1),
    ( '2021-05-28 17:46:00:00', 1, 2, 2),
    ( '2021-06-08 21:15:00:00', 7, 2, 2),
    ( '2021-06-01 23:49:00:00', 6, 1, 1),
    ( '2021-06-12 07:59:00:00', 3, 2, 2),
    ( '2021-05-25 07:35:00:00', 14, 1, 1),
    ( '2021-06-09 11:04:00:00', 13, 2, 2)

INSERT INTO reservation (screening_id, price_id, created_at, order_id)
VALUES
	( 16, 1, '2021-06-12 18:00:00:00', 1),
    ( 7, 1, '2021-06-12 17:38:00:00', 2),
    ( 8, 1, '2021-06-07 13:39:00:00', 3),
    ( 2, 2, '2021-05-25 12:05:00:00', 4),
    ( 12, 1, '2021-05-28 17:46:00:00', 5),
    ( 8, 2, '2021-06-08 21:15:00:00', 6),
    ( 14, 2, '2021-06-01 23:49:00:00', 7),
    ( 3, 1, '2021-06-12 07:59:00:00', 8),
    ( 9, 2, '2021-05-25 07:35:00:00', 9),
    ( 9, 2, '2021-05-25 07:35:00:00', 9),
    ( 2, 1, '2021-06-09 11:04:00:00', 10),
    ( 2, 1, '2021-06-09 11:04:00:00', 10),
    ( 2, 3, '2021-06-09 11:04:00:00', 10)

