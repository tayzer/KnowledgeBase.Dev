# Async/Await Patterns
Date: 2025-11-25
Status: 🟢 Current
Tags: #async #concurrency #dotnet

## ⚠️ Canonical Location
This note is now maintained in [[V2/Design Patterns/Concurrency Patterns/Async]].

## 🎯 TL;DR / Quick Reference

**Definition:** Asynchronous programming model in .NET using `async`/`await` to write non-blocking I/O and concurrency-friendly code.

**When to use:**
- I/O-bound work where you want to free threads for other work.

**Key Takeaways:**
- ✅ **Avoid blocking calls** in async methods; prefer `Task`-based APIs.
- ⚡ **ConfigureAwait(false)** in library code to avoid capturing synchronization context.

---

## 🔄 Review Schedule
- [ ] Review in 6 months

