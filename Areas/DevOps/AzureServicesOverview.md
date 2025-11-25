# Azure Services Overview
Date: 2025-11-25
Status: 🟢 Current
Tags: #azure #cloud #services #architecture

## 🎯 TL;DR / Quick Reference

**Definition:** High-level overview of common Azure services useful for .NET applications: App Services, Functions, AKS, Storage, Service Bus, Cosmos DB, Redis, Key Vault.

**When to use:**
- Selecting cloud primitives for application needs (compute, storage, messaging).

**Key Takeaways:**
- ✅ **Serverless (Functions)** for event-driven, low-maintenance workloads.
- ✅ **AKS** for container orchestration at scale.
- ✅ **Managed PaaS (App Service)** for straightforward web hosting.
- 🔒 **Use Key Vault** to store secrets and certificates.

**Gotchas:**
- ⚠️ **Cost model:** Each service has different billing — design for scale and cost.
- ⚠️ **Consistency models:** Cosmos DB offers tunable consistency — choose carefully.

---

## 📚 Deep Dive

### Compute Options
- **App Service:** Managed web hosting with easy CI/CD.
- **Azure Functions:** Event-driven, pay-per-execution serverless.
- **AKS:** Kubernetes for containers; full control and complexity.

### Data & Storage
- **Blob Storage:** Object storage for files.
- **Cosmos DB:** Globally distributed NoSQL.
- **Azure SQL / Managed Instance:** Relational options.

### Messaging & Integration
- **Service Bus:** Enterprise messaging with queues/topics.
- **Event Grid:** Event routing for serverless architectures.

### Security & Management
- **Key Vault:** Secrets and key management.
- **Azure Monitor / Application Insights:** Observability.

---

## 🔗 Related Concepts
- [[DockerDotNet]]
- [[ServiceCommunication]]

## 📖 Resources
- Microsoft Azure docs (service-specific)

## 🧪 Practice Exercises
1. Deploy a simple Web API to App Service and connect it to Azure SQL.
2. Create a Function triggered by Blob Storage and forward messages to Service Bus.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
