USE ActivityHubDB;
GO

SET NOCOUNT ON;
GO

-----------------------------------------------------
-- Generate Test Data for Performance Testing
-- Target: 100,000 Posts
-----------------------------------------------------

DECLARE @TargetCount INT = 100000;
DECLARE @CurrentCount INT;
DECLARE @InsertCount INT;
DECLARE @CurrentMaxId INT;

SELECT
    @CurrentCount = COUNT(*),
    @CurrentMaxId = ISNULL(MAX(post_id), 0)
FROM Posts;

SET @InsertCount = @TargetCount - @CurrentCount;

IF @InsertCount <= 0
BEGIN
    PRINT 'Posts table already contains 100,000 or more rows.';
    RETURN;
END;

PRINT CONCAT('Generating ', @InsertCount, ' posts...');

;WITH Numbers AS
(
    SELECT TOP (@InsertCount)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO Posts
(
    group_id,
    author_id,
    title,
    content,
    created_at
)
SELECT
    ((n - 1) % 3) + 1,
    ((n - 1) % 5) + 1,
    CONCAT('Performance Test Post ', @CurrentMaxId + n),
    CONCAT(
        'This is automatically generated test content for performance testing. Post #',
        @CurrentMaxId + n
    ),
    DATEADD(MINUTE, n, '2026-01-01')
FROM Numbers;

PRINT 'Post generation completed.';
GO

-----------------------------------------------------
-- Generate Test Comments for Performance Testing
-- Target: 500,000 Comments
-----------------------------------------------------

DECLARE @TargetCount INT = 500000;
DECLARE @CurrentCount INT;
DECLARE @InsertCount INT;
DECLARE @CurrentMaxId INT;
DECLARE @PostCount INT;
DECLARE @UserCount INT;

-- Current Comments
SELECT
    @CurrentCount = COUNT(*),
    @CurrentMaxId = ISNULL(MAX(comment_id), 0)
FROM Comments;

-- Current Posts
SELECT
    @PostCount = COUNT(*)
FROM Posts;

-- Current Users
SELECT
    @UserCount = COUNT(*)
FROM Users;

-- Validation
IF @PostCount = 0
BEGIN
    PRINT 'No posts found. Generate Posts first.';
    RETURN;
END;

IF @UserCount = 0
BEGIN
    PRINT 'No users found.';
    RETURN;
END;

SET @InsertCount = @TargetCount - @CurrentCount;

IF @InsertCount <= 0
BEGIN
    PRINT 'Comments table already contains 500,000 or more rows.';
    RETURN;
END;

PRINT CONCAT('Generating ', @InsertCount, ' comments...');

;WITH Numbers AS
(
    SELECT TOP (@InsertCount)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO Comments
(
    post_id,
    author_id,
    content,
    created_at
)
SELECT
    ((n - 1) % @PostCount) + 1,
    ((n - 1) % @UserCount) + 1,
    CONCAT(
        'Performance Test Comment ',
        @CurrentMaxId + n
    ),
    DATEADD(SECOND, n, '2026-01-01')
FROM Numbers;

PRINT 'Comment generation completed.';
GO

-----------------------------------------------------
-- Verify Row Counts
-----------------------------------------------------

PRINT '';
PRINT '========== Data Generation Summary ==========';

SELECT
    TableName,
    TotalRows
FROM
(
    SELECT 1 AS SortOrder, 'Users' AS TableName, COUNT(*) AS TotalRows
    FROM Users

    UNION ALL

    SELECT 2, 'Groups', COUNT(*)
    FROM Groups

    UNION ALL

    SELECT 3, 'Posts', COUNT(*)
    FROM Posts

    UNION ALL

    SELECT 4, 'Comments', COUNT(*)
    FROM Comments

    UNION ALL

    SELECT 5, 'Events', COUNT(*)
    FROM Events

    UNION ALL

    SELECT 6, 'ActivityLogs', COUNT(*)
    FROM ActivityLogs
) AS RowCounts
ORDER BY SortOrder;

PRINT '=============================================';
PRINT 'Test data generation completed successfully.';
GO