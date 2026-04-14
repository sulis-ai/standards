# Capability Delta Validator

> **Focus:** Validates CAPABILITY_SPECIFICATION_DELTA.md for capability enhancement features
> **Checks:** CAPDELTA-01 to CAPDELTA-14
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md
> **Version:** 1.0.0 (2026-01-11)

## Purpose

Ensures CAPABILITY_SPECIFICATION_DELTA.md is complete, references the correct parent spec version, and follows proper delta patterns. Only runs for `capability_enhancement` classification.

## Files to Read

1. `features/{feature}/LIFECYCLE_STATE.json` (for classification and parent info)
2. `features/{feature}/CAPABILITY_SPECIFICATION_DELTA.md` (primary artifact)
3. `.capabilities/{parent}/CAPABILITY_SPECIFICATION.md` (parent spec for version check)
4. `.capabilities/{parent}/changelog.md` (for version history)

## Applicability

| Classification | Required Artifact | Run Validator? |
|----------------|-------------------|----------------|
| capability | CAPABILITY_SPECIFICATION.md | No - dedicated validator |
| **capability_enhancement** | **CAPABILITY_SPECIFICATION_DELTA.md** | **Yes** |
| service_enhancement | SERVICE_SPECIFICATION_DELTA.md | Use servicespec-delta-validator |
| extension_enhancement | EXTENSION_SPECIFICATION_DELTA.md | Use extension-delta-validator |

## Validation Checks

### Parent Reference (CAPDELTA-01 to CAPDELTA-03)

| Check ID | Check | Severity |
|----------|-------|----------|
| CAPDELTA-01 | Parent spec exists at `.capabilities/{parent}/CAPABILITY_SPECIFICATION.md` | BLOCKING |
| CAPDELTA-02 | Parent version in delta matches current canonical version | BLOCKING |
| CAPDELTA-03 | `enhances` field in LIFECYCLE_STATE.json matches delta parent | BLOCKING |

### Structure (CAPDELTA-04 to CAPDELTA-06)

| Check ID | Check | Severity |
|----------|-------|----------|
| CAPDELTA-04 | Header table has Feature, Enhances, Parent Spec, Parent Version | BLOCKING |
| CAPDELTA-05 | Summary section (§D1) with Change Overview table | BLOCKING |
| CAPDELTA-06 | All applicable delta sections present | BLOCKING |

### Contract Delta (CAPDELTA-07 to CAPDELTA-09)

| Check ID | Check | Severity |
|----------|-------|----------|
| CAPDELTA-07 | New protocol methods don't break existing implementations | BLOCKING |
| CAPDELTA-08 | New types are backward compatible | BLOCKING |
| CAPDELTA-09 | Required behaviors don't conflict with parent | BLOCKING |

### Testing & Migration (CAPDELTA-10 to CAPDELTA-12)

| Check ID | Check | Severity |
|----------|-------|----------|
| CAPDELTA-10 | Mock implementations updated for new methods | WARNING |
| CAPDELTA-11 | Test scenarios cover new functionality | WARNING |
| CAPDELTA-12 | Migration guide provided if breaking changes | BLOCKING (if breaking) |

### Completeness (CAPDELTA-13 to CAPDELTA-14)

| Check ID | Check | Severity |
|----------|-------|----------|
| CAPDELTA-13 | Observability delta includes metrics for new methods | WARNING |
| CAPDELTA-14 | Validation checklist in delta is complete | WARNING |

## Validation Process

### Step 1: Check Applicability

```
Read: features/{feature}/LIFECYCLE_STATE.json
If classification != "capability_enhancement":
    Return: { status: "SKIP", reason: "Not a capability enhancement" }
```

### Step 2: Verify Parent Exists

```
Read: .capabilities/{parent}/CAPABILITY_SPECIFICATION.md
If not exists:
    FAIL CAPDELTA-01: Parent spec not found at .capabilities/{parent}/

Extract version from parent spec header
Store as parent_current_version
```

### Step 3: Verify Version Match

```
Read: features/{feature}/CAPABILITY_SPECIFICATION_DELTA.md
Extract "Parent Version" from header table
Compare with parent_current_version

If mismatch:
    FAIL CAPDELTA-02: Delta references v{delta_version} but parent is v{parent_version}
```

### Step 4: Validate Structure and Content

```
Check for required sections:
- §D1 Summary
- §D2 Contract Delta
- §D3 Type Definitions Delta
- §D7 Testing Pattern Delta
- §D9 Migration Guide (if breaking changes)
- §D10 Validation Checklist
- §D11 Merge Instructions
```

### Step 5: Check Backward Compatibility

```
For each new protocol method:
    - Verify default implementation possible
    - Check existing implementations won't break

For each new type:
    - Verify optional fields or defaults
    - Check no required field removals
```

## Agent Prompt

```
You are the Capability Delta Validator - validates capability enhancement delta files.

## Your Task

Validate CAPABILITY_SPECIFICATION_DELTA.md for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/LIFECYCLE_STATE.json
2. features/{feature_name}/CAPABILITY_SPECIFICATION_DELTA.md
3. .capabilities/{parent}/CAPABILITY_SPECIFICATION.md
4. .capabilities/{parent}/changelog.md

## Critical Checks

### CAPDELTA-01: Parent Exists
Read the parent CAPABILITY_SPECIFICATION.md from .capabilities/{parent}/

### CAPDELTA-02: Version Match (CRITICAL)
1. Extract version from parent spec
2. Extract "Parent Version" from delta header
3. If mismatch: BLOCKING failure

### CAPDELTA-07: Backward Compatibility
Capabilities are internal patterns used by all services. Breaking changes
require explicit migration guides and version bumps.

Check:
- New methods have default implementations or are optional
- Existing method signatures unchanged
- Types extended, not modified incompatibly

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "capability-delta",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "parent": {
    "capability": "{parent_capability}",
    "path": ".capabilities/{parent}/CAPABILITY_SPECIFICATION.md",
    "current_version": "{X.Y.Z}",
    "delta_references_version": "{X.Y.Z}",
    "version_match": true
  },
  "backward_compatible": true,
  "issues": [...],
  "checks": [...]
}
```
```

## Why Capability Validation Matters

Capabilities are **internal implementation patterns** used across all services:

1. **Breaking changes cascade** - A capability change affects every service using it
2. **Migration complexity** - Existing code must be updated if contracts change
3. **Testing impact** - Mock implementations must be updated
4. **Documentation debt** - Outdated capability specs confuse developers

The validator ensures capability evolution is safe, documented, and traceable.

---

*Capability Delta Validator v1.0.0*
