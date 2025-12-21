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