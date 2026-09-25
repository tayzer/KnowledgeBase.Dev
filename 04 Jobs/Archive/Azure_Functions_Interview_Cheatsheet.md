# Azure Functions Interview Cheat Sheet

Use this if they ask for an Azure Functions app instead of a normal ASP.NET Web API.

Current machine note:

- `.NET 8` SDK is installed.
- Visual Studio 2022 with Azure/Cloud workload is installed.
- `func` is not currently available on PATH.
- `azurite` is not currently available on PATH.

So your safest interview fallback is Visual Studio:

```text
Create new project -> Azure Functions -> .NET 8 isolated -> HTTP trigger
```

If Azure Functions Core Tools is installed later, you can use the CLI route too.

## Mental Model

In ASP.NET Web API you usually think:

```text
Endpoint/controller route -> service -> repository -> response
```

In Azure Functions you think:

```text
Trigger -> function method -> service/repository -> response/output binding
```

A function is just a public method marked with:

```csharp
[Function("FunctionName")]
```

And it has one trigger, for example:

```csharp
[HttpTrigger(...)]
[QueueTrigger(...)]
[BlobTrigger(...)]
```

For the interview, HTTP trigger is the most likely if they ask for an API-style challenge.

## What To Say

```text
If this is an Azure Functions challenge, I will keep the same core design: request DTOs, a small service or use case, reader/writer interfaces, and storage behind an abstraction. The main difference is that the entry point is an HTTP trigger rather than a controller or Minimal API endpoint.
```

## Visual Studio Flow

Use this if `func` is unavailable.

1. Open Visual Studio.
2. Create a new project.
3. Choose Azure Functions.
4. Select `.NET 8 isolated`.
5. Choose HTTP trigger.
6. Use Authorization level `Function` or `Anonymous` depending on the challenge.
7. Run locally.
8. The local URL will usually be:

```text
http://localhost:7071/api/<route>
```

## CLI Flow

Only use this if `func --version` works.

```powershell
func init CpsFunctions --worker-runtime dotnet-isolated --target-framework net8.0
cd CpsFunctions
func new --template "Http Trigger" --name CreateCaseDocument
func start
```

Core Tools usually prints URLs like:

```text
http://localhost:7071/api/CreateCaseDocument
```

## local.settings.json

For local development with storage/Azurite:

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

Important:

- Do not hard-code connection strings in code.
- Local settings are for local development.
- In Azure, these become app settings.

## Program.cs With Dependency Injection

The template may generate slightly different code. The important bit is that you register your services in `Program.cs`.

Example:

```csharp
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = FunctionsApplication.CreateBuilder(args);

builder.ConfigureFunctionsWebApplication();

builder.Services.AddSingleton<InMemoryCaseDocumentStore>();

builder.Services.AddSingleton<ICaseDocumentReader>(sp =>
    sp.GetRequiredService<InMemoryCaseDocumentStore>());

builder.Services.AddSingleton<ICaseDocumentWriter>(sp =>
    sp.GetRequiredService<InMemoryCaseDocumentStore>());

builder.Build().Run();
```

Why singleton here?

```text
For an in-memory interview store, singleton keeps data available between function calls. In production, I would choose lifetimes based on the dependency, such as scoped for EF Core or singleton Azure SDK clients.
```

## Domain and DTOs

```csharp
public sealed record CaseDocument(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);

public sealed record CreateCaseDocumentRequest(
    string? CaseUrn,
    string? DocumentType,
    string? Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseDocumentResponse(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);
```

Mapping:

```csharp
private static CaseDocumentResponse ToResponse(CaseDocument document)
{
    return new CaseDocumentResponse(
        document.Id,
        document.CaseUrn,
        document.DocumentType,
        document.Status,
        document.ReceivedAt);
}
```

## Reader and Writer Interfaces

```csharp
public interface ICaseDocumentReader
{
    Task<CaseDocument?> GetByIdAsync(
        Guid id,
        CancellationToken cancellationToken);

    Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(
        string status,
        CancellationToken cancellationToken);
}

public interface ICaseDocumentWriter
{
    Task AddAsync(
        CaseDocument document,
        CancellationToken cancellationToken);
}
```

## In-Memory Store

```csharp
using System.Collections.Concurrent;

public sealed class InMemoryCaseDocumentStore :
    ICaseDocumentReader,
    ICaseDocumentWriter
{
    private readonly ConcurrentDictionary<Guid, CaseDocument> _documents = new();

    public Task AddAsync(CaseDocument document, CancellationToken cancellationToken)
    {
        _documents[document.Id] = document;
        return Task.CompletedTask;
    }

    public Task<CaseDocument?> GetByIdAsync(
        Guid id,
        CancellationToken cancellationToken)
    {
        _documents.TryGetValue(id, out var document);
        return Task.FromResult(document);
    }

    public Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(
        string status,
        CancellationToken cancellationToken)
    {
        var results = _documents.Values
            .Where(x => string.Equals(x.Status, status, StringComparison.OrdinalIgnoreCase))
            .ToList();

        return Task.FromResult<IReadOnlyList<CaseDocument>>(results);
    }
}
```

## HTTP Function Using IActionResult

This feels closest to ASP.NET Core.

Typical imports:

```csharp
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
```

Class with dependencies:

```csharp
public sealed class CaseDocumentFunctions
{
    private readonly ICaseDocumentReader _reader;
    private readonly ICaseDocumentWriter _writer;
    private readonly ILogger<CaseDocumentFunctions> _logger;

    public CaseDocumentFunctions(
        ICaseDocumentReader reader,
        ICaseDocumentWriter writer,
        ILogger<CaseDocumentFunctions> logger)
    {
        _reader = reader;
        _writer = writer;
        _logger = logger;
    }
}
```

## POST Function

Equivalent of `Results.Created(...)` in Functions:

```csharp
return new CreatedResult($"/api/case-documents/{document.Id}", ToResponse(document));
```

Full example:

```csharp
[Function("CreateCaseDocument")]
public async Task<IActionResult> CreateCaseDocument(
    [HttpTrigger(AuthorizationLevel.Function, "post", Route = "case-documents")]
    HttpRequest request,
    CancellationToken cancellationToken)
{
    var createRequest = await JsonSerializer.DeserializeAsync<CreateCaseDocumentRequest>(
        request.Body,
        cancellationToken: cancellationToken);

    if (createRequest is null)
    {
        return new BadRequestObjectResult("Request body is required.");
    }

    var validationError = Validate(createRequest);

    if (validationError is not null)
    {
        return new BadRequestObjectResult(validationError);
    }

    var document = new CaseDocument(
        Guid.NewGuid(),
        createRequest.CaseUrn!.Trim(),
        createRequest.DocumentType!.Trim(),
        createRequest.Status!.Trim(),
        createRequest.ReceivedAt);

    await _writer.AddAsync(document, cancellationToken);

    _logger.LogInformation("Created case document {DocumentId}.", document.Id);

    return new CreatedResult(
        $"/api/case-documents/{document.Id}",
        ToResponse(document));
}
```

## GET by Id Function

This is the same logic as Minimal API, just with `IActionResult`.

```csharp
[Function("GetCaseDocumentById")]
public async Task<IActionResult> GetCaseDocumentById(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "case-documents/{id}")]
    HttpRequest request,
    string id,
    CancellationToken cancellationToken)
{
    if (!Guid.TryParse(id, out var documentId))
    {
        return new BadRequestObjectResult("Invalid document id.");
    }

    var document = await _reader.GetByIdAsync(documentId, cancellationToken);

    if (document is null)
    {
        return new NotFoundResult();
    }

    return new OkObjectResult(ToResponse(document));
}
```

Memory hook:

```text
Route value -> Guid.TryParse -> reader.GetByIdAsync -> null means 404 -> found means 200.
```

## GET List by Status Function

```csharp
[Function("ListCaseDocumentsByStatus")]
public async Task<IActionResult> ListCaseDocumentsByStatus(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "case-documents")]
    HttpRequest request,
    CancellationToken cancellationToken)
{
    var status = request.Query["status"].ToString();

    if (string.IsNullOrWhiteSpace(status))
    {
        return new BadRequestObjectResult("Status is required.");
    }

    var documents = await _reader.ListByStatusAsync(status, cancellationToken);

    var response = documents
        .Select(ToResponse)
        .ToList();

    return new OkObjectResult(response);
}
```

Example:

```http
GET http://localhost:7071/api/case-documents?status=Received
```

## Validation Helper

```csharp
private static string? Validate(CreateCaseDocumentRequest request)
{
    if (string.IsNullOrWhiteSpace(request.CaseUrn))
    {
        return "Case URN is required.";
    }

    if (string.IsNullOrWhiteSpace(request.DocumentType))
    {
        return "Document type is required.";
    }

    if (string.IsNullOrWhiteSpace(request.Status))
    {
        return "Status is required.";
    }

    if (request.ReceivedAt > DateTimeOffset.UtcNow)
    {
        return "Received date cannot be in the future.";
    }

    return null;
}
```

## If They Use HttpRequestData Instead

Some templates use `HttpRequestData` and `HttpResponseData` instead of `HttpRequest` and `IActionResult`.

GET by id shape:

```csharp
[Function("GetCaseDocumentById")]
public async Task<HttpResponseData> GetCaseDocumentById(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "case-documents/{id}")]
    HttpRequestData request,
    string id,
    CancellationToken cancellationToken)
{
    if (!Guid.TryParse(id, out var documentId))
    {
        var badRequest = request.CreateResponse(HttpStatusCode.BadRequest);
        await badRequest.WriteStringAsync("Invalid document id.", cancellationToken);
        return badRequest;
    }

    var document = await _reader.GetByIdAsync(documentId, cancellationToken);

    if (document is null)
    {
        return request.CreateResponse(HttpStatusCode.NotFound);
    }

    var ok = request.CreateResponse(HttpStatusCode.OK);
    await ok.WriteAsJsonAsync(ToResponse(document), cancellationToken);
    return ok;
}
```

Created response shape:

```csharp
var created = request.CreateResponse(HttpStatusCode.Created);
created.Headers.Add("Location", $"/api/case-documents/{document.Id}");
await created.WriteAsJsonAsync(ToResponse(document), cancellationToken);
return created;
```

## Queue Trigger Backup Pattern

If they ask for background or event-driven processing, use a queue trigger.

Queue triggers are useful when the caller does not need the work to finish immediately. The HTTP endpoint can accept the request, put a message on a queue, and return quickly. A separate queue-triggered function then processes the message in the background.

Say:

```text
I would use an HTTP trigger for synchronous request/response work, and a Queue trigger when the work can happen asynchronously in the background.
```

Good examples:

- Send a case document for virus scanning.
- Start OCR/text extraction.
- Notify downstream systems that a case document was received.
- Retry a flaky integration without blocking the user.
- Process a long-running task after returning `202 Accepted`.

Good interview wording:

```text
For this kind of work I would separate intake from processing. The HTTP function validates the request and enqueues a small message. The queue-triggered function owns the background processing, logging, retry behaviour, and idempotency checks.
```

### Message Shape

Keep queue messages small. Put identifiers and intent in the message, not a huge payload.

```csharp
public sealed record CaseDocumentMessage(
    Guid DocumentId,
    string CaseUrn,
    string Action,
    DateTimeOffset EnqueuedAt);
```

Example message:

```json
{
  "documentId": "2c8cf2a0-833e-4a7d-923a-5fd66a4ec2f1",
  "caseUrn": "CPS-2026-001",
  "action": "ProcessDocument",
  "enqueuedAt": "2026-06-17T09:30:00Z"
}
```

### Queue Trigger Function

Simple queue-triggered function:

```csharp
using System.Text.Json;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

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
        [QueueTrigger("case-documents", Connection = "AzureWebJobsStorage")]
        string message,
        CancellationToken cancellationToken)
    {
        var queueMessage = JsonSerializer.Deserialize<CaseDocumentMessage>(message);

        if (queueMessage is null)
        {
            _logger.LogWarning("Queue message could not be deserialized.");
            return;
        }

        _logger.LogInformation(
            "Processing document {DocumentId} for case {CaseUrn}.",
            queueMessage.DocumentId,
            queueMessage.CaseUrn);

        // Load document metadata by id.
        // Check whether it has already been processed.
        // Perform the background work.
        // Mark processing status.

        await Task.CompletedTask;
    }
}
```

Memory hook:

```text
QueueTrigger queue name -> deserialize message -> validate -> idempotency check -> process -> log outcome.
```

### HTTP Function That Enqueues Work

If they ask for an HTTP endpoint that starts background work, return `202 Accepted`.

Install/use the queue SDK if you are writing to the queue yourself:

```powershell
dotnet add package Azure.Storage.Queues
```

Register a `QueueClient`:

```csharp
using Azure.Storage.Queues;

var storageConnectionString = builder.Configuration["AzureWebJobsStorage"];

builder.Services.AddSingleton(_ =>
    new QueueClient(storageConnectionString, "case-documents"));
```

In `local.settings.json`, `AzureWebJobsStorage` lives under `Values`, not as a normal nested configuration object:

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

Example HTTP function:

```csharp
using System.Text.Json;
using Azure.Storage.Queues;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;

public sealed class EnqueueCaseDocumentProcessing
{
    private readonly QueueClient _queueClient;

    public EnqueueCaseDocumentProcessing(QueueClient queueClient)
    {
        _queueClient = queueClient;
    }

    [Function("EnqueueCaseDocumentProcessing")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = "case-documents/{id}/process")]
        HttpRequest request,
        string id,
        CancellationToken cancellationToken)
    {
        if (!Guid.TryParse(id, out var documentId))
        {
            return new BadRequestObjectResult("Invalid document id.");
        }

        await _queueClient.CreateIfNotExistsAsync(cancellationToken: cancellationToken);

        var message = new CaseDocumentMessage(
            documentId,
            "CPS-2026-001",
            "ProcessDocument",
            DateTimeOffset.UtcNow);

        await _queueClient.SendMessageAsync(
            BinaryData.FromObjectAsJson(message),
            cancellationToken);

        return new AcceptedResult(
            $"/api/case-documents/{documentId}",
            new { documentId, status = "Queued" });
    }
}
```

What this shows:

- The HTTP call returns quickly.
- Work is queued for background processing.
- The response is `202 Accepted`, not `201 Created`, because the processing has not completed yet.

### Alternative: Queue Output Binding

For a short challenge, they may prefer an output binding rather than manually using `QueueClient`.

The exact syntax can vary by Functions model/template, so use this only if the template clearly supports it. In .NET isolated with ASP.NET Core integration, the shape is usually a custom return type with both the HTTP result and the queue output.

```csharp
public sealed class EnqueueProcessingResponse
{
    [HttpResult]
    public IActionResult HttpResponse { get; set; } = default!;

    [QueueOutput("case-documents", Connection = "AzureWebJobsStorage")]
    public string? QueueMessage { get; set; }
}
```

Then the HTTP function can return both:

```csharp
[Function("EnqueueCaseDocumentProcessing")]
public EnqueueProcessingResponse Run(
    [HttpTrigger(AuthorizationLevel.Function, "post", Route = "case-documents/{id}/process")]
    HttpRequest request,
    string id)
{
    if (!Guid.TryParse(id, out var documentId))
    {
        return new EnqueueProcessingResponse
        {
            HttpResponse = new BadRequestObjectResult("Invalid document id."),
            QueueMessage = null
        };
    }

    var message = new CaseDocumentMessage(
        documentId,
        "CPS-2026-001",
        "ProcessDocument",
        DateTimeOffset.UtcNow);

    return new EnqueueProcessingResponse
    {
        HttpResponse = new AcceptedResult(
            $"/api/case-documents/{documentId}",
            new { documentId, status = "Queued" }),
        QueueMessage = JsonSerializer.Serialize(message)
    };
}
```

In a live challenge, if this feels fiddly, use `QueueClient`. It is explicit and easier to explain under pressure.

For a real interview, it is perfectly fine to say:

```text
I can either use a queue output binding or the QueueClient SDK. For clarity and testability in this short exercise, I will use the SDK behind an injected dependency.
```

### Local Azurite Setup

If using Azurite, `AzureWebJobsStorage` should point to local development storage:

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

Start Azurite before running the function app:

```powershell
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log
```

If Azurite is not available:

```text
I will keep the queue boundary clear and use an in-memory placeholder for the live exercise. In a real local setup, AzureWebJobsStorage would use UseDevelopmentStorage=true with Azurite.
```

### Idempotency

Queue-triggered work can be retried. Design so the same message can be processed more than once without corrupting state.

Say:

```text
Because queue messages can be retried, I would make the processor idempotent. Before processing, I would check the current document status and skip work that has already completed.
```

Example logic:

```csharp
if (document.Status == "Processed")
{
    _logger.LogInformation(
        "Document {DocumentId} has already been processed. Skipping.",
        message.DocumentId);

    return;
}
```

### Retry and Poison Queue Talking Points

If a queue-triggered function throws, Azure Functions can retry the message. After repeated failures, messages can end up on a poison queue depending on the storage queue trigger configuration.

Good wording:

```text
For transient failures I would let the function fail so the runtime can retry. For validation failures that will never succeed, I would log the issue and mark the record as failed rather than retrying forever. I would also monitor the poison queue and alert on it.
```

Mention:

- Log enough context to diagnose the failed message.
- Avoid swallowing unexpected exceptions.
- Distinguish transient errors from permanent validation errors.
- Make processing idempotent because retries can happen.
- Consider a poison queue/dead-letter handling process.

### When Not To Use A Queue Trigger

Do not use a queue if:

- The caller needs an immediate result.
- The work must complete inside the same transaction as the request.
- Ordering is strict and hard to relax.
- The message would need to contain large sensitive payloads.

Say:

```text
I would only use a queue where eventual consistency is acceptable. If the caller needs an immediate answer, I would keep the work synchronous or return a clear accepted/pending status.
```

## Function vs Web API Translation

| Web API concept | Azure Functions equivalent |
|---|---|
| Controller or Minimal API endpoint | Function method |
| Route | `Route = "case-documents/{id}"` |
| `Results.Ok(...)` | `new OkObjectResult(...)` or `HttpStatusCode.OK` |
| `Results.NotFound()` | `new NotFoundResult()` or `HttpStatusCode.NotFound` |
| `Results.Created(...)` | `new CreatedResult(location, body)` or `HttpStatusCode.Created` plus Location header |
| `appsettings.json` | `local.settings.json` locally, app settings in Azure |
| Background service | Queue/Timer trigger |
| Dependency injection | Register services in `Program.cs` |

## What To Prioritise In A Function Challenge

1. Correct trigger.
2. Clear route.
3. Deserialize request safely.
4. Validate input.
5. Call service/repository.
6. Return the right status code.
7. Use `local.settings.json` for storage/configuration.
8. Mention production hardening.

## What Full Host Integration Tests Look Like

For Azure Functions, there are three useful testing levels:

```text
Unit test                -> Call your service/validation code directly.
Function method test      -> Instantiate the function class and call Run(...).
Full host integration test -> Start the actual Functions host and call it over HTTP.
```

In a live interview, you are unlikely to write full host integration tests from scratch. They are slow and tool-dependent. But it is useful to know what they mean.

Say:

```text
For the timebox I would unit test the validation and core service logic. In the real project I would add full host integration tests that start the Functions host, run against Azurite, call the HTTP endpoint with HttpClient, and assert the queue or table storage side effect.
```

### Example: Queue Scenario

For the queue mock, a full host integration test would prove:

1. Azurite is running.
2. The Functions host starts.
3. `POST /api/case-documents/{id}/process` returns `202 Accepted`.
4. A message appears on the `case-document-processing` queue.
5. Optionally, the queue-triggered function processes that message and updates some observable state.

That is different from a unit test. A unit test asks:

```text
Does my validation method work?
```

A host integration test asks:

```text
Does the real function app start, route HTTP correctly, bind configuration correctly, and talk to local Azure Storage?
```

### Typical Test Shape

You need packages like:

```powershell
dotnet add package xunit
dotnet add package FluentAssertions
dotnet add package Azure.Storage.Queues
```

The test usually starts external processes:

- `azurite`
- `func start`

Then calls the local function endpoint:

```csharp
public sealed class CaseDocumentFunctionHostTests : IAsyncLifetime
{
    private readonly HttpClient _httpClient = new();

    public async Task InitializeAsync()
    {
        // Start Azurite as a process, or require it to already be running.
        // Start the Functions host with `func start --port 7079`.
        // Wait until http://localhost:7079 responds.
        await Task.CompletedTask;
    }

    public async Task DisposeAsync()
    {
        // Stop the Functions host process.
        // Stop Azurite if this test started it.
        await Task.CompletedTask;
    }

    [Fact]
    public async Task ProcessEndpoint_EnqueuesMessage_WhenRequestIsValid()
    {
        var documentId = Guid.NewGuid();

        var request = new
        {
            caseUrn = "CPS-2026-001",
            requestedBy = "integration-test",
            priority = "Normal"
        };

        var response = await _httpClient.PostAsJsonAsync(
            $"http://localhost:7079/api/case-documents/{documentId}/process",
            request);

        response.StatusCode.Should().Be(HttpStatusCode.Accepted);

        var queueClient = new QueueClient(
            "UseDevelopmentStorage=true",
            "case-document-processing");

        var message = await queueClient.ReceiveMessageAsync();

        message.Value.Should().NotBeNull();
    }
}
```

This example is intentionally incomplete around process startup because that part depends on local tooling, paths, and ports. The important pattern is:

```text
Start real host -> call real HTTP endpoint -> inspect real Azurite queue/table.
```

### Why This Is Heavy

Full host integration tests are heavier because they need:

- Azure Functions Core Tools
- Azurite
- Free local ports
- Test isolation
- Cleanup between runs
- More waiting/retry logic
- CI configuration

That is why, in the interview, it is better to say:

```text
I would not spend the interview time setting up full host integration tests unless asked. I would unit test the validation and service logic now, then add host-level tests in the project pipeline.
```

### Better Live-Challenge Test

For the interview, write this kind of test instead:

```csharp
[Fact]
public void Validate_ReturnsError_WhenPriorityIsInvalid()
{
    var request = new ProcessCaseDocumentRequest(
        "CPS-2026-001",
        "candidate",
        "Urgent");

    var result = Validate(request);

    result.Should().Be("Priority is invalid.");
}
```

Or test the queue-message writer behind an interface:

```csharp
[Fact]
public async Task EnqueueAsync_SendsMessageToQueue()
{
    var fakeWriter = new FakeProcessingMessageWriter();

    var message = new CaseDocumentProcessingMessage(
        Guid.NewGuid(),
        "CPS-2026-001",
        "candidate",
        "Normal",
        DateTimeOffset.UtcNow);

    await fakeWriter.EnqueueAsync(message, CancellationToken.None);

    fakeWriter.Messages.Should().ContainSingle();
}
```

This gives you a quality signal without losing 30 minutes to host setup.

## What To Say If Tools Are Missing

```text
Core Tools does not appear to be available on PATH, so I will use the Visual Studio Azure Functions template. The code shape is the same: HTTP trigger, dependency injection, validation, repository abstraction, and local settings for storage.
```

If Azurite is missing:

```text
I will keep the storage behind an interface and start with an in-memory implementation. If Azurite is available, I can swap the implementation to local Azure Storage using UseDevelopmentStorage=true.
```

## Panic Card

POST:

```csharp
[Function("CreateItem")]
public async Task<IActionResult> CreateItem(
    [HttpTrigger(AuthorizationLevel.Function, "post", Route = "items")]
    HttpRequest request,
    CancellationToken cancellationToken)
{
    var dto = await JsonSerializer.DeserializeAsync<CreateItemRequest>(
        request.Body,
        cancellationToken: cancellationToken);

    if (dto is null)
    {
        return new BadRequestObjectResult("Request body is required.");
    }

    var item = new Item(Guid.NewGuid(), dto.Name);

    await _writer.AddAsync(item, cancellationToken);

    return new CreatedResult($"/api/items/{item.Id}", item);
}
```

GET by id:

```csharp
[Function("GetItemById")]
public async Task<IActionResult> GetItemById(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "items/{id}")]
    HttpRequest request,
    string id,
    CancellationToken cancellationToken)
{
    if (!Guid.TryParse(id, out var itemId))
    {
        return new BadRequestObjectResult("Invalid id.");
    }

    var item = await _reader.GetByIdAsync(itemId, cancellationToken);

    return item is null
        ? new NotFoundResult()
        : new OkObjectResult(item);
}
```

Local URL:

```text
http://localhost:7071/api/items/{id}
```

## Production Hardening To Mention

- Function-level or APIM authentication/authorisation
- Managed identity for Azure resources
- Key Vault for secrets
- App settings rather than hard-coded configuration
- Application Insights/OpenTelemetry
- Retry policies where safe
- Idempotency for queue-triggered processing
- Poison queue/dead-letter strategy
- Integration tests against Azurite or test Azure resources
- CI/CD pipeline
- Health/availability monitoring

## Sources

- Microsoft Learn: Azure Functions .NET isolated worker guide
- Microsoft Learn: Develop Azure Functions locally with Core Tools
- Microsoft Learn: Use local settings in Azure Functions
