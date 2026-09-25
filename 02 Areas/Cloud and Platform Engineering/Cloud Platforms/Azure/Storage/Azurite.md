---
date: 2026-08-13
status: Current
tags:
  - knowledge-base
  - azure
  - storage

---

# Azurite

## Quick Reference
**Definition:** Azurite is Microsoft's local emulator for Azure Blob, Queue, and Table Storage development and testing.

**When to use:**
- Use Azurite to develop and test storage integrations locally before validating against Azure Storage.

**Key Takeaways:**
- Azurite does not cover Azure Files or Data Lake Storage Gen2.
- Its behavior and performance are not identical to a cloud storage account.

Azurite is the local emulator for Azure Storage. Use it when you want to develop or test against Blob, Queue, or Table Storage without connecting to a real Azure Storage account.

**Limit:** Azurite is a local emulator, not a substitute for testing cloud authorization and performance.


## What Azurite Emulates

Supported:

- Blob Storage
- Queue Storage
- Table Storage

Not supported:

- Azure Files
- Azure Data Lake Storage Gen2

Check the [current Azurite documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite) for service support and differences from Azure Storage.

## Install

In PowerShell, use `npm.cmd` if execution policy blocks `npm.ps1`.

```powershell
npm.cmd install -g azurite
azurite --version
```

If `azurite` is still not recognised after install, close and reopen PowerShell or Visual Studio.

## Start Azurite

Example local command:

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

Add only the service packages the application uses.

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

Stop Azurite. This example uses a disposable local workspace only. Verify that the resolved path is exactly the workspace you intend to reset before removing its contents; never run it against a shared or production path.

For the suggested Windows workspace:

```powershell
(Resolve-Path -LiteralPath 'C:\tmp\azurite').Path
# After verifying the path and stopping Azurite, remove only this disposable workspace's contents in Explorer.
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

## Quick Commands

```powershell
# Install
npm.cmd install -g azurite

# Check version
azurite --version

# Start all services
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log

# Start only Blob
azurite-blob --location C:\tmp\azurite

# Start only Queue
azurite-queue --location C:\tmp\azurite

# Start only Table
azurite-table --location C:\tmp\azurite
```

## Sources

- [Primary documentation](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite) (accessed 2026-09-24).

- [Microsoft Learn: Use the Azurite emulator for local Azure Storage development](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite) (checked 2026-09-24)
- [Microsoft Learn: Connect to Azurite with SDKs and tools](https://learn.microsoft.com/en-us/azure/storage/common/storage-connect-azurite)
- [Azure/Azurite GitHub repository](https://github.com/Azure/Azurite)


## Environment and verification boundary

The commands above are Windows and local-workspace examples, not required Azurite defaults. The documented development account key is public and only for local emulation. Stop Azurite and verify the resolved path is the intended disposable Azurite workspace before removing local data. Do not run the reset against a shared or production directory. Azure Files and Data Lake Storage Gen2 are outside Azurite emulation. CLI, SDK, and Storage Explorer examples need an executable smoke test on the chosen Azurite version before Current.

## Related Concepts
- [[Azure Blob Storage]]
- [[Azure Queue Storage]]

## Review Schedule
- [ ] Review in 3 months.
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
