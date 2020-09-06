-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.   

CREATE DATABASE flight; 

USE flight;
   
CREATE TABLE IF NOT EXISTS flights(
id SERIAL PRIMARY KEY,
`from` VARCHAR(50) NOT NULL, 
`to` VARCHAR(50) NOT NULL 
);

CREATE TABLE  IF NOT EXISTS cities(
label VARCHAR(50) PRIMARY KEY, 
name VARCHAR(50)
);


ALTER TABLE flights
  ADD CONSTRAINT fk_from_label
  FOREIGN KEY(`from`)
  REFERENCES cities(label);

ALTER TABLE flights
  ADD CONSTRAINT fk_to_label
  FOREIGN KEY(`to`)
  REFERENCES cities(label);


INSERT INTO cities VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');

INSERT INTO flights VALUES
  (NULL, 'moscow', 'omsk'),
  (NULL, 'novgorod', 'kazan'),
  (NULL, 'irkutsk', 'moscow'),
  (NULL, 'omsk', 'irkutsk'),
  (NULL, 'moscow', 'kazan');


SELECT
  id,
  (SELECT name FROM cities WHERE label = `from`),
  (SELECT name FROM cities WHERE label = `to`)
FROM
  flights;