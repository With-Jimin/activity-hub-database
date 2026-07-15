USE ActivityHubDB;
GO

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    nickname NVARCHAR(50) NOT NULL,
    status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Users_Status DEFAULT 'ACTIVE',
    created_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_Users_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT CK_Users_Status
        CHECK (status IN ('ACTIVE', 'SUSPENDED', 'DEACTIVATED'))
);
GO

CREATE TABLE Groups (
    group_id INT IDENTITY(1,1) PRIMARY KEY,
    created_by INT NOT NULL,
    group_name NVARCHAR(100) NOT NULL,
    category NVARCHAR(50) NOT NULL,
    description NVARCHAR(1000),
    status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Groups_Status DEFAULT 'ACTIVE',
    created_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_Groups_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Groups_CreatedBy
        FOREIGN KEY (created_by)
        REFERENCES Users(user_id),

    CONSTRAINT CK_Groups_Status
        CHECK (status IN ('ACTIVE', 'INACTIVE'))
);
GO

CREATE TABLE GroupMembers (
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    role NVARCHAR(20) NOT NULL
        CONSTRAINT DF_GroupMembers_Role DEFAULT 'MEMBER',
    joined_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_GroupMembers_JoinedAt DEFAULT SYSDATETIME(),

    CONSTRAINT PK_GroupMembers
        PRIMARY KEY (group_id, user_id),

    CONSTRAINT FK_GroupMembers_Group
        FOREIGN KEY (group_id)
        REFERENCES Groups(group_id),

    CONSTRAINT FK_GroupMembers_User
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT CK_GroupMembers_Role
        CHECK (role IN ('OWNER', 'ADMIN', 'MEMBER'))
);
GO

CREATE TABLE Posts (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    group_id INT NOT NULL,
    author_id INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    created_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_Posts_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Posts_Group
        FOREIGN KEY (group_id)
        REFERENCES Groups(group_id),

    CONSTRAINT FK_Posts_Author
        FOREIGN KEY (author_id)
        REFERENCES Users(user_id)
);
GO

CREATE TABLE Comments (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    author_id INT NOT NULL,
    content NVARCHAR(1000) NOT NULL,
    status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Comments_Status DEFAULT 'ACTIVE',
    created_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_Comments_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Comments_Post
        FOREIGN KEY (post_id)
        REFERENCES Posts(post_id),

    CONSTRAINT FK_Comments_Author
        FOREIGN KEY (author_id)
        REFERENCES Users(user_id),

    CONSTRAINT CK_Comments_Status
        CHECK (status IN ('ACTIVE', 'DELETED'))
);
GO

CREATE TABLE Events (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    group_id INT NOT NULL,
    created_by INT NOT NULL,
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(1000),
    start_at DATETIME2(3) NOT NULL,
    end_at DATETIME2(3) NOT NULL,
    location NVARCHAR(255),
    status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Events_Status DEFAULT 'SCHEDULED',
    created_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_Events_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Events_Group
        FOREIGN KEY (group_id)
        REFERENCES Groups(group_id),

    CONSTRAINT FK_Events_CreatedBy
        FOREIGN KEY (created_by)
        REFERENCES Users(user_id),

    CONSTRAINT CK_Events_Status
        CHECK (status IN ('SCHEDULED', 'CANCELLED', 'COMPLETED')),

    CONSTRAINT CK_Events_DateRange
        CHECK (end_at > start_at)
);
GO

CREATE TABLE EventParticipants (
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_EventParticipants_Status DEFAULT 'REGISTERED',
    registered_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_EventParticipants_RegisteredAt DEFAULT SYSDATETIME(),

    CONSTRAINT PK_EventParticipants
        PRIMARY KEY (event_id, user_id),

    CONSTRAINT FK_EventParticipants_Event
        FOREIGN KEY (event_id)
        REFERENCES Events(event_id),

    CONSTRAINT FK_EventParticipants_User
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT CK_EventParticipants_Status
        CHECK (status IN ('REGISTERED', 'CANCELLED', 'ATTENDED'))
);
GO

CREATE TABLE ActivityLogs (
    activity_log_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    activity_type NVARCHAR(50) NOT NULL,
    target_type NVARCHAR(50),
    target_id INT,
    created_at DATETIME2(3) NOT NULL
        CONSTRAINT DF_ActivityLogs_CreatedAt DEFAULT SYSDATETIME(),

    CONSTRAINT FK_ActivityLogs_User
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id),

    CONSTRAINT CK_ActivityLogs_Target
        CHECK (
            (target_type IS NULL AND target_id IS NULL)
            OR
            (target_type IS NOT NULL AND target_id IS NOT NULL)
        )
);
GO