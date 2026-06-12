# Async/Await Patterns
Date: 2025-11-25
Status: 🟢 Current
Tags: #async #concurrency #dotnet

## 🎯 TL;DR / Quick Reference

**Definition:** Asynchronous programming model in .NET using `async` and `await` to write non-blocking I/O and concurrency-friendly code.

**When to use:**
- I/O-bound work where you want to free threads for other work.

**Key Takeaways:**
- ✅ **Avoid blocking calls** in async methods; prefer `Task`-based APIs.
- ⚡ **ConfigureAwait(false)** in library code to avoid capturing synchronization context.

---

## 🔄 Review Schedule
- [ ] Review in 6 months
