# Serverless Architecture
Date: 2026-06-23
Status: Needs Review
Tags: #architecture #serverless #cloud #event-driven

## TL;DR / Quick Reference

**Definition:** Serverless architecture builds applications from managed cloud services and event-driven compute where the platform handles most server provisioning, scaling, and runtime management.

**When to use:**
- Event-driven, bursty, scheduled, integration, or background-processing workloads.
- Teams that want to minimize infrastructure management and accept cloud-platform constraints.

**Key Takeaways:**
- Serverless reduces infrastructure burden but increases dependency on provider services, limits, and observability tooling.
- It fits event-driven workflows well, but not every long-running or latency-sensitive workload.
- Design for retries, idempotency, cold starts, configuration, and local testing from the start.

---

## Deep Dive

### Good Fit

- Queue, topic, storage, webhook, and timer-triggered processing.
- APIs with variable or unpredictable traffic.
- Glue code between managed services.
- Workloads where scaling to zero or pay-per-use matters.

### Be Careful When

- The workflow is long-running or stateful without a durable orchestration model.
- Latency is strict and cold starts matter.
- The team needs strong portability across cloud providers.
- Debugging depends on local reproduction of many managed-service interactions.

### Design Guidance

- Keep functions small but not so tiny that the workflow becomes unreadable.
- Put business logic in testable services rather than inside trigger boilerplate.
- Make handlers idempotent because retries are normal.
- Use correlation IDs and structured logging across triggers.

## Related Concepts

- [[Areas/Architecture and System Design/Integration and Messaging/Event-Driven Integration/Event-Driven Architecture]]
- [[Message-Driven Architecture]]
- [[Saga Pattern]]
- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]
- [[Areas/Cloud and Platform Engineering/_Index]]

## Review Schedule

- [ ] Review in 3 months
