# Azure Productionisation: Senior Cheat Sheet

Use this if they ask: "How would you plug this into real Azure?"

Senior answer:

```text
I would keep the local Azurite design, but swap the infrastructure boundary from local emulator to real Azure resources using managed identity, RBAC, environment-specific configuration, IaC, CI/CD, and observability.
```

## Production Shape

```text
App Service or Function App
  -> Managed Identity
  -> Azure Storage Account
  -> Table / Queue / Blob
  -> RBAC permissions
  -> App settings / Key Vault where needed
  -> Application Insights / Azure Monitor
  -> CI/CD + IaC
```

Avoid:

```text
Hard-coded connection strings in source code.
Secrets committed to appsettings.json.
Manually clicked infrastructure with no repeatability.
Over-broad subscription-level permissions.
```

## Local vs Azure

Local:

```text
Azurite
UseDevelopmentStorage=true
```

Azure:

```text
Real Storage Account
Managed Identity
DefaultAzureCredential
Azure RBAC
Environment-specific app settings
```

## Code Change: Table Storage

Local/Azurite:

```csharp
new TableClient("UseDevelopmentStorage=true", "CaseDocuments");
```

Azure production-style:

```powershell
dotnet add package Azure.Identity
```

```csharp
using Azure.Data.Tables;
using Azure.Identity;

var accountName = builder.Configuration["Storage:AccountName"];
var tableName = builder.Configuration["Storage:TableName"];

builder.Services.AddSingleton(_ =>
{
    var serviceUri = new Uri($"https://{accountName}.table.core.windows.net");
    var serviceClient = new TableServiceClient(
        serviceUri,
        new DefaultAzureCredential());

    return serviceClient.GetTableClient(tableName);
});
```

## Code Change: Queue Storage

Local/Azurite:

```csharp
new QueueClient("UseDevelopmentStorage=true", "case-document-processing");
```

Azure production-style:

```csharp
using Azure.Identity;
using Azure.Storage.Queues;

var accountName = builder.Configuration["Storage:AccountName"];
var queueName = builder.Configuration["Storage:QueueName"];

builder.Services.AddSingleton(_ =>
{
    var queueUri = new Uri(
        $"https://{accountName}.queue.core.windows.net/{queueName}");

    return new QueueClient(queueUri, new DefaultAzureCredential());
});
```

## Azure Resources

Create:

- Resource group
- Storage account
- Table, for example `CaseDocuments`
- Queue, for example `case-document-processing`
- App Service or Function App
- Application Insights / Azure Monitor
- Managed identity for the app
- Key Vault if secrets remain necessary

## RBAC / Least Privilege

Grant the app's managed identity only what it needs.

Examples:

| Need | Role |
|---|---|
| Read/write table records | `Storage Table Data Contributor` |
| Read table records only | `Storage Table Data Reader` |
| Send queue messages | `Storage Queue Data Message Sender` |
| Process queue messages | `Storage Queue Data Message Processor` |
| Read/write queue messages | `Storage Queue Data Contributor` |

Prefer narrow scope:

```text
Queue/table scope if practical
Storage account scope if needed
Resource group scope only if justified
Avoid subscription scope
```

Interview line:

```text
I would use managed identity and RBAC rather than shared keys. The role assignment should be scoped as narrowly as practical.
```

## Azure Functions Notes

For a Function App there are two concerns:

1. Your application code accessing Azure resources.
2. The Functions runtime using `AzureWebJobsStorage`.

Application code can use:

```csharp
new DefaultAzureCredential()
```

For the Functions host storage, target state is identity-based configuration where possible.

Example setting:

```text
AzureWebJobsStorage__accountName = <storage-account-name>
```

Pragmatic senior wording:

```text
For an initial deployment I might use app settings to get the function working, but the target state is identity-based connections and managed identity, with secrets moved out of app configuration where possible.
```

## Configuration

Local:

```json
{
  "Storage": {
    "ConnectionString": "UseDevelopmentStorage=true",
    "TableName": "CaseDocuments",
    "QueueName": "case-document-processing"
  }
}
```

Azure:

```text
Storage__AccountName = <storage-account-name>
Storage__TableName = CaseDocuments
Storage__QueueName = case-document-processing
APPLICATIONINSIGHTS_CONNECTION_STRING = <app-insights-connection-string>
```

Do not put production secrets in source control.

## IaC

Senior answer:

```text
I would provision this with Bicep or Terraform rather than relying on manual portal configuration.
```

IaC should define:

- Storage account
- Table/queue resources
- App Service or Function App
- Managed identity
- RBAC role assignments
- Application settings
- Application Insights
- Alerts where appropriate

## CI/CD

Pipeline shape:

```text
Restore/build
Run unit tests
Run integration tests against Azurite or test Azure resources
Static analysis/security checks
Deploy infrastructure
Deploy app
Run smoke test
Monitor release
```

For App Service:

```text
Use deployment slots if appropriate.
Warm up slot.
Run smoke tests.
Swap slots.
Rollback via previous slot if needed.
```

## Observability

Add:

- Structured logging
- Correlation ids
- Application Insights / Azure Monitor
- Metrics and traces
- Alerts on failures
- Queue length alerts
- Poison queue/dead-letter alerts
- Storage failure monitoring

Interview line:

```text
I would make this observable from day one: structured logs, correlation ids, Application Insights, and alerts around queue failures and storage errors.
```

## Resilience

For queues:

- Make processing idempotent.
- Assume messages can be retried.
- Track processing status by document id.
- Do not put huge payloads or secrets in messages.
- Distinguish transient failures from permanent validation failures.
- Monitor poison queue/dead-letter behaviour.

For storage:

- Use Azure SDK retry behaviour where appropriate.
- Consider request timeouts.
- Avoid hot partitions.
- Design partition keys around query patterns.
- Add integration tests against Azurite or test Azure resources.

## Security

Do:

- Use managed identity.
- Use RBAC least privilege.
- Use Key Vault for secrets that cannot be removed.
- Use HTTPS.
- Add authentication and authorisation.
- Avoid shared keys where possible.
- Separate dev/test/prod resources.

Do not:

- Commit secrets.
- Hard-code connection strings.
- Give broad permissions by default.
- Put sensitive data in queue messages.

## Final Interview Script

```text
I would keep the code dependent on abstractions and Azure SDK clients, then swap configuration between local and Azure. Locally I use Azurite and UseDevelopmentStorage=true; in Azure I would use a real Storage Account, managed identity via DefaultAzureCredential, and RBAC roles scoped as narrowly as possible.
```

```text
I would provision the infrastructure with Bicep or Terraform, deploy through CI/CD, and add Application Insights, structured logging, alerts, retry and idempotency handling, and environment-specific configuration.
```

```text
For Azure Functions specifically, I would also consider identity-based connections for AzureWebJobsStorage and avoid storing host storage secrets where possible.
```

## One-Line Memory

```text
Local = Azurite + UseDevelopmentStorage=true. Azure = real Storage Account + managed identity + RBAC + IaC + CI/CD + observability.
```
