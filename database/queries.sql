USE ActivityHubDB;
GO

-- 1. View all users
SELECT *
FROM Users;
GO

-- 2. View users and the groups they joined
SELECT
    u.nickname,
    g.group_name,
    gm.role
FROM GroupMembers gm
JOIN Users u
    ON gm.user_id = u.user_id
JOIN Groups g
    ON gm.group_id = g.group_id
ORDER BY g.group_name, gm.role, u.nickname;
GO

-- 3. View posts with group and author information
SELECT
    p.post_id,
    g.group_name,
    p.title,
    u.nickname AS author,
    p.created_at
FROM Posts p
JOIN Groups g
    ON p.group_id = g.group_id
JOIN Users u
    ON p.author_id = u.user_id
ORDER BY p.post_id;
GO

-- 4. Count comments for every post, including posts with no comments
SELECT
    p.post_id,
    p.title,
    COUNT(c.comment_id) AS comment_count
FROM Posts p
LEFT JOIN Comments c
    ON p.post_id = c.post_id
GROUP BY
    p.post_id,
    p.title
ORDER BY p.post_id;
GO

-- 5. Count participants by event status
SELECT
    e.event_id,
    e.title,
    ep.status,
    COUNT(*) AS participant_count
FROM Events e
JOIN EventParticipants ep
    ON e.event_id = ep.event_id
GROUP BY
    e.event_id,
    e.title,
    ep.status
ORDER BY
    e.event_id,
    ep.status;
GO