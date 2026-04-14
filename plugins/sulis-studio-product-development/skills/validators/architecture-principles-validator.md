# Architecture Principles Validator

> **Focus:** Validates compliance with ARCHITECTURE.md core principles
> **Checks:** ARCH-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures the design follows the 8+ non-negotiable architecture principles including security, handler-centric design, ports & adapters, and cloud abstraction.

## Files to Read

1. `architecture/ARCHITECTURE.md` (reference)
2. `features/{feature}/DESIGN.md`
3. `features/{feature}/IVS.md`
4. `features/{feature}/USER_GUIDE.md`

## Validation Checks

### Security by Design (ARCH-SEC-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-SEC-01 | Zero-trust security model, input validation at boundaries | BLOCKING |
| ARCH-SEC-02 | Authorization checks at handler level | BLOCKING |
| ARCH-SEC-03 | DAC owner policies created on resource creation | BLOCKING |

### Quality (ARCH-QUAL-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-QUAL-01 | TDD approach specified in test scenarios | BLOCKING |
| ARCH-QUAL-02 | No WIP indicators (TODO without tracking, partial implementations) | BLOCKING |

### Dogfooding (ARCH-DOG-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-DOG-01 | Uses existing platform components where available | BLOCKING |

### Handler-Centric Design (ARCH-SOLID-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-SOLID-01 | Handlers are single source of truth for business logic | BLOCKING |
| ARCH-SOLID-02 | Same handler used for HTTP, Tools, SDK | BLOCKING |

### Ports & Adapters (ARCH-PORT-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-PORT-01 | External infrastructure abstracted via protocols | BLOCKING |
| ARCH-PORT-02 | In-memory adapter available for testing | BLOCKING |

### Result Pattern (ARCH-RES-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-RES-01 | Handlers return Result[T] pattern, not exceptions | BLOCKING |

### Document Lifecycle (ARCH-DOC-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-DOC-01 | Soft delete pattern used for entities | BLOCKING |

### Cloud Abstraction (ARCH-CLOUD-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ARCH-CLOUD-01 | DESIGN.md answers: "What cloud resources does this create?" | BLOCKING |
| ARCH-CLOUD-02 | DESIGN.md answers: "How will users access logs/metrics/status?" | BLOCKING |
| ARCH-CLOUD-03 | USER_GUIDE.md does NOT reference cloud consoles (GCP/AWS/Azure) | BLOCKING |
| ARCH-CLOUD-04 | USER_GUIDE.md does NOT tell users to use gcloud/aws/az CLI | BLOCKING |
| ARCH-CLOUD-05 | All cloud resource status surfaced through Sulis Platform APIs | BLOCKING |
| ARCH-CLOUD-06 | Log retrieval endpoints defined if feature creates log-producing resources | BLOCKING |
| ARCH-CLOUD-07 | Provider-specific UIs (Spark UI, etc.) addressed - proxied or data surfaced | WARNING |

## Validation Process

### Step 1: Load Reference

```
Read: architecture/ARCHITECTURE.md
Extract: Core principles and patterns
```

### Step 2: Check Handler Design

```
Read: DESIGN.md

Verify:
- Handler methods defined for all operations
- No business logic in router/HTTP layer
- Result[T] return types shown
```

### Step 3: Check Ports & Adapters

```
Read: DESIGN.md

Verify:
- Protocol/interface definitions for external services
- At least Memory adapter mentioned for testing
- Infrastructure abstracted (no direct GCP calls in handlers)
```

### Step 4: Check Cloud Abstraction (Critical)

```
Read: USER_GUIDE.md

Search for violations:
- "GCP Console" or "Google Cloud Console"
- "gcloud" commands
- "AWS Console" or "aws" CLI
- Direct cloud URLs

Read: DESIGN.md
Verify:
- Cloud resources documented
- User access to logs/metrics defined via Sulis Platform API
```

## Agent Prompt

```
You are the Architecture Principles Validator - a focused validator that checks ONLY architecture principle compliance.

## Your Task

Validate architecture principles for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. architecture/ARCHITECTURE.md (reference - read first)
2. features/{feature_name}/DESIGN.md
3. features/{feature_name}/IVS.md
4. features/{feature_name}/USER_GUIDE.md

## Validation Checklist

### ARCH-SEC-*: Security by Design
- [ ] ARCH-SEC-01: Zero-trust, input validation at boundaries
- [ ] ARCH-SEC-02: Authorization checks at handler level
- [ ] ARCH-SEC-03: DAC owner policies on resource creation

### ARCH-QUAL-*: Quality
- [ ] ARCH-QUAL-01: TDD approach in test scenarios
- [ ] ARCH-QUAL-02: No WIP indicators (untracked TODOs)

### ARCH-DOG-*: Dogfooding
- [ ] ARCH-DOG-01: Uses existing platform components

### ARCH-SOLID-*: Handler-Centric
- [ ] ARCH-SOLID-01: Handlers are single source of truth
- [ ] ARCH-SOLID-02: Same handler for HTTP/Tools/SDK

### ARCH-PORT-*: Ports & Adapters
- [ ] ARCH-PORT-01: External infra abstracted via protocols
- [ ] ARCH-PORT-02: In-memory adapter for testing

### ARCH-RES-*: Result Pattern
- [ ] ARCH-RES-01: Handlers return Result[T]

### ARCH-DOC-*: Document Lifecycle
- [ ] ARCH-DOC-01: Soft delete pattern used

### ARCH-CLOUD-*: Cloud Abstraction (CRITICAL)
- [ ] ARCH-CLOUD-01: Cloud resources documented
- [ ] ARCH-CLOUD-02: User access to logs/metrics defined
- [ ] ARCH-CLOUD-03: USER_GUIDE has NO cloud console refs
- [ ] ARCH-CLOUD-04: USER_GUIDE has NO gcloud/aws/az CLI
- [ ] ARCH-CLOUD-05: Status surfaced via Sulis Platform APIs
- [ ] ARCH-CLOUD-06: Log endpoints if log-producing resources
- [ ] ARCH-CLOUD-07: Provider UIs proxied or data surfaced

## Cloud Console Violation Patterns

Search USER_GUIDE.md for:
- `console.cloud.google.com`
- `GCP Console`
- `Google Cloud Console`
- `gcloud `
- `aws `
- `az ` (Azure CLI)
- `*.dataproc.googleusercontent.com`
- `*.run.app` (direct Cloud Run URLs)
- Any instruction to "go to" or "open" a cloud provider interface

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "architecture-principles",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {...},
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Read ARCHITECTURE.md FIRST to understand principles
2. Check ONLY ARCH-* checks
3. Pay special attention to ARCH-CLOUD-* checks
4. Return ONLY JSON output
5. Be thorough on cloud abstraction - this is a common violation
```
