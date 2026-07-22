<div align="center">

# ActivityHub

English · [한국어](README_ko.md)

**A database design and query performance optimization project.**

</div>

## Project Overview

ActivityHub is a database design project that simulates the backend of a community platform.

The project focuses on designing a relational database, implementing SQL Server features, and improving query performance through execution plan analysis and index optimization.

### Key Features

- Relational database design
- Database normalization
- Microsoft SQL Server
- Query optimization
- Execution plan analysis
- Index tuning
- ASP.NET Core MVC CRUD application

## Goals

- Design a normalized relational database
- Practice Microsoft SQL Server
- Analyze execution plans
- Optimize query performance
- Build an ASP.NET Core MVC admin application

## Test Data

To evaluate query performance and index efficiency, the project includes an automated test data generation script.

| Table | Target Rows |
|-------|------------:|
| Posts | 100,000 |
| Comments | 500,000 |

The script automatically inserts only the required number of rows, allowing it to be executed multiple times without generating duplicate data.

Comments are distributed across existing posts to create a realistic dataset for query performance testing.

## Documentation

Detailed documentation for each development phase is available in the `docs` directory.

| Document | Description |
|----------|-------------|
| [Business Rules](docs/business-rules.md) | Business rules and entity relationships |
| [Database Schema](docs/schema.md) | Database schema and table definitions |
| [Query Optimization](docs/optimization.md) | Execution plan analysis and index tuning |
| [AWS Practice](docs/aws-practice.md) | EC2 and S3 practice notes |