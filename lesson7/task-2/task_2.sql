-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 
  catalogs.name,
  products.name, 
  description, 
  price
  FROM 
    products 
  JOIN 
    catalogs
  ON
    products.catalog_id = catalogs.id;