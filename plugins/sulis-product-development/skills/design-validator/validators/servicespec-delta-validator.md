# Service Specification Delta Validator

> **Purpose:** Validate SERVICE_SPECIFICATION_DELTA.md for service_enhancement classifications.
> **Check Prefix:** DELTA-*

## Files to Read

**Feature Directory:**
- `features/{feature}/SERVICE_SPECIFICATION_DELTA.md` - Delta specification under review
- `features/{feature}/DESIGN.md` - Technical design (for cross-referencing operations and entities)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

**Referenced (not validated):**
- The existing `SERVICE_SPECIFICATION.md` referenced by the delta (for version verification)

---

## Classification Gate

**This validator applies to `service_enhancement` classification ONLY.**

```
IF classification != "service_enhancement":
    SKIP all DELTA-* checks
    RETURN status: "SKIPPED", reason: "Not a service_enhancement classification"
```

---

## Scope Handling

- **Multi-scope features:** Run all DELTA-* checks against each `{scope}/SERVICE_SPECIFICATION_DELTA.md` independently. Tag findings with scope (e.g., `DELTA-03 [backend]: New operation missing contract`).
- **Single-scope features:** Run against root `SERVICE_SPECIFICATION_DELTA.md`. No scope tagging needed.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### DELTA-* (Service Specification Delta)

| ID | Check | When | Severity |
|----|-------|------|----------|
| DELTA-01 | SERVICE_SPECIFICATION_DELTA.md exists | Always | BLOCKING |
| DELTA-02 | References existing SERVICE_SPECIFICATION.md version | Always | BLOCKING |
| DELTA-03 | New operations documented with full contract | New operations added | BLOCKING |
| DELTA-04 | Modified operations show before/after | Operations modified | BLOCKING |
| DELTA-05 | New permissions defined for new operations | New operations added | BLOCKING |
| DELTA-06 | New events defined for new state-changing operations | New state-changing operations | BLOCKING |
| DELTA-07 | Entity modifications documented | Entities modified | WARNING |
| DELTA-08 | Backward compatibility notes present | Always | BLOCKING |
| DELTA-09 | Migration path documented for breaking changes | Breaking changes present | BLOCKING |
| DELTA-10 | Version bump type specified (major/minor/patch) | Always | WARNING |

---

## Validation Logic

### DELTA-01: File Exists

**Severity:** BLOCKING
**Mechanism:** Verify `SERVICE_SPECIFICATION_DELTA.md` exists in the expected location (root or scope directory).
**Failure:** "SERVICE_SPECIFICATION_DELTA.md not found. Required for service_enhancement classification."

### DELTA-02: References Existing Version

**Severity:** BLOCKING
**Mechanism:** Search SERVICE_SPECIFICATION_DELTA.md for a reference to the base SERVICE_SPECIFICATION.md version (e.g., `Base Version: X.Y.Z` or `Extends: SERVICE_SPECIFICATION.md vX.Y.Z`). Verify the referenced file exists.
**Failure:** "SERVICE_SPECIFICATION_DELTA.md does not reference a base SERVICE_SPECIFICATION.md version."

### DELTA-03: New Operations Have Full Contract

**Severity:** BLOCKING
**Mechanism:** For each new operation listed in the delta, verify the documentation includes: operation name, input parameters with types, output schema, error responses, and authorization requirements.
**Failure:** "New operation '{name}' missing full contract (requires: input, output, errors, authorization)."

### DELTA-04: Modified Operations Show Before/After

**Severity:** BLOCKING
**Mechanism:** For each modified operation, verify both the current behavior and the new behavior are documented, making the change explicit.
**Failure:** "Modified operation '{name}' missing before/after comparison."

### DELTA-05: New Permissions Defined

**Severity:** BLOCKING
**Mechanism:** For each new operation in DELTA-03, verify corresponding permission definitions exist (permission name, scope, and which roles receive it).
**Failure:** "New operation '{name}' has no corresponding permission definition."

### DELTA-06: New Events Defined

**Severity:** BLOCKING
**Mechanism:** For each new state-changing operation, verify a corresponding domain event is defined (event name, payload schema, trigger condition).
**Failure:** "State-changing operation '{name}' has no corresponding event definition."

### DELTA-07: Entity Modifications Documented

**Severity:** WARNING
**Mechanism:** If DESIGN.md references entity changes (new fields, modified schemas), verify SERVICE_SPECIFICATION_DELTA.md documents these entity modifications.
**Failure:** "DESIGN.md references entity modifications not documented in SERVICE_SPECIFICATION_DELTA.md."

### DELTA-08: Backward Compatibility Notes

**Severity:** BLOCKING
**Mechanism:** Search for a backward compatibility section (heading matching "backward compatib" case-insensitive). Verify it contains substantive content (not placeholder text, at least 2 non-blank lines).
**Failure:** "No backward compatibility notes found in SERVICE_SPECIFICATION_DELTA.md."

### DELTA-09: Migration Path for Breaking Changes

**Severity:** BLOCKING (only if breaking changes present)
**Mechanism:**
1. Detect breaking changes: removed operations, changed required fields, modified response schemas, permission changes.
2. If breaking changes detected, verify a migration section exists documenting the upgrade path.
3. If no breaking changes, this check is SKIPPED.
**Failure:** "Breaking changes detected but no migration path documented."

### DELTA-10: Version Bump Type Specified

**Severity:** WARNING
**Mechanism:** Search for version bump declaration (e.g., `Version Bump: minor` or `Change Type: patch`). Verify value is one of: `major`, `minor`, `patch`.
**Failure:** "No version bump type specified (expected major/minor/patch)."

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "servicespec-delta",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL or SKIPPED",
  "classification_gate": "service_enhancement",
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
| 1.0.0 | 2026-02-24 | Initial service specification delta validator. DELTA-01 to DELTA-10. Classification-gated to service_enhancement only. Scope-aware checking. |
