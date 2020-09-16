-- 1.
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

CREATE DATABASE sample;
USE sample;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';


START TRANSACTION;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id =1;
DELETE FROM shop.users WHERE id = 1;

COMMIT;

SELECT * FROM users;

-- 2.
-- Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW product_catalog (name_prod, name_cat) AS SELECT products.name, catalogs .name 
  FROM products 
  LEFT JOIN catalogs
  ON products.catalog_id = catalogs.id;
 
 SELECT * FROM product_catalog;