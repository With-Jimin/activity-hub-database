# ActivityHub

Database Design and Query Performance Optimization

## Project Overview

ActivityHub is a relational database project that simulates a community platform from a database administrator's perspective.

The project focuses on designing a scalable relational database, implementing SQL Server features, and improving query performance through execution plan analysis and index optimization.

The project focuses on:
- Database schema design
- Normalization
- Query optimization
- Execution plan analysis
- Index tuning
- SQL Server administration
- ASP.NET Core admin application with CRUD functionality

## Goals

- Learn Microsoft SQL Server
- Practice relational database design
- Analyze execution plans
- Optimize query performance
- Build an ASP.NET Core admin page

## Test Data

To evaluate query performance and index efficiency, the project includes an automated test data generation script.

| Table | Target Rows |
|-------|------------:|
| Posts | 100,000 |
| Comments | 500,000 |

The script automatically inserts only the required number of rows, allowing it to be executed multiple times without generating duplicate data.

Comments are evenly distributed across existing posts to provide a consistent dataset for performance testing.