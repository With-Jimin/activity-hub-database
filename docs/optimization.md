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

### Initial Result

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

At this stage, the database contains only a small amount of data. Therefore, this result is used as the baseline for future performance comparison.

(To be updated)