USE ActivityHubDB;
GO

INSERT INTO Users (email, nickname)
VALUES
('alice@example.com', 'Alice'),
('bob@example.com', 'Bob'),
('charlie@example.com', 'Charlie'),
('david@example.com', 'David'),
('emma@example.com', 'Emma');
GO

INSERT INTO Groups (created_by, group_name, category, description)
VALUES
(1, 'SQL Study', 'STUDY', 'A group for learning SQL and database fundamentals.'),
(3, 'Movie Club', 'HOBBY', 'A community for movie lovers to share reviews and recommendations.'),
(5, 'Travel Crew', 'TRAVEL', 'A group for planning trips and sharing travel experiences.');
GO

INSERT INTO GroupMembers (group_id, user_id, role)
VALUES
(1, 1, 'OWNER'),
(1, 2, 'ADMIN'),
(1, 3, 'MEMBER'),

(2, 3, 'OWNER'),
(2, 4, 'MEMBER'),

(3, 5, 'OWNER'),
(3, 1, 'MEMBER'),
(3, 4, 'MEMBER');
GO

INSERT INTO Posts (group_id, author_id, title, content)
VALUES
(1, 1, 'Welcome to SQL Study',
 'Welcome everyone! This group is for learning SQL and database concepts together.'),

(1, 2, 'SQL Server Installation Guide',
 'Here are the basic steps for installing SQL Server and SSMS.'),

(1, 3, 'Normalization Basics',
 'Normalization helps reduce redundancy and improve data consistency.'),

(1, 1, 'Practice Query Challenge',
 'Try solving these SQL practice questions before our next meeting.'),

(2, 3, 'Favorite Sci-Fi Movies',
 'What are your favorite science fiction movies?'),

(2, 4, 'Weekend Movie Night',
 'Lets watch a movie together this weekend!'),

(2, 3, 'Best Movies of 2025',
 'Share your favorite movies released this year.'),

(3, 5, 'Summer Trip Planning',
 'Lets discuss our travel plans for this summer.'),

(3, 1, 'Recommended Travel Destinations',
 'Here are some amazing places I would like to visit.'),

(3, 4, 'Travel Checklist',
 'Dont forget your passport, tickets, and travel insurance.');
GO

INSERT INTO Comments (post_id, author_id, content)
VALUES
(1, 2, 'Thanks for creating this group!'),
(1, 3, 'I am looking forward to studying together.'),

(2, 1, 'This guide will be helpful for new members.'),
(2, 3, 'I finished the installation successfully.'),

(3, 1, 'The explanation of normalization is clear.'),
(3, 2, 'Could you also explain third normal form?'),

(4, 2, 'I will try the challenge before the meeting.'),

(5, 4, 'Interstellar is one of my favorites.'),
(5, 3, 'I also enjoy classic science fiction movies.'),

(6, 3, 'Saturday evening works for me.'),

(8, 1, 'We should decide the budget first.'),
(8, 4, 'I can research transportation options.'),

(9, 5, 'Those destinations look great.');
GO

INSERT INTO Events (
    group_id,
    created_by,
    title,
    description,
    start_at,
    end_at,
    location
)
VALUES
(1, 1,
 'SQL Workshop',
 'Introduction to SQL Server and basic query practice.',
 '2026-07-20 14:00:00',
 '2026-07-20 16:00:00',
 'Room A'),

(2, 3,
 'Monthly Movie Night',
 'Watch a movie together and share reviews afterwards.',
 '2026-07-22 19:00:00',
 '2026-07-22 21:30:00',
 'Community Hall'),

(3, 5,
 'Summer Trip Meeting',
 'Discuss travel plans, budget, and transportation.',
 '2026-07-25 15:00:00',
 '2026-07-25 17:00:00',
 'Meeting Room 2'),

(1, 2,
 'Database Project Review',
 'Review database design and optimization progress.',
 '2026-07-28 18:00:00',
 '2026-07-28 20:00:00',
 'Online');
GO

INSERT INTO EventParticipants (event_id, user_id, status)
VALUES
(1, 1, 'REGISTERED'),
(1, 2, 'REGISTERED'),
(1, 3, 'REGISTERED'),

(2, 3, 'REGISTERED'),
(2, 4, 'CANCELLED'),

(3, 5, 'REGISTERED'),
(3, 1, 'REGISTERED'),
(3, 4, 'REGISTERED'),

(4, 1, 'REGISTERED'),
(4, 2, 'REGISTERED');
GO