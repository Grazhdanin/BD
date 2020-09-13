-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender
    FROM likes; 

-- Группируем и сортируем
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1;  
  
-- 3. JOIN(Для наглядности вывел значеня и для мужчин и для женщин)

SELECT
  COUNT(id) AS total,
  gender 
  FROM likes
    JOIN profiles
  ON profiles.user_id = likes.user_id
  GROUP BY gender
  ORDER BY total; 
   
   
   
   
-- 4. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- Смотрим типы для лайков
SELECT * FROM target_types;

-- Выбираем профили с сортировкой по дате рождения
SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10;

-- Выбираем количество лайков по условию
SELECT 
  (SELECT COUNT(*) FROM likes WHERE target_id = profiles.user_id AND target_type_id = 2) AS likes_total  
  FROM profiles 
  ORDER BY birthday 
  DESC LIMIT 10;

-- Подбиваем сумму внешним запросом
SELECT SUM(likes_total) FROM  
  (SELECT 
    (SELECT COUNT(*) FROM likes WHERE target_id = profiles.user_id AND target_type_id = 2) AS likes_total  
    FROM profiles 
    ORDER BY birthday 
    DESC LIMIT 10) AS user_likes
;  
 
 -- 4. JOIN
 
SELECT SUM(likes)
  FROM (SELECT COUNT(likes.id) AS likes
    FROM profiles
    LEFT JOIN likes
	  ON likes.target_id = profiles.user_id AND target_type_id = 2
	GROUP BY profiles.user_id
	ORDER BY profiles.birthday DESC
	LIMIT 10) AS qwerti;

 
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной 
-- сети.     
SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	  LIMIT 10;
	  
-- 5.JOIN

SELECT users.id,
  CONCAT(first_name, ' ', last_name) AS user,
  (COUNT(DISTINCT(messages.id))) + (COUNT(DISTINCT(media.id))) + (COUNT(DISTINCT(likes.id))) AS ii
  FROM users 
    LEFT JOIN likes 
      ON users.id = likes.user_id
    LEFT JOIN media 
      ON media.user_id = users.id
    LEFT JOIN messages 
      ON messages.from_user_id = users.id   
  GROUP BY users.id
  ORDER BY ii  
  LIMIT 10;