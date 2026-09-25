# Mock Challenge: Async Pivot With HTTP, Queue Storage, and Azure Functions

  

Timebox: 75-90 minutes

  

This mock practises the likely pivot from a normal REST endpoint to asynchronous processing:

  

```text

HTTP endpoint accepts work -> returns 202 Accepted -> message goes to Azure Storage Queue -> background processor handles it.

```

  

If they prefer Azure Functions:

  

```text

HTTP endpoint = HTTP trigger

Background processor = Queue trigger

```

  

## Why This Is A Likely Pivot

  

The challenge document mentions:

  

- `.NET 8`

- Web Development

- Cloud Development

- Azurite

- Optional HTTP client

  

That could mean a normal REST API with Azure Storage, but they may pivot to an async/cloud-native pattern using Queue Storage.

  

## Scenario

  

CPS receives case documents. Creating the document record is quick, but processing the document is slower. Processing might include OCR, virus scanning, metadata extraction, or sending a notification to another system.

  

The HTTP request should not wait for that background processing to complete.

  

## Functional Requirements

  

Build:

  

1. An HTTP endpoint that accepts a document processing request.

2. A queue message written to Azure Storage Queue through Azurite.

3. A background processor that consumes the queue message.

  

Endpoint:

  

```http

POST /case-documents/{id}/process

```

  

Queue:

  

```text

case-document-processing

```

  

## Request Body

  

```json

{

  "caseUrn": "CPS-2026-001",

  "requestedBy": "interview.candidate",

  "priority": "Normal"

}

```

  

Allowed priorities:

  

- `Low`

- `Normal`

- `High`

  

## Successful Response

  

Return:

  

```http

202 Accepted

Location: /case-documents/{id}

```

  

Body:

  

```json

{

  "documentId": "2c8cf2a0-833e-4a7d-923a-5fd66a4ec2f1",

  "status": "Queued"

}

```

  

## Validation Rules

  

Return `400 Bad Request` when:

  

- Route id is not a valid `Guid`.

- Request body is missing.

- `caseUrn` is missing or whitespace.

- `requestedBy` is missing or whitespace.

- `priority` is missing, whitespace, or unknown.

  

## Non-Functional Requirements

  

Show:

  

- Correct use of `202 Accepted`.

- Small queue messages.

- No hard-coded secrets.

- Azurite/local storage configuration.

- Meaningful logs.

- Idempotency awareness.

- Retry/poison queue awareness.

- Basic validation tests if time allows.

  

## Local Setup

  

Start Azurite:

  

```powershell

azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log

```

  

Connection string:

  

```text

UseDevelopmentStorage=true

```

  

For ASP.NET API:

  

```json

{

  "Storage": {

    "ConnectionString": "UseDevelopmentStorage=true",

    "QueueName": "case-document-processing"

  }

}

```

  

For Azure Functions:

  

```json

{

  "IsEncrypted": false,

  "Values": {

    "AzureWebJobsStorage": "UseDevelopmentStorage=true",

    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"

  }

}

```

  

## DTOs

  

Request:

  

```csharp

public sealed record ProcessCaseDocumentRequest(

    string? CaseUrn,

    string? RequestedBy,

    string? Priority);

```

  

Queue message:

  

```csharp

public sealed record CaseDocumentProcessingMessage(

    Guid DocumentId,

    string CaseUrn,

    string RequestedBy,

    string Priority,

    DateTimeOffset RequestedAt);

```

  

Response:

  

```csharp

public sealed record ProcessingAcceptedResponse(

    Guid DocumentId,

    string Status);

```

  

## Validation

  

```csharp

static string? Validate(ProcessCaseDocumentRequest request)

{

    if (string.IsNullOrWhiteSpace(request.CaseUrn))

    {

        return "Case URN is required.";

    }

  

    if (string.IsNullOrWhiteSpace(request.RequestedBy))

    {

        return "Requested by is required.";

    }

  

    if (!IsValidPriority(request.Priority))

    {

        return "Priority is invalid.";

    }

  

    return null;

}

  

static bool IsValidPriority(string? priority)

{

    string[] allowed = ["Low", "Normal", "High"];

  

    return allowed.Any(x =>

        string.Equals(x, priority, StringComparison.OrdinalIgnoreCase));

}

```

  

## Option A: ASP.NET REST API That Writes To Queue

  

Use this if they ask for a normal REST API plus queue.

  

Package:

  

```powershell

dotnet add package Azure.Storage.Queues

```

  

Register `QueueClient`:

  

```csharp

using Azure.Storage.Queues;

  

var connectionString = builder.Configuration["Storage:ConnectionString"];

var queueName = builder.Configuration["Storage:QueueName"] ?? "case-document-processing";

  

builder.Services.AddSingleton(_ =>

    new QueueClient(connectionString, queueName));

```

  

Endpoint:

  

```csharp

app.MapPost("/case-documents/{id}/process", async (

    string id,

    ProcessCaseDocumentRequest request,

    QueueClient queueClient,

    ILogger<Program> logger,

    CancellationToken ct) =>

{

    if (!Guid.TryParse(id, out var documentId))

    {

        return Results.BadRequest("Invalid document id.");

    }

  

    var error = Validate(request);

  

    if (error is not null)

    {

        return Results.BadRequest(error);

    }

  

    var message = new CaseDocumentProcessingMessage(

        documentId,

        request.CaseUrn!.Trim(),

        request.RequestedBy!.Trim(),

        request.Priority!.Trim(),

        DateTimeOffset.UtcNow);

  

    await queueClient.CreateIfNotExistsAsync(cancellationToken: ct);

  

    await queueClient.SendMessageAsync(

        BinaryData.FromObjectAsJson(message),

        ct);

  

    logger.LogInformation(

        "Queued processing for document {DocumentId}.",

        documentId);

  

    return Results.Accepted(

        $"/case-documents/{documentId}",

        new ProcessingAcceptedResponse(documentId, "Queued"));

});

```

  

Important line:

  

```csharp

return Results.Accepted($"/case-documents/{documentId}", response);

```

  

Why:

  

```text

202 Accepted means the request was accepted, but processing is not complete yet.

```

  

## Option B: Azure Functions HTTP Trigger + Queue Trigger

  

Use this if they ask for Azure Functions.

  

### Program.cs

  

```csharp

var builder = FunctionsApplication.CreateBuilder(args);

  

builder.ConfigureFunctionsWebApplication();

  

builder.Build().Run();

```

  

### HTTP Trigger With QueueClient

  

Package:

  

```powershell

dotnet add package Azure.Storage.Queues

```

  

Register:

  

```csharp

using Azure.Storage.Queues;

  

builder.Services.AddSingleton(_ =>

    new QueueClient(

        builder.Configuration["AzureWebJobsStorage"],

        "case-document-processing"));

```

  

Function:

  

```csharp

public sealed class EnqueueCaseDocumentProcessing

{

    private readonly QueueClient _queueClient;

    private readonly ILogger<EnqueueCaseDocumentProcessing> _logger;

  

    public EnqueueCaseDocumentProcessing(

        QueueClient queueClient,

        ILogger<EnqueueCaseDocumentProcessing> logger)

    {

        _queueClient = queueClient;

        _logger = logger;

    }

  

    [Function("EnqueueCaseDocumentProcessing")]

    public async Task<IActionResult> Run(

        [HttpTrigger(AuthorizationLevel.Function, "post", Route = "case-documents/{id}/process")]

        HttpRequest request,

        string id,

        CancellationToken ct)

    {

        if (!Guid.TryParse(id, out var documentId))

        {

            return new BadRequestObjectResult("Invalid document id.");

        }

  

        var dto = await JsonSerializer.DeserializeAsync<ProcessCaseDocumentRequest>(

            request.Body,

            cancellationToken: ct);

  

        if (dto is null)

        {

            return new BadRequestObjectResult("Request body is required.");

        }

  

        var error = Validate(dto);

  

        if (error is not null)

        {

            return new BadRequestObjectResult(error);

        }

  

        var message = new CaseDocumentProcessingMessage(

            documentId,

            dto.CaseUrn!.Trim(),

            dto.RequestedBy!.Trim(),

            dto.Priority!.Trim(),

            DateTimeOffset.UtcNow);

  

        await _queueClient.CreateIfNotExistsAsync(cancellationToken: ct);

  

        await _queueClient.SendMessageAsync(

            BinaryData.FromObjectAsJson(message),

            ct);

  

        _logger.LogInformation(

            "Queued processing for document {DocumentId}.",

            documentId);

  

        return new AcceptedResult(

            $"/api/case-documents/{documentId}",

            new ProcessingAcceptedResponse(documentId, "Queued"));

    }

}

```

  

### Queue Trigger Processor

  

```csharp

public sealed class ProcessCaseDocumentMessage

{

    private readonly ILogger<ProcessCaseDocumentMessage> _logger;

  

    public ProcessCaseDocumentMessage(

        ILogger<ProcessCaseDocumentMessage> logger)

    {

        _logger = logger;

    }

  

    [Function("ProcessCaseDocumentMessage")]

    public async Task Run(

        [QueueTrigger("case-document-processing", Connection = "AzureWebJobsStorage")]

        string message,

        CancellationToken ct)

    {

        var payload = JsonSerializer.Deserialize<CaseDocumentProcessingMessage>(message);

  

        if (payload is null)

        {

            _logger.LogWarning("Invalid queue message received.");

            return;

        }

  

        _logger.LogInformation(

            "Started processing document {DocumentId} for case {CaseUrn}.",

            payload.DocumentId,

            payload.CaseUrn);

  

        // Load current status by document id.

        // If already processed, skip.

        // Perform processing.

        // Mark status as processed.

  

        await Task.CompletedTask;

  

        _logger.LogInformation(

            "Completed processing document {DocumentId}.",

            payload.DocumentId);

    }

}

```

  

## Optional Interface For Queue Writing

  

Use this if you want testability without tying endpoint code directly to `QueueClient`.

  

```csharp

public interface IProcessingMessageWriter

{

    Task EnqueueAsync(

        CaseDocumentProcessingMessage message,

        CancellationToken ct);

}

```

  

```csharp

public sealed class QueueProcessingMessageWriter : IProcessingMessageWriter

{

    private readonly QueueClient _queueClient;

  

    public QueueProcessingMessageWriter(QueueClient queueClient)

    {

        _queueClient = queueClient;

    }

  

    public async Task EnqueueAsync(

        CaseDocumentProcessingMessage message,

        CancellationToken ct)

    {

        await _queueClient.CreateIfNotExistsAsync(cancellationToken: ct);

  

        await _queueClient.SendMessageAsync(

            BinaryData.FromObjectAsJson(message),

            ct);

    }

}

```

  

Say:

  

```text

I am hiding QueueClient behind a small writer interface so I can test the endpoint behaviour without talking to Azure Storage.

```

  

## Tests To Write If Time Allows

  

Validation test:

  

```csharp

[Fact]

public void Validate_ReturnsError_WhenPriorityInvalid()

{

    var request = new ProcessCaseDocumentRequest(

        "CPS-2026-001",

        "candidate",

        "Urgent");

  

    var error = Validate(request);

  

    Assert.Equal("Priority is invalid.", error);

}

```

  

Fake queue writer test:

  

```csharp

public sealed class FakeProcessingMessageWriter : IProcessingMessageWriter

{

    public List<CaseDocumentProcessingMessage> Messages { get; } = [];

  

    public Task EnqueueAsync(

        CaseDocumentProcessingMessage message,

        CancellationToken ct)

    {

        Messages.Add(message);

        return Task.CompletedTask;

    }

}

```

  

```csharp

[Fact]

public async Task EnqueueAsync_StoresMessage()

{

    var writer = new FakeProcessingMessageWriter();

  

    var message = new CaseDocumentProcessingMessage(

        Guid.NewGuid(),

        "CPS-2026-001",

        "candidate",

        "Normal",

        DateTimeOffset.UtcNow);

  

    await writer.EnqueueAsync(message, CancellationToken.None);

  

    Assert.Single(writer.Messages);

}

```

  

If asked about full integration tests:

  

```text

I would add host-level tests that start the Functions host, run against Azurite, call the HTTP endpoint, and assert that a message appears in the queue. I would not spend the main live-coding time building that harness unless requested.

```

  

## Acceptance Criteria

  

You are done when:

  

- Valid request returns `202 Accepted`.

- Invalid route id returns `400 Bad Request`.

- Invalid body returns `400 Bad Request`.

- Message is written to the Azurite queue.

- Queue processor can deserialize and process the message.

- You can explain retry and idempotency.

  

## Production Talking Points

  

Say:

  

```text

Queue-triggered processing can retry, so I would make the processor idempotent. I would track processing status by document id and skip work that is already completed.

```

  

Say:

  

```text

For transient failures I would let the function fail so the runtime can retry. For permanent validation failures, I would log and mark the item failed rather than retry forever.

```

  

Mention:

  

- Do not put huge payloads or secrets in queue messages.

- Store identifiers and fetch full data from durable storage.

- Monitor poison queue/dead-letter behaviour.

- Use Application Insights/OpenTelemetry.

- Use managed identity where possible.

- Use app settings or Key Vault for configuration.

- Add integration tests against Azurite or test Azure resources.

  

## Panic Card

  

HTTP to queue:

  

```csharp

if (!Guid.TryParse(id, out var documentId))

{

    return Results.BadRequest("Invalid document id.");

}

  

var message = new CaseDocumentProcessingMessage(

    documentId,

    request.CaseUrn!,

    request.RequestedBy!,

    request.Priority!,

    DateTimeOffset.UtcNow);

  

await queueClient.CreateIfNotExistsAsync(cancellationToken: ct);

await queueClient.SendMessageAsync(BinaryData.FromObjectAsJson(message), ct);

  

return Results.Accepted(

    $"/case-documents/{documentId}",

    new { documentId, status = "Queued" });

```

  

Azure Functions queue trigger:

  

```csharp

[Function("ProcessCaseDocumentMessage")]

public async Task Run(

    [QueueTrigger("case-document-processing", Connection = "AzureWebJobsStorage")]

    string message,

    CancellationToken ct)

{

    var payload = JsonSerializer.Deserialize<CaseDocumentProcessingMessage>(message);

  

    if (payload is null)

    {

        return;

    }

  

    await Task.CompletedTask;

}

```

  

Best interview line:

  

```text

The core design stays the same. If processing can happen asynchronously, I return 202 Accepted from the HTTP endpoint and put a small message on an Azure Storage Queue. If using Azure Functions, the HTTP endpoint becomes an HTTP trigger and the background processor becomes a Queue trigger.

```