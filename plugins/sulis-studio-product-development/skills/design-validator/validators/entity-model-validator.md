# Entity Model Validator

> **Purpose:** Validate entity model against PLATFORM_ENTITY_MODEL.md tenant hierarchy and entity rules.
> **Check Prefix:** ENT-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/DESIGN.md` (per scope for multi-scope)
- `features/{feature}/ENTITY_MODEL_DELTA.md` (if exists, in `backend/` or root)
- `features/{feature}/LIFECYCLE_STATE.json` - Scope and classification metadata

**Platform References:**
- `architecture/PLATFORM_ENTITY_MODEL.md` - Canonical entity model and tenant hierarchy

---

## Scope Handling

- **Multi-scope features:** ENT-* checks apply primarily to `backend/DESIGN.md` and `backend/ENTITY_MODEL_DELTA.md`. If no backend scope exists but entities are defined in root DESIGN.md, check root. Tag findings with scope (e.g., `ENT-R1-01 [backend]: Missing platform_id`).
- **Single-scope features:** Check root DESIGN.md and root ENTITY_MODEL_DELTA.md.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.
- **Skip condition:** If DESIGN.md introduces no new entities and no ENTITY_MODEL_DELTA.md exists, all ENT-* checks are skipped (PASS with note "No entities introduced").

---

## Validation Checklist

### ENT-R1-* (Platform Tenancy - Rule 1)

| ID | Check | Severity |
|----|-------|----------|
| ENT-R1-01 | Every tenant-scoped entity has `platform_id` field | BLOCKING |
| ENT-R1-02 | `platform_id` is marked immutable after creation | WARNING |

### ENT-R2-* (Organization Optionality - Rule 2)

| ID | Check | Severity |
|----|-------|----------|
| ENT-R2-01 | `organization_id` is always optional/nullable (never required) | BLOCKING |

### ENT-R3-* (User References - Rule 3)

| ID | Check | Severity |
|----|-------|----------|
| ENT-R3-01 | Users reference exactly 1 Platform (not 0, not N) | BLOCKING |
| ENT-R3-02 | Users can reference 0..N Organizations | BLOCKING |

### ENT-R4-* (Organization References - Rule 4)

| ID | Check | Severity |
|----|-------|----------|
| ENT-R4-01 | Organizations reference exactly 1 Platform | BLOCKING |

### ENT-R5-* (Cross-Platform Isolation - Rule 5)

| ID | Check | Severity |
|----|-------|----------|
| ENT-R5-01 | No cross-platform entity references in entity relationships | WARNING |

### ENT-R6-* (Global Entities - Rule 6)

| ID | Check | Severity |
|----|-------|----------|
| ENT-R6-01 | Global entities (instance-level) have NO `platform_id` field | BLOCKING |

### ENT-ID-* (Entity Identification)

| ID | Check | Severity |
|----|-------|----------|
| ENT-ID-01 | Entity ID prefixes follow established pattern from PLATFORM_ENTITY_MODEL.md | WARNING |

### ENT-HIER-* (Hierarchy Compliance)

| ID | Check | Severity |
|----|-------|----------|
| ENT-HIER-01 | Hierarchy respects INSTANCE -> PLATFORM -> ORGANIZATION -> USER ordering | WARNING |

### ENT-NS-* (Namespace Patterns)

| ID | Check | Severity |
|----|-------|----------|
| ENT-NS-01 | Entity namespace patterns documented in DESIGN.md or ENTITY_MODEL_DELTA.md | WARNING |

### ENT-SUB-* (Optional Organization)

| ID | Check | Severity |
|----|-------|----------|
| ENT-SUB-01 | Optional organization feature properly handled (entities work with and without org) | WARNING |

---

## Validation Logic

### ENT-R1-01: Platform ID Presence

```
FOR EACH entity defined in DESIGN.md or ENTITY_MODEL_DELTA.md:
    Determine entity scope level from hierarchy:
      - INSTANCE level → skip (global entity)
      - PLATFORM level or below → must have platform_id

    IF tenant-scoped AND no platform_id field:
        FAIL "Entity '{entity}' is tenant-scoped but missing platform_id"
```

### ENT-R2-01: Organization Optionality

```
FOR EACH entity with organization_id field:
    Check field definition for required/optional marker
    IF organization_id is marked as required (not nullable):
        FAIL "Entity '{entity}' has organization_id as required; must be optional/nullable"
```

### ENT-R5-01: Cross-Platform Isolation

```
FOR EACH entity relationship (foreign key, reference):
    Trace reference chain
    IF reference crosses platform boundary (entity A in platform X references entity B in platform Y):
        WARN "Cross-platform reference detected: {entity_a} -> {entity_b}"
```

### ENT-R6-01: Global Entity Check

```
FOR EACH entity at INSTANCE level (global):
    IF entity schema includes platform_id:
        FAIL "Global entity '{entity}' should not have platform_id"
```

### ENT-ID-01: ID Prefix Validation

```
Read PLATFORM_ENTITY_MODEL.md for established prefix patterns.
FOR EACH new entity:
    IF entity ID prefix does not follow pattern (e.g., usr_, org_, plt_):
        WARN "Entity '{entity}' ID prefix '{prefix}' does not match established pattern"
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "entity-model",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 12,
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
| 1.0.0 | 2026-02-24 | Initial entity model validator. ENT-R1 to ENT-R6 tenant hierarchy rules, ENT-ID prefix validation, ENT-HIER hierarchy compliance, ENT-NS namespace patterns, ENT-SUB optional organization handling. |
