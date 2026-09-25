# Azurite Historical Interview Capture

Migrated from `Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite.md` during the 2026-09-24 knowledge-base audit. Retained for provenance; this is not a current technical reference.

## Original Local Setup Context

- PowerShell on the author's machine used `npm.cmd` because `npm.ps1` was blocked.
- Original storage directory: `C:\tmp\azurite`.
- The original note recommended keeping Azurite running for a CPS interview coding challenge.

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
