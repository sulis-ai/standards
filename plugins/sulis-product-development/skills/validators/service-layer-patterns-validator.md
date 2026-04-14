# Service Layer Patterns Validator

> **Focus:** Validates DESIGN.md Section 9.6 Service Layer Implementation Patterns
> **Checks:** IMPL-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures the design documents all required service layer implementation patterns: event publishing, DAC authorization, request context, error handling, authorization decorators, and deployment wiring.

## Files to Read

1. `features/{feature}/DESIGN.md` (Section 9.6)
2. `features/{feature}/TEST_SCENARIOS.md` (for DAC test coverage)

## Validation Checks

### Event Publishing (IMPL-EVT-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-EVT-01 | Section 9.6.1 exists (Event Publishing Pattern) | BLOCKING |
| IMPL-EVT-02 | EventPublisher shown as handler/service dependency | BLOCKING |
| IMPL-EVT-03 | Events emitted AFTER persistence (not before) | BLOCKING |
| IMPL-EVT-04 | Event types use platform-configurable prefix | BLOCKING |
| IMPL-EVT-05 | All state-changing operations emit events | BLOCKING |

### DAC Authorization (IMPL-DAC-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-DAC-01 | Section 9.6.2 exists (DAC Authorization Pattern) | BLOCKING |
| IMPL-DAC-02 | Repository has `list_by_creator()` method defined | BLOCKING |
| IMPL-DAC-03 | List operations show user-scoped vs admin-scoped filtering | BLOCKING |
| IMPL-DAC-04 | Get/Update/Delete show ownership verification pattern | BLOCKING |
| IMPL-DAC-05 | Admin permission (`:admin`) defined for cross-user access | BLOCKING |
| IMPL-DAC-06 | TEST_SCENARIOS.md includes ownership filtering tests | BLOCKING |

### Request Context (IMPL-CTX-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-CTX-01 | Section 9.6.3 exists (Request Context Propagation) | BLOCKING |
| IMPL-CTX-02 | RequestContext dataclass shown with platform_id, user_id | BLOCKING |
| IMPL-CTX-03 | ContextVar used for async safety | BLOCKING |
| IMPL-CTX-04 | Handlers show get_current_context() usage | BLOCKING |
| IMPL-CTX-05 | Correlation ID propagation documented | BLOCKING |

### Error Handling (IMPL-ERR-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-ERR-01 | Section 9.6.4 exists (Error Handling Pattern) | BLOCKING |
| IMPL-ERR-02 | Domain error classes defined with error_code and http_status | BLOCKING |
| IMPL-ERR-03 | Handlers return Result[T] with domain errors | BLOCKING |
| IMPL-ERR-04 | Router maps domain errors to HTTP exceptions | BLOCKING |
| IMPL-ERR-05 | Error response follows standard envelope | BLOCKING |

### Authorization Decorators (IMPL-AUTH-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-AUTH-01 | Section 9.6.5 exists (Authorization Decorators) | BLOCKING |
| IMPL-AUTH-02 | All endpoints show @require_permission decorator | BLOCKING |
| IMPL-AUTH-03 | Permission names match ServiceSpec permissions | BLOCKING |
| IMPL-AUTH-04 | Permission verification flow documented | BLOCKING |

### Deployment Wiring (IMPL-WIRE-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-WIRE-01 | Section 9.6.6 exists (Deployment Wiring) | BLOCKING |
| IMPL-WIRE-02 | Router mounting location identified | BLOCKING |
| IMPL-WIRE-03 | SDK resource class location identified | BLOCKING |
| IMPL-WIRE-04 | Integration test suite location identified | BLOCKING |
| IMPL-WIRE-05 | CI/CD registration requirement documented | BLOCKING |

### Checklist Completeness (IMPL-CHK-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IMPL-CHK-01 | Service Layer Checklist (9.6.7) exists | BLOCKING |
| IMPL-CHK-02 | All EVT-IMPL-*, DAC-IMPL-*, etc. checks listed | BLOCKING |

## Validation Process

### Step 1: Check Section Existence

```
Read: DESIGN.md

Search for sections:
- "9.6" or "Service Layer Implementation Patterns"
- "9.6.1" or "Event Publishing"
- "9.6.2" or "DAC Authorization"
- "9.6.3" or "Request Context"
- "9.6.4" or "Error Handling"
- "9.6.5" or "Authorization Decorators"
- "9.6.6" or "Deployment Wiring"
- "9.6.7" or "Service Layer Checklist"

If section missing → corresponding IMPL-*-01 FAIL
```

### Step 2: Check Pattern Details

```
For each existing section, verify content:

Event Publishing:
- EventPublisher in constructor/dependency
- Events after await repo.save()
- {platform.event_type_prefix} in event types

DAC Authorization:
- list_by_creator() method
- is_admin check for filtering
- Ownership check in get/update/delete
```

### Step 3: Check Test Coverage

```
Read: TEST_SCENARIOS.md

Search for:
- "TS-DAC" or ownership tests
- "ownership" or "creator" filtering tests

If not found → IMPL-DAC-06 FAIL
```

## Agent Prompt

```
You are the Service Layer Patterns Validator - a focused validator that checks ONLY Section 9.6 compliance.

## Your Task

Validate service layer patterns for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/DESIGN.md (focus on Section 9.6)
2. features/{feature_name}/TEST_SCENARIOS.md

## Validation Checklist

### IMPL-EVT-*: Event Publishing (9.6.1)
- [ ] IMPL-EVT-01: Section 9.6.1 exists
- [ ] IMPL-EVT-02: EventPublisher as dependency
- [ ] IMPL-EVT-03: Events after persistence
- [ ] IMPL-EVT-04: Platform-configurable prefix
- [ ] IMPL-EVT-05: All state changes emit events

### IMPL-DAC-*: DAC Authorization (9.6.2)
- [ ] IMPL-DAC-01: Section 9.6.2 exists
- [ ] IMPL-DAC-02: list_by_creator() method
- [ ] IMPL-DAC-03: User vs admin filtering
- [ ] IMPL-DAC-04: Ownership verification
- [ ] IMPL-DAC-05: :admin permission defined
- [ ] IMPL-DAC-06: DAC tests in TEST_SCENARIOS.md

### IMPL-CTX-*: Request Context (9.6.3)
- [ ] IMPL-CTX-01: Section 9.6.3 exists
- [ ] IMPL-CTX-02: RequestContext dataclass
- [ ] IMPL-CTX-03: ContextVar for async
- [ ] IMPL-CTX-04: get_current_context() usage
- [ ] IMPL-CTX-05: Correlation ID propagation

### IMPL-ERR-*: Error Handling (9.6.4)
- [ ] IMPL-ERR-01: Section 9.6.4 exists
- [ ] IMPL-ERR-02: Domain errors with code/status
- [ ] IMPL-ERR-03: Result[T] return pattern
- [ ] IMPL-ERR-04: Router error mapping
- [ ] IMPL-ERR-05: Standard error envelope

### IMPL-AUTH-*: Authorization Decorators (9.6.5)
- [ ] IMPL-AUTH-01: Section 9.6.5 exists
- [ ] IMPL-AUTH-02: @require_permission on endpoints
- [ ] IMPL-AUTH-03: Permission names match spec
- [ ] IMPL-AUTH-04: Verification flow documented

### IMPL-WIRE-*: Deployment Wiring (9.6.6)
- [ ] IMPL-WIRE-01: Section 9.6.6 exists
- [ ] IMPL-WIRE-02: Router mount location
- [ ] IMPL-WIRE-03: SDK class location
- [ ] IMPL-WIRE-04: Integration test location
- [ ] IMPL-WIRE-05: CI/CD registration

### IMPL-CHK-*: Checklist (9.6.7)
- [ ] IMPL-CHK-01: Checklist exists
- [ ] IMPL-CHK-02: All check IDs listed

## Section Detection Patterns

```markdown
## 9.6 Service Layer Implementation Patterns
### 9.6.1 Event Publishing Pattern
### 9.6.2 DAC Authorization Pattern
### 9.6.3 Request Context Propagation
### 9.6.4 Error Handling Pattern
### 9.6.5 Authorization Decorators
### 9.6.6 Deployment Wiring
### 9.6.7 Service Layer Checklist
```

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "service-layer-patterns",
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

1. Focus ONLY on Section 9.6 content
2. Check ONLY IMPL-* checks
3. Return ONLY JSON output
4. If section exists but is empty/placeholder, mark as FAIL
5. Check TEST_SCENARIOS.md for DAC test coverage
```
