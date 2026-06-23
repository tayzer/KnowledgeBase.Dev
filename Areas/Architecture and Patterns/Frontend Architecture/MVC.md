# Model-View-Controller (MVC)
Date: 2026-04-30
Status: 🟡 Needs Review
Tags: #mvc #architecture #web

## 🎯 TL;DR / Quick Reference

**Definition:** Architectural pattern separating concerns into Model (application state and behavior relevant to the view), View (UI), and Controller (input and interaction).

**When to use:**
- Web applications and UI-driven apps where separation of concerns improves maintainability.
- Applications where request handling, UI rendering, and application logic need clear but lightweight separation.

**Key Takeaways:**
- ✅ **Clear separation of concerns** improves testability and team workflows.
- ⚡ **Controllers** coordinate models and views but should remain thin.
- ⚠️ **MVC is not a license for fat controllers**: business rules still belong outside the web layer.

---

## 📚 Deep Dive

### Roles In MVC
- **Model:** the data and state the application works with. Depending on the framework and application style, this may mean domain models, view models, or DTOs.
- **View:** the rendering layer responsible for presenting data.
- **Controller:** the coordinator that receives input, invokes application behavior, and selects the response or view.

### Good Fit
- Server-rendered web applications.
- Frameworks where routing, controllers, and views are first-class concepts.
- Systems that need a familiar and well-understood web architecture without introducing unnecessary architectural complexity.

### Common Pitfalls
- Controllers that accumulate validation, business rules, mapping, persistence, and formatting logic.
- Confusing domain models with view models and letting presentation needs distort core concepts.
- Treating MVC as the whole architecture instead of just the presentation pattern.

### Practical Guidance
- Keep controllers thin and push business behavior into application or domain services.
- Use dedicated view models when the view's needs differ from domain structures.
- Be explicit about where request mapping, validation, and persistence responsibilities live.

## 🔗 Related Concepts
- [[Repository]]
- [[DependencyInjection]]
- [[Clean Architecture]]

## 📖 Resources
- Microsoft Docs: ASP.NET Core MVC overview

## 🧪 Practice Exercises
1. Take one controller action and identify which lines are presentation concerns versus application or domain concerns.
2. Replace a domain entity returned directly to a view with a dedicated view model and document what improved.

## 🔄 Review Schedule
- [ ] Review in 3 months
