# Business Rules

## Overview

ActivityHub is a community platform where users join groups, share posts, write comments, and participate in group events.

## Rules

1. A user can join multiple groups.
2. A group can have multiple users.
3. A user cannot join the same group twice.
4. Every post belongs to one group.
5. Every comment belongs to one post.
6. Every event belongs to one group.
7. A user can participate in an event only once.
8. Activity logs are stored for auditing and performance analysis.

## Relationship Summary

- Users and Groups have a many-to-many relationship.
- Posts belong to a single Group.
- Comments belong to a single Post.
- Events belong to a single Group.
- Users participate in Events through EventParticipants.