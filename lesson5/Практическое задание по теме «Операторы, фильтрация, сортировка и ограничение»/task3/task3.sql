INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15123),
    (1, 3, 0),
    (1, 5, 10345),
    (1, 7, 5342),
    (1, 9, 0);

SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;