# Cloud Storage Services
Date: 2026-06-23
Status: Needs Review
Tags: #cloud-storage #object-storage #cloud #data

## TL;DR / Quick Reference

**Definition:** Managed cloud services for durable unstructured data, usually exposed through object-storage APIs rather than database tables or POSIX filesystem semantics.

**When to use:**
- Files, media, exports, backups, archives, static assets, and data-lake landing zones.
- Workloads that need high durability, lifecycle rules, access policies, and cloud-native event integration.

**Key Takeaways:**
- Object storage is excellent for durable blobs, but it is not a transactional database.
- Access pattern, security model, lifecycle, request volume, retrieval tier, and egress cost shape the design.
- Storage services often sit beside databases: metadata in a database, large binary objects in object storage.

---

## Deep Dive

### Choose Object Storage When

- Data is naturally file-like: documents, images, logs, exports, backups, or lake data.
- The application mostly writes or reads whole objects rather than querying inside them.
- Lifecycle, retention, compliance, or integration with cloud analytics matters.

### Be Careful When

- You need transactional updates across many records.
- You need rich server-side querying over object content.
- You need low-latency random writes inside a file-like structure.

### Design Questions

- What metadata belongs in a database versus on the object?
- Who can read, write, delete, and list objects?
- What is the lifecycle: hot, cool, archive, retention, legal hold, deletion?
- How will the application handle versioning, overwrite races, malware scanning, and event processing?

### Child Notes

- [[Amazon S3]] - AWS object storage with broad ecosystem support and mature lifecycle controls.
- [[Azure Blob Storage]] - Azure object storage for unstructured data with strong Microsoft ecosystem integration.
- [[Google Cloud Storage]] - GCP object storage with simple global object storage semantics and analytics alignment.

## Related Concepts

- [[Data Warehouses]]
- [[Data Lakes]]
- [[Areas/Data Systems/Data Models and Query Languages/_Index]]
- [[Areas/Security and Privacy/_Index]]

## Review Schedule

- [ ] Review in 3 months
