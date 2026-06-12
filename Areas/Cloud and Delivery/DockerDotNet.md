# Docker & .NET
Date: 2025-11-25
Status: 🟢 Current
Tags: #docker #dotnet #containers #devops

## 🎯 TL;DR / Quick Reference

**Definition:** Best practices for containerizing .NET apps using Docker, multi-stage builds, and runtime considerations.

**When to use:**
- Deploying services in containers (Kubernetes, App Services, Docker Swarm).

**Key Takeaways:**
- ✅ **Use multi-stage builds** to keep images small.
- ✅ **Choose appropriate base images** (`mcr.microsoft.com/dotnet/aspnet` for runtime, `sdk` for build).
- ⚡ **Keep secrets out of images**; use environment variables or secret stores.

**Code Snippet (multi-stage Dockerfile):**
```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . ./
RUN dotnet publish -c Release -o /app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet","MyApp.dll"]
```

**Gotchas:**
- ⚠️ **Layer invalidation:** Copy only necessary files to reduce rebuild time.
- ⚠️ **Image size:** Avoid installing unnecessary packages in the runtime image.

---

## 📚 Deep Dive

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

## 🔗 Related Concepts
- [[AzureServicesOverview]]

## 📖 Resources
- Microsoft Docs: containerize .NET apps
- Docker best practices

## 🧪 Practice Exercises
1. Containerize a simple Web API using multi-stage build and push to a registry.
2. Measure image size before/after optimization.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
