# Platform Conventions Validator

> **Focus:** Validates compliance with PLATFORM_CONVENTIONS.md
> **Checks:** CONV-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures the feature design follows platform-wide conventions for white-labeling, secrets management, naming, authorization, namespaces, and events.

## Files to Read

1. `features/PLATFORM_CONVENTIONS.md` (reference)
2. `features/{feature}/DESIGN.md`
3. `features/{feature}/USER_GUIDE.md`
4. `features/{feature}/PR_FAQ.md`

## Validation Checks

### White-Labeling (CONV-WL-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| CONV-WL-01 | No hardcoded "sulis.dev" or "Sulis Platform" branding in user-facing content | BLOCKING |
| CONV-WL-02 | Event type prefixes use `{platform.eventTypePrefix}` not hardcoded | BLOCKING |
| CONV-WL-03 | All external identifiers use platform configuration | BLOCKING |
| CONV-WL-04 | Error messages reference `{platform.supportEmail}` not hardcoded | BLOCKING |
| CONV-WL-05 | No direct cloud console URLs (GCP/AWS/Azure) in user-facing docs | BLOCKING |

### Secrets Management (CONV-SEC-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| CONV-SEC-01 | Secrets use `secret_id` reference pattern, not direct values | BLOCKING |
| CONV-SEC-02 | No secret values stored directly in entity fields | BLOCKING |
| CONV-SEC-03 | SecretService pattern used for all secret operations | BLOCKING |

### Naming Conventions (CONV-NAME-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| CONV-NAME-01 | JSON API fields use camelCase | BLOCKING |
| CONV-NAME-02 | URL paths use kebab-case | BLOCKING |
| CONV-NAME-03 | Query parameters use camelCase | BLOCKING |
| CONV-NAME-04 | Entity IDs use correct prefixes per PLATFORM_ENTITY_MODEL | BLOCKING |

### Authorization Model (CONV-AUTH-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| CONV-AUTH-01 | Three-layer model documented: Identity → Interaction → Permission | BLOCKING |
| CONV-AUTH-02 | Permissions follow `{domain}.{entity}:{action}` pattern | BLOCKING |
| CONV-AUTH-03 | Grantable permission implication chain documented | BLOCKING |

### Namespace Isolation (CONV-NS-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| CONV-NS-01 | Entities scoped to namespace | BLOCKING |
| CONV-NS-02 | Dual namespace support (org_* and plat_*) if applicable | BLOCKING |

### CloudEvents (CONV-EVT-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| CONV-EVT-01 | Events use CloudEvents 1.0 format | BLOCKING |
| CONV-EVT-02 | Event types follow configurable prefix convention | BLOCKING |

## Validation Process

### Step 1: Load Reference

```
Read: features/PLATFORM_CONVENTIONS.md
Extract: Current conventions and patterns
```

### Step 2: Scan User-Facing Content

```
Read: USER_GUIDE.md, PR_FAQ.md

Search for violations:
- "sulis.dev" → CONV-WL-01 FAIL
- "Sulis Platform" (not as placeholder) → CONV-WL-01 FAIL
- "console.cloud.google.com" → CONV-WL-05 FAIL
- "dataproc.googleusercontent.com" → CONV-WL-05 FAIL
- Hardcoded email addresses → CONV-WL-04 FAIL
```

### Step 3: Check DESIGN.md Patterns

```
Read: DESIGN.md

Check API contracts:
- snake_case in JSON → CONV-NAME-01 FAIL
- CamelCase in URLs → CONV-NAME-02 FAIL

Check secrets:
- "password: str" or "api_key: str" fields → CONV-SEC-02 FAIL
- Should be "secret_id: str" referencing SecretService

Check events:
- Hardcoded event types → CONV-EVT-02 FAIL
```

## Agent Prompt

```
You are the Platform Conventions Validator - a focused validator that checks ONLY platform convention compliance.

## Your Task

Validate platform conventions for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/PLATFORM_CONVENTIONS.md (reference - read first)
2. features/{feature_name}/DESIGN.md
3. features/{feature_name}/USER_GUIDE.md
4. features/{feature_name}/PR_FAQ.md

## Validation Checklist

### CONV-WL-*: White-Labeling
- [ ] CONV-WL-01: No hardcoded "sulis.dev" or Sulis Platform branding
- [ ] CONV-WL-02: Event prefixes use platform configuration
- [ ] CONV-WL-03: External identifiers use platform configuration
- [ ] CONV-WL-04: Error messages use {platform.supportEmail}
- [ ] CONV-WL-05: No direct cloud console URLs in user docs

### CONV-SEC-*: Secrets Management
- [ ] CONV-SEC-01: Secrets use secret_id reference pattern
- [ ] CONV-SEC-02: No secret values in entity fields
- [ ] CONV-SEC-03: SecretService pattern used

### CONV-NAME-*: Naming Conventions
- [ ] CONV-NAME-01: JSON fields use camelCase
- [ ] CONV-NAME-02: URL paths use kebab-case
- [ ] CONV-NAME-03: Query params use camelCase
- [ ] CONV-NAME-04: Entity IDs use correct prefixes

### CONV-AUTH-*: Authorization Model
- [ ] CONV-AUTH-01: Three-layer model documented
- [ ] CONV-AUTH-02: Permissions follow {domain}.{entity}:{action}
- [ ] CONV-AUTH-03: Permission implication chain documented

### CONV-NS-*: Namespace Isolation
- [ ] CONV-NS-01: Entities scoped to namespace
- [ ] CONV-NS-02: Dual namespace support if applicable

### CONV-EVT-*: CloudEvents
- [ ] CONV-EVT-01: Events use CloudEvents 1.0 format
- [ ] CONV-EVT-02: Event types follow convention

## Search Patterns for Violations

Look for these patterns indicating violations:

**White-Label Violations:**
- `sulis.dev` in user-facing content
- `console.cloud.google.com`
- `*.dataproc.googleusercontent.com`
- `*.run.app` (direct Cloud Run URLs)
- Hardcoded email addresses

**Naming Violations:**
- `snake_case` in JSON examples (should be camelCase)
- `/some_path/` in URLs (should be kebab-case)

**Secrets Violations:**
- `password: str` or `api_key: str` fields
- Secret values in examples

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "platform-conventions",
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

1. Read the reference document FIRST
2. Check ONLY CONV-* checks
3. Return ONLY JSON output
4. Quote evidence exactly as found
5. Provide specific fix instructions
```
