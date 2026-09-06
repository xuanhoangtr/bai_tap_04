-- ========================================================
-- POSTGRESQL DATABASE INITIALIZATION SCRIPT
-- Database: jakartajpa
-- Owner: postgres
-- ========================================================

DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS videos CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 1. Tao bang Categories
CREATE TABLE categories (
    categoryid SERIAL PRIMARY KEY,
    categoryname VARCHAR(255) NOT NULL,
    images VARCHAR(255),
    status INT DEFAULT 1
);

-- 2. Tao bang Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fullname VARCHAR(100),
    phone VARCHAR(20),
    images VARCHAR(255),
    status INT DEFAULT 1,
    otp VARCHAR(10),
    otp_expiry TIMESTAMP
);

-- 3. Tao bang Products
CREATE TABLE products (
    productid SERIAL PRIMARY KEY,
    productname VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    quantity INT DEFAULT 0,
    images VARCHAR(255),
    status INT DEFAULT 1,
    categoryid INT,
    CONSTRAINT fk_product_category FOREIGN KEY (categoryid) REFERENCES categories(categoryid) ON DELETE SET NULL
);

-- 4. Tao bang Videos
CREATE TABLE videos (
    videoid VARCHAR(50) PRIMARY KEY,
    active INT DEFAULT 1,
    description TEXT,
    poster VARCHAR(255),
    title VARCHAR(255),
    views INT DEFAULT 0,
    categoryid INT,
    CONSTRAINT fk_video_category FOREIGN KEY (categoryid) REFERENCES categories(categoryid) ON DELETE SET NULL
);

-- ========================================================
-- INSERT SEED DATA
-- ========================================================

-- Nap tai khoan mac dinh: xuan / 123
INSERT INTO users (username, password, email, fullname, phone, images, status)
VALUES ('xuan', '123', 'xuanhoangtr@gmail.com', 'Tran Xuan Hoang', '0987654321', 'avatar.png', 1);

-- Nap Categories
INSERT INTO categories (categoryid, categoryname, images, status) VALUES 
(1, 'Phone', 'avatar.png', 1),
(2, 'Laptop', 'avatar.png', 1),
(3, 'Tai nghe', 'avatar.png', 1);

-- Reset sequence cho categories
SELECT setval('categories_categoryid_seq', (SELECT MAX(categoryid) FROM categories));

-- Nap Products mau
INSERT INTO products (productname, description, price, quantity, images, status, categoryid) VALUES
('iPhone 16 Pro Max', 'San pham iPhone 16 Pro Max chinh hang Apple VN/A, bao hanh 12 thang.', 34000000, 50, 'avatar.png', 1, 1),
('iPhone 16 Pro', 'San pham iPhone 16 Pro chinh hang Apple VN/A, bao hanh 12 thang.', 28000000, 50, 'avatar.png', 1, 1),
('iPhone 16', 'San pham iPhone 16 chinh hang Apple VN/A, bao hanh 12 thang.', 22000000, 50, 'avatar.png', 1, 1),
('iPhone 15 Pro Max', 'San pham iPhone 15 Pro Max chinh hang Apple VN/A, bao hanh 12 thang.', 29000000, 50, 'avatar.png', 1, 1),
('iPhone 15', 'San pham iPhone 15 chinh hang Apple VN/A, bao hanh 12 thang.', 19000000, 50, 'avatar.png', 1, 1),
('MacBook Pro 16 M3 Max', 'San pham MacBook Pro 16 M3 Max chinh hang Apple VN/A, bao hanh 12 thang.', 89000000, 50, 'avatar.png', 1, 2),
('MacBook Pro 14 M3', 'San pham MacBook Pro 14 M3 chinh hang Apple VN/A, bao hanh 12 thang.', 39000000, 50, 'avatar.png', 1, 2),
('MacBook Air 15 M3', 'San pham MacBook Air 15 M3 chinh hang Apple VN/A, bao hanh 12 thang.', 32000000, 50, 'avatar.png', 1, 2),
('MacBook Air 13 M2', 'San pham MacBook Air 13 M2 chinh hang Apple VN/A, bao hanh 12 thang.', 24000000, 50, 'avatar.png', 1, 2),
('MacBook Air 13 M1', 'San pham MacBook Air 13 M1 chinh hang Apple VN/A, bao hanh 12 thang.', 18000000, 50, 'avatar.png', 1, 2),
('AirPods Max', 'San pham AirPods Max chinh hang Apple VN/A, bao hanh 12 thang.', 13000000, 50, 'avatar.png', 1, 3),
('AirPods Pro 2 MagSafe USB-C', 'San pham AirPods Pro 2 MagSafe USB-C chinh hang Apple VN/A, bao hanh 12 thang.', 6000000, 50, 'avatar.png', 1, 3),
('AirPods 4 ANC', 'San pham AirPods 4 ANC chinh hang Apple VN/A, bao hanh 12 thang.', 5000000, 50, 'avatar.png', 1, 3),
('AirPods 4', 'San pham AirPods 4 chinh hang Apple VN/A, bao hanh 12 thang.', 4000000, 50, 'avatar.png', 1, 3),
('AirPods 3', 'San pham AirPods 3 chinh hang Apple VN/A, bao hanh 12 thang.', 4000000, 50, 'avatar.png', 1, 3);
