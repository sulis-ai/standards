# ServiceSpec Validator

> **Purpose:** Validate SERVICE_SPECIFICATION.md for service/extension classifications.
> **Check Prefix:** SPEC-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/SERVICE_SPECIFICATION.md` - Service specification (primary target)
- `features/{feature}/EXTENSION_SPECIFICATION.md` - Extension specification (alternative for `extension` classification)
- `features/{feature}/DESIGN.md` - Technical design (cross-reference, single-scope)
- `features/{feature}/{scope}/DESIGN.md` - Technical design (cross-reference, multi-scope)
- `features/{feature}/IVS.md` - Implementation verification spec (cross-reference)
- `features/{feature}/{scope}/IVS.md` - Per-scope IVS (cross-reference, multi-scope)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

---

## Classification

**Applies to:** `service`, `extension` classifications only.

**Skip for:** `service_extension`, `service_enhancement`, `infrastructure`, `bug_fix`, `capability` classifications. Emit skip notice and PASS.

---

## Scope Handling

- **Multi-scope and single-scope features:** SERVICE_SPECIFICATION.md is always at the feature root. It is a cross-cutting artifact that defines the service contract.
- **No per-scope variants.** All SPEC-* checks apply to the single root file.
- **DESIGN.md cross-references:** For multi-scope features, read `backend/DESIGN.md` for entity and API contract extraction. For single-scope, read root `DESIGN.md`.

---

## Validation Checklist

### SPEC-* (Core Structure)

| ID | Check | Severity |
|----|-------|----------|
| SPEC-01 | SERVICE_SPECIFICATION.md (or EXTENSION_SPECIFICATION.md for `extension`) exists | BLOCKING |
| SPEC-02 | All entities from DESIGN.md represented in specification | BLOCKING |
| SPEC-03 | All operations from DESIGN.md API contract represented in specification | BLOCKING |
| SPEC-04 | Permissions defined for each operation | BLOCKING |
| SPEC-05 | Events defined for state-changing operations | BLOCKING |
| SPEC-06 | Entity relationships documented | BLOCKING |

### SPEC-* (Quality)

| ID | Check | Severity |
|----|-------|----------|
| SPEC-07 | Lifecycle states defined for entities with status fields | WARNING |
| SPEC-08 | Error catalog matches DESIGN.md error types | WARNING |
| SPEC-09 | Navigation (HATEOAS) links defined | WARNING |
| SPEC-10 | Version field present | WARNING |

---

## Validation Logic

### Classification Gate

```
IF classification NOT IN [service, extension]:
    SKIP all SPEC-* checks
    RETURN PASS with skip notice
```

### SPEC-01: Existence Check

```
IF classification == "service":
    CHECK features/{feature}/SERVICE_SPECIFICATION.md exists
ELIF classification == "extension":
    CHECK features/{feature}/EXTENSION_SPECIFICATION.md exists
    OR CHECK features/{feature}/SERVICE_SPECIFICATION.md exists
```

### SPEC-02: Entity Coverage

```
Extract entity names from DESIGN.md:
  - Section 8 (Data Model) entity definitions
  - Class/model names in code blocks
  - Table definitions

Extract entity names from SERVICE_SPECIFICATION.md:
  - Entity/Resource sections
  - Schema definitions

FOR EACH entity in DESIGN.md:
    IF entity NOT found in SERVICE_SPECIFICATION.md:
        FAIL SPEC-02 with "Entity '{entity}' in DESIGN.md not represented in specification"
```

### SPEC-03: Operation Coverage

```
Extract operations from DESIGN.md:
  - Section 9 (API Design) endpoints
  - HTTP method + path combinations
  - CRUD operations listed

Extract operations from SERVICE_SPECIFICATION.md:
  - Operation sections
  - Endpoint definitions

FOR EACH operation in DESIGN.md:
    IF operation NOT found in SERVICE_SPECIFICATION.md:
        FAIL SPEC-03 with "Operation '{operation}' in DESIGN.md not represented in specification"
```

### SPEC-04: Permission Verification

```
FOR EACH operation in SERVICE_SPECIFICATION.md:
    Search for "permission" or "require" near operation definition
    IF no permission found:
        FAIL SPEC-04 with "Operation '{operation}' has no permission defined"
```

### SPEC-05: Event Verification

```
Extract state-changing operations (POST, PUT, PATCH, DELETE) from SERVICE_SPECIFICATION.md

FOR EACH state-changing operation:
    Search for associated event definition
    IF no event found:
        FAIL SPEC-05 with "State-changing operation '{operation}' has no event defined"
```

### SPEC-06: Relationship Verification

```
IF specification contains 2+ entities:
    Search for "relationship" or "references" or foreign key patterns
    IF no relationships documented:
        FAIL SPEC-06 with "Multiple entities but no relationships documented"
```

### SPEC-07: Lifecycle State Verification

```
FOR EACH entity in specification:
    IF entity has a "status" or "state" field:
        Search for lifecycle state definitions (enum values, state diagram)
        WARN if absent
```

### SPEC-08: Error Catalog Cross-Reference

```
Extract error types from DESIGN.md (error classes, HTTP status codes, error codes)
Extract error catalog from SERVICE_SPECIFICATION.md

FOR EACH error type in DESIGN.md:
    IF error NOT found in SERVICE_SPECIFICATION.md error catalog:
        WARN with "Error type '{error}' in DESIGN.md not in specification error catalog"
```

### SPEC-10: Version Check

```
Search SERVICE_SPECIFICATION.md header area (first 20 lines) for:
  - "Version:" followed by semver pattern (\d+\.\d+\.\d+)
WARN if absent
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "servicespec",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 10,
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
| 1.0.0 | 2026-02-24 | Initial ServiceSpec validator. SPEC-01 to SPEC-10. Entity and operation coverage cross-referencing with DESIGN.md. Permission and event verification. Classification-gated for service/extension only. Supports EXTENSION_SPECIFICATION.md alternative. |
