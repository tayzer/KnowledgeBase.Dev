# LINQ (Language Integrated Query)
Date: 2026-06-14
Status: 🟢 Current
Tags: #csharp #dotnet #linq #functional-programming #performance

## 🎯 TL;DR / Quick Reference

**Definition:** A uniform query syntax in C# to retrieve and manipulate data from different sources (collections, databases, XML) using a consistent model.

**When to use:**
- Filtering, ordering, or projecting data from in-memory collections (`IEnumerable<T>`).
- Querying databases via Entity Framework Core (`IQueryable<T>`).
- Transforming data shapes (e.g., mapping DTOs).
- Performing set operations (Union, Intersect, Except).

**Key Takeaways:**
- ✅ **Deferred Execution:** Most operators (Where, Select) don't execute until you iterate (foreach, ToList).
- ✅ **IQueryable vs IEnumerable:** `IQueryable` can be translated by a provider before execution, while `IEnumerable` runs against in-memory or iterator-based sequences.
- ✅ **Execution model matters:** `IAsyncEnumerable<T>` streams results asynchronously instead of materializing everything first.
- ⚡ **Performance:** Be careful with `ToList()` too early; it pulls everything into memory.
- 🔒 **Non-mutating pipelines:** LINQ operations do not modify the source collection; they produce a new sequence definition or result.

**Code Snippet:**
```csharp
using System.Linq;

var activeUsers = users
    .Where(u => u.IsActive && u.LastLogin > DateTime.UtcNow.AddDays(-30))
    .OrderByDescending(u => u.LastLogin)
    .Select(u => new UserDto { Name = u.Name, Email = u.Email })
    .Take(10)
    .ToList(); // Executes here
```

**Gotchas:**
- ⚠️ **Multiple Enumeration:** Iterating a LINQ query twice (e.g., `Count()` then `foreach`) re-executes the query logic. Use `ToList()` or `ToArray()` to materialize if needed multiple times.
- ⚠️ **Capturing Variables:** Be aware of closure semantics when lambdas capture changing variables from surrounding code.
- ⚠️ **Client-side Evaluation:** In EF Core, some LINQ methods cannot be translated to SQL and will throw or pull data locally (implicit client eval is disabled in modern EF Core).
- ⚠️ **Hot paths:** LINQ readability is often worth it, but tight loops can pay measurable delegate, iterator, and allocation costs.

---

## 📚 Deep Dive

### Conceptual Foundation
LINQ brings functional programming concepts to C#. It treats data manipulation as a pipeline of operations.
- **Declarative:** You say *what* you want (`Where(x => x > 5)`), not *how* to get it (loops).
- **Type Safety:** Compile-time checking of queries.
- **Standard Query Operators:** A set of extension methods on `IEnumerable<T>` and `IQueryable<T>`.

### Execution Models
- **`IEnumerable<T>`:** in-memory or iterator-based pipelines evaluated during enumeration.
- **`IQueryable<T>`:** provider-backed queries where expression trees can be translated, for example into SQL.
- **`IAsyncEnumerable<T>`:** asynchronous streaming for results that arrive over time rather than all at once.

Knowing which model you are working with matters more than the surface syntax.

### Implementation Details

#### Method Syntax vs. Query Syntax
Method syntax (fluent API) is generally preferred in modern C# for its flexibility and support for all operators. Query syntax (SQL-like) is syntactic sugar.

```csharp
// Method Syntax (Preferred)
var result = data.Where(x => x > 10).Select(x => x * 2);

// Query Syntax
var result = from x in data
             where x > 10
             select x * 2;
```

#### Deferred vs. Immediate Execution
Understanding this is critical for performance.

**Deferred (Lazy):**
- `Where`, `Select`, `Take`, `Skip`
- The query is just a definition. Nothing happens until iteration.

**Immediate (Eager):**
- `ToList`, `ToArray`, `ToDictionary`, `Count`, `First`, `Any`
- Forces the query to execute immediately.

```csharp
var numbers = new List<int> { 1, 2, 3 };
var query = numbers.Select(n => n * 10); // No execution yet

numbers.Add(4); // Modify source

// Execution happens here - includes 4!
foreach (var n in query) 
{
    Console.WriteLine(n); // Outputs 10, 20, 30, 40
}
```

#### Operator Choice Patterns
- Use `Select` to transform one item into one result item.
- Use `SelectMany` to flatten nested collections.
- Use `Any()` for existence checks and short-circuit behavior.
- Use `GroupBy` carefully because grouping can hold significant data in memory.
- Use `Distinct`, `Intersect`, `Except`, and `Union` with awareness of equality semantics.

### Performance Considerations

1.  **Materialization:** Avoid `ToList()` until the very end of the chain.
2.  **Filtering:** Filter (`Where`) as early as possible to reduce the dataset size.
3.  **Any() vs Count():** Use `Any()` when you only care whether at least one item exists. It communicates intent and can short-circuit.
    ```csharp
    // ❌ Bad
    if (users.Count() > 0) { ... }
    
    // ✅ Good
    if (users.Any()) { ... }
    ```
4.  **Translation boundaries:** With `IQueryable<T>`, not every method can be translated by the provider. Know when execution switches from server-side to client-side.
5.  **Hot paths:** LINQ involves iterator and delegate overhead. For extremely hot paths, a plain `for` or `foreach` loop may be the better choice after profiling.

### Comparison with Alternatives
- **LINQ:** best when clarity, composability, and transformation pipelines matter most.
- **`foreach` loop:** often easier to debug step-by-step and a good middle ground for custom logic.
- **`for` loop:** useful when index control, in-place updates, or very hot paths matter.

Pick based on the real constraint: readability, provider translation, allocation pressure, or tight-loop performance.

### Real-World Example: Data Transformation Pipeline

```csharp
public class OrderProcessor
{
    public IEnumerable<OrderSummary> GetHighValueOrders(IEnumerable<Order> orders)
    {
        return orders
            // 1. Filter first
            .Where(o => o.Status == OrderStatus.Completed)
            .Where(o => o.TotalAmount > 1000)
            // 2. Sort
            .OrderByDescending(o => o.OrderDate)
            // 3. Project (Map)
            .Select(o => new OrderSummary 
            {
                OrderId = o.Id,
                CustomerName = o.Customer.Name,
                Total = o.TotalAmount,
                ItemCount = o.Items.Count
            });
    }
}
```

---

## 🔗 Related Concepts
- [[GenericsConstraints]] - LINQ relies heavily on generics.
- [[DelegatesEventsActions]] - `Func<T, bool>` predicates are the backbone of LINQ.
- [[ExpressionBodiedMembers]] - Often used with LINQ selectors.
- [[CollectionTypes]] - Source collection choice affects evaluation, materialization, and performance.
- [[EntityFramework/QueryOptimisations]] - LINQ to SQL translation.

## 📖 Resources
- [Microsoft Docs: LINQ (Language Integrated Query)](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/linq/)
- [101 LINQ Samples](https://linqsamples.com/)
- [MoreLINQ Library](https://github.com/morelinq/MoreLINQ) (Extensions for missing operators like `Batch`, `DistinctBy`)

## 🧪 Practice Exercises

1.  **Grouping:** Given a list of `Product` (Id, Category, Price), group them by `Category` and find the most expensive product in each category.
2.  **Flattening:** Use `SelectMany` to flatten a `List<Order>` where each order has a `List<OrderItem>`, to get a simple list of all items sold.
3.  **Set Operations:** Create two lists of integers. Find numbers present in both lists (`Intersect`) and numbers in the first but not the second (`Except`).

## 📝 Personal Notes
<!-- Add your own observations, project-specific snippets, or "aha!" moments here -->

## 🔄 Review Schedule
- [ ] Review in 3 months
