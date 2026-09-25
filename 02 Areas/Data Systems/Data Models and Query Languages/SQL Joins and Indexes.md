---
date: 2026-06-14
status: Needs Review
tags:
  - sql
  - databases
  - joins
  - indexes
  - performance

---

Separate these
# SQL Joins and Indexes

## Quick Reference

**Definition:** Joins combine rows across related tables; indexes speed up data access paths for filters, joins, sorting, and lookups.

An index provides an access path for selected rows. Without a useful index, an engine may scan the table; even with an index, its optimizer may choose a scan when that costs less.

Indexes are created on one or more columns and allow the engine to look things up much faster. However, they come with a cost, so it's important to understand when and how to use them.

**When to use:**
- You work with relational databases and need reliable query performance.
- You want to understand why one query is fast and another is slow.

**Key Takeaways:**
- **Choose the right join type** based on result intent, not habit.
- **Index for real query patterns** (WHERE, JOIN, ORDER BY), not every column.
- Caution: **Indexes are not free**: they consume storage and slow inserts/updates/deletes.
- Caution: **Measure plans, not assumptions**: use EXPLAIN/actual execution plans.

**Limit:** An index helps only when the optimizer and workload make its read benefit worth storage and write cost.

---

## Deep Dive

### Join Fundamentals
A join combines rows from two or more tables using a predicate, usually key equality.

Common patterns:
- One-to-many: `Customers -> Orders`
- Many-to-many: `Students -> StudentCourses -> Courses` (bridge table)

### Join Types
- **INNER JOIN:** returns rows with matches on both sides.
- **LEFT JOIN:** returns all rows from the left table and matching rows from the right (or NULL when no match).
- **RIGHT JOIN:** mirror of LEFT JOIN (less commonly used in practice).
- **FULL OUTER JOIN:** returns matched rows plus non-matching rows from both sides.
- **CROSS JOIN:** Cartesian product (usually intentional only for specific cases).
- **SELF JOIN:** table joined to itself, often for hierarchies or comparisons.

### Choosing Join Type by Intent
- Need only records with related data: use INNER JOIN.
- Need all parent records even if child is missing: use LEFT JOIN.
- Need unmatched rows from both sides (reconciliation): use FULL OUTER JOIN.

### Join Pitfalls
- Missing join predicates can accidentally create huge Cartesian products.
- Joining on non-unique columns can duplicate rows unexpectedly.
- Filtering after LEFT JOIN in the WHERE clause can accidentally turn it into INNER JOIN behavior.

Example pattern to preserve LEFT JOIN semantics:
```sql
SELECT c.CustomerId, o.OrderId
FROM Customers c
LEFT JOIN Orders o
    ON o.CustomerId = c.CustomerId
    AND o.Status = 'Open';
```

## Index Fundamentals

### What an Index Is
An index is a separate data structure (often a B-tree) that helps the engine find rows without scanning the full table.

### Why Indexes Help
Indexes reduce work for:
- Filtering (`WHERE`)
- Joins (`ON`)
- Sorting (`ORDER BY`)
- Grouping (`GROUP BY`)
- Uniqueness constraints (`UNIQUE`)

### Core Index Types (Conceptual)
- **Clustered index:** in SQL Server, organizes table rows in a B-tree by the clustering key; query result order still requires `ORDER BY`. Other engines use different terminology and storage behavior.
- **Nonclustered index:** separate structure pointing to table rows.
- **Composite index:** multiple columns in a defined order.
- **Unique index:** enforces uniqueness and can improve lookup speed.

### Composite Index Ordering Rule
For an index on `(A, B, C)`, common B-tree left-prefix access patterns include:
- `A`
- `A, B`
- `A, B, C`

It is usually less effective for filtering by only `B` or only `C`.

### Covering Index Concept
A covering index includes all columns needed by a query (seek + output), so the engine avoids extra lookups.

Example:
```sql
-- Query pattern:
-- SELECT OrderDate, Total FROM Orders WHERE CustomerId = ? AND Status = ?;

-- Useful index shape (syntax varies by database):
-- Key columns for filtering first, projected columns included where supported.
```

## Tradeoffs and Rules of Thumb

### Good Defaults
- Index foreign keys used in joins.
- Index columns or expressions used by costly recurring queries when a measured plan and write cost justify it.
- Add composite indexes for recurring multi-column predicates.

### Avoid Over-Indexing
Too many indexes can:
- Increase write latency.
- Increase storage use.
- Increase maintenance overhead (rebuilds, stats, fragmentation management).

### Query Design and Sargability
A predicate is usually more index-friendly when it is sargable (search-argument-able).

Prefer:
```sql
WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01'
```
Over patterns that wrap indexed columns in functions:
```sql
WHERE YEAR(OrderDate) = 2026
```

## Practical Workflow for Tuning
1. Start with a slow query and capture real execution plan.
2. Confirm cardinality assumptions (row counts and selectivity).
3. Ensure join predicates match keys and data types.
4. Add or adjust indexes based on query shape.
5. Re-check execution plan and latency.
6. Validate write-impact and regression risk.

## Quick Checklist
- Join keys correct and indexed?
- Unintended row multiplication checked?
- WHERE predicates sargable?
- ORDER BY/GROUP BY backed by useful index order?
- Execution plan validated before and after changes?

## Engine-aware index decisions

The leftmost-prefix examples are common for B-tree composite indexes, but optimizers and access methods vary; check the chosen engine's plan. Index recurring query predicates, not just columns with high selectivity. Compare plan, latency, write cost, and storage before and after. In SQL Server a clustered index organizes row storage, but only ORDER BY guarantees output order. Consider splitting joins and indexing into linked notes later if navigation becomes unwieldy.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[QueryOptimisations]]
- [[Repository Pattern]]

## Resources

- [Primary documentation](https://www.postgresql.org/docs/18/using-explain.html) (accessed 2026-09-24).
- Use your database engine docs for: execution plans, index types, and statistics behavior.
- SQL tuning references specific to your primary engine (PostgreSQL, SQL Server, MySQL, Oracle).
- [PostgreSQL: Using EXPLAIN](https://www.postgresql.org/docs/18/using-explain.html) (checked 2026-09-24).
- [SQL Server index design guide](https://learn.microsoft.com/en-us/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver17) (checked 2026-09-24).

## Practice Exercises
1. Write one query each using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN (or equivalent workaround) on the same schema and compare results.
2. Pick one slow query, inspect its plan, then add one index and measure impact on read latency and write cost.
3. Design a composite index for a dashboard query with filters and sorting; explain column order choice.

## Review Schedule
- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.

- [ ] Before setting this note to Current: Run SQL examples and execution plans on the target database engine.
