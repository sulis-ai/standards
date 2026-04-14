# Service Layer Patterns Validator

> **Purpose:** Validate DESIGN.md Section 9.6 Service Layer Implementation Patterns.
> **Check Prefix:** IMPL-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/{scope}/DESIGN.md` - Per-scope technical design (backend scope only)
- `features/{feature}/DESIGN.md` - Root technical design (single-scope fallback)
- `features/{feature}/SERVICE_SPECIFICATION.md` - Service specification (cross-reference)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

**Reference:**
- `methodology/delivery/product/outcomes/solution-design/templates/DESIGN_TEMPLATE.md` Section 9.6

---

## Classification

**Applies to:** `service`, `service_extension`, `service_enhancement`, `extension` classifications.

**Skip for:** `infrastructure`, `bug_fix` classifications. Emit skip notice and PASS.

---

## Scope Handling

- **Multi-scope features:** Run all IMPL-* checks against `backend/DESIGN.md` only. Section 9.6 is a backend concern. Tag findings with scope (e.g., `IMPL-EVT-01 [backend]`). Skip non-backend scopes.
- **Single-scope features:** Run against root `DESIGN.md`.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### IMPL-SECTION-* (Section Presence)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-SECTION-01 | Section 9.6 "Service Layer Implementation Patterns" present in DESIGN.md | BLOCKING |

### IMPL-EVT-* (Event Publishing)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-EVT-01 | Event publishing pattern documented with EventPublisher injection | BLOCKING |
| IMPL-EVT-02 | Events emitted after successful persistence (not before) | BLOCKING |
| IMPL-EVT-03 | Event types use platform-configurable prefix (e.g., `{platform_id}.{service}.{event}`) | BLOCKING |

### IMPL-DAC-* (Data Access Control)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-DAC-01 | DAC authorization pattern documented with `list_by_creator()` or equivalent | BLOCKING |
| IMPL-DAC-02 | List operations filter by owner unless admin role | BLOCKING |
| IMPL-DAC-03 | Get/Update/Delete operations verify ownership before executing | BLOCKING |

### IMPL-CTX-* (Request Context)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-CTX-01 | RequestContext dataclass defined with required fields | BLOCKING |
| IMPL-CTX-02 | Correlation ID propagated through service layer | BLOCKING |

### IMPL-ERR-* (Error Handling)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-ERR-01 | Domain error classes defined (e.g., NotFoundError, ValidationError) | BLOCKING |
| IMPL-ERR-02 | Standard error response envelope documented | BLOCKING |

### IMPL-AUTH-* (Authorization)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-AUTH-01 | All endpoints have `@require_permission` or equivalent decorator | BLOCKING |
| IMPL-AUTH-02 | Permission names match SERVICE_SPECIFICATION.md permissions | BLOCKING |

### IMPL-WIRE-* (Wiring & Integration)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-WIRE-01 | Router mounting pattern documented | WARNING |
| IMPL-WIRE-02 | SDK resource class documented | WARNING |
| IMPL-WIRE-03 | Integration test suite referenced | WARNING |

### IMPL-CHECKLIST-* (Completeness)

| ID | Check | Severity |
|----|-------|----------|
| IMPL-CHECKLIST-01 | Section 9.6.7 "Service Layer Checklist" present with 25 items | BLOCKING |

---

## Validation Logic

### Classification Gate

```
IF classification NOT IN [service, service_extension, service_enhancement, extension]:
    SKIP all IMPL-* checks
    RETURN PASS with skip notice
```

### Section 9.6 Detection

```
Search DESIGN.md for heading matching: ^## 9\.6[\.\s]
OR: ^### 9\.6[\.\s]
Must find substantive content beyond placeholder text.
```

### Event Pattern Verification (IMPL-EVT-*)

```
Search Section 9.6 for:
  - "EventPublisher" OR "event_publisher" (IMPL-EVT-01)
  - "after.*persist" OR "post-commit" OR "after successful" (IMPL-EVT-02)
  - Platform prefix pattern: "{platform" OR "configurable prefix" (IMPL-EVT-03)
```

### DAC Pattern Verification (IMPL-DAC-*)

```
Search Section 9.6 for:
  - "list_by_creator" OR "list_by_owner" OR "creator_id" (IMPL-DAC-01)
  - "filter.*owner" OR "unless admin" (IMPL-DAC-02)
  - "verify.*ownership" OR "check.*owner" (IMPL-DAC-03)
```

### Permission Cross-Reference (IMPL-AUTH-02)

```
IF SERVICE_SPECIFICATION.md exists:
    Extract permission names from SERVICE_SPECIFICATION.md
    Verify DESIGN.md Section 9.6 references matching permission names
ELSE:
    SKIP IMPL-AUTH-02 with note "No SERVICE_SPECIFICATION.md to cross-reference"
```

### Checklist Verification (IMPL-CHECKLIST-01)

```
Search Section 9.6 for subsection matching: 9\.6\.7.*[Cc]hecklist
Count checklist items (lines matching: ^- \[[ x]\] OR numbered list items)
Verify count >= 25
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "service-layer-patterns",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 17,
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
| 1.0.0 | 2026-02-24 | Initial service layer patterns validator. IMPL-SECTION-01, IMPL-EVT-01 to IMPL-EVT-03, IMPL-DAC-01 to IMPL-DAC-03, IMPL-CTX-01 to IMPL-CTX-02, IMPL-ERR-01 to IMPL-ERR-02, IMPL-AUTH-01 to IMPL-AUTH-02, IMPL-WIRE-01 to IMPL-WIRE-03, IMPL-CHECKLIST-01. Backend scope only. Classification-gated for service/extension types. |
