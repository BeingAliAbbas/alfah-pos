-- Database schema for Alfah POS System

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    composition TEXT,
    unit VARCHAR(50),
    form VARCHAR(100),
    buy_price DECIMAL(10,2) NOT NULL,
    sell_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    min_stock INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'completed',
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
);

CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'cashier',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample products (13 antibiotics, 7 neutralisation)
INSERT INTO products (name, category, composition, unit, form, buy_price, sell_price, stock_quantity, min_stock) VALUES
('Amoxicillin 10%', 'antibiotics', 'Amoxicillin Trihydrate', '100g', 'Water Soluble Powder', 5.00, 8.00, 200, 20),
('Tetracycline HCl', 'antibiotics', 'Tetracycline Hydrochloride', '100g', 'Water Soluble Powder', 4.50, 7.50, 150, 15),
('Erythromycin', 'antibiotics', 'Erythromycin Thiocyanate', '100g', 'Water Soluble Powder', 6.00, 10.00, 100, 10),
('Streptomycin', 'antibiotics', 'Streptomycin Sulfate', '100g', 'Water Soluble Powder', 5.50, 9.00, 120, 12),
('Gentamicin', 'antibiotics', 'Gentamicin Sulfate', '100ml', 'Oral Solution', 7.00, 12.00, 80, 8),
('Colistin Sulfate', 'antibiotics', 'Colistin Sulfate', '100g', 'Water Soluble Powder', 8.00, 14.00, 90, 9),
('Enrofloxacin', 'antibiotics', 'Enrofloxacin', '100ml', 'Oral Solution', 9.00, 15.00, 70, 7),
('Ciprofloxacin', 'antibiotics', 'Ciprofloxacin HCl', '100g', 'Water Soluble Powder', 6.50, 11.00, 110, 11),
('Doxycycline', 'antibiotics', 'Doxycycline Hyclate', '100g', 'Water Soluble Powder', 7.50, 13.00, 130, 13),
('Lincomycin', 'antibiotics', 'Lincomycin HCl', '100g', 'Water Soluble Powder', 5.00, 8.50, 140, 14),
('Spectinomycin', 'antibiotics', 'Spectinomycin HCl', '100g', 'Water Soluble Powder', 6.00, 10.50, 160, 16),
('Neomycin', 'antibiotics', 'Neomycin Sulfate', '100g', 'Water Soluble Powder', 4.00, 6.50, 180, 18),
('Chloramphenicol', 'antibiotics', 'Chloramphenicol', '100g', 'Water Soluble Powder', 7.00, 12.50, 85, 8),
('Citric Acid', 'neutralisation', 'Citric Acid Monohydrate', '100g', 'Water Soluble Powder', 2.00, 3.50, 250, 25),
('Phosphoric Acid', 'neutralisation', 'Phosphoric Acid 85%', '100ml', 'Oral Solution', 3.00, 5.00, 200, 20),
('Acetic Acid', 'neutralisation', 'Acetic Acid', '100ml', 'Oral Solution', 2.50, 4.00, 220, 22),
('Sodium Bicarbonate', 'neutralisation', 'Sodium Bicarbonate', '100g', 'Water Soluble Powder', 1.50, 2.50, 300, 30),
('Lactic Acid', 'neutralisation', 'Lactic Acid 80%', '100ml', 'Oral Solution', 3.50, 6.00, 180, 18),
('Hydrochloric Acid', 'neutralisation', 'HCl 37%', '100ml', 'Oral Solution', 2.00, 3.50, 190, 19),
('Sulfuric Acid', 'neutralisation', 'H2SO4 98%', '100ml', 'Oral Solution', 1.80, 3.00, 210, 21);

-- Admin user (password: Admin@123 hashed)
INSERT INTO users (username, password, role) VALUES ('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');