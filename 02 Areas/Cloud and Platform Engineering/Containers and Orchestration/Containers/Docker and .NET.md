---
date: 2025-11-25
status: Current
tags:
  - docker
  - dotnet
  - containers
  - devops

---

# Docker & .NET

## Quick Reference

**Definition:** A guide to packaging supported .NET applications in containers with separate build and runtime stages.

**When to use:**
- Deploying services in containers (Kubernetes, App Services, Docker Swarm).

**Key Takeaways:**
- **Use multi-stage builds** to omit build tools from the runtime stage; final size still depends on base image and published artifacts.
- **Choose appropriate base images** (`mcr.microsoft.com/dotnet/aspnet` for runtime, `sdk` for build).
- Tip: **Keep secrets out of images**; use environment variables or secret stores.

**Code Snippet (multi-stage Dockerfile):**
```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY MyApp.csproj ./
RUN dotnet restore MyApp.csproj
COPY . ./
RUN dotnet publish MyApp.csproj -c Release -o /app --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet","MyApp.dll"]
```

**Gotchas:**
- Caution: **Layer invalidation:** Copy only necessary files to reduce rebuild time.
- Caution: **Image size:** Avoid installing unnecessary packages in the runtime image.

**Limit:** The Dockerfile needs a real project/assembly and a build test before publication.

---

## Deep Dive

### Build-Time Optimizations
- Use `.dockerignore` to avoid copying local artifacts.
- Pin SDK versions for reproducible builds.

### Runtime Considerations
- Use `ASPNETCORE_ENVIRONMENT` and configure logging appropriately.
- Use health probes and graceful shutdown (SIGTERM) handling in ASP.NET Core.

### Security
- Scan images for vulnerabilities.
- Run processes as non-root where possible.

---

## Build and runtime boundaries

Use matching supported SDK and ASP.NET runtime tags. The Dockerfile is an illustrative MyApp project; set the real project and assembly name, keep a .dockerignore, and build it before publication. Multi-stage builds separate build dependencies from the runtime image, but image size depends on base image and copied artifacts. Consider the non-root app user and HTTP port configured by the chosen image, and pass secrets at runtime through the deployment platform rather than baking them into layers.

## Related Concepts
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]

## Resources

- [Primary documentation](https://dotnet.microsoft.com/en-us/platform/support/policy) (accessed 2026-09-24).
- [Microsoft Docs: containerize .NET apps](https://learn.microsoft.com/en-us/dotnet/core/docker/build-container) (accessed 2026-09-24).
- [Docker best practices](https://docs.docker.com/build/building/best-practices/) (accessed 2026-09-24).

## Practice Exercises
1. Containerize a simple Web API using multi-stage build and push to a registry.
2. Measure image size before/after optimization.

## Review Schedule
- [ ] Review in 6 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
