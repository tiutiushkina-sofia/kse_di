-- 1. Створення бази даних
CREATE DATABASE IF NOT EXISTS call_center;
USE call_center;

-- 2. Створення таблиці працівників
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    team VARCHAR(50),
    hire_date DATE
);

-- 3. Створення таблиці дзвінків
CREATE TABLE IF NOT EXISTS calls (
    call_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    call_time DATETIME,
    phone VARCHAR(20),
    direction VARCHAR(10),
    status VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 4. Генерація ~50 записів працівників
INSERT INTO employees (full_name, team, hire_date) VALUES
('Sofiia Melnyk', 'Support', '2023-01-15'), ('Ivan Kovalenko', 'Sales', '2022-11-01'),
('Anna Shevchenko', 'Billing', '2024-02-10'), ('Petro Boyko', 'Tech Support', '2021-08-23'),
('Olena Tkachenko', 'Support', '2023-05-12'), ('Dmytro Kravchenko', 'Sales', '2022-09-30'),
('Kateryna Polishchuk', 'Support', '2024-01-05'), ('Mykola Bondarenko', 'Billing', '2020-04-18'),
('Mariya Morozyuk', 'Tech Support', '2023-11-22'), ('Yuriy Savchenko', 'Support', '2021-12-01'),
('Oksana Lysenko', 'Sales', '2022-03-14'), ('Andriy Rudenko', 'Support', '2023-07-19'),
('Viktoriya Havrylyuk', 'Billing', '2024-02-28'), ('Oleksandr Ponomarenko', 'Tech Support', '2021-05-09'),
('Iryna Pavlenko', 'Support', '2023-09-15'), ('Serhiy Klymenko', 'Sales', '2022-10-11'),
('Yuliya Kotsyuba', 'Support', '2024-01-20'), ('Roman Hrytsenko', 'Billing', '2020-08-30'),
('Nataliya Vlasenko', 'Tech Support', '2023-12-05'), ('Volodymyr Zhuk', 'Support', '2021-02-14'),
('Tetiana Marchenko', 'Sales', '2022-06-21'), ('Artem Hryhorenko', 'Support', '2023-04-03'),
('Svitlana Shulha', 'Billing', '2024-03-01'), ('Maksym Petrenko', 'Tech Support', '2021-09-17'),
('Alina Voloshyna', 'Support', '2023-10-08'), ('Taras Lytvyn', 'Sales', '2022-01-25'),
('Nadiya Vovk', 'Support', '2024-02-02'), ('Oleh Sydorenko', 'Billing', '2020-11-12'),
('Daryna Zakharchuk', 'Tech Support', '2023-06-16'), ('Mykhailo Polishchuk', 'Support', '2021-07-28'),
('Yana Kostenko', 'Sales', '2022-04-05'), ('Denys Taran', 'Support', '2023-08-20'),
('Olesia Kolisnyk', 'Billing', '2024-01-11'), ('Vitaliy Sereda', 'Tech Support', '2021-10-29'),
('Liliya Piliuhina', 'Support', '2023-02-24'), ('Pavlo Chernenko', 'Sales', '2022-08-16'),
('Diana Romanyuk', 'Support', '2024-02-15'), ('Nazar Yermolenko', 'Billing', '2020-05-22'),
('Zoryana Antonenko', 'Tech Support', '2023-01-09'), ('Ruslan Nazarenko', 'Support', '2021-11-03'),
('Valeriya Tkach', 'Sales', '2022-07-10'), ('Illia Hlushko', 'Support', '2023-03-27'),
('Khrystyna Omelchenko', 'Billing', '2024-02-20'), ('Bohdan Yurchuk', 'Tech Support', '2021-04-15'),
('Maryna Didenko', 'Support', '2023-05-06'), ('Hryhoriy Stepanenko', 'Sales', '2022-12-18'),
('Veronika Hrytsay', 'Support', '2024-01-30'), ('Valentyn Kuchar', 'Billing', '2020-09-08'),
('Karina Honchar', 'Tech Support', '2023-08-11'), ('Matviy Vasylyuk', 'Support', '2021-03-25');

-- 5. Генерація стартових тестових дзвінків (імітуємо минулі дзвінки)
INSERT INTO calls (call_id, employee_id, call_time, phone, direction, status) VALUES
(1, 5, '2026-03-06 09:15:00', '+380501112233', 'inbound', 'answered'),
(2, 12, '2026-03-06 09:45:30', '+380671234567', 'outbound', 'answered'),
(3, 42, '2026-03-06 10:05:00', '+380999876543', 'inbound', 'missed'),
(4, 3, '2026-03-06 10:22:15', '+380635556677', 'inbound', 'answered'),
(5, 28, '2026-03-06 11:10:00', '+380504445566', 'outbound', 'missed'),
(6, 17, '2026-03-06 11:45:00', '+380678889900', 'inbound', 'answered'),
(7, 33, '2026-03-06 12:30:45', '+380991112233', 'outbound', 'answered'),
(8, 9, '2026-03-06 13:15:20', '+380634445566', 'inbound', 'answered'),
(9, 49, '2026-03-06 14:00:00', '+380507778899', 'inbound', 'missed'),
(10, 2, '2026-03-06 14:50:10', '+380672223344', 'outbound', 'answered');

SELECT call_id FROM calls WHERE call_time > '2000-01-01 00:00:00';

INSERT INTO call_center.calls (call_id, employee_id, call_time, phone)
VALUES (11, 2, '2026-03-09 15:00:00', '+380991112233');

INSERT INTO call_center.calls (call_id, employee_id, call_time, phone)
VALUES (12, 5, '2026-03-09 16:00:00', '+380670001122');