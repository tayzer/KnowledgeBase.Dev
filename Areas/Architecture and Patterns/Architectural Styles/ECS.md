# Entity Component System (ECS)
Date: 2025-11-25
Status: 🟢 Current
Tags: #architecture #gamedev #design-patterns #performance #unity #dots

## 🎯 TL;DR / Quick Reference

**Definition:** An architectural pattern used primarily in game development that favors composition over inheritance. It separates data (Components) from behavior (Systems), with Entities serving merely as IDs to group them.

**When to use:**
- Games with massive numbers of active objects (thousands of units, particles).
- When inheritance hierarchies become too deep or complex ("Diamond of Death").
- To optimize for CPU cache locality (Data-Oriented Design).
- When building multiplayer games where state synchronization is critical.

**Key Takeaways:**
- ✅ **Composition over Inheritance:** Behavior is added by attaching components, not extending classes.
- ✅ **Data-Oriented:** Data is packed contiguously in memory, reducing cache misses.
- ✅ **Decoupling:** Systems don't know about each other; they just operate on components they care about.
- ⚡ **Performance:** Parallelization is much easier because systems declare their data dependencies upfront.

**Code Snippet (Conceptual):**
```csharp
// 1. Entity: Just an ID
public struct Entity { public int Id; }

// 2. Component: Pure Data
public struct Position { public float X, Y; }
public struct Velocity { public float Dx, Dy; }

// 3. System: Pure Logic
public class MovementSystem {
    public void Update(float deltaTime, ref Position pos, ref Velocity vel) {
        pos.X += vel.Dx * deltaTime;
        pos.Y += vel.Dy * deltaTime;
    }
}
```

**Gotchas:**
- ⚠️ **Paradigm Shift:** Requires unlearning OOP habits. No `player.Move()`. Instead, `MovementSystem` moves all things that have `Velocity`.
- ⚠️ **Boilerplate:** Can require more setup code than traditional OOP.
- ⚠️ **Inter-System Communication:** Can be tricky. Avoid systems calling systems. Use components as flags or event queues.

---

## 📚 Deep Dive

### Conceptual Foundation
ECS breaks the "God Object" problem where a `Player` class has 3000 lines of code handling rendering, physics, input, and inventory.

1.  **Entity:** A general-purpose object. Usually just a unique integer ID. It "has" nothing but an identity.
2.  **Component:** A raw data container. Has NO methods. (e.g., `Health`, `Position`, `Sprite`).
3.  **System:** The logic. Runs continuously (game loop). Queries for entities that have a specific set of components (e.g., "Give me all entities with `Position` AND `Velocity`") and processes them.

### Implementation Details

#### Memory Layout (The Secret Sauce)
In OOP, an array of `GameObject` pointers causes cache misses because the objects are scattered in the heap.
In ECS (Archetype-based), components of the same type are stored in contiguous arrays.

**OOP Memory:** `[Ptr] -> [Obj] ... [Ptr] -> [Obj]` (Random access)
**ECS Memory:** `[Pos, Pos, Pos] ... [Vel, Vel, Vel]` (Linear access)

#### Unity DOTS (Data-Oriented Technology Stack)
Unity's implementation of ECS.

```csharp
using Unity.Entities;
using Unity.Transforms;
using Unity.Mathematics;

// Component
public struct Speed : IComponentData
{
    public float Value;
}

// System
public partial struct MoveSystem : ISystem
{
    public void OnUpdate(ref SystemState state)
    {
        // Query: All entities with LocalTransform AND Speed
        foreach (var (transform, speed) in SystemAPI.Query<RefRW<LocalTransform>, RefRO<Speed>>())
        {
            transform.ValueRW.Position.y += speed.ValueRO.Value * SystemAPI.Time.DeltaTime;
        }
    }
}
```

### Performance Considerations

1.  **Cache Locality:** The CPU prefetcher loves linear arrays. ECS maximizes this.
2.  **SIMD (Single Instruction, Multiple Data):** Since data is aligned, compilers (like Unity's Burst Compiler) can vectorize operations, processing 4-8 floats at once.
3.  **Multithreading:** Systems that touch different components can run in parallel safely without locks.

### Comparison with Alternatives

| Feature | OOP (Monobehaviour) | ECS (Data-Oriented) |
| :--- | :--- | :--- |
| **Mental Model** | Objects doing things | Systems transforming data |
| **Data Layout** | Scattered (Heap) | Contiguous (Arrays/Chunks) |
| **Coupling** | High (References) | Low (Data matching) |
| **Performance** | Good for < 1000 objs | Excellent for > 10,000 objs |
| **Complexity** | Low (Intuitive) | High (Abstract) |

### Real-World Example: RTS Unit Management
In an RTS game with 5000 units:
- **OOP:** Each unit `Update()` checks distance to target. 5000 virtual calls per frame. Slow.
- **ECS:** `TargetingSystem` grabs two arrays: `Positions` and `Targets`. It runs a tight loop (vectorized) to update them. Blazing fast.

---

## 🔗 Related Concepts
- [[CleanArchitecture]] - Separation of concerns (Data vs Logic).
- [[Unity/Resources]] - Unity specific ECS (DOTS) resources.
- [[Concurrency/ThreadPool]] - How ECS systems are often scheduled.

## 📖 Resources
- [Unity DOTS Documentation](https://docs.unity3d.com/Packages/com.unity.entities@1.0/manual/index.html)
- [Overwatch Gameplay Architecture and Netcode](https://www.youtube.com/watch?v=W3aieHjyNvw) (GDC Talk - excellent ECS case study)
- [Data-Oriented Design](https://dataorienteddesign.com/dod/) (Richard Fabian)

## 🧪 Practice Exercises

1.  **Basic Mover:** Create a simple ECS simulation where entities with `Position` and `Velocity` bounce off the bounds of a 100x100 grid.
2.  **Tag Components:** Implement a "Paused" tag component. Modify your systems to ignore entities that have this tag.
3.  **System Dependencies:** Create a `DamageSystem` that reduces `Health`. Create a `DeathSystem` that runs *after* `DamageSystem` and removes entities with `Health <= 0`.

## 📝 Personal Notes
<!-- Add your own observations, project-specific snippets, or "aha!" moments here -->

## 🔄 Review Schedule
- [ ] Review in 6 months (Check Unity DOTS 1.0+ stability)
