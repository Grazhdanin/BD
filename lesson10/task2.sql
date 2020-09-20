-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
  
 
SELECT DISTINCT name,
  COUNT(profiles.user_id) OVER() / 
  (SELECT COUNT(communities.id) FROM communities) AS avg_total,
  FIRST_VALUE(profiles.user_id) OVER(PARTITION BY communities.id ORDER BY profiles.birthday) AS 'first',
  LAST_VALUE(profiles.user_id) OVER(PARTITION BY communities.id ORDER BY profiles.birthday 
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'last',
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) AS total_communities,
  COUNT(profiles.user_id) OVER() AS total,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) / COUNT(profiles.user_id) OVER() * 100 AS '%%'
  FROM communities 
    LEFT JOIN communities_users
      ON  communities.id = communities_users.community_id
    LEFT JOIN profiles
      ON communities_users.user_id = profiles.user_id;