-- 1.Брой на потребители;
SELECT count(*) FROM users
-- 2. Най-стария потребител;
SELECT * FROM users
ORDER BY birthDate DESC;
-- 3. Най-младия потребител.;
SELECT * FROM Users
ORDER By BirthDate ASC;
-- 4. Колко юзъра са регистрирани с мейли от abv и колко от gmail и колко с различни от;
SELECT count(*)  FROM users
WHERE email LIKE '%gmail.com'
union all
SELECT count(*)  FROM users
WHERE email LIKE '%abv.bg'
union all
SELECT count(*) FROM users
WHERE email NOT LIKE '%abv.bg' AND email NOT LIKE '%gmail.com'


-- 5. Кои юзъри са banned;
SELECT * FROM users
WHERE isBanned = 0;
/*6. Изкарайте всички потребители от базата като ги наредите по име в азбучен ред и
дата на раждане(от най-младия към най-възрастния).*/

SELECT * FROM users
ORDER BY birthDate ASC, username ASC

/*7. Изкарайте всички потребители от базата, на които потребителското име започва с
a.*/;
SELECT * FROM users
WHERE username LIKE 'a%'

/*8. Изкарайте всички потребители от базата, които съдържат а username името си.*/;
SELECT * FROM users
WHERE username LIKE '%a%'

/*9. Изкарайте всички потребители от базата, чието име се състои от 2 имена.*/;

SELECT * FROM  users
WHERE 
   (username REGEXP '([[:space:]]|[[:space:]]$)')

/*10. Регистрирайте 1 юзър през UI-а и го забранете след това от базата.*/;
UPDATE users
SET isBanned = 1
WHERE id = 35;


-- 11. Брой на всички постове.;
SELECT count(id) FROM posts

-- 12. Брой на всички постове групирани по статуса на post-a.;

SELECT count(id), postStatus FROM posts
GROUP BY postStatus
ORDER BY count(id)

-- 13. Намерете поста/овете с най-къс caption.;
SELECT min(caption) FROM posts

-- 14. Покажете поста с най-дълъг caption.;
SELECT max(caption) FROM posts

-- 15. Кой потребител има най-много постове. ;
SELECT users.username, count(*) AS CountOfPosts
FROM posts
INNER JOIN users ON posts.userid = users.id
GROUP BY username
ORDER BY count(*) DESC
LIMIT 1;

-- 16. Кои потребители имат най-малко постове;
SELECT users.username, count(*) AS CountOfPosts
FROM posts
INNER JOIN users ON posts.userid = users.id
GROUP BY username
ORDER BY count(*) ;

-- 17. Колко потребителя с по 1 пост имаме. ;
SELECT users.username, count(*) AS CountOfPosts
FROM posts
INNER JOIN users ON posts.userid = users.id
GROUP BY username
HAVING CountofPosts = 1
ORDER BY username ASC;

-- 18. Колко потребителя с по малко от 5 поста имаме. ;
SELECT users.username, count(*) AS CountOfPosts
FROM posts
INNER JOIN users ON posts.userid = users.id
GROUP BY username
HAVING CountOfPosts < 5
ORDER BY username ASC;

-- 19. Кои са постовете с най-много коментари;
SELECT id,caption,commentsCount 
FROM posts
WHERE commentsCount != 0
ORDER BY commentsCount DESC;

-- 20. Покажете най-стария пост;
SELECT caption, createdAt FROM posts
ORDER BY createdAt DESC;

-- 21. Покажете най-новия пост;
SELECT caption, createdAt FROM posts
ORDER BY createdAt ASC;

-- 22. Покажете всички постове с празен caption.;
SELECT * FROM posts
WHERE caption = ' ' OR caption IS NULL;

/*23. Създайте потребител през UI-а, добавете му public пост през базата и проверете
дали се е създал през UI-а.*/;

INSERT INTO posts (id, caption, coverUrl , postStatus, userId )
VALUES (100, 'dsa' ,'https://i.imgur.com/iGLY89p.jpg' , 1 , 73 );
select * from posts
WHERE userId = 73;

-- 24. Покажете всички постове и коментарите им ако имат такива.;
SELECT posts.caption AS PostCaption , comments.content AS Comments 
FROM posts
LEFT JOIN comments 
ON  posts.id = comments.postId 
OR posts.caption = comments.content


-- 25. Покажете само постове с коментари и самите коментари.;
SELECT posts.caption AS PostCaption , comments.content AS Comments 
FROM posts
RIGHT JOIN comments 
ON  posts.id = comments.postId 
OR posts.caption = comments.content
ORDER BY posts.caption

-- 26. Покажете името на потребителя с най-много коментари.;
SELECT users.username , posts.commentsCount FROM users
RIGHT JOIN posts ON users.id = posts.id
WHERE posts.commentsCount != 0
ORDER BY posts.commentsCount DESC
LIMIT 1;


-- 27. Покажете всички коментари, към кой пост принадлежат и кой ги е направил. ;
SELECT comments.content , posts.caption , posts.userId 
FROM posts
JOIN comments 
ON posts.userId = comments.postId
OR posts.userId = comments.userId

-- 28. Кои потребители са like-нали най-много постове.;
SELECT users.username, COUNT(users_liked_posts.postsId) AS CountOfLikes  
FROM users
JOIN users_liked_posts 
ON users.id = users_liked_posts.usersId
GROUP BY usersId
ORDER BY COUNT(usersId) DESC;

-- 29. Кои потребители не са like-вали постове.;
SELECT users.username, users_liked_posts.postsId AS CountOfLikes  
FROM users
LEFT JOIN users_liked_posts 
ON users.id = users_liked_posts.usersId
WHERE users_liked_posts.postsId IS NULL

-- 30. Кои постове имат like-ове. Покажете id на поста и caption;
SELECT posts.caption , posts.Id , users.username
FROM users_liked_posts
LEFT JOIN posts 
ON posts.id = users_liked_posts.postsId
LEFT JOIN users ON users.id = users_liked_posts.usersId


-- 31. Кои постове имат най-много like-ове. Покажете id на поста и caption;
SELECT posts.caption, posts.id
FROM users_liked_posts
JOIN posts 
ON posts.userId = users_liked_posts.usersId
GROUP BY id , usersId
ORDER BY users_liked_posts.usersId

-- 32. Покажете всички потребители, които не follow-ват никого.;
SELECT users.username, users_followers_users.usersId_2
 FROM users
LEFT JOIN users_followers_users 
ON users.id = users_followers_users.usersId_1
WHERE usersId_2 IS NULL

-- 33. Покажете всички потребители, които не са follow-нати от никого;
SELECT users.username, users_followers_users.usersId_2
FROM users
LEFT JOIN users_followers_users 
ON users.id = users_followers_users.usersId_1
WHERE usersId_2 IS NULL











