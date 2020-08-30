UPDATE users 
    SET created_at = NOW() where created_at is NULL;