---
date: 2026-06-23
status: Current
tags:
  - architecture
  - serverless
  - cloud
  - event-driven

---

# Serverless Architecture

## Quick Reference

**Definition:** Serverless architecture builds applications from managed cloud services and event-driven compute where the platform handles most server provisioning, scaling, and runtime management.

**When to use:**
- Event-driven, bursty, scheduled, integration, or background-processing workloads.
- Teams that want to minimize infrastructure management and accept cloud-platform constraints.

**Key Takeaways:**
- Serverless reduces infrastructure burden but increases dependency on provider services, limits, and observability tooling.
- It fits event-driven workflows well, but execution limits and startup latency must be measured for the selected service and plan.
- Design for retries, idempotency, cold starts, configuration, and local testing from the start.

**Limit:** Execution limits, startup latency, and provider pricing depend on the selected service and plan.

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

## Limits and workload example

A bursty event handler may benefit from platform scaling, but queue delivery can retry and duplicate work; make side effects idempotent. A latency-sensitive API needs measured cold-start behavior or warm capacity. A long-running task must fit the selected service's execution limit or use an orchestration/workflow service. Compare invocation, provisioned capacity, storage, and observability cost against a container or VM alternative.

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale) (accessed 2026-09-24).

## Related Concepts

- [[Event-Driven Architecture]]
- [[Message-Driven Architecture]]
- [[Saga Pattern]]
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/_Index]]

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
