# Architecture Principles Validator

> **Purpose:** Validate DESIGN.md against core architecture principles from ARCHITECTURE.md.
> **Check Prefix:** ARCH-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/DESIGN.md` (per scope for multi-scope)
- `features/{feature}/IVS.md` (per scope for multi-scope)
- `features/{feature}/TEST_SCENARIOS.md`
- `features/{feature}/LIFECYCLE_STATE.json`

**Platform References:**
- `architecture/ARCHITECTURE.md` - Core architecture principles (NON-NEGOTIABLE)

---

## Scope Handling

- **Multi-scope features:** Run ARCH-* checks against each `{scope}/DESIGN.md` and `{scope}/IVS.md` independently. Tag findings with scope (e.g., `ARCH-9-01 [backend]: No auth check at handler level`). ARCH-4-01 checks all IVS.md files (root and per-scope).
- **Single-scope features:** Run against root DESIGN.md and IVS.md. No scope tagging needed.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### ARCH-1-* (Security by Design)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-1-01 | Zero-trust approach documented in DESIGN.md security section | WARNING |
| ARCH-1-02 | Input validation at system boundaries described | WARNING |
| ARCH-1-03 | Security-sensitive operations have audit logging plan | WARNING |

### ARCH-2-* (Quality)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-2-01 | Double-loop TDD strategy documented (outer integration, inner unit) | WARNING |

### ARCH-9-* (Authorization-First)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-9-01 | Auth check at handler level before business logic (not buried in service layer) | BLOCKING |
| ARCH-9-02 | Permissions defined before operations (not checked after the fact) | BLOCKING |
| ARCH-9-03 | DAC owner policies auto-created on resource creation | WARNING |

### ARCH-10-* (Cloud Abstraction)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-10-01 | Users have NO direct cloud provider access in design | BLOCKING |
| ARCH-10-02 | Logs, metrics, and status surfaced through platform APIs | BLOCKING |
| ARCH-10-03 | Provider UIs proxied, embedded, or surfaced (not direct links) | WARNING |

### ARCH-PA-* (Ports & Adapters)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-PA-01 | External infrastructure abstracted via protocol interfaces (ports) | BLOCKING |
| ARCH-PA-02 | In-memory adapters available for testing (not mocks) | WARNING |

### ARCH-7-* (Clean Code)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-7-03 | Type hints present in code examples within DESIGN.md | BLOCKING |

### ARCH-ANTI-* (Anti-Patterns)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-ANTI-01 | No direct GCP imports in service layer code examples | BLOCKING |
| ARCH-ANTI-02 | No mocking in test design (use real in-memory adapters) | WARNING |
| ARCH-ANTI-03 | Services don't import other services directly (use dependency injection) | WARNING |

### ARCH-4-* (Completion)

| ID | Check | Severity |
|----|-------|----------|
| ARCH-4-01 | No TODOs, FIXMEs, or deferred items in IVS.md | BLOCKING |

---

## Validation Logic

### ARCH-9-01: Authorization at Handler Level

```
Search DESIGN.md for API endpoint / handler definitions.
FOR EACH endpoint:
    Check if auth check is described as first operation in handler:
      - "authorize", "check_permission", "require_auth", "@authenticated"
    IF auth check is in service layer or missing:
        FAIL "Endpoint '{endpoint}' does not show auth at handler level"
```

### ARCH-9-02: Permissions Before Operations

```
Search DESIGN.md for permission/authorization patterns.
IF permissions are checked reactively (after operation):
    FAIL "Permissions must be defined and checked before operations execute"
```

### ARCH-10-01 / ARCH-10-02: Cloud Abstraction

```
Search DESIGN.md and USER_GUIDE.md for patterns:
  - Direct cloud console URLs (console.cloud.google.com, console.aws.amazon.com)
  - "log in to GCP/AWS/Azure" instructions
  - Direct cloud SDK usage in user-facing flows

IF found:
    FAIL ARCH-10-01

Search for observability design:
IF logs/metrics/status require direct cloud access:
    FAIL ARCH-10-02
```

### ARCH-PA-01: Ports & Adapters Check

```
Search DESIGN.md for external service interactions:
  - Database access
  - Message queue / pub-sub
  - External APIs
  - File storage

FOR EACH interaction:
    IF accessed directly (no interface/port abstraction):
        FAIL "External service '{service}' not abstracted via port interface"
```

### ARCH-ANTI-01: GCP Import Check

```
Search DESIGN.md code examples for:
  - "from google.cloud import"
  - "import google.cloud"
  - "from firebase_admin import"
  in service layer context (not adapter layer)

IF found in service/domain layer:
    FAIL "Direct GCP import in service layer code example"
```

### ARCH-4-01: No Deferrals in IVS

```
FOR EACH IVS.md (root and per-scope):
    Search for patterns:
      - "TODO"
      - "FIXME"
      - "deferred"
      - "out of scope" (in requirement context)
      - "future work" (in requirement context)
    IF found within requirement definitions:
        FAIL "IVS.md contains deferred item: '{match}'"
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "architecture-principles",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 18,
    "checks_passed": 0,
    "checks_failed": 0,
    "checks_skipped": 0,
    "blocking_issues": 0,
    "warning_issues": 0
  },
  "issues": [],
  "checks": []
}
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-24 | Initial architecture principles validator. ARCH-1 security by design, ARCH-2 quality, ARCH-9 authorization-first, ARCH-10 cloud abstraction, ARCH-PA ports and adapters, ARCH-7 clean code, ARCH-ANTI anti-patterns, ARCH-4 completion. 18 checks across 8 principle categories. |
