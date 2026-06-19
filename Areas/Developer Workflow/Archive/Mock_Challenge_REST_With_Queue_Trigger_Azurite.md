# Mock Challenge: REST Endpoint With Queue Trigger and Azurite

Timebox: 75-90 minutes

Goal: Build an Azure Functions app where an HTTP endpoint accepts a case document processing request, writes a message to Azure Queue Storage using Azurite, and a queue-triggered function processes the message.

This mock is designed to practise:

- Azure Functions HTTP triggers
- Queue triggers
- Azurite/local storage
- `202 Accepted` for asynchronous work
- Validation
- Idempotency thinking
- Logging and production tradeoffs

## Scenario

CPS receives case documents that need background processing, such as OCR, virus scanning, or metadata extraction.

The user should be able to request processing for a case document through a REST-style HTTP endpoint. The endpoint should return quickly and enqueue a message. A separate queue-triggered function should process that message asynchronously.

## Functional Requirements

Build two functions:

1. HTTP-triggered function:

```http
POST /api/case-documents/{id}/process
```

2. Queue-triggered function:

```text
Queue: case-document-processing
```

The HTTP function must:

- Accept a document id from the route.
- Validate that the id is a valid `Guid`.
- Accept a JSON body containing:
  - `caseUrn`
  - `requestedBy`
  - `priority`
- Validate required fields.
- Enqueue a message to Azure Queue Storage.
- Return `202 Accepted`.

The queue-triggered function must:

- Receive the queue message.
- Deserialize it.
- Validate the message.
- Log that processing has started.
- Simulate processing.
- Log that processing has completed.

## Example Request

```http
POST http://localhost:7071/api/case-documents/2c8cf2a0-833e-4a7d-923a-5fd66a4ec2f1/process
Content-Type: application/json

{
  "caseUrn": "CPS-2026-001",
  "requestedBy": "interview.candidate",
  "priority": "Normal"
}
```

## Expected Successful Response

```http
202 Accepted
Location: /api/case-documents/2c8cf2a0-833e-4a7d-923a-5fd66a4ec2f1
```

Example response body:

```json
{
  "documentId": "2c8cf2a0-833e-4a7d-923a-5fd66a4ec2f1",
  "status": "Queued"
}
```

## Validation Rules

Return `400 Bad Request` when:

- The route id is not a valid `Guid`.
- Request body is missing.
- `caseUrn` is missing or whitespace.
- `requestedBy` is missing or whitespace.
- `priority` is not one of:
  - `Low`
  - `Normal`
  - `High`

## Non-Functional Requirements

Your solution should show:

- Clear trigger separation.
- Small DTOs.
- No hard-coded storage secrets.
- Use of `AzureWebJobsStorage` from `local.settings.json`.
- Meaningful logs.
- Cancellation token usage where practical.
- A short explanation of retry/idempotency concerns.

## Local Setup

Azurite must be running.

```powershell
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log
```

`local.settings.json`:

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

If `func` is not available, create the Function App through Visual Studio:

```text
Create new project -> Azure Functions -> .NET 8 isolated -> HTTP trigger
```

If `func` is available:

```powershell
func init CpsQueueMock --worker-runtime dotnet-isolated --target-framework net8.0
cd CpsQueueMock
func new --template "Http Trigger" --name EnqueueCaseDocumentProcessing
func new --template "Azure Queue Storage Trigger" --name ProcessCaseDocumentMessage
func start
```

## Suggested Project Shape

```text
CpsQueueMock/
  Program.cs
  Functions/
    EnqueueCaseDocumentProcessing.cs
    ProcessCaseDocumentMessage.cs
  Contracts/
    ProcessCaseDocumentRequest.cs
    CaseDocumentProcessingMessage.cs
    ProcessingAcceptedResponse.cs
  Services/
    IProcessingMessageWriter.cs
    QueueProcessingMessageWriter.cs
```

You can keep it flatter if the timebox is tight.

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

## Suggested Implementation Flow

### Step 1: Create the HTTP Function

Start with the route and validation.

Memory hook:

```text
Route id -> parse Guid -> deserialize body -> validate -> enqueue -> return 202.
```

### Step 2: Enqueue the Message

Use `QueueClient` directly, because it is explicit and easy to explain.

Package:

```powershell
dotnet add package Azure.Storage.Queues
```

Register:

```csharp
using Azure.Storage.Queues;

var storageConnectionString = builder.Configuration["AzureWebJobsStorage"];

builder.Services.AddSingleton(_ =>
    new QueueClient(storageConnectionString, "case-document-processing"));
```

Important interview note:

```text
For a live exercise I am using QueueClient directly because the dependency is visible and testable. I could also use a queue output binding.
```

### Step 3: Return 202 Accepted

Use:

```csharp
return new AcceptedResult(
    $"/api/case-documents/{documentId}",
    new ProcessingAcceptedResponse(documentId, "Queued"));
```

Explain:

```text
I am returning 202 because the request has been accepted, but the background processing has not completed yet.
```

### Step 4: Create the Queue Trigger

Memory hook:

```text
Queue message -> deserialize -> validate -> idempotency check -> process -> log.
```

Queue trigger shape:

```csharp
[Function("ProcessCaseDocumentMessage")]
public async Task Run(
    [QueueTrigger("case-document-processing", Connection = "AzureWebJobsStorage")]
    string message,
    CancellationToken cancellationToken)
{
    // Deserialize
    // Validate
    // Process
    await Task.CompletedTask;
}
```

## Acceptance Criteria

You are done when:

- `POST /api/case-documents/{id}/process` returns `202 Accepted` for a valid request.
- Invalid ids return `400 Bad Request`.
- Missing required fields return `400 Bad Request`.
- A queue message is created in Azurite.
- The queue-triggered function logs that it processed the message.
- You can explain why this design is asynchronous.

## Tests To Add If Time Allows

Add unit tests for validation:

- Valid request passes validation.
- Invalid priority fails validation.
- Missing `caseUrn` fails validation.
- Invalid `Guid` route value fails parsing.

You do not need full Azure Functions host integration tests in the mock unless you have time.

## Stretch Goals

- Add a status store so the HTTP endpoint marks the document as `Queued` and the queue processor marks it as `Processed`.
- Add idempotency: skip processing if document is already processed.
- Add `High` priority logging.
- Add a poison queue monitoring explanation.
- Add retry policy discussion.

## Production Talking Points

Say:

```text
In production I would make the queue processor idempotent because queue messages can be retried. I would track processing status by document id, avoid putting large payloads or secrets in the queue message, and monitor poison queue/dead-letter behaviour.
```

Also mention:

- Managed identity instead of connection strings where possible.
- Key Vault/app settings for configuration.
- Application Insights/OpenTelemetry.
- Alerting on failed/poison messages.
- Idempotency for repeated messages.
- Validation failures should not retry forever.

## Panic Card

HTTP enqueue:

```csharp
if (!Guid.TryParse(id, out var documentId))
{
    return new BadRequestObjectResult("Invalid document id.");
}

await queueClient.CreateIfNotExistsAsync(cancellationToken: cancellationToken);
await queueClient.SendMessageAsync(
    BinaryData.FromObjectAsJson(message),
    cancellationToken);

return new AcceptedResult(
    $"/api/case-documents/{documentId}",
    new { documentId, status = "Queued" });
```

Queue trigger:

```csharp
[Function("ProcessCaseDocumentMessage")]
public async Task Run(
    [QueueTrigger("case-document-processing", Connection = "AzureWebJobsStorage")]
    string message,
    CancellationToken cancellationToken)
{
    var payload = JsonSerializer.Deserialize<CaseDocumentProcessingMessage>(message);

    if (payload is null)
    {
        logger.LogWarning("Invalid queue message.");
        return;
    }

    logger.LogInformation("Processing document {DocumentId}.", payload.DocumentId);

    await Task.CompletedTask;
}
```

Final explanation:

```text
The HTTP trigger handles request validation and enqueues work, then returns 202 Accepted. The queue trigger handles asynchronous processing. This keeps the user-facing request fast and gives us retry behaviour for background work.
```
