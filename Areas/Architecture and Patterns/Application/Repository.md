# Repository Pattern
Date: 2025-11-25
Status: 🟢 Current
Tags: #design-patterns #architecture #data-access #csharp #testing

## 🎯 TL;DR / Quick Reference

**Definition:** A design pattern that mediates between the domain and data mapping layers using a collection-like interface for accessing domain objects.

**When to use:**
- To decouple business logic from data access details (SQL, EF Core, File System).
- To make code unit-testable by mocking data access.
- To centralize query logic (e.g., "GetActiveUsers") to avoid duplication.

**Key Takeaways:**
- ✅ **Abstraction:** The calling code shouldn't know if data comes from a DB or a web service.
- ✅ **Testability:** Easy to swap with an `InMemoryRepository` for tests.
- ✅ **Consistency:** Prevents scattered LINQ queries throughout the codebase.
- ⚡ **Performance:** Be careful not to hide performance pitfalls (like N+1 problems) behind the abstraction.

**Code Snippet:**
```csharp
public interface IUserRepository
{
    Task<User?> GetByIdAsync(int id);
    Task<IEnumerable<User>> GetActiveUsersAsync();
    void Add(User user);
    // Note: SaveChanges is usually on the UnitOfWork, not here.
}

public class EfUserRepository : IUserRepository
{
    private readonly AppDbContext _context;
    public EfUserRepository(AppDbContext context) => _context = context;

    public async Task<User?> GetByIdAsync(int id) => 
        await _context.Users.FindAsync(id);

    public async Task<IEnumerable<User>> GetActiveUsersAsync() =>
        await _context.Users.Where(u => u.IsActive).ToListAsync();

    public void Add(User user) => _context.Users.Add(user);
}
```

**Gotchas:**
- ⚠️ **Generic Repository Trap:** Avoid `IRepository<T>` for everything. It often leads to leaky abstractions (`IQueryable` leaking out). Prefer specific repositories (`IUserRepository`) or a hybrid approach.
- ⚠️ **IQueryable Leaks:** Returning `IQueryable<T>` from a repository defeats the purpose of the pattern, as the controller/service can modify the query (coupling them to the DB schema).
- ⚠️ **Over-abstraction:** With EF Core, the `DbSet` is already a repository and `DbContext` is a Unit of Work. For simple apps, a repository layer might be overkill.

---

## 📚 Deep Dive

### Conceptual Foundation
The Repository pattern creates an illusion that your data is just a collection in memory. You "Add" to it, "Remove" from it, and "Get" items from it. The repository handles the plumbing of actually persisting that to a database.

### Implementation Details

#### The Generic vs. Specific Debate

**Generic Repository:**
Good for basic CRUD, but bad for complex logic.
```csharp
public interface IRepository<T> {
    T Get(int id);
    void Add(T entity);
}
```

**Specific Repository (Recommended):**
Tailored to the domain needs.
```csharp
public interface IOrderRepository {
    Task<Order> GetOrderWithLinesAsync(int id); // Specific fetch requirement
}
```

#### Repository + Unit of Work
Repositories handle *collections* of objects. The Unit of Work handles the *transaction*.
If you modify a User and an Order, you want them saved together.

```csharp
// Service Layer
public async Task PlaceOrder(Order order)
{
    _orderRepo.Add(order);
    _inventoryRepo.DecrementStock(order.Items);
    
    // Commit both changes in one transaction
    await _unitOfWork.SaveChangesAsync(); 
}
```

### Performance Considerations

1.  **Lazy Loading:** If your repository returns entities connected to other entities, be wary of lazy loading triggering N+1 queries outside the repository.
2.  **Tracking:** For read-only scenarios, use `.AsNoTracking()` inside the repository to save overhead.
    ```csharp
    public async Task<User> GetReadOnly(int id) => 
        await _context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.Id == id);
    ```

### Comparison with Alternatives

| Feature | Direct DbContext | Repository Pattern | CQRS (Query Handlers) |
| :--- | :--- | :--- | :--- |
| **Complexity** | Low | Medium | High |
| **Testability** | Hard (requires in-memory DB) | Easy (Mock interface) | Easy |
| **Flexibility** | High (LINQ everywhere) | Controlled | High (Specific queries) |
| **Best For** | Prototypes, Simple CRUD | Enterprise Apps, DDD | High Scale, Complex Domains |

### Real-World Example: Specification Pattern
To avoid exploding method counts (`GetActiveUsers`, `GetActiveUsersCreatedLastWeek`, etc.), combine Repositories with the **Specification Pattern**.

```csharp
public async Task<IEnumerable<T>> ListAsync(ISpecification<T> spec)
{
    // Apply spec.Criteria (Where) and spec.Includes (Join) to the DbSet
    return await _specificationEvaluator.GetQuery(_dbContext.Set<T>(), spec).ToListAsync();
}
```

---

## 🔗 Related Concepts
- [[RepositoryUnitOfWork]] - The combination of these two patterns.
- [[CleanArchitecture]] - Repositories are the bridge between Core and Infrastructure.
- [[EntityFramework/QueryOptimisations]] - How to write efficient queries inside repositories.

## 📖 Resources
- [Microsoft: Design the infrastructure persistence layer](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)
- [Martin Fowler: Repository](https://martinfowler.com/eaaCatalog/repository.html)
- [Ardalis.Specification](https://github.com/ardalis/Specification) (Library for Specification pattern)

## 🧪 Practice Exercises

1.  **Refactor:** Take a controller that uses `DbContext` directly and refactor it to use an `IProductRepository`.
2.  **Mocking:** Write a unit test for a `ProductService` using a `Mock<IProductRepository>` (using Moq or NSubstitute).
3.  **Cached Repository:** Create a `CachedProductRepository` (Decorator pattern) that wraps the real repository and caches results in memory for 5 minutes.

## 📝 Personal Notes
<!-- Add your own observations, project-specific snippets, or "aha!" moments here -->

## 🔄 Review Schedule
- [ ] Review in 6 months
