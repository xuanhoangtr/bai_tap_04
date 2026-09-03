-- =========================================================
-- DATABASE SCRIPT CHO DU AN BAI_TAP_03 (JPA & SERVLET)
-- =========================================================

CREATE DATABASE jakartaJPA;
GO

USE jakartaJPA;
GO

-- 1. BANG USERS (Quan ly nguoi dung & Profile)
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL DROP TABLE dbo.users;
CREATE TABLE dbo.users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    fullname NVARCHAR(100) NULL,
    phone NVARCHAR(20) NULL,
    images NVARCHAR(500) NULL,
    status INT DEFAULT 1,
    otp NVARCHAR(10) NULL,
    otp_generated_time DATETIME2 NULL
);
GO

-- 2. BANG CATEGORIES (Danh muc san pham)
IF OBJECT_ID('dbo.categories', 'U') IS NOT NULL DROP TABLE dbo.categories;
CREATE TABLE dbo.categories (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NOT NULL,
    images NVARCHAR(500) NULL,
    status INT DEFAULT 1
);
GO

-- 3. BANG PRODUCTS (San pham)
IF OBJECT_ID('dbo.products', 'U') IS NOT NULL DROP TABLE dbo.products;
CREATE TABLE dbo.products (
    productId INT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(255) NOT NULL,
    unitPrice FLOAT DEFAULT 0,
    images NVARCHAR(500) NULL,
    description NVARCHAR(MAX) NULL,
    categoryId INT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (categoryId) REFERENCES dbo.categories(categoryId) ON DELETE SET NULL
);
GO

-- 4. DU LIEU MAU KHOI TAO
-- Tai khoan mau: username: xuan / password: 123
INSERT INTO dbo.users (username, password, email, fullname, phone, images, status)
VALUES 
(N'xuan', N'123', N'xuanhoangtr@gmail.com', N'Tran Xuan Hoang', N'0987654321', N'avatar.png', 1),
(N'admin', N'admin123', N'admin@iotstar.vn', N'Administrator', N'0909123456', N'avatar.png', 1);

-- Danh muc mau
INSERT INTO dbo.categories (categoryname, images, status)
VALUES 
(N'Dien thoai & Tablet', N'phone.png', 1),
(N'Laptop & May tinh', N'laptop.png', 1),
(N'Phu kien cong nghe', N'accessory.png', 1);

-- San pham mau
INSERT INTO dbo.products (productName, unitPrice, images, description, categoryId)
VALUES 
(N'iPhone 15 Pro Max 256GB', 29990000, N'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500', N'Sieu pham Apple Titan tu nhien', 1),
(N'Samsung Galaxy S24 Ultra', 27990000, N'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500', N'Camera 200MP AI thong minh', 1),
(N'MacBook Pro 14 M3 Pro', 49990000, N'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', N'Hieu nang vuot troi cho lap trinh vien', 2),
(N'Dell XPS 15 9530', 38500000, N'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', N'Man hinh OLED 3.5K sac net', 2),
(N'Tai nghe Sony WH-1000XM5', 6990000, N'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', N'Chong on chu dong hang dau the gioi', 3),
(N'Chuot Logitech MX Master 3S', 2190000, N'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500', N'Cuon sieu toc, lam viec da man hinh', 3);
GO
