-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;

-- ==========================================
-- PROBLEM 1 DATA: Users Table (For Login)
-- ==========================================

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

-- Insert dummy users
INSERT INTO users (username, password) VALUES
('student1', 'pass123'),
('teacher_john', 'teach2024'),
('admin', 'adminpass');


-- ==========================================
-- PROBLEM 2 DATA: Exam Results (For Aggregates)
-- ==========================================

CREATE TABLE IF NOT EXISTS exam_results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100),
    subject VARCHAR(50),
    marks INT
);

-- Insert dummy scores
INSERT INTO exam_results (student_name, subject, marks) VALUES
('Alice', 'Math', 85),
('Bob', 'Math', 78),
('Charlie', 'Math', 92),
('Alice', 'Science', 88),
('Bob', 'Science', 65),
('Charlie', 'Science', 95),
('David', 'History', 70);


-- ==========================================
-- PROBLEM 3 DATA: Products & Categories (For Joins)
-- ==========================================

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cat_name VARCHAR(50)
);

-- Insert Categories
INSERT INTO categories (id, cat_name) VALUES
(1, 'Laptops'),
(2, 'Smartphones'),
(3, 'Accessories');

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert Products
INSERT INTO products (name, price, category_id) VALUES
('MacBook Pro', 1200.00, 1),
('Dell XPS', 950.00, 1),
('iPhone 15', 999.00, 2),
('Samsung Galaxy', 850.00, 2),
('USB Cable', 15.00, 3),
('Generic Mouse', 20.00, NULL); -- NULL category for testing LEFT JOIN
