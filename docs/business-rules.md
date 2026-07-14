# Business Rules

## Overview

ActivityHub is a community platform where users join groups, share posts, write comments, and participate in group events.

## Rules

1. A user can join multiple groups.
2. A group can have multiple users.
3. A user cannot join the same group twice.
4. Every post belongs to one group and is written by one user.
5. Every comment belongs to one post and is written by one user.
6. Every event belongs to one group and is created by one user.
7. A user can participate in an event only once.
8. Activity logs are stored for auditing and performance analysis.

## Relationship Summary

- Users and Groups have a many-to-many relationship through GroupMembers.
- A Group can have multiple Posts.
- A User can write multiple Posts.
- A Post can have multiple Comments.
- A User can write multiple Comments.
- A Group can have multiple Events.
- A User can create multiple Events.
- Users and Events have a many-to-many relationship through EventParticipants.
- A User can have multiple ActivityLogs.