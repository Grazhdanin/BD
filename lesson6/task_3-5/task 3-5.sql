-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT COUNT(*) user_id FROM profiles WHERE gender = 'm';

(SELECT COUNT(*) target_id, 'm' AS gender FROM likes l WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'm'))
UNION
(SELECT COUNT(*) target_id, 'f' FROM likes l WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'f'));

-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
	
SELECT SUM(likes_total) FROM
  (SELECT
    (SELECT COUNT(*) target_id FROM likes WHERE likes.target_id = profiles.user_id 
      AND target_type_id = (SELECT id FROM media_types WHERE name = 'names' )) AS likes_total
    FROM profiles 
    ORDER BY birthday 
    DESC LIMIT 10) AS tt;


   
   
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
--    (критерии активности необходимо определить самостоятельно).


SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	  LIMIT 10;