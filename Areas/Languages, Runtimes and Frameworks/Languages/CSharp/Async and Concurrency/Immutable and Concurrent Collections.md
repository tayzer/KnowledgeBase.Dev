# Immutable and Concurrent Collections
Date: 2026-06-14
Status: Needs Review
Tags: #csharp #dotnet #collections #immutability #concurrency

## 🎯 TL;DR / Quick Reference

**Definition:** Immutable collections avoid in-place mutation by producing updated versions, while concurrent collections are designed for safe multi-threaded coordination over shared state.

**When to use:**
- You need safer shared state than mutable collections provide.
- You are deciding whether read-only, immutable, or concurrent behavior is the right fit for a design.

**Key Takeaways:**
- ✅ **Immutable collections are for safer sharing** and snapshot-style updates.
- ✅ **Concurrent collections are for coordination** between threads, not just for general storage.
- ⚠️ **Read-only is not immutable**: a read-only interface can still expose changing backing data.
- ⚠️ **Neither family is a universal default**: both trade simplicity or write cost for specific guarantees.

---

## 📚 Deep Dive

### Immutable Collections
Immutable collections never change in place. Operations like add, remove, or replace return a new collection that reuses as much internal structure as possible.

Common examples:
- `ImmutableArray<T>`
- `ImmutableList<T>`
- `ImmutableDictionary<TKey, TValue>`
- `ImmutableHashSet<T>`

Why they help:
- Safer sharing across components because readers do not observe partial mutation.
- Easier reasoning in functional-style or state-snapshot workflows.
- Useful for configuration-like data, cached snapshots, and public APIs that should resist accidental mutation.

Tradeoffs:
- Writes are usually more expensive than mutating a `List<T>` or `Dictionary<TKey, TValue>`.
- Overusing them in write-heavy hot paths can add avoidable overhead.

### Concurrent Collections
Concurrent collections support access from multiple threads without requiring every caller to build its own locking discipline around a mutable collection.

Common examples:
- `ConcurrentDictionary<TKey, TValue>`
- `ConcurrentQueue<T>`
- `ConcurrentStack<T>`
- `BlockingCollection<T>`

Why they help:
- Reduce ad hoc locking for common producer-consumer and shared-lookup patterns.
- Make intent clearer than a plain `List<T>` guarded by scattered locks.

Tradeoffs:
- They do not remove the need to think about correctness, ordering, or higher-level concurrency design.
- Enumeration behavior and atomicity guarantees differ from normal collections and must be understood per type.

### Choosing Between Read-Only, Immutable, and Concurrent
- Use **read-only interfaces** when you only want to restrict what a caller can do through a particular reference.
- Use **immutable collections** when you want stable snapshots and safer sharing.
- Use **concurrent collections** when multiple threads actively coordinate over shared mutable state.

### Practical Guidance
- Prefer ordinary mutable collections when state is local and single-threaded.
- Prefer immutable collections when updates are less frequent than reads and sharing safety matters.
- Prefer concurrent collections when coordination is the real problem, especially queues and shared maps.
- Do not use concurrent collections just to avoid thinking about ownership.

### Common Pitfalls
- Returning `IReadOnlyList<T>` does not guarantee the underlying list will not change.
- Replacing a clean ownership model with a concurrent collection can hide deeper design problems.
- Immutable collections improve safety, but they do not make contained objects immutable.
- Using `ConcurrentDictionary<TKey, TValue>` does not automatically make compound workflows atomic.

## 🧭 Quick Decision Guide
- Need snapshot-style shared state: consider immutable collections.
- Need multi-threaded producer-consumer flow: consider `ConcurrentQueue<T>` or `BlockingCollection<T>`.
- Need shared key-based state across threads: consider `ConcurrentDictionary<TKey, TValue>`.
- Need only to prevent caller mutation, not global mutation: use `IReadOnlyList<T>` or `IReadOnlyCollection<T>`.

## 🧪 Practice Exercises
1. Take an API that currently returns `List<T>` and decide whether `IReadOnlyList<T>` or an immutable collection would better express its guarantees.
2. Compare a `lock`-wrapped `Dictionary<TKey, TValue>` with `ConcurrentDictionary<TKey, TValue>` and list what correctness concerns remain in both designs.
3. Identify one place in a codebase where snapshot semantics would simplify reasoning about shared state.

## 🔗 Related Concepts
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Collection Types]]
- [[Linq]]
- [[Encapsulation]]
- [[Areas/Languages, Runtimes and Frameworks/Languages/CSharp/Type System/Nullable Reference Types]]

## 📖 Resources
- Microsoft Docs: System.Collections.Immutable
- Microsoft Docs: Thread-safe collections

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 3 months
