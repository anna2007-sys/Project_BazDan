CREATE TYPE computer_status AS ENUM ('Available', 'Busy', 'Maintenance');
CREATE TYPE service_category AS ENUM ('Food', 'Drink', 'Other');

CREATE TABLE Card (
    card_id INT PRIMARY KEY,
    code INT UNIQUE,
    balance INT DEFAULT 0
);

CREATE TABLE Clients (
    clients_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone INT,
    birthday DATE,
    card_id INT NULL,
    FOREIGN KEY (card_id) REFERENCES Card(card_id)
);

CREATE TABLE Computers (
    computers_id INT PRIMARY KEY,
    computer_code VARCHAR(100) UNIQUE,
    status computer_status DEFAULT 'Available',
    price_per_hour DECIMAL(10,2)
);

CREATE TABLE Services (
    services_id INT PRIMARY KEY,
    name VARCHAR(80),
    category service_category DEFAULT 'Other',
    price DECIMAL(10,2)
);

CREATE TABLE Sessions (
    sessions_id INT PRIMARY KEY,
    client_id INT,
    computer_id INT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    total_price DECIMAL(10,2),
    FOREIGN KEY (client_id) REFERENCES Clients(clients_id),
    FOREIGN KEY (computer_id) REFERENCES Computers(computers_id)
);

CREATE TABLE Orders (
    orders_id INT PRIMARY KEY,
    client_id INT,
    session_id INT NULL,
    orders_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES Clients(clients_id),
    FOREIGN KEY (session_id) REFERENCES Sessions(sessions_id)
);

CREATE TABLE Orders_Item (
    orders_item_id INT PRIMARY KEY,
    orders_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (orders_id) REFERENCES Orders(orders_id),
    FOREIGN KEY (service_id) REFERENCES Services(services_id)
);

INSERT INTO Card (card_id, code, balance) VALUES
(1, 1001, 5000),
(2, 1002, 2500),
(3, 1003, 10000),
(4, 1004, 0),
(5, 1005, 1500),
(6, 1006, 3000),
(7, 1007, 7000),
(8, 1008, 2000),
(9, 1009, 4500),
(10, 1010, 6000);

INSERT INTO Clients (clients_id, full_name, phone, birthday, card_id) VALUES
(1, 'Иван Иванов', 7915123, '1995-03-15', 1),        
(2, 'Мария Петрова', 7926234, '2000-07-22', 2),      
(3, 'Алексей Смирнов', 7937345, '1998-11-30', 3),    
(4, 'Елена Васильева', 7948456, '1997-05-14', 4),    
(5, 'Андрей Николаев', 7959567, '1999-12-05', 5),    
(6, 'Ольга Сидорова', 7960678, '1996-08-18', 6),     
(7, 'Дмитрий Козлов', 7971789, '2001-02-25', 7),     
(8, 'Анна Федорова', 7982890, '1994-09-10', 8),      
(9, 'Сергей Павлов', 7993901, '1993-06-20', 9),      
(10, 'Наталья Морозова', 7904012, '2002-01-08', 10);

INSERT INTO Computers (computers_id, computer_code, status, price_per_hour) VALUES
(1, 'PC-001', 'Available', 150.00),
(2, 'PC-002', 'Busy', 150.00),
(3, 'PC-003', 'Available', 120.00),
(4, 'PC-004', 'Maintenance', 120.00),
(5, 'PC-005', 'Available', 200.00),
(6, 'PC-006', 'Busy', 200.00),
(7, 'PC-007', 'Available', 180.00),
(8, 'PC-008', 'Available', 180.00),
(9, 'PC-009', 'Busy', 250.00),
(10, 'PC-010', 'Available', 250.00);

INSERT INTO Services (services_id, name, category, price) VALUES
(1, 'Кола 0.5л', 'Drink', 120.00),
(2, 'Чипсы Lays', 'Food', 180.00),
(3, 'Кофе латте', 'Drink', 200.00),
(4, 'Пицца Маргарита', 'Food', 450.00),
(5, 'Чай зеленый', 'Drink', 100.00),
(6, 'Шоколадный батончик', 'Food', 80.00),
(7, 'Минеральная вода', 'Drink', 90.00),
(8, 'Печенье', 'Food', 120.00),
(9, 'Час игры (стандарт)', 'Other', 150.00),
(10, 'Час игры (премиум)', 'Other', 200.00);

INSERT INTO Sessions (sessions_id, client_id, computer_id, start_time, end_time, total_price) VALUES
(1, 1, 2, '2024-05-10 14:00:00', '2024-05-10 16:00:00', 300.00),
(2, 2, 6, '2024-05-10 18:00:00', '2024-05-10 21:00:00', 600.00),
(3, 3, 9, '2024-05-11 12:00:00', '2024-05-11 15:30:00', 875.00),
(4, 4, 1, '2024-05-11 16:00:00', '2024-05-11 18:00:00', 300.00),
(5, 5, 5, '2024-05-12 20:00:00', '2024-05-13 01:00:00', 1000.00),
(6, 6, 7, '2024-05-13 14:00:00', '2024-05-13 17:00:00', 540.00),
(7, 7, 10, '2024-05-14 10:00:00', '2024-05-14 12:30:00', 625.00),
(8, 8, 3, '2024-05-14 19:00:00', '2024-05-14 22:00:00', 360.00),
(9, 9, 8, '2024-05-15 13:00:00', '2024-05-15 16:00:00', 540.00),
(10, 10, 2, '2024-05-16 11:00:00',NULL, 0.00); 

INSERT INTO Orders (orders_id, client_id, session_id, orders_time) VALUES
(1, 1, 1, '2024-05-10 15:30:00'),
(2, 2, 2, '2024-05-10 19:00:00'),
(3, 3, 3, '2024-05-11 14:00:00'),
(4, 4, 4, '2024-05-11 17:00:00'),
(5, 5, 5, '2024-05-12 22:00:00'),
(6, 6, 6, '2024-05-13 15:30:00'),
(7, 7, 7, '2024-05-14 11:00:00'),
(8, 8, 8, '2024-05-14 20:30:00'),
(9, 9, 9, '2024-05-15 14:30:00'),
(10, 10, 10, '2024-05-16 12:00:00'),
(11, 1, NULL, '2024-05-17 10:00:00'), 
(12, 3, NULL, '2024-05-17 11:00:00'); 

INSERT INTO Orders_Item (orders_item_id, orders_id, service_id, quantity, unit_price) VALUES
(1, 1, 1, 2, 120.00),
(2, 1, 2, 1, 180.00),
(3, 2, 3, 1, 200.00),
(4, 2, 4, 1, 450.00),
(5, 3, 1, 3, 120.00),
(6, 3, 2, 2, 180.00),
(7, 4, 5, 2, 100.00),
(8, 4, 6, 1, 80.00),
(9, 5, 1, 4, 120.00),
(10, 5, 2, 2, 180.00);

--1.Посчитать сумму всех заказов за сегодняшний день. (допустим что сегодня 2024-05-10)
SELECT
    DATE(o.orders_time) as order_date,
    SUM(oi.quantity * oi.unit_price) as total_sales_today
FROM orders o
JOIN orders_item oi ON o.orders_id = oi.orders_id
WHERE DATE(o.orders_time) = CURRENT_DATE
GROUP BY DATE(o.orders_time);

--2.Выбрать самый продаваемый товар в категории food
SELECT 
    s.name as product_name,
    s.category,
    SUM(oi.quantity) as total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) as total_revenue
FROM Services s
JOIN Orders_Item oi ON s.services_id = oi.service_id
WHERE s.category = 'Food'
GROUP BY s.services_id, s.name, s.category
ORDER BY total_quantity_sold DESC
LIMIT 1; 

--3.Найти самую длинную игровую сессию за все время
SELECT 
    s.sessions_id,
    c.full_name as client_name,
    pc.computer_code,
    s.start_time,
    s.end_time,
    CASE 
        WHEN s.end_time IS NOT NULL 
        THEN EXTRACT(EPOCH FROM (s.end_time - s.start_time))/3600 
        ELSE NULL 
    END as duration_hours,
    s.total_price
FROM Sessions s
JOIN Clients c ON s.client_id = c.clients_id
JOIN Computers pc ON s.computer_id = pc.computers_id
WHERE s.end_time IS NOT NULL
ORDER BY (s.end_time - s.start_time) DESC
LIMIT 1; 

