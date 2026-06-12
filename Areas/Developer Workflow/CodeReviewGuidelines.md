# Code Review Guidelines
Date: 2025-11-25
Status: 🟢 Current
Tags: #code-review #practices #quality #process

## 🎯 TL;DR / Quick Reference

**Definition:** Concise checklist and practices to make code reviews effective, fast, and educational.

**When to use:**
- Before merging pull requests; to maintain code quality and share knowledge.

**Key Takeaways:**
- ✅ **Review for intent first:** Does the change do what the author intended?
- ✅ **Keep reviews small:** Smaller PRs reduce cognitive load and speed up reviews.
- ✅ **Automate style and tests:** Use CI to catch formatting and test regressions before review.

**Checklist:**
- Code correctness: logic, edge cases
- Tests: unit/integration coverage for new behavior
- Performance: obvious hotspots
- Security: input validation, secrets
- Readability: clear naming and comments
- Documentation: README, changelog, API contracts

**Gotchas:**
- ⚠️ **Nitpicking style** wastes time—use linters and formatters instead.
- ⚠️ **Review fatigue:** Limit review sessions and break large reviews into chunks.

---

## 📚 Deep Dive

### Review etiquette
- Be respectful and educational. Ask questions instead of ordering changes.
- Prefer examples or suggested fixes.

### Effective PRs
- One logical change per PR.
- Provide context in PR description: motivation, trade-offs, how to test.
- Include links to design docs when appropriate.

### Tools & Automation
- Use branch policies, required reviewers, and CI checks.
- Use code owners to route domain-specific reviews.

---

## 🔗 Related Concepts
- [[IntegrationTestingAspNet]]
- [[MsTest]]

## 📖 Resources
- GitHub PR best practices
- Atlassian and Google engineering guides

## 🧪 Practice Exercises
1. Review a historical PR and write a short checklist of missed issues.
2. Add a PR template that enforces description and testing instructions.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
