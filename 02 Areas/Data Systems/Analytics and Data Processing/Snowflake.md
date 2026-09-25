---
date: 2025-11-25
status: Current
tags:
  - datawarehouse
  - snowflake
  - cloud

---

# Snowflake

## Quick Reference

**Definition:** Cloud-native data warehouse with separation of storage and compute, supporting SQL; multi-cluster concurrency depends on edition and configuration.

**When to use:**
- Large-scale analytics with concurrent workloads and simplified management.

**Key Takeaways:**
- **Separation of compute and storage** enables independent scaling.
- **Time Travel** supports recovery within configured retention; clones can aid development but are not long-term backups.

**Limit:** Time Travel retention and multi-cluster behavior depend on edition and configuration; clones are not backups.

---

## Warehouse and retention decisions

Size and suspend virtual warehouses from measured concurrency and idle time. Check edition before relying on multi-cluster behavior. Time Travel has configured retention limits. A zero-copy clone initially shares storage and is not a long-term backup.

## Related Concepts
- [[Data Warehouses]]

## Resources

- [Primary documentation](https://docs.snowflake.com/en/user-guide/data-time-travel) (accessed 2026-09-24).
- [Snowflake docs](https://docs.snowflake.com/en/user-guide/intro-key-concepts) (accessed 2026-09-24).

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
