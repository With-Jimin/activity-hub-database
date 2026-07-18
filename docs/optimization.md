# Query Performance Optimization

## 1. Baseline Performance

### Test Query

```sql
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
```

### Measurement Method

- Enabled `SET STATISTICS IO ON`
- Enabled `SET STATISTICS TIME ON`
- Enabled Actual Execution Plan in SQL Server Management Studio

---

## 1.1 Small Dataset Baseline

### Logical Reads

| Table | Logical Reads |
| ------ | ------------: |
| Posts | 3 |
| Comments | 30 |

### Execution Plan

- Clustered Index Scan (Posts)
- Clustered Index Scan (Comments)
- Stream Aggregate
- Left Outer Join

### Notes

At this stage, the database contained only a small amount of data. Therefore, this result was recorded as the initial baseline before generating large-scale test data.

---

## 1.2 Large Dataset Baseline

### Test Data

| Table | Row Count |
| ------ | --------: |
| Posts | 100,000 |
| Comments | 500,000 |

### Statistics

| Metric | Value |
| ------ | ----: |
| CPU Time | 343 ms |
| Elapsed Time | 531 ms |
| Posts Logical Reads | 3,296 |
| Comments Logical Reads | 7,086 |

### Execution Plan

- Clustered Index Scan (Posts)
- Clustered Index Scan (Comments)
- Hash Match (Aggregate)
- Hash Match (Right Outer Join)
- Sort
- Parallelism

### Notes

After generating large-scale test data, SQL Server scanned all rows in both the `Posts` and `Comments` tables to calculate the number of comments per post.

The `Clustered Index Scan` on the `Comments` table accounted for the highest estimated query cost (58%), indicating that scanning the entire table was the most expensive operation in the execution plan.

This result serves as the baseline before applying additional indexes.

## 2. Index Design

### Index

```sql
CREATE NONCLUSTERED INDEX IX_Comments_PostId
ON Comments(post_id);
```

### Reason

The test query joins the `Posts` and `Comments` tables using the `post_id` column.

```sql
ON p.post_id = c.post_id
```

Although `Posts.post_id` is already indexed as the primary key, the `Comments.post_id` column did not have a separate nonclustered index.

A nonclustered index was created on `Comments(post_id)` to improve join performance and reduce the cost of accessing matching rows during query execution.

## 3. After Index

### Statistics

| Metric | Value |
| ------ | ----: |
| CPU Time | 140 ms |
| Elapsed Time | 517 ms |
| Posts Logical Reads | 3,137 |
| Comments Logical Reads | 876 |

### Execution Plan

- Clustered Index Scan (Posts)
- Nonclustered Index Scan (Comments)
- Stream Aggregate
- Merge Join

### Notes

After creating a nonclustered index on `Comments(post_id)`, SQL Server used the new index instead of scanning the clustered index.

The execution plan changed from a `Hash Match`-based plan to a `Merge Join` with a `Stream Aggregate`, reducing the logical reads on the `Comments` table from **7,086** to **876**.

As a result, CPU time decreased while the overall query became more efficient.

## 4. Comparison

| Metric | Before Index | After Index | Improvement |
| ------ | -----------: | ----------: | ----------: |
| CPU Time | 343 ms | 140 ms | **-59.2%** |
| Elapsed Time | 531 ms | 517 ms | **-2.6%** |
| Posts Logical Reads | 3,296 | 3,137 | **-4.8%** |
| Comments Logical Reads | 7,086 | 876 | **-87.6%** |

### Execution Plan Changes

#### Before Index

![Before Execution Plan](images/before_execution_plan.png)

#### After Index

![After Execution Plan](images/after_execution_plan.png)

### Key Changes

| Before | After |
| ------ | ----- |
| Clustered Index Scan (Comments) | Nonclustered Index Scan (Comments) |
| Hash Match | Merge Join |
| Hash Match (Aggregate) | Stream Aggregate |
| Sort | Removed |

## 5. Conclusion

Creating a nonclustered index on `Comments(post_id)` significantly improved query performance.

The optimizer selected a different execution plan after the index was added, replacing the `Clustered Index Scan` and `Hash Match` operators with a `Nonclustered Index Scan`, `Merge Join`, and `Stream Aggregate`.

The most significant improvement was observed in the `Comments` table, where logical reads decreased by **87.6%** (from **7,086** to **876**). CPU time was also reduced by **59.2%**, indicating a more efficient execution plan with lower I/O costs.

This experiment demonstrates how an appropriate index can reduce I/O operations and enable SQL Server to choose a more efficient execution plan.