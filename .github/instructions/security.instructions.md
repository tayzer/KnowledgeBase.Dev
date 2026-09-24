---
description: Apply extra security scrutiny to authentication, authorization, secrets, IAM, and deployment configuration.
applyTo: "**/*Auth*.cs,**/*Security*.cs,**/*Secret*.cs,**/*Identity*.cs,**/*Policy*.cs,**/*Permission*.cs,**/*.tf,**/template.yaml,**/template.yml,**/serverless.yml,**/serverless.yaml"
---

# Security-sensitive changes

- Map trust boundaries, authentication and authorization decisions, privilege scope, and affected identities. Enforce least privilege on API and AWS IAM paths; verify deny and unauthenticated behavior.
- Keep secrets, tokens, PII, and sensitive payloads out of source, errors, telemetry, and test fixtures. Use existing secret storage and rotation conventions; encrypt data in transit and at rest where applicable.
- Validate untrusted input. Assess injection, unsafe deserialization, SSRF, path traversal, mass assignment, insecure defaults, and publicly exposed resources at relevant boundaries.
- Review dependency and configuration risks using current advisories when changes depend on them. Do not claim a change is “secure”; describe controls checked, evidence, and residual risk.
