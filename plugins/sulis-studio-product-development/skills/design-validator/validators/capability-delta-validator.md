# Capability Specification Delta Validator

> **Purpose:** Validate CAPABILITY_SPECIFICATION_DELTA.md for capability_enhancement classifications.
> **Check Prefix:** CAPDELTA-*

## Files to Read

**Feature Directory:**
- `features/{feature}/CAPABILITY_SPECIFICATION_DELTA.md` - Delta specification under review
- `features/{feature}/DESIGN.md` - Technical design (for cross-referencing capabilities and impact)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

**Referenced (not validated):**
- The existing `CAPABILITY_SPECIFICATION.md` referenced by the delta (for version verification)

---

## Classification Gate

**This validator applies to `capability_enhancement` classification ONLY.**

```
IF classification != "capability_enhancement":
    SKIP all CAPDELTA-* checks
    RETURN status: "SKIPPED", reason: "Not a capability_enhancement classification"
```

---

## Scope Handling

- **Multi-scope features:** Run all CAPDELTA-* checks against each `{scope}/CAPABILITY_SPECIFICATION_DELTA.md` independently. Tag findings with scope (e.g., `CAPDELTA-03 [backend]: New capability missing contract`).
- **Single-scope features:** Run against root `CAPABILITY_SPECIFICATION_DELTA.md`. No scope tagging needed.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### CAPDELTA-* (Capability Specification Delta)

| ID | Check | When | Severity |
|----|-------|------|----------|
| CAPDELTA-01 | CAPABILITY_SPECIFICATION_DELTA.md exists | Always | BLOCKING |
| CAPDELTA-02 | References existing CAPABILITY_SPECIFICATION.md version | Always | BLOCKING |
| CAPDELTA-03 | New capabilities documented with contract | New capabilities added | BLOCKING |
| CAPDELTA-04 | Modified capabilities show before/after | Capabilities modified | BLOCKING |
| CAPDELTA-05 | Platform-wide impact documented | Always | BLOCKING |
| CAPDELTA-06 | Backward compatibility confirmed or migration documented | Always | BLOCKING |
| CAPDELTA-07 | Version bump type specified (major/minor/patch) | Always | WARNING |

---

## Validation Logic

### CAPDELTA-01: File Exists

**Severity:** BLOCKING
**Mechanism:** Verify `CAPABILITY_SPECIFICATION_DELTA.md` exists in the expected location (root or scope directory).
**Failure:** "CAPABILITY_SPECIFICATION_DELTA.md not found. Required for capability_enhancement classification."

### CAPDELTA-02: References Existing Version

**Severity:** BLOCKING
**Mechanism:** Search CAPABILITY_SPECIFICATION_DELTA.md for a reference to the base CAPABILITY_SPECIFICATION.md version (e.g., `Base Version: X.Y.Z` or `Extends: CAPABILITY_SPECIFICATION.md vX.Y.Z`). Verify the referenced file exists.
**Failure:** "CAPABILITY_SPECIFICATION_DELTA.md does not reference a base CAPABILITY_SPECIFICATION.md version."

### CAPDELTA-03: New Capabilities Have Contract

**Severity:** BLOCKING
**Mechanism:** For each new capability listed in the delta, verify the documentation includes: capability name, interface contract (inputs, outputs, errors), consuming services, and integration points.
**Failure:** "New capability '{name}' missing full contract (requires: interface, consumers, integration points)."

### CAPDELTA-04: Modified Capabilities Show Before/After

**Severity:** BLOCKING
**Mechanism:** For each modified capability, verify both the current behavior and the new behavior are documented, making the change explicit.
**Failure:** "Modified capability '{name}' missing before/after comparison."

### CAPDELTA-05: Platform-Wide Impact Documented

**Severity:** BLOCKING
**Mechanism:** Verify the delta contains a platform impact section documenting how this capability change affects the broader platform. This must include: affected services, affected extensions, tenant isolation implications, and performance considerations.
**Failure:** "Platform-wide impact section missing or incomplete (requires: affected services, extensions, tenant isolation, performance)."

### CAPDELTA-06: Backward Compatibility or Migration

**Severity:** BLOCKING
**Mechanism:**
1. Search for a backward compatibility section (heading matching "backward compatib" case-insensitive).
2. If backward compatible: verify explicit confirmation statement.
3. If NOT backward compatible: verify a migration section exists documenting the upgrade path for all consuming services and extensions.
**Failure:** "No backward compatibility confirmation or migration path documented."

### CAPDELTA-07: Version Bump Type Specified

**Severity:** WARNING
**Mechanism:** Search for version bump declaration (e.g., `Version Bump: minor` or `Change Type: patch`). Verify value is one of: `major`, `minor`, `patch`.
**Failure:** "No version bump type specified (expected major/minor/patch)."

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "capability-delta",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL or SKIPPED",
  "classification_gate": "capability_enhancement",
  "summary": {
    "checks_total": 7,
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
| 1.0.0 | 2026-02-24 | Initial capability specification delta validator. CAPDELTA-01 to CAPDELTA-07. Classification-gated to capability_enhancement only. Scope-aware checking. |
