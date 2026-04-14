# Extension Specification Delta Validator

> **Purpose:** Validate EXTENSION_SPECIFICATION_DELTA.md for extension_enhancement classifications.
> **Check Prefix:** EXTDELTA-*

## Files to Read

**Feature Directory:**
- `features/{feature}/EXTENSION_SPECIFICATION_DELTA.md` - Delta specification under review
- `features/{feature}/DESIGN.md` - Technical design (for cross-referencing behaviors and impact)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

**Referenced (not validated):**
- The existing `EXTENSION_SPECIFICATION.md` referenced by the delta (for version verification)

---

## Classification Gate

**This validator applies to `extension_enhancement` classification ONLY.**

```
IF classification != "extension_enhancement":
    SKIP all EXTDELTA-* checks
    RETURN status: "SKIPPED", reason: "Not an extension_enhancement classification"
```

---

## Scope Handling

- **Multi-scope features:** Run all EXTDELTA-* checks against each `{scope}/EXTENSION_SPECIFICATION_DELTA.md` independently. Tag findings with scope (e.g., `EXTDELTA-03 [backend]: New behavior missing documentation`).
- **Single-scope features:** Run against root `EXTENSION_SPECIFICATION_DELTA.md`. No scope tagging needed.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### EXTDELTA-* (Extension Specification Delta)

| ID | Check | When | Severity |
|----|-------|------|----------|
| EXTDELTA-01 | EXTENSION_SPECIFICATION_DELTA.md exists | Always | BLOCKING |
| EXTDELTA-02 | References existing EXTENSION_SPECIFICATION.md version | Always | BLOCKING |
| EXTDELTA-03 | New cross-cutting behaviors documented | New behaviors added | BLOCKING |
| EXTDELTA-04 | Modified behaviors show before/after | Behaviors modified | BLOCKING |
| EXTDELTA-05 | Impact on ALL consuming services documented | Always | BLOCKING |
| EXTDELTA-06 | Backward compatibility confirmed or migration documented | Always | BLOCKING |
| EXTDELTA-07 | New configuration options documented | New config added | WARNING |
| EXTDELTA-08 | Version bump type specified (major/minor/patch) | Always | WARNING |

---

## Validation Logic

### EXTDELTA-01: File Exists

**Severity:** BLOCKING
**Mechanism:** Verify `EXTENSION_SPECIFICATION_DELTA.md` exists in the expected location (root or scope directory).
**Failure:** "EXTENSION_SPECIFICATION_DELTA.md not found. Required for extension_enhancement classification."

### EXTDELTA-02: References Existing Version

**Severity:** BLOCKING
**Mechanism:** Search EXTENSION_SPECIFICATION_DELTA.md for a reference to the base EXTENSION_SPECIFICATION.md version (e.g., `Base Version: X.Y.Z` or `Extends: EXTENSION_SPECIFICATION.md vX.Y.Z`). Verify the referenced file exists.
**Failure:** "EXTENSION_SPECIFICATION_DELTA.md does not reference a base EXTENSION_SPECIFICATION.md version."

### EXTDELTA-03: New Cross-Cutting Behaviors Documented

**Severity:** BLOCKING
**Mechanism:** For each new cross-cutting behavior listed in the delta, verify the documentation includes: behavior name, trigger conditions, affected services/components, and expected outcome.
**Failure:** "New cross-cutting behavior '{name}' missing complete documentation (requires: trigger, affected services, outcome)."

### EXTDELTA-04: Modified Behaviors Show Before/After

**Severity:** BLOCKING
**Mechanism:** For each modified behavior, verify both the current behavior and the new behavior are documented, making the change explicit.
**Failure:** "Modified behavior '{name}' missing before/after comparison."

### EXTDELTA-05: Impact on Consuming Services Documented

**Severity:** BLOCKING
**Mechanism:** Verify the delta contains a consumer impact section listing ALL services that consume this extension. For each consuming service, verify the impact is categorized (no change / configuration update / code change required).
**Failure:** "Consumer impact section missing or incomplete. All consuming services must be listed with impact assessment."

### EXTDELTA-06: Backward Compatibility or Migration

**Severity:** BLOCKING
**Mechanism:**
1. Search for a backward compatibility section (heading matching "backward compatib" case-insensitive).
2. If backward compatible: verify explicit confirmation statement.
3. If NOT backward compatible: verify a migration section exists documenting the upgrade path for each consuming service.
**Failure:** "No backward compatibility confirmation or migration path documented."

### EXTDELTA-07: New Configuration Options Documented

**Severity:** WARNING
**Mechanism:** If new configuration options are introduced, verify each includes: option name, type, default value, description, and validation rules.
**Failure:** "New configuration option '{name}' missing complete documentation (requires: type, default, description)."

### EXTDELTA-08: Version Bump Type Specified

**Severity:** WARNING
**Mechanism:** Search for version bump declaration (e.g., `Version Bump: minor` or `Change Type: patch`). Verify value is one of: `major`, `minor`, `patch`.
**Failure:** "No version bump type specified (expected major/minor/patch)."

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "extension-delta",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL or SKIPPED",
  "classification_gate": "extension_enhancement",
  "summary": {
    "checks_total": 8,
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
| 1.0.0 | 2026-02-24 | Initial extension specification delta validator. EXTDELTA-01 to EXTDELTA-08. Classification-gated to extension_enhancement only. Scope-aware checking. |
