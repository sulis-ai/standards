# Extension Delta Validator

> **Focus:** Validates EXTENSION_SPECIFICATION_DELTA.md for extension enhancement features
> **Checks:** EXTDELTA-01 to EXTDELTA-12
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md
> **Version:** 1.0.0 (2026-01-11)

## Purpose

Ensures EXTENSION_SPECIFICATION_DELTA.md is complete, references the correct parent spec version, and follows proper delta patterns. Only runs for `extension_enhancement` classification.

## Files to Read

1. `features/{feature}/LIFECYCLE_STATE.json` (for classification and parent info)
2. `features/{feature}/EXTENSION_SPECIFICATION_DELTA.md` (primary artifact)
3. `.extensions/{parent}/EXTENSION_SPECIFICATION.md` (parent spec for version check)
4. `.extensions/{parent}/changelog.md` (for version history)

## Applicability

| Classification | Required Artifact | Run Validator? |
|----------------|-------------------|----------------|
| extension | EXTENSION_SPECIFICATION.md | No - use servicespec-validator |
| **extension_enhancement** | **EXTENSION_SPECIFICATION_DELTA.md** | **Yes** |
| service_enhancement | SERVICE_SPECIFICATION_DELTA.md | Use servicespec-delta-validator |
| capability_enhancement | CAPABILITY_SPECIFICATION_DELTA.md | Use capability-delta-validator |

## Validation Checks

### Parent Reference (EXTDELTA-01 to EXTDELTA-03)

| Check ID | Check | Severity |
|----------|-------|----------|
| EXTDELTA-01 | Parent spec exists at `.extensions/{parent}/EXTENSION_SPECIFICATION.md` | BLOCKING |
| EXTDELTA-02 | Parent version in delta matches current canonical version | BLOCKING |
| EXTDELTA-03 | `enhances` field in LIFECYCLE_STATE.json matches delta parent | BLOCKING |

### Structure (EXTDELTA-04 to EXTDELTA-06)

| Check ID | Check | Severity |
|----------|-------|----------|
| EXTDELTA-04 | Header table has Feature, Enhances, Parent Spec, Parent Version | BLOCKING |
| EXTDELTA-05 | Summary section (§D1) with Change Overview table | BLOCKING |
| EXTDELTA-06 | All applicable delta sections present | BLOCKING |

### Schema Extensions (EXTDELTA-07 to EXTDELTA-08)

| Check ID | Check | Severity |
|----------|-------|----------|
| EXTDELTA-07 | New schema fields don't conflict with parent | BLOCKING |
| EXTDELTA-08 | Schema changes are backward compatible | BLOCKING |

### Headers & Errors (EXTDELTA-09 to EXTDELTA-10)

| Check ID | Check | Severity |
|----------|-------|----------|
| EXTDELTA-09 | New headers follow `X-{Extension}-*` convention | BLOCKING |
| EXTDELTA-10 | Error codes follow parent naming convention | BLOCKING |

### Cross-Cutting Validation (EXTDELTA-11 to EXTDELTA-12)

| Check ID | Check | Severity |
|----------|-------|----------|
| EXTDELTA-11 | Changes apply to ALL services (cross-cutting requirement) | BLOCKING |
| EXTDELTA-12 | Validation checklist in delta is complete | WARNING |

## Validation Process

### Step 1: Check Applicability

```
Read: features/{feature}/LIFECYCLE_STATE.json
If classification != "extension_enhancement":
    Return: { status: "SKIP", reason: "Not an extension enhancement" }
```

### Step 2: Verify Parent Exists

```
Read: .extensions/{parent}/EXTENSION_SPECIFICATION.md
If not exists:
    FAIL EXTDELTA-01: Parent spec not found at .extensions/{parent}/

Extract version from parent spec header
Store as parent_current_version
```

### Step 3: Verify Version Match

```
Read: features/{feature}/EXTENSION_SPECIFICATION_DELTA.md
Extract "Parent Version" from header table
Compare with parent_current_version

If mismatch:
    FAIL EXTDELTA-02: Delta references v{delta_version} but parent is v{parent_version}
```

### Step 4: Validate Structure and Content

```
Check for required sections:
- §D1 Summary
- §D2 Schema Extensions Delta
- §D3 Response Headers Delta
- §D4 Error Codes Delta
- §D9 Validation Checklist
- §D10 Merge Instructions
```

## Agent Prompt

```
You are the Extension Delta Validator - validates extension enhancement delta files.

## Your Task

Validate EXTENSION_SPECIFICATION_DELTA.md for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/LIFECYCLE_STATE.json
2. features/{feature_name}/EXTENSION_SPECIFICATION_DELTA.md
3. .extensions/{parent}/EXTENSION_SPECIFICATION.md
4. .extensions/{parent}/changelog.md

## Critical Checks

### EXTDELTA-01: Parent Exists
Read the parent EXTENSION_SPECIFICATION.md from .extensions/{parent}/

### EXTDELTA-02: Version Match (CRITICAL)
1. Extract version from parent spec
2. Extract "Parent Version" from delta header
3. If mismatch: BLOCKING failure

### EXTDELTA-11: Cross-Cutting Validation
Extensions must apply to ALL services. Verify the delta doesn't introduce
service-specific behavior.

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "extension-delta",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "parent": {
    "extension": "{parent_extension}",
    "path": ".extensions/{parent}/EXTENSION_SPECIFICATION.md",
    "current_version": "{X.Y.Z}",
    "delta_references_version": "{X.Y.Z}",
    "version_match": true
  },
  "issues": [...],
  "checks": [...]
}
```
```

---

*Extension Delta Validator v1.0.0*
