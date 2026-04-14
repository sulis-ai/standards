# Artifact Presence Validator

> **Focus:** Validates all required design artifacts exist
> **Checks:** ART-01 to ART-11
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md
> **Version:** 1.1.0 (2026-01-11)

## Purpose

Ensures all required design artifacts exist in the feature folder before other validators run. This is a quick existence check, not content validation.

## Files to Check

| Artifact | Check ID | Required For |
|----------|----------|--------------|
| PR_FAQ.md | ART-01 | All features |
| USER_GUIDE.md | ART-02 | All features |
| TEST_SCENARIOS.md | ART-03 | All features |
| DESIGN.md | ART-04 | All features |
| IVS.md | ART-05 | All features |
| ONTOLOGY.jsonld | ART-06 | All features |
| TRACEABILITY.jsonld | ART-07 | All features |
| SERVICE_SPECIFICATION.md | ART-08 | service classification only |
| SERVICE_SPECIFICATION_EXTENSION.md | ART-09 | servicespec_extension only |
| LIFECYCLE_STATE.json | ART-10 | All features |
| SOLUTION_SUMMARY.md | ART-11 | All features |

## Validation Checks

| Check ID | Check | Severity |
|----------|-------|----------|
| ART-01 | PR_FAQ.md exists | BLOCKING |
| ART-02 | USER_GUIDE.md exists with required sections | BLOCKING |
| ART-03 | TEST_SCENARIOS.md exists | BLOCKING |
| ART-04 | DESIGN.md exists | BLOCKING |
| ART-05 | IVS.md exists with SEC-*, OBS-*, REL-* | BLOCKING |
| ART-06 | ONTOLOGY.jsonld exists and valid JSON-LD | BLOCKING |
| ART-07 | TRACEABILITY.jsonld exists | BLOCKING |
| ART-08 | SERVICE_SPECIFICATION.md exists (service only) | BLOCKING |
| ART-09 | SERVICE_SPECIFICATION_EXTENSION.md exists (extension only) | BLOCKING |
| ART-10 | LIFECYCLE_STATE.json exists and valid | BLOCKING |
| ART-11 | SOLUTION_SUMMARY.md exists with coverage matrices | BLOCKING |

## Validation Process

### Step 1: Check LIFECYCLE_STATE.json

```
Read: features/{feature}/LIFECYCLE_STATE.json
If not found → ART-10 FAIL (critical - can't determine classification)
Extract: classification
```

### Step 2: Check Core Artifacts

```
For each core artifact (ART-01 to ART-07):
  Check if file exists
  If exists → PASS
  If not exists → FAIL
```

### Step 3: Check Classification-Specific Artifacts

```
If classification == service:
  Check SERVICE_SPECIFICATION.md exists → ART-08
  ART-09 = SKIP

If classification == servicespec_extension:
  Check SERVICE_SPECIFICATION_EXTENSION.md exists → ART-09
  ART-08 = SKIP

Otherwise:
  ART-08 = SKIP
  ART-09 = SKIP
```

### Step 4: Basic Content Validation

```
For artifacts that exist, do minimal content checks:

USER_GUIDE.md:
  - Has "Getting Started" or "Quick Start"
  - Has "How-To" section
  - Has "Reference" section
  - Has "FAQ" section

IVS.md:
  - Has "SEC-" requirements
  - Has "OBS-" requirements
  - Has "REL-" requirements

ONTOLOGY.jsonld:
  - Valid JSON
  - Has "@context"

LIFECYCLE_STATE.json:
  - Valid JSON
  - Has "classification" field
  - Has "current_phase" field
```

## Agent Prompt

```
You are the Artifact Presence Validator - a focused validator that checks design artifact existence.

## Your Task

Validate artifact presence for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Check

Check existence of these files in features/{feature_name}/:

1. LIFECYCLE_STATE.json (check FIRST)
2. PR_FAQ.md
3. USER_GUIDE.md
4. TEST_SCENARIOS.md
5. DESIGN.md
6. IVS.md
7. ONTOLOGY.jsonld
8. TRACEABILITY.jsonld
9. SOLUTION_SUMMARY.md
10. SERVICE_SPECIFICATION.md (if classification = service)
11. SERVICE_SPECIFICATION_EXTENSION.md (if classification = servicespec_extension)

## Validation Checklist

### Core Artifacts
- [ ] ART-10: LIFECYCLE_STATE.json exists and valid
- [ ] ART-01: PR_FAQ.md exists
- [ ] ART-02: USER_GUIDE.md exists with required sections
- [ ] ART-03: TEST_SCENARIOS.md exists
- [ ] ART-04: DESIGN.md exists
- [ ] ART-05: IVS.md exists with SEC-*/OBS-*/REL-*
- [ ] ART-06: ONTOLOGY.jsonld exists and valid JSON-LD
- [ ] ART-07: TRACEABILITY.jsonld exists
- [ ] ART-11: SOLUTION_SUMMARY.md exists with coverage matrices

### Classification-Specific
- [ ] ART-08: SERVICE_SPECIFICATION.md (service only)
- [ ] ART-09: SERVICE_SPECIFICATION_EXTENSION.md (extension only)

## Content Checks

For files that exist, verify minimal content:

**USER_GUIDE.md must have:**
- "Quick Start" or "Getting Started"
- "How-To" section
- "Reference" section
- "FAQ" section

**IVS.md must have:**
- SEC-* security requirements
- OBS-* observability requirements
- REL-* reliability requirements

**ONTOLOGY.jsonld must have:**
- Valid JSON syntax
- "@context" property

**LIFECYCLE_STATE.json must have:**
- "classification" field
- "current_phase" field

**SOLUTION_SUMMARY.md must have:**
- "Executive Brief" section
- "Solution Overview" section
- "Coverage Matrix" section
- "Artifact Index" section
- "Approval Status" section

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "artifact-presence",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "classification": "{classification}",
    "artifacts_required": 8,
    "artifacts_present": 8,
    "artifacts_missing": 0,
    ...
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Check LIFECYCLE_STATE.json FIRST (needed for classification)
2. Only check ART-08 or ART-09 based on classification
3. Do minimal content validation (existence + basic structure)
4. Return ONLY JSON output
5. This is a fast check - don't deep-dive into content
```
