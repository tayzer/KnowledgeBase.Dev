---
description: Apply to AWS infrastructure and AWS-specific source or configuration; consult manually for other cloud files.
applyTo: "**/*aws*.tf,**/*AWS*.tf,**/*lambda*.tf,**/*sqs*.tf,**/cdk.json,**/samconfig.toml,**/serverless.yml,**/serverless.yaml,**/*Lambda*.cs,**/*Sqs*.cs,**/*SQS*.cs,**/*DynamoDb*.cs,**/*DynamoDB*.cs"
---

# AWS and event workloads

- Inspect existing IaC, deployment, service configuration, IAM, and operational conventions before adding resources. Use least privilege, scoped secrets access, encryption, and private exposure by default. Do not add services when current design suffices.
- For Lambda, assess execution reuse, cold starts where relevant, timeout, memory, reserved or provisioned concurrency, downstream limits, and deployment package size. Keep initialization and per-invocation state safe.
- For SQS, SNS, EventBridge, and Step Functions, define delivery, retries, backoff, redrive, dead-letter handling, poison messages, partial processing, and failure isolation. For SQS batches, align visibility timeout and partial batch response behavior with function timeout and retry policy.
- Treat duplicate delivery as normal. Consider ordering, idempotency key scope and retention, replay, schema evolution, eventual consistency, and partial failures. Check throttling, rate limits, and concurrency controls at every downstream boundary.
- For DynamoDB, API Gateway, and S3 when encountered, inspect access patterns, consistency, pagination, conditional writes, public exposure, lifecycle, and cost where relevant. Avoid assuming any one data store or gateway.
- Emit structured CloudWatch logs, meaningful metrics, traces via OpenTelemetry or X-Ray where already used, and alarms tied to actionable failures. Avoid sensitive data in telemetry.
- Make IaC reviewable; plan deployment, migration, rollback, and drift handling. Consider regional or service failure only to the degree required by availability goals. State material cost effects.
