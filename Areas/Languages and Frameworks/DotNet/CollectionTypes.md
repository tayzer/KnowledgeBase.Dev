# .NET Collection Types
Date: 2026-06-14
Status: 🟡 Needs Review
Tags: #csharp #dotnet #collections #performance #api-design

## 🎯 TL;DR / Quick Reference

**Definition:** .NET collection types model different data shapes and access patterns such as ordered lists, key-value maps, sets, queues, and stacks.

**When to use:**
- You need to choose the right in-memory data structure for correctness, API clarity, and performance.
- You want to understand the tradeoffs between concrete collection types and collection interfaces.

**Key Takeaways:**
- ✅ **Choose by access pattern first**: indexing, key lookup, membership testing, append, or FIFO/LIFO behavior.
- ✅ **Use `List<T>` as the default mutable sequence** unless a different shape is clearly required.
- ✅ **Expose narrower interfaces in APIs** such as `IEnumerable<T>` or `IReadOnlyList<T>` when callers do not need mutation.
- ⚠️ **Read-only is not immutable**: `IReadOnlyList<T>` can still wrap mutable backing state.
- ⚠️ **Collection choice affects performance** through allocation, locality, hashing, resizing, and enumeration behavior.

---

## 📚 Deep Dive

### Quick Chooser
- **`T[]` / Array:** fixed-size, contiguous storage; best when size is known and you want fast indexing with low overhead.
- **`List<T>`:** default growable ordered collection.
- **`Dictionary<TKey, TValue>`:** key-based lookup.
- **`HashSet<T>`:** uniqueness and fast membership checks.
- **`Queue<T>`:** first-in, first-out processing.
- **`Stack<T>`:** last-in, first-out processing.
- **`LinkedList<T>`:** rare specialized cases with node-based insertion/removal.
- **`IReadOnlyList<T>` / `IEnumerable<T>`:** API contracts, not storage choices.

### Deep-Dive Notes
- [[List]] - Growth, capacity planning, API design, and common performance pitfalls.
- [[Dictionary]] - Key semantics, comparer choices, and lookup-centric design.
- [[HashSet]] - Uniqueness, membership checks, and practical set operations.

### Mental Model
Most collection decisions are driven by three questions:
- What shape is the data: sequence, map, set, queue, or stack?
- Who owns mutation: current method, caller, multiple threads, or nobody?
- What operation matters most: lookup by index, lookup by key, membership test, append, insert, or iteration?

### Core Concrete Types

#### `T[]` (Array)
- Best when count is fixed or known up front.
- Fast indexed access and good cache locality.
- Fixed size, but element values remain mutable.

Common trap:
- Arrays are not a general replacement for growable collections. Resizing means allocating a new array and copying values.

#### `List<T>`
- Best default for mutable ordered data.
- Good for append-heavy workflows and indexed access.
- Backed by an array, so it has strong locality and generally performs well.

Common traps:
- Repeated insert/remove near the front or middle is expensive because elements shift.
- Unbounded growth can trigger reallocations; use capacity when size is predictable.

#### `Dictionary<TKey, TValue>`
- Best for lookup by key.
- Use when callers think in identifiers rather than positions.
- Performance depends heavily on good equality and hashing behavior.

Common traps:
- Custom key types need correct equality semantics.
- Dictionary iteration order should not be treated as a business contract unless you explicitly control it.

#### `HashSet<T>`
- Best for fast membership checks and uniqueness.
- Useful for deduplication, exclusion lists, and set-style operations.

Common trap:
- Like `Dictionary`, it depends on correct equality and hash code behavior.

#### `Queue<T>` and `Stack<T>`
- Use `Queue<T>` when processing items in arrival order.
- Use `Stack<T>` for reverse-order workflows, parsing, undo behavior, or traversal algorithms.

Common trap:
- If callers need arbitrary indexing or removal, these are probably the wrong abstraction.

#### `LinkedList<T>`
- Usually not the default choice in modern .NET.
- Theoretical insertion/removal benefits often lose to `List<T>` because pointer chasing hurts locality and each node adds allocation overhead.

Use only when:
- You need stable nodes and frequent insert/remove operations around known nodes.

### Collection Interfaces and API Design

#### `IEnumerable<T>`
- Means "this can be enumerated."
- Good for streaming, pipelines, and minimal input requirements.

Important:
- It does not guarantee cheap `Count`, indexing, repeatability, or materialized storage.

#### `IReadOnlyCollection<T>`
- Adds a `Count` contract without exposing mutation.
- Good when callers need size but not indexing.

#### `IReadOnlyList<T>`
- Adds indexed access without exposing mutation.
- Good return type when order and indexing matter.

#### `ICollection<T>` and `IList<T>`
- Expose mutation capabilities.
- Use when mutation by the caller is genuinely part of the contract.

Practical rule:
- Accept the narrowest interface you need.
- Return the most useful contract you can honestly guarantee.

### Read-Only vs Immutable vs Concurrent
- **Read-only interface:** prevents mutation through that reference, but underlying data may still change.
- **Immutable collection:** updates return a new collection or structure; useful for shared snapshots and safer public surfaces.
- **Concurrent collection:** designed for multi-threaded coordination, not just general-purpose storage.

Choose immutable when:
- Shared read-mostly state matters more than write throughput.

Choose concurrent when:
- Multiple threads coordinate over a shared collection and the concurrency semantics are intentional.

### Performance Tradeoffs
- Arrays and lists usually win for sequential access and locality.
- Dictionaries and sets trade ordering for fast lookup.
- Materializing with `ToList()` or `ToArray()` costs memory but can avoid repeated enumeration.
- Hash-based collections depend on comparer quality.
- The wrong abstraction can hide expensive operations behind a simple-looking API.

### LINQ Interactions
Collection semantics influence how LINQ behaves:
- LINQ over `IEnumerable<T>` may be lazy and re-execute on each enumeration.
- Repeated enumeration can be wasteful for expensive sources.
- `ToArray()` is often a good endpoint for fixed-size snapshots.
- `ToList()` is often a good endpoint when callers need indexed mutable access.

If performance is critical, profile whether a direct loop is clearer and faster than a long LINQ pipeline.

## 🧭 Practical Selection Guide
- Need ordered mutable items: use `List<T>`.
- Need fixed-size indexed data: use `T[]`.
- Need key lookup: use `Dictionary<TKey, TValue>`.
- Need fast membership or deduplication: use `HashSet<T>`.
- Need FIFO processing: use `Queue<T>`.
- Need LIFO processing: use `Stack<T>`.
- Need to expose results without mutation: use `IReadOnlyList<T>` or `IReadOnlyCollection<T>`.
- Need only iteration: use `IEnumerable<T>`.

## 🧪 Practice Exercises
1. Replace a `List<T>` used only for membership checks with `HashSet<T>` and explain the tradeoff.
2. Review one public API and decide whether its parameter or return type should be `IEnumerable<T>`, `IReadOnlyList<T>`, or `List<T>`.
3. Take a hot path that uses repeated dictionary lookups or LINQ materialization and measure whether a simpler collection choice reduces cost.

## 🔗 Related Concepts
- [[Linq]]
- [[Immutable and Concurrent Collections]]
- [[CSharp Fundamentals]]
- [[GenericsConstraints]]
- [[NullableReferenceTypes]]
- [[EntityFramework/MemoryAllocations]]
- [[Encapsulation]]

## 📖 Resources
- Microsoft Docs: Collections in .NET
- Microsoft Docs: Choosing between collection classes

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months