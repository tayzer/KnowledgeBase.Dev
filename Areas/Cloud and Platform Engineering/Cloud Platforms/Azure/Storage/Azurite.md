# Azurite Cheat Sheet
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.

Azurite is the local emulator for Azure Storage. Use it when you want to develop or test against Blob, Queue, or Table Storage without connecting to a real Azure Storage account.

For the CPS interview, treat it as local infrastructure: start it before the challenge, connect your .NET app to it, and keep moving.

## What Azurite Emulates

Supported:

- Blob Storage
- Queue Storage
- Table Storage

Not supported:

- Azure Files
- Azure Data Lake Storage Gen2

Important note: Microsoft documents Table Storage support in Azurite as preview, but it is commonly used for local development scenarios.

## Install

On your machine, use `npm.cmd` rather than `npm` in PowerShell, because PowerShell may block `npm.ps1`.

```powershell
npm.cmd install -g azurite
azurite --version
```

If `azurite` is still not recognised after install, close and reopen PowerShell or Visual Studio.

## Start Azurite

Recommended interview-friendly command:

```powershell
New-Item -ItemType Directory -Force C:\tmp\azurite
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log
```

What this does:

- Stores local Azurite data under `C:\tmp\azurite`
- Keeps console noise down with `--silent`
- Writes debug logs to `C:\tmp\azurite\debug.log`

Leave this terminal running while your app uses storage.

## Default Ports

```text
Blob:  http://127.0.0.1:10000
Queue: http://127.0.0.1:10001
Table: http://127.0.0.1:10002
```

If these ports are already in use, Azurite will fail to start. Stop the other process or use custom ports.

## Simplest Connection String

Use this first:

```text
UseDevelopmentStorage=true
```

Example `appsettings.Development.json`:

```json
{
  "Storage": {
    "ConnectionString": "UseDevelopmentStorage=true"
  }
}
```

Example Azure Functions `local.settings.json`:

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

## Full Local Connection String

Use this if a library or tool does not understand `UseDevelopmentStorage=true`:

```text
DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;
```

The default local account is:

```text
AccountName: devstoreaccount1
AccountKey:  Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==
```

This is not a real secret. It is the well-known Azurite development key.

## .NET Packages

Install only what you need:

```powershell
dotnet add package Azure.Storage.Blobs
dotnet add package Azure.Storage.Queues
dotnet add package Azure.Data.Tables
```

For a timeboxed interview, do not add all three unless the requirement calls for them.

## Blob Storage Minimal Example

```csharp
using Azure.Storage.Blobs;

var connectionString = builder.Configuration["Storage:ConnectionString"];

builder.Services.AddSingleton(_ =>
    new BlobServiceClient(connectionString));
```

Create a container and upload text:

```csharp
public sealed class BlobDocumentStore
{
    private readonly BlobContainerClient _container;

    public BlobDocumentStore(BlobServiceClient blobServiceClient)
    {
        _container = blobServiceClient.GetBlobContainerClient("documents");
    }

    public async Task SaveAsync(string id, string content, CancellationToken cancellationToken)
    {
        await _container.CreateIfNotExistsAsync(cancellationToken: cancellationToken);

        var blob = _container.GetBlobClient($"{id}.txt");
        await blob.UploadAsync(BinaryData.FromString(content), overwrite: true, cancellationToken);
    }
}
```

## Queue Storage Minimal Example

```csharp
using Azure.Storage.Queues;

var connectionString = builder.Configuration["Storage:ConnectionString"];

builder.Services.AddSingleton(_ =>
    new QueueClient(connectionString, "case-events"));
```

Send a message:

```csharp
await queueClient.CreateIfNotExistsAsync(cancellationToken: cancellationToken);
await queueClient.SendMessageAsync("case-created:123", cancellationToken);
```

## Table Storage Minimal Example

```csharp
using Azure;
using Azure.Data.Tables;

public sealed class CaseRecordEntity : ITableEntity
{
    public string PartitionKey { get; set; } = default!;
    public string RowKey { get; set; } = default!;
    public DateTimeOffset? Timestamp { get; set; }
    public ETag ETag { get; set; }

    public string CaseUrn { get; set; } = default!;
    public string Status { get; set; } = default!;
    public DateTimeOffset ReceivedAt { get; set; }
}
```

Register the client:

```csharp
using Azure.Data.Tables;

var connectionString = builder.Configuration["Storage:ConnectionString"];

builder.Services.AddSingleton(_ =>
    new TableClient(connectionString, "CaseRecords"));
```

Save an entity:

```csharp
await tableClient.CreateIfNotExistsAsync(cancellationToken);

var entity = new CaseRecordEntity
{
    PartitionKey = "case",
    RowKey = id,
    CaseUrn = request.CaseUrn,
    Status = request.Status,
    ReceivedAt = request.ReceivedAt
};

await tableClient.UpsertEntityAsync(entity, cancellationToken: cancellationToken);
```

Fetch an entity:

```csharp
var response = await tableClient.GetEntityAsync<CaseRecordEntity>(
    partitionKey: "case",
    rowKey: id,
    cancellationToken: cancellationToken);

var entity = response.Value;
```

Query by status:

```csharp
var results = tableClient.QueryAsync<CaseRecordEntity>(
    x => x.PartitionKey == "case" && x.Status == status,
    cancellationToken: cancellationToken);

await foreach (var entity in results)
{
    // Map entity to response DTO
}
```

## Storage Explorer

If Azure Storage Explorer is installed:

1. Open Storage Explorer.
2. Select the account/manage accounts icon.
3. Add an account.
4. Choose attach to a local emulator.
5. Connect.

This is useful for quickly checking whether containers, queues, tables, and records were created.

## Reset Local Data

Stop Azurite, delete the workspace files, then restart it.

For the suggested workspace:

```powershell
Remove-Item C:\tmp\azurite\* -Recurse -Force
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log
```

Be careful: this deletes your local emulator data.

## Troubleshooting

### `azurite` is not recognised

Try:

```powershell
npm.cmd install -g azurite
```

Then restart the terminal.

### `npm.ps1 cannot be loaded`

Use this:

```powershell
npm.cmd install -g azurite
```

### Port already in use

Default ports are `10000`, `10001`, and `10002`. Either stop the other process or start Azurite on custom ports.

### App cannot connect

Check:

- Is Azurite still running?
- Is the app using `UseDevelopmentStorage=true`?
- Did you accidentally use HTTPS endpoints while Azurite is running HTTP?
- Are the ports correct?
- Did you create the container/table/queue first?

### Table queries feel limited

Azure Table Storage is not SQL. Design around partition and row keys, and keep queries simple.

## Interview Talking Points

Good wording:

```text
I am using Azurite so we can exercise the Azure Storage integration locally without needing a live cloud dependency. In production I would switch this connection string to a managed Azure Storage account and use proper secret/configuration management.
```

If time is tight:

```text
I will keep the repository interface stable and start with in-memory persistence. If time allows, I will swap the implementation to Azurite-backed storage.
```

If asked why not connect to real Azure:

```text
For a coding exercise, a local emulator is faster and more repeatable. For production, I would validate against the real Azure service as part of integration testing and deployment.
```

## Quick Commands

```powershell
# Install
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.
npm.cmd install -g azurite

# Check version
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.
azurite --version

# Start all services
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log

# Start only Blob
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.
azurite-blob --location C:\tmp\azurite

# Start only Queue
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.
azurite-queue --location C:\tmp\azurite

# Start only Table
Date: 2026-08-13
Status: Needs Review
Tags: #knowledge-base #azure #storage

## TL;DR / Quick Reference

**Definition:** Reference guidance for A zu ri te.

**When to use:**
- Use this note when making a decision about A zu ri te.

**Key Takeaways:**
- Check scope, trade-offs, and related concepts before applying guidance.
- This migrated note needs content review before it is marked current.
azurite-table --location C:\tmp\azurite
```

## Sources

- Microsoft Learn: Use the Azurite emulator for local Azure Storage development
- Microsoft Learn: Connect to Azurite with SDKs and tools
- Azure/Azurite GitHub repository


## Related Concepts
- [[Areas/_Index|Software Engineering Knowledge Base]]

## Review Schedule
- [ ] Review in 3 months.
