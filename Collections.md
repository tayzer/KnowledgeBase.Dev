# C# Collections & Sequences: An Architect’s Reference

## The Core Distinction: `IEnumerable<T>` vs. Concrete Collections

- **`IEnumerable<T>`** → Represents a sequence of items that *can be* iterated. Think of it as a *recipe* for producing data. Often lazy (deferred execution).
  - *Note:* The interface itself does not guarantee laziness; materialized sources can also be exposed as `IEnumerable<T>`.
- **Concrete collections (`List<T>`, `Array`, `Dictionary<TKey,TValue>`)** → Represent data *stored in memory*. They are eagerly evaluated and immediately usable.

---

## `IEnumerable<T>`: The Read-Only, Forward-Only Sequence

- Exposes `GetEnumerator()` to loop items.
- Supports **deferred execution**: LINQ queries don’t execute until iteration.
- Common uses:
  - Method return type for **read-only contracts**.
  - EF Core query definitions (`IQueryable<T>` extends it).
  - Processing large files/streams with `yield return`.

**Example: Deferred Execution**
```csharp
var numbers = new List<int> { 1, 2, 3, 4, 5, 6 };
IEnumerable<int> evenNumbers = numbers.Where(n =>
{
    Console.WriteLine($"Evaluating {n}...");
    return n % 2 == 0;
});

Console.WriteLine("Query defined. About to iterate...");
foreach (var n in evenNumbers)
{
    Console.WriteLine($"Found even number: {n}");
}
```

---

## Concrete Collection Interfaces

### `ICollection<T>`
- Inherits from `IEnumerable<T>`.
- Adds size/mutation operations (`Count`, `Add`, `Remove`).
- Use when: you need collection modification, but not index access.

### `IList<T>`
- Inherits from `ICollection<T>`.
- Adds **index-based access**.
- Use when: you need ordering and random access.

### `List<T>`
- Concrete implementation of `IList<T>`.
- Default in-memory choice for general-purpose collections.
- Provides `Sort()`, `FindAll()`, `AddRange()`.

### `Array` (`T[]`)
- Fixed-size.
- Best raw index performance.
- Use when size is known in advance.

### `Dictionary<TKey,TValue>`
- Key-value pairs.
- Optimized for *O(1)* average lookups.

### `HashSet<T>`
- Unique items, no duplicates.
- Optimized for membership checks and set operations.

---

## Other Key Abstractions

### `IReadOnlyCollection<T>`
- Extends `IEnumerable<T>` with a `Count` property.
- Ideal for return types when you need immutability + constant-time count.

### `IQueryable<T>`
- Extends `IEnumerable<T>` with query tree support.
- LINQ providers (like EF) translate it to SQL or other queries.
- **Architectural note:** avoid returning `IQueryable<T>` from repositories/services. Materialize results and return `IEnumerable<T>` or DTOs.

### `Span<T>` / `Memory<T>`
- Stack-only or heap-safe memory abstractions.
- Provide slicing without allocations.
- Use in **performance-critical hot paths**, not as general-purpose collections.

---

## Architectural Rules of Thumb 🧠

1. **Method Parameters: Be liberal in what you accept.**
   - Accept `IEnumerable<T>` if you only need iteration.
   - Accept `ICollection<T>`/`IList<T>` if you require modification or indexing.
   ```csharp
   public void ProcessItems(IEnumerable<string> items)
   {
       foreach (var item in items) { /* ... */ }
   }
   ```

2. **Method Returns: Be conservative in what you return.**
   - Default: `IEnumerable<T>`.
   - If count is needed: `IReadOnlyCollection<T>`.
   - Only return `List<T>` if consumers must modify or need list-specific APIs.
   ```csharp
   private readonly List<string> _cache = new();
   public IEnumerable<string> GetItems() => _cache;
   ```

3. **Local Variables: Be specific in what you use.**
   - Use concrete collections (`List<T>`) internally for full functionality.
   - `var` usually handles this naturally.
   ```csharp
   var results = new List<string>();
   results.Add("item");
   return results;
   ```

---

## Summary Table

| Feature              | `IEnumerable<T>`          | `IReadOnlyCollection<T>` | `ICollection<T>`       | `IList<T>`           | `List<T>` (Class) | `IQueryable<T>`             |
| -------------------- | ------------------------- | ------------------------ | ---------------------- | -------------------- | ----------------- | --------------------------- |
| **Primary Purpose** | Sequence contract          | Read-only collection     | Modifiable group       | Ordered/indexed      | General-purpose   | Deferred query (LINQ tree)  |
| **Execution**       | Often deferred (lazy)      | Eager                    | Eager                  | Eager                | Eager             | Deferred until materialized |
| **Can Modify?**     | No                         | No                       | Yes                    | Yes                  | Yes               | No (query only)             |
| **Has `Count`?**    | No                         | Yes                      | Yes                    | Yes                  | Yes               | Yes (when executed)         |
| **Indexed Access?** | No                         | No                       | No                     | Yes                  | Yes               | No                          |
| **Best Use Case**   | Return type, LINQ, streams | Return immutable + count | Modifiable parameters  | Indexed parameters   | Local variables   | EF queries, dynamic LINQ    |
