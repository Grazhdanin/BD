-- 1.
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello (value TIME)
	RETURNS VARCHAR(255) NO SQL
BEGIN
	DECLARE greeting VARCHAR(50);

	IF (TIME(value) BETWEEN 0 AND 6) THEN 
		SET greeting = 'Доброй ночи';
	ELSEIF (TIME(value) BETWEEN 6 AND 12) THEN
		SET greeting = 'Доброе утро';
	ELSEIF (TIME(value) BETWEEN 12 AND 18) THEN
		SET greeting = 'Добрый день';
	ELSE 
		SET greeting = 'Добрый вечер';
	END IF;

  	RETURN greeting;
END//

DELIMITER ;

SELECT hello(TIME(NOW())) AS greetings;


-- 2.
-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS check_products_update;
DROP TRIGGER IF EXISTS check_products_insert;
DELIMITER //

CREATE TRIGGER check_products_insert BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The NAME and DESCRIPTON cannot be NULL';
  END IF;
END//



CREATE TRIGGER check_products_update BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'The NAME and DESCRIPTON cannot be NULL';
  END IF;
END//

DELIMITER ;

SHOW TRIGGERS;