
-- We want to reward the user who has been around the longest, Find the 5 oldest users.

SELECT id,username,created_at
FROM users 
ORDER BY created_at
LIMIT 5; 
		
                       
-- To target inactive users in an email ad campaign, find the users who have never posted a photo.

SELECT username FROM users WHERE id NOT IN  (SELECT user_id FROM photos);

-- Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?

 SELECT u.username,p.id,count(photo_id) AS most_likes 
 FROM users u INNER JOIN photos p ON u.id=p.user_id
 JOIN likes l ON p.id=l.photo_id
 GROUP BY p.id
 ORDER BY most_likes DESC
 LIMIT 1;  

-- The investors want to know how many times does the average user post.
SELECT (SELECT count(*) FROM photos)/(SELECT count(*) FROM users) AS average_user_post;


-- A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

SELECT tag_name,count(tag_id) AS count 
FROM photo_tags p JOIN tags t
 ON p.tag_id=t.id
 GROUP BY tag_name
 ORDER BY count DESC
 LIMIT 5;

-- To find out if there are bots, find users who have liked every single photo on the site.


SELECT username,count(photo_id) AS count FROM likes l JOIN users u
ON l.user_id=u.id
GROUP BY user_id HAVING count = (SELECT count(*) FROM photos);

-- Find the users who have created instagramid in may and select top 5 newest joinees from it?

SELECT * FROM users
WHERE monthname(created_at)='may'
ORDER BY created_at DESC
LIMIT 5;


-- Can you help me find the users whose name starts with c and ends with any number 
-- and have posted the photos as well as liked the photos?

SELECT  DISTINCT username FROM users u JOIN photos p
ON u.id=p.id JOIN likes l
ON p.id=l.user_id
WHERE username REGEXP '^[c]' AND username REGEXP '[0-9]$';

-- Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
SELECT u.id,u.username,count(p.id) posted_photos FROM users u JOIN photos p 
ON u.id=p.user_id
GROUP BY user_id
HAVING posted_photos BETWEEN 3 AND 5
LIMIT 30;
