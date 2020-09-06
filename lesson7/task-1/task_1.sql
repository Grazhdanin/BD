-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине

INSERT INTO
  orders(user_id)
  VALUES
    (3), -- Александр
    (4); -- Cергей
  
-- товары заказанные Сергеем
INSERT INTO
  orders_products(order_id, product_id, total)
  VALUES
    (4, 2, 1);
 
-- товары заказанные Александром
INSERT INTO
  orders_products(order_id, product_id, total)
  VALUES
    (3, 2, 2),
    (3, 2, 2);
  

SELECT 
  users.name,
  orders.id
  FROM 
    users 
  RIGHT JOIN
    orders  
  ON
    users.id = orders.user_id;