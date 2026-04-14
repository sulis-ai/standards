# Platform Conventions Validator

> **Purpose:** Verify design compliance with cross-cutting platform conventions defined in PLATFORM_CONVENTIONS.md.
> **Check Prefix:** CONV-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/DESIGN.md` (per scope for multi-scope)
- `features/{feature}/USER_GUIDE.md`
- `features/{feature}/IVS.md` (per scope for multi-scope)
- `features/{feature}/LIFECYCLE_STATE.json`

**Platform References:**
- `features/PLATFORM_CONVENTIONS.md` - Canonical platform conventions

---

## Scope Handling

- **Multi-scope features:** CONV-WL-*, CONV-SEC-*, CONV-CLOUD-*, CONV-NAMING-* checks run against each `{scope}/DESIGN.md` independently. CONV-SCOPE-* checks run against the feature root. Tag findings with scope (e.g., `CONV-WL-01 [backend]: Hardcoded domain found`).
- **Single-scope features:** All checks run against root DESIGN.md. CONV-SCOPE-03 verifies no scope subdirectories exist.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### CONV-WL-* (White-Label Compliance)

| ID | Check | Severity |
|----|-------|----------|
| CONV-WL-01 | No hardcoded `sulis.dev` or `sulis.dev` in user-facing outputs | BLOCKING |
| CONV-WL-02 | User-facing identifiers use `{platform.*}` config variables | BLOCKING |
| CONV-WL-03 | Webhook signatures use generic header (not `X-Sulis Platform-*`) | BLOCKING |
| CONV-WL-04 | Error messages use config variables, not hardcoded contact info | BLOCKING |

### CONV-SEC-* (Secrets Management)

| ID | Check | Severity |
|----|-------|----------|
| CONV-SEC-01 | No plain secret/password/key/token fields in entity definitions | BLOCKING |
| CONV-SEC-02 | Secrets referenced via SecretService pattern | BLOCKING |
| CONV-SEC-03 | Secret ID naming follows `{service}_{type}_{entity_id}` convention | WARNING |

### CONV-CLOUD-* (Cloud Abstraction)

| ID | Check | Severity |
|----|-------|----------|
| CONV-CLOUD-01 | No GCP/AWS/Azure console references in USER_GUIDE.md | BLOCKING |
| CONV-CLOUD-02 | No direct provider-specific UI references (e.g., "Go to GCP Console") | BLOCKING |
| CONV-CLOUD-03 | Cloud data surfaced through Sulis Platform APIs, not direct provider access | BLOCKING |
| CONV-CLOUD-04 | 4 mandatory cloud abstraction questions addressed in DESIGN.md | WARNING |

### CONV-NAMING-* (Naming Conventions)

| ID | Check | Severity |
|----|-------|----------|
| CONV-NAMING-01 | JSON fields use camelCase in API examples and schemas | BLOCKING |
| CONV-NAMING-02 | URL paths use kebab-case in endpoint definitions | BLOCKING |
| CONV-NAMING-03 | Query parameters use camelCase in API examples | BLOCKING |
| CONV-NAMING-04 | Python identifiers use snake_case in code examples | WARNING |

### CONV-SCOPE-* (Scope Directory Compliance)

| ID | Check | Severity |
|----|-------|----------|
| CONV-SCOPE-01 | Multi-scope has `scopes.resolved` array in LIFECYCLE_STATE.json | BLOCKING |
| CONV-SCOPE-02 | Scope directory names match declared scopes exactly | WARNING |
| CONV-SCOPE-03 | Single-scope has NO scope subdirectories (backend/, frontend-web/, etc.) | BLOCKING |
| CONV-SCOPE-04 | Root IVS.md in multi-scope contains cross-scope requirements only | BLOCKING |

---

## Validation Logic

### CONV-WL-01 / CONV-WL-02: White-Label Scan

```
FOR EACH file IN [DESIGN.md, USER_GUIDE.md, IVS.md]:
    Search for patterns:
      - "sulis.dev" (case-insensitive)
      - "sulis.dev" (case-insensitive)
      - "Sulis Platform" in user-facing output context (not internal references)
    IF found in user-facing context:
        FAIL CONV-WL-01

    Search for user-facing identifiers (app name, domain, email):
      IF hardcoded (not using {platform.*} variable):
          FAIL CONV-WL-02
```

### CONV-WL-03: Webhook Header Check

```
Search DESIGN.md for webhook-related sections.
IF webhook headers defined:
    Search for "X-Sulis Platform-" pattern
    IF found:
        FAIL "Webhook header uses branded prefix instead of generic"
```

### CONV-SEC-01 / CONV-SEC-02: Secrets Pattern

```
Search DESIGN.md entity definitions and schemas for fields named:
  - *secret*, *password*, *key*, *token*, *credential*
IF field stores value directly (not a reference ID):
    FAIL CONV-SEC-01

Search for secret access patterns:
IF secrets accessed without SecretService:
    FAIL CONV-SEC-02
```

### CONV-CLOUD-04: Cloud Abstraction Questions

The 4 mandatory questions from PLATFORM_CONVENTIONS.md:
1. How will users access cloud resources?
2. What cloud data needs to be surfaced?
3. How will cloud status be reported?
4. What cloud operations need to be proxied?

```
Search DESIGN.md for cloud abstraction section.
FOR EACH question:
    IF not addressed:
        WARN CONV-CLOUD-04
```

### CONV-SCOPE-04: Cross-Scope IVS Validation

```
IF multi-scope:
    Read root IVS.md
    FOR EACH requirement in root IVS.md:
        Apply 3-criteria entry test:
          1. Verifiable chain spanning 2+ scopes
          2. Both verified together
          3. Cannot decompose into single-scope checks
        IF requirement fails entry test:
            FAIL "Root IVS.md contains single-scope requirement: {req_id}"
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "platform-conventions",
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
| 1.0.0 | 2026-02-24 | Initial platform conventions validator. CONV-WL-01 to CONV-WL-04, CONV-SEC-01 to CONV-SEC-03, CONV-CLOUD-01 to CONV-CLOUD-04, CONV-NAMING-01 to CONV-NAMING-04, CONV-SCOPE-01 to CONV-SCOPE-04. Five convention categories covering white-label, secrets, cloud abstraction, naming, and scope compliance. |
