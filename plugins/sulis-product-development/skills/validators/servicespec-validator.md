# ServiceSpec Validator

> **Focus:** Validates SERVICE_SPECIFICATION.md or SERVICE_SPECIFICATION_EXTENSION.md
> **Checks:** SPEC-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures ServiceSpec artifacts are complete with all required sections: entity specification, operations, authorization, events, and observability. Only runs for `service` or `servicespec_extension` classifications.

## Files to Read

1. `features/{feature}/LIFECYCLE_STATE.json` (for classification)
2. `features/{feature}/SERVICE_SPECIFICATION.md` (if service)
3. `features/{feature}/SERVICE_SPECIFICATION_EXTENSION.md` (if extension)

## Applicability

| Classification | Required Artifact | Run Validator? |
|----------------|-------------------|----------------|
| service | SERVICE_SPECIFICATION.md | Yes |
| servicespec_extension | SERVICE_SPECIFICATION_EXTENSION.md | Yes |
| service_enhancement | None | No - SKIP all checks |
| infrastructure | None | No - SKIP all checks |

## Validation Checks

### Structure (SPEC-01 to SPEC-02)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-01 | ServiceSpec matches feature classification | BLOCKING |
| SPEC-02 | ServiceSpec uses correct template structure | BLOCKING |

### Entity Specification (SPEC-03 to SPEC-05)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-03 | Entities have displayMetadata (icon, primaryField, badges) | BLOCKING |
| SPEC-04 | Entity fields have display properties (copyable, masked, prominent) | BLOCKING |
| SPEC-05 | Computed fields documented with expressions | BLOCKING |

### Form-Drivable Metadata (SPEC-06 to SPEC-09)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-06 | All fields have x-display (order, label, inputType) | BLOCKING |
| SPEC-07 | Enum fields have x-enum-labels | BLOCKING |
| SPEC-08 | Dependent fields have x-dependent-enum | BLOCKING |
| SPEC-09 | Required fields have x-validation-messages | BLOCKING |

### Operations Specification (SPEC-10 to SPEC-18)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-10 | Operations defined with @operation decorator | BLOCKING |
| SPEC-11 | Operations have permissions specified | BLOCKING |
| SPEC-12 | Operations have input/output schemas | BLOCKING |
| SPEC-13 | Operations have error codes listed | BLOCKING |
| SPEC-14 | Operations have HATEOAS navigation (leads_to) | BLOCKING |
| SPEC-15 | Operations have rate_limits specified | BLOCKING |
| SPEC-16 | Operations have examples (2+ each) | BLOCKING |
| SPEC-17 | Destructive operations have confirmation | BLOCKING |
| SPEC-18 | List operations have pagination spec | BLOCKING |

### Authorization & Sharing (SPEC-19 to SPEC-26)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-19 | Three-layer authorization model referenced | BLOCKING |
| SPEC-20 | Namespace isolation documented | BLOCKING |
| SPEC-21 | Permissions follow {domain}.{entity}:{action} pattern | BLOCKING |
| SPEC-22 | Permission hierarchy/implication documented | BLOCKING |
| SPEC-23 | Roles defined with name, description, permissions, icon | BLOCKING |
| SPEC-24 | Sharing grants specified (if shareable entity) | BLOCKING |
| SPEC-25 | Identity types documented (USER, ORG, PUBLIC) | BLOCKING |
| SPEC-26 | Grantable permission chain documented | BLOCKING |

### Events & Notifications (SPEC-27 to SPEC-32)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-27 | Events use CloudEvents 1.0 format | BLOCKING |
| SPEC-28 | Event schemas defined | BLOCKING |
| SPEC-29 | Extension attributes documented (platformid, actorid) | BLOCKING |
| SPEC-30 | Event subscribers listed | BLOCKING |
| SPEC-31 | Notification triggers mapped to events | BLOCKING |
| SPEC-32 | Subscription patterns documented | BLOCKING |

### Errors & Observability (SPEC-33 to SPEC-35)

| Check ID | Check | Severity |
|----------|-------|----------|
| SPEC-33 | Error catalog with user_action remediation | BLOCKING |
| SPEC-34 | Metrics defined | BLOCKING |
| SPEC-35 | Alerts configured | BLOCKING |

## Validation Process

### Step 1: Check Classification

```
Read: LIFECYCLE_STATE.json
Extract: classification

If classification NOT in [service, servicespec_extension]:
  → Return all checks as SKIP
  → Status = PASS (N/A for this classification)
```

### Step 2: Check Artifact Existence

```
If classification == service:
  Read: SERVICE_SPECIFICATION.md
  If not found → SPEC-01 FAIL

If classification == servicespec_extension:
  Read: SERVICE_SPECIFICATION_EXTENSION.md
  If not found → SPEC-01 FAIL
```

### Step 3: Validate Sections

```
For each required section:
  Search for section header
  If found, check content requirements
  If missing, mark check as FAIL
```

## Agent Prompt

```
You are the ServiceSpec Validator - a focused validator that checks SERVICE_SPECIFICATION completeness.

## Your Task

Validate ServiceSpec for feature: {feature_name}
Feature path: features/{feature_name}/

## Step 1: Check Classification

Read: features/{feature_name}/LIFECYCLE_STATE.json

Extract "classification" field.

**If classification is NOT "service" or "servicespec_extension":**
- Return status: "PASS"
- Mark ALL checks as "SKIP"
- Set note: "ServiceSpec not required for {classification} features"
- Exit early

## Step 2: Determine Required Artifact

- If classification = "service" → Read SERVICE_SPECIFICATION.md
- If classification = "servicespec_extension" → Read SERVICE_SPECIFICATION_EXTENSION.md

## Step 3: Validate Content

### SPEC-01 to SPEC-02: Structure
- [ ] SPEC-01: Correct artifact exists for classification
- [ ] SPEC-02: Uses correct template structure

### SPEC-03 to SPEC-05: Entity Specification
- [ ] SPEC-03: displayMetadata (icon, primaryField, badges)
- [ ] SPEC-04: Field display properties
- [ ] SPEC-05: Computed fields documented

### SPEC-06 to SPEC-09: Form-Drivable Metadata
- [ ] SPEC-06: x-display on fields
- [ ] SPEC-07: x-enum-labels for enums
- [ ] SPEC-08: x-dependent-enum for dependent fields
- [ ] SPEC-09: x-validation-messages for required

### SPEC-10 to SPEC-18: Operations
- [ ] SPEC-10: @operation decorator
- [ ] SPEC-11: Permissions specified
- [ ] SPEC-12: Input/output schemas
- [ ] SPEC-13: Error codes
- [ ] SPEC-14: HATEOAS navigation
- [ ] SPEC-15: Rate limits
- [ ] SPEC-16: Examples (2+ each)
- [ ] SPEC-17: Destructive confirmations
- [ ] SPEC-18: List pagination

### SPEC-19 to SPEC-26: Authorization
- [ ] SPEC-19: Three-layer model
- [ ] SPEC-20: Namespace isolation
- [ ] SPEC-21: Permission pattern
- [ ] SPEC-22: Permission hierarchy
- [ ] SPEC-23: Roles defined
- [ ] SPEC-24: Sharing grants
- [ ] SPEC-25: Identity types
- [ ] SPEC-26: Grantable chain

### SPEC-27 to SPEC-32: Events
- [ ] SPEC-27: CloudEvents 1.0
- [ ] SPEC-28: Event schemas
- [ ] SPEC-29: Extension attributes
- [ ] SPEC-30: Subscribers
- [ ] SPEC-31: Notification triggers
- [ ] SPEC-32: Subscription patterns

### SPEC-33 to SPEC-35: Observability
- [ ] SPEC-33: Error catalog with user_action
- [ ] SPEC-34: Metrics
- [ ] SPEC-35: Alerts

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "servicespec",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "classification": "service",
    "artifact": "SERVICE_SPECIFICATION.md",
    ...
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Check classification FIRST - may skip entirely
2. Check ONLY SPEC-* checks
3. Return ONLY JSON output
4. If N/A, return PASS with all SKIP
5. Be thorough on operations and authorization
```
