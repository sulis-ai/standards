# ServiceSpec Delta Validator

> **Focus:** Validates SERVICE_SPECIFICATION_DELTA.md for enhancement features
> **Checks:** DELTA-01 to DELTA-15
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md
> **Version:** 1.0.0 (2026-01-11)

## Purpose

Ensures SERVICE_SPECIFICATION_DELTA.md is complete, references the correct parent spec version, and follows proper delta patterns. Only runs for `service_enhancement` classification.

## Files to Read

1. `features/{feature}/LIFECYCLE_STATE.json` (for classification and parent info)
2. `features/{feature}/SERVICE_SPECIFICATION_DELTA.md` (primary artifact)
3. `features/services/{parent}/SERVICE_SPECIFICATION.md` (parent spec for version check)
4. `features/services/{parent}/changelog.md` (for version history)

## Applicability

| Classification | Required Artifact | Run Validator? |
|----------------|-------------------|----------------|
| service | SERVICE_SPECIFICATION.md | No - use servicespec-validator |
| servicespec_extension | SERVICE_SPECIFICATION_EXTENSION.md | No - use servicespec-validator |
| **service_enhancement** | **SERVICE_SPECIFICATION_DELTA.md** | **Yes** |
| extension_enhancement | EXTENSION_SPECIFICATION_DELTA.md | Use extension-delta-validator |
| capability_enhancement | CAPABILITY_SPECIFICATION_DELTA.md | Use capability-delta-validator |
| infrastructure | None | No |

## Validation Checks

### Parent Reference (DELTA-01 to DELTA-03)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-01 | Parent spec exists at `features/services/{parent}/SERVICE_SPECIFICATION.md` | BLOCKING |
| DELTA-02 | Parent version in delta matches current canonical version | BLOCKING |
| DELTA-03 | `enhances` field in LIFECYCLE_STATE.json matches delta parent | BLOCKING |

### Structure (DELTA-04 to DELTA-06)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-04 | Header table has Feature, Enhances, Parent Spec, Parent Version | BLOCKING |
| DELTA-05 | Summary section (§D1) with Change Overview table | BLOCKING |
| DELTA-06 | All applicable delta sections present (§D2-§D12) | BLOCKING |

### Operations Delta (DELTA-07 to DELTA-08)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-07 | New operations have permission, path, method defined | BLOCKING |
| DELTA-08 | New operations don't conflict with parent operations | BLOCKING |

### Error Codes (DELTA-09)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-09 | Error codes follow parent naming convention (check prefix) | BLOCKING |

### Events (DELTA-10)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-10 | Events follow CloudEvents format with platform prefix | BLOCKING |

### Permissions (DELTA-11 to DELTA-12)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-11 | New permissions follow parent `{domain}.{entity}:{action}` pattern | BLOCKING |
| DELTA-12 | Permission scope clarifications reference existing permissions | BLOCKING |

### SDK & Observability (DELTA-13 to DELTA-14)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-13 | SDK methods map to delta operations | BLOCKING |
| DELTA-14 | Metrics follow parent naming convention | BLOCKING |

### Completeness (DELTA-15)

| Check ID | Check | Severity |
|----------|-------|----------|
| DELTA-15 | Validation checklist in §D11 is complete | WARNING |

## Validation Process

### Step 1: Check Applicability

```
Read: features/{feature}/LIFECYCLE_STATE.json
If classification != "service_enhancement":
    Return: { status: "SKIP", reason: "Not a service enhancement" }
```

### Step 2: Verify Parent Exists

```
Read: features/services/{parent}/SERVICE_SPECIFICATION.md
If not exists:
    FAIL DELTA-01: Parent spec not found at features/services/{parent}/

Extract version from parent spec header
Store as parent_current_version
```

### Step 3: Verify Version Match

```
Read: features/{feature}/SERVICE_SPECIFICATION_DELTA.md
Extract "Parent Version" from header table
Compare with parent_current_version

If mismatch:
    FAIL DELTA-02: Delta references v{delta_version} but parent is v{parent_version}
    Suggest: Update delta or check if parent was modified
```

### Step 4: Validate Structure

```
Check for required sections:
- §D1 Summary
- §D2 Operations Delta
- §D3 Error Codes Delta
- §D4 Events Delta
- §D5 Permissions Delta
- §D11 Validation Checklist
- §D12 Merge Instructions

Missing sections → FAIL DELTA-06
```

### Step 5: Validate Content

```
For each new operation:
    - Has Method (GET/POST/etc)
    - Has Path
    - Has Permission
    - Not duplicate of parent operation

For each new error code:
    - Follows parent prefix convention

For each new event:
    - Uses CloudEvents format
    - Uses platform.eventTypePrefix
```

## Agent Prompt

```
You are the ServiceSpec Delta Validator - validates enhancement feature delta files.

## Your Task

Validate SERVICE_SPECIFICATION_DELTA.md for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/LIFECYCLE_STATE.json
2. features/{feature_name}/SERVICE_SPECIFICATION_DELTA.md
3. features/services/{parent}/SERVICE_SPECIFICATION.md (extract parent from LIFECYCLE_STATE)
4. features/services/{parent}/changelog.md

## Critical Checks

### DELTA-01: Parent Exists
Read the parent SERVICE_SPECIFICATION.md from features/services/{parent}/
If it doesn't exist, this is a BLOCKING failure.

### DELTA-02: Version Match (CRITICAL)
1. Extract version from parent spec (look for "Version:" in header)
2. Extract "Parent Version" from delta header table
3. If they don't match: BLOCKING failure
   - Include current parent version in error
   - Include delta's referenced version in error
   - Suggest updating delta if parent was modified

### DELTA-03: Enhances Field Match
Compare LIFECYCLE_STATE.json `enhances` with delta's "Enhances" field

## Validation Checklist

- [ ] DELTA-01: Parent spec exists
- [ ] DELTA-02: Parent version matches
- [ ] DELTA-03: Enhances field consistent
- [ ] DELTA-04: Header table complete
- [ ] DELTA-05: Summary section present
- [ ] DELTA-06: Required sections present
- [ ] DELTA-07: Operations have required fields
- [ ] DELTA-08: No operation conflicts
- [ ] DELTA-09: Error code naming
- [ ] DELTA-10: Event format
- [ ] DELTA-11: Permission pattern
- [ ] DELTA-12: Scope clarifications valid
- [ ] DELTA-13: SDK method mapping
- [ ] DELTA-14: Metric naming
- [ ] DELTA-15: Checklist complete

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "servicespec-delta",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "parent": {
    "service": "{parent_service}",
    "path": "features/services/{parent}/SERVICE_SPECIFICATION.md",
    "current_version": "{X.Y.Z}",
    "delta_references_version": "{X.Y.Z}",
    "version_match": true
  },
  "summary": {
    "operations_added": 0,
    "errors_added": 0,
    "events_added": 0,
    "permissions_added": 0
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Read LIFECYCLE_STATE.json FIRST to get parent info
2. Read parent SERVICE_SPECIFICATION.md to get current version
3. Version mismatch is ALWAYS BLOCKING
4. Return ONLY JSON output
```

## Version Drift Detection

When parent spec version doesn't match delta reference:

```json
{
  "check_id": "DELTA-02",
  "status": "FAIL",
  "severity": "BLOCKING",
  "message": "Parent spec version mismatch",
  "details": {
    "parent_current_version": "1.2.0",
    "delta_references_version": "1.1.0",
    "parent_path": "features/services/compute/SERVICE_SPECIFICATION.md"
  },
  "fix": {
    "action": "Update SERVICE_SPECIFICATION_DELTA.md",
    "steps": [
      "1. Review changes in parent spec v1.2.0",
      "2. Update 'Parent Version' to 1.2.0",
      "3. Verify delta doesn't conflict with new parent changes",
      "4. Run validator again"
    ]
  }
}
```

## Why This Validation Matters

1. **Version Drift** - If parent spec changes during enhancement development, delta may conflict
2. **Merge Integrity** - Delta must reference correct version to merge cleanly
3. **Traceability** - Version reference enables audit trail of spec evolution
4. **Conflict Prevention** - Early detection of operation/permission conflicts

---

*ServiceSpec Delta Validator v1.0.0*
