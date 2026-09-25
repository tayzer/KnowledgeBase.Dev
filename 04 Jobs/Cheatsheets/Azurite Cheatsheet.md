# Azurite Panic Cheat Sheet

Local Azure Storage emulator for Blob, Queue, Table. Use it so your app can talk to "Azure Storage" locally.

## Install / Start

```powershell
# PowerShell may block npm.ps1, so use npm.cmd
npm.cmd install -g azurite
azurite --version

# Start all services
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log
```

## Default Endpoints

| Service | URL |
|---|---|
| Blob | `http://127.0.0.1:10000/devstoreaccount1` |
| Queue | `http://127.0.0.1:10001/devstoreaccount1` |
| Table | `http://127.0.0.1:10002/devstoreaccount1` |

## Connection String

Use this first:

```text
UseDevelopmentStorage=true
```

ASP.NET `appsettings.Development.json`:

```json
{
  "Storage": {
    "ConnectionString": "UseDevelopmentStorage=true"
  }
}
```

Azure Functions `local.settings.json`:

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

## Packages

```powershell
dotnet add package Azure.Data.Tables
dotnet add package Azure.Storage.Queues
dotnet add package Azure.Storage.Blobs
```

Install only what you need.

## Table Storage Pattern

Entity:

```csharp
using Azure;
using Azure.Data.Tables;

public sealed class CaseEntity : ITableEntity
{
    public string PartitionKey { get; set; } = default!;
    public string RowKey { get; set; } = default!;
    public DateTimeOffset? Timestamp { get; set; }
    public ETag ETag { get; set; }

    public string CaseUrn { get; set; } = default!;
    public string Status { get; set; } = default!;
}
```

Register:

```csharp
builder.Services.AddSingleton(_ =>
    new TableClient("UseDevelopmentStorage=true", "Cases"));
```

Add:

```csharp
await table.CreateIfNotExistsAsync(ct);
await table.AddEntityAsync(entity, ct);
```

Get by id:

```csharp
try
{
    var response = await table.GetEntityAsync<CaseEntity>(
        "case",
        id.ToString(),
        cancellationToken: ct);

    return response.Value;
}
catch (RequestFailedException ex) when (ex.Status == 404)
{
    return null;
}
```

Query:

```csharp
var query = table.QueryAsync<CaseEntity>(
    x => x.PartitionKey == "case" && x.Status == status,
    cancellationToken: ct);

await foreach (var entity in query)
{
    results.Add(entity);
}
```

## Queue Pattern

Register:

```csharp
builder.Services.AddSingleton(_ =>
    new QueueClient("UseDevelopmentStorage=true", "case-events"));
```

Send:

```csharp
await queue.CreateIfNotExistsAsync(cancellationToken: ct);
await queue.SendMessageAsync(
    BinaryData.FromObjectAsJson(message),
    ct);
```

Receive/check:

```csharp
var message = await queue.ReceiveMessageAsync(cancellationToken: ct);
```

## Blob Pattern

Register:

```csharp
builder.Services.AddSingleton(_ =>
    new BlobServiceClient("UseDevelopmentStorage=true"));
```

Upload:

```csharp
var container = blobService.GetBlobContainerClient("documents");
await container.CreateIfNotExistsAsync(cancellationToken: ct);

var blob = container.GetBlobClient($"{id}.txt");
await blob.UploadAsync(BinaryData.FromString(content), overwrite: true, ct);
```

## Panic Lines

```text
Azurite is local Azure Storage.
UseDevelopmentStorage=true is the local connection string.
Start Azurite before running the app.
Table = metadata/key-value records.
Queue = async/background messages.
Blob = files/content.
```

## If It Breaks

| Problem | Fix |
|---|---|
| `azurite` not found | Install with `npm.cmd install -g azurite`, reopen terminal |
| `npm.ps1 blocked` | Use `npm.cmd` |
| App cannot connect | Check Azurite is running and connection string is `UseDevelopmentStorage=true` |
| Port clash | Default ports are `10000`, `10001`, `10002` |
| Table query awkward | Table Storage is not SQL; design around `PartitionKey` and `RowKey` |

## Interview Line

```text
I am using Azurite so the Azure Storage integration can run locally without depending on a live cloud resource. In production I would use a real storage account, managed identity where possible, and app settings or Key Vault for configuration.
```
