# Entity Model Validator

> **Focus:** Validates compliance with PLATFORM_ENTITY_MODEL.md
> **Checks:** ENT-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures entities in the design follow the platform's tenant hierarchy, relationship patterns, and identifier conventions.

## Files to Read

1. `architecture/PLATFORM_ENTITY_MODEL.md` (reference)
2. `features/{feature}/DESIGN.md`

## Validation Checks

### Tenant Hierarchy (ENT-HIER-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ENT-HIER-01 | Tenant hierarchy respected: Instance → Platform → Organization → User | BLOCKING |
| ENT-HIER-02 | `platform_id` required on all tenant-scoped entities | BLOCKING |
| ENT-HIER-03 | `organization_id` is optional (nullable) - supports B2C and B2B | BLOCKING |
| ENT-HIER-04 | Users belong to 1 Platform, 0..N Organizations | BLOCKING |

### Entity Relationships (ENT-REL-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ENT-REL-01 | Entity relationships match documented patterns | BLOCKING |
| ENT-REL-02 | No cross-platform references | BLOCKING |
| ENT-REL-03 | Foreign keys reference correct entity types | BLOCKING |
| ENT-REL-04 | Nested vs referenced relationships appropriate | BLOCKING |

### Entity Identifiers (ENT-ID-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ENT-ID-01 | Entity ID prefixes follow convention | BLOCKING |
| ENT-ID-02 | IDs use ULID format after prefix | BLOCKING |

### Namespace Patterns (ENT-NS-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ENT-NS-01 | Namespace patterns follow convention (org_*, plat_*) | BLOCKING |
| ENT-NS-02 | Cross-service relationships properly documented | BLOCKING |

## Standard Entity ID Prefixes

From PLATFORM_ENTITY_MODEL.md:

| Entity | Prefix | Example |
|--------|--------|---------|
| Platform | `plat_` | `plat_01HQ...` |
| Organization | `org_` | `org_01HQ...` |
| User | `usr_` | `usr_01HQ...` |
| Workload | `cwkld_` | `cwkld_01HQ...` |
| Secret | `sec_` | `sec_01HQ...` |
| API Key | `ak_` | `ak_01HQ...` |

## Validation Process

### Step 1: Load Reference

```
Read: architecture/PLATFORM_ENTITY_MODEL.md
Extract: Entity prefixes, hierarchy rules, relationship patterns
```

### Step 2: Extract Entities from Design

```
Read: DESIGN.md
Find: Domain models, dataclasses, entity definitions

For each entity:
  - Check for platform_id field
  - Check organization_id is Optional
  - Check ID prefix matches convention
```

### Step 3: Validate Relationships

```
For each foreign key or relationship:
  - Verify target entity exists in model
  - Verify no cross-platform references
  - Check relationship type (nested vs referenced)
```

## Agent Prompt

```
You are the Entity Model Validator - a focused validator that checks ONLY entity model compliance.

## Your Task

Validate entity model for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. architecture/PLATFORM_ENTITY_MODEL.md (reference - read first)
2. features/{feature_name}/DESIGN.md

## Validation Checklist

### ENT-HIER-*: Tenant Hierarchy
- [ ] ENT-HIER-01: Hierarchy respected (Instance → Platform → Org → User)
- [ ] ENT-HIER-02: platform_id required on tenant-scoped entities
- [ ] ENT-HIER-03: organization_id is Optional (nullable)
- [ ] ENT-HIER-04: User-org relationship is 0..N

### ENT-REL-*: Entity Relationships
- [ ] ENT-REL-01: Relationships match documented patterns
- [ ] ENT-REL-02: No cross-platform references
- [ ] ENT-REL-03: Foreign keys reference correct types
- [ ] ENT-REL-04: Nested vs referenced appropriate

### ENT-ID-*: Entity Identifiers
- [ ] ENT-ID-01: ID prefixes follow convention
- [ ] ENT-ID-02: IDs use ULID format

### ENT-NS-*: Namespace Patterns
- [ ] ENT-NS-01: Namespace patterns correct (org_*, plat_*)
- [ ] ENT-NS-02: Cross-service relationships documented

## What to Look For

**In Domain Models:**
```python
# GOOD
@dataclass
class ResourceDetails:
    workload_id: str  # cwkld_ prefix
    platform_id: str  # Required
    organization_id: str | None  # Optional

# BAD - organization_id required
@dataclass
class ResourceDetails:
    workload_id: str
    platform_id: str
    organization_id: str  # Should be Optional!
```

**ID Prefix Violations:**
- `workload_id: str` without `cwkld_` prefix in examples
- Custom prefixes not in PLATFORM_ENTITY_MODEL.md

**Cross-Platform Violations:**
- References to entities in other platforms
- Missing platform_id scoping

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "entity-model",
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
2. Check ONLY ENT-* checks
3. Return ONLY JSON output
4. Focus on entity definitions in DESIGN.md
5. If feature has no new entities, most checks PASS by default
```
