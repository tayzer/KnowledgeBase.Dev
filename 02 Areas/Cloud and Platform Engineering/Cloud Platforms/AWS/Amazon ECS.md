---
date: "2026-09-25"
status: Needs Review
tags: [aws, ecs, containers, orchestration]
---

# Amazon ECS

## Quick Reference

**What it is:** Amazon Elastic Container Service (ECS) is AWS's managed container orchestration service for deploying, running, and scaling containerized applications.

**Use when:** You need ECS to schedule and manage containerized services or one-off tasks. Choose compute capacity separately: AWS Fargate, self-managed Amazon EC2 instances, Amazon ECS Managed Instances, or external instances, subject to workload requirements.

**Key points:**
- A **task definition** describes containers, images, CPU and memory, networking, roles, logging, and volumes. A **task** is a running instance of a task definition. A **cluster** groups the capacity and workloads.
- An ECS **service** maintains a desired number of tasks and supports deployments. Run a standalone task for work that should finish rather than remain continuously available.
- Choose a compatible capacity provider strategy or launch type. AWS recommends capacity providers for launching tasks and services; Fargate avoids managing EC2 hosts, while EC2-based options offer different host-level control and resource tradeoffs.
- For Fargate, `awsvpc` networking assigns each task a network interface. Configure subnets, security groups, and a route for required image pulls and outbound calls.
- Keep the **task role** (permissions for application code) separate from the **task execution role** (permissions ECS needs for actions such as pulling images and sending logs). Store secrets in AWS Secrets Manager or Systems Manager Parameter Store rather than plaintext task definitions.

**Limit:** ECS manages orchestration, not application correctness. You still need suitable health checks, deployment settings, scaling policy, observability, network design, and cost review. Fargate also restricts some task definition options available with EC2-hosted tasks.

## Choosing the ECS Building Blocks

1. Build and publish a container image, then register a versioned task definition.
2. Choose a cluster and compute capacity suited to the application's resource and operational needs.
3. For a long-running API or worker, create a service with a desired task count; use a standalone task for finite work.
4. Configure network access, IAM roles, logs, health checks, and secrets. Add a load balancer when the service needs incoming traffic; use service auto scaling when demand varies.
5. During deployment, check task and service events, container logs, health, and running task count. A registered task definition alone does not deploy an application.

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/_Index|Cloud Platforms]] - provider context.
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Containers and Orchestration/_Index|Containers and Orchestration]] - broader orchestration concepts.
- [[Docker and .NET|Docker and .NET]] - container image development for .NET.
- [[Serverless Architecture|Serverless Architecture]] - related compute model for Fargate.

## Sources

AWS documentation, accessed 2026-09-25:
- [What is Amazon ECS?](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/)
- [Launch types and capacity providers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/capacity-launch-type-comparison.html)
- [Fargate task definition differences](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-tasks-services.html)
- [Best practices for IAM roles](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/security-iam-roles.html)
- [Pass sensitive data to a container](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html)
- [Service auto scaling](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-auto-scaling.html)

## Review Schedule

- Review when AWS changes ECS capacity, task definition, networking, or deployment guidance, or before using this note for a design decision.
