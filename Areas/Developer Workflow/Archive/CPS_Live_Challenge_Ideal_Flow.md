# CPS Live Challenge: Ideal Flow

Use this as a practical script for the hands-on technical interview.

Your overall pattern is:

```text
Clarify -> Design -> Test -> Build -> Harden -> Explain
```

The goal is not to produce a huge solution. The goal is to show that you can make good lead-developer decisions under time pressure.

## 1. First 5 Minutes: Clarify

Before writing code, make sure you understand the requirement.

Say:

```text
Before I start coding, I will quickly confirm the core behaviour, edge cases, and any non-functional expectations so I can keep the implementation focused.
```

Ask a few focused questions:

- What are the required inputs and outputs?
- Should data persist after restart?
- Is Azurite or local Azure Storage expected?
- What error cases matter most?
- Are tests expected within the timebox?
- Is this more about API shape, storage integration, or business rules?

Then summarise back:

```text
So the core requirement is [X]. I will first build a thin working API/service slice, then add validation, tests, and storage if time allows.
```

## 2. Next 5 Minutes: State Your Design

Give a short architecture explanation before coding.

Say:

```text
I will keep this proportionate for the timebox: API endpoint, request and response DTOs, a small service for the business rule, and a repository abstraction. I will start in-memory or with Azurite depending on priority, so the core logic remains testable.
```

Suggested structure:

```text
Api
  Endpoints or Controllers
  Contracts
Application
  Services
  Interfaces
Domain
  Models / Rules
Infrastructure
  Repositories
Tests
```

Do not over-engineer. A small, working, well-explained design is stronger than a large unfinished one.

## 3. Next 10-15 Minutes: Write the First Test or Acceptance Case

Use a light TDD/BDD approach.

Say:

```text
I will start by pinning the main business rule with a test. That gives us confidence before wiring it into the API.
```

Good early test cases:

- Valid request creates a record.
- Invalid request is rejected.
- Future date is rejected.
- Unknown status is rejected.
- Duplicate record is handled correctly.

Avoid spending too long on test infrastructure. One or two meaningful tests early are enough.

## 4. Next 20-30 Minutes: Build the Thin Working Slice

Get one end-to-end path working.

Priority order:

1. Create request DTO.
2. Add domain model or service.
3. Add endpoint/controller.
4. Add repository.
5. Return correct HTTP status.
6. Test with Swagger or an HTTP client.

Say:

```text
I am aiming for a working vertical slice first. Once that is running, I will come back and improve validation, error handling, and persistence.
```

This is important: a working simple solution beats an unfinished perfect architecture.

## 5. Next 15-20 Minutes: Add Validation and Error Handling

Now make it professional.

Add:

- Required field validation
- Sensible status codes
- Clear error messages
- `400 Bad Request` for invalid input
- `404 Not Found` for missing resources
- `201 Created` for successful creation
- Logging where useful
- Cancellation tokens on async methods

Say:

```text
I am putting validation at the boundary and keeping the service focused on business decisions.
```

## 6. Next 15-20 Minutes: Add Persistence

If the requirement mentions Azure Storage, use Azurite.

Good approach:

- Keep a repository interface stable.
- Start with in-memory persistence if needed.
- Swap to a Table, Blob, or Queue implementation when ready.

Say:

```text
I have kept storage behind an interface so the API and business logic do not care whether this is in-memory, Azurite, or a real Azure Storage account.
```

For Azurite, the simplest local connection string is:

```text
UseDevelopmentStorage=true
```

If time is tight, say:

```text
I will keep this in-memory for now to preserve the working slice, but the repository boundary is where I would plug in Azure Table Storage.
```

That is a good tradeoff, not a failure.

## 7. Next 10-15 Minutes: Add More Tests

Add tests around the highest-risk logic rather than every line.

Best tests:

- Happy path
- Important validation failure
- Not found case
- Business rule edge case

If you are comfortable, add an endpoint or integration test. If not, focused unit tests are fine.

Say:

```text
I am focusing test coverage on the rules most likely to break or cause user impact.
```

## 8. Final 5-10 Minutes: Refactor and Explain

Do a quick cleanup:

- Rename unclear variables
- Remove obvious duplication
- Check async/await usage
- Check status codes
- Check configuration naming
- Check the project builds
- Run tests

Then summarise clearly:

```text
What is working is [X], [Y], and [Z]. The main tradeoff I made was [A] because of the timebox. In production I would add [B], [C], and [D].
```

Production hardening points to mention:

- Authentication and authorisation
- Real Azure Storage account
- Managed identity and Key Vault
- CI/CD pipeline
- Integration tests
- Health checks
- Structured logging
- Monitoring and alerts
- Retry policies
- Security review
- Accessibility if UI is involved

## Ideal Script While Coding

Use this shape throughout:

```text
I understand the requirement as...
The main edge cases are...
I will start with...
I am making this tradeoff because...
Now I am validating...
Now I am testing...
If this were production, I would also...
```

## What They Want To See

They are probably assessing whether you:

- Communicate while coding
- Clarify ambiguity
- Build incrementally
- Understand .NET 8 and C#
- Use sensible architecture without overcomplicating
- Test important behaviour
- Handle errors cleanly
- Understand Azure and local cloud development
- Make lead-developer tradeoffs
- Stay calm when something goes wrong

## North Star

```text
Build the smallest clean thing that works, explain your decisions, and leave clear evidence that you know how to take it to production.
```
