# Structural Completeness Validator

> **Focus:** Validates DESIGN.md follows the template structure based on classification
> **Checks:** STRUCT-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures DESIGN.md contains all required sections based on feature classification. This prevents drift from the canonical template structure.

## Files to Read

1. `methodology templates/feature/DESIGN_TEMPLATE.md` (reference)
2. `features/{feature}/LIFECYCLE_STATE.json` (for classification)
3. `features/{feature}/DESIGN.md`

## Classification-Based Requirements

| Classification | Required Sections | Optional Sections |
|----------------|-------------------|-------------------|
| **service** | ALL (0-16) | None |
| **servicespec_extension** | ALL (0-16) | None |
| **service_enhancement** | 0, 1, 7, 9.6, 9.7, 10-16 | 2, 3, 4, 5, 6, 8, 9.5, 9.8 |
| **infrastructure** | 1, 7, 9, 10-16 | 0, 2-6, 8, 9.6, 9.7 |
| **bug_fix** | 1, 7, 12, 13 | All others |

## Validation Checks

### Template Version (STRUCT-VER-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| STRUCT-VER-01 | DESIGN.md header includes template version | WARNING |
| STRUCT-VER-02 | Template version is current (2.0.0) | WARNING |

### Section Presence (STRUCT-*)

| Check ID | Section | Severity |
|----------|---------|----------|
| STRUCT-00 | 0. Working Backwards Summary | BLOCKING* |
| STRUCT-01 | 1. Executive Summary | BLOCKING |
| STRUCT-02 | 2. Problem Discovery | BLOCKING* |
| STRUCT-03 | 3. Stakeholders | BLOCKING* |
| STRUCT-04 | 4. Requirements (FR-*, NFR-*) | BLOCKING* |
| STRUCT-05 | 5. Scope Definition | BLOCKING* |
| STRUCT-06 | 6. Use Cases (UC-*) | BLOCKING* |
| STRUCT-07 | 7. Solution Design | BLOCKING |
| STRUCT-07-SM | 7.7 State Machine | CONDITIONAL |
| STRUCT-08 | 8. Ontology Integration | WARNING* |
| STRUCT-09 | 9. Technical Decisions (TD-*) | BLOCKING* |
| STRUCT-09-5 | 9.5 Infrastructure Reconciliation | CONDITIONAL |
| STRUCT-09-6 | 9.6 Service Layer Patterns | BLOCKING* |
| STRUCT-09-7 | 9.7 Data Access Patterns | BLOCKING* |
| STRUCT-09-8 | 9.8 Cloud Abstraction | CONDITIONAL |
| STRUCT-10 | 10. Component Breakdown | BLOCKING |
| STRUCT-11 | 11. Validation & Testing | BLOCKING |
| STRUCT-12 | 12. Architecture Compliance | BLOCKING |
| STRUCT-13 | 13. Risks & Mitigations | BLOCKING |
| STRUCT-14 | 14. Open Questions | BLOCKING |
| STRUCT-15 | 15. Decision Log | BLOCKING |
| STRUCT-16 | 16. Approval | BLOCKING |

*Severity depends on classification - may be OPTIONAL for some classifications.

## Conditional Sections

| Section | Condition |
|---------|-----------|
| 7.7 State Machine | Required if feature has stateful entities |
| 9.5 Infrastructure Reconciliation | Required if feature creates cloud resources |
| 9.8 Cloud Abstraction | Required if feature creates user-accessible resources |

## Validation Process

### Step 1: Get Classification

```
Read: LIFECYCLE_STATE.json
Extract: classification field

Map to requirements:
- service → ALL sections required
- servicespec_extension → ALL sections required
- service_enhancement → subset required
- infrastructure → subset required
- bug_fix → minimal required
```

### Step 2: Check Template Version

```
Read: DESIGN.md header

Search for: "Template Version:" or "**Template Version:**"
If found, check version is 2.0.0
```

### Step 3: Scan for Section Headers

```
Read: DESIGN.md

For each required section, search for header patterns:
- "## 0." or "## 0. Working Backwards"
- "## 1." or "## 1. Executive Summary"
- "## 2." or "## 2. Problem Discovery"
- etc.

Also check for subsections:
- "### 9.6" or "### 9.6 Service Layer"
- "### 9.7" or "### 9.7 Data Access"
```

### Step 4: Apply Classification Rules

```
For each section:
  If classification requires section AND section missing:
    → FAIL (BLOCKING)
  If classification allows optional AND section missing:
    → SKIP (not a failure)
  If section present:
    → PASS
```

## Agent Prompt

```
You are the Structural Completeness Validator - a focused validator that checks template structure compliance.

## Your Task

Validate structural completeness for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/LIFECYCLE_STATE.json (read FIRST for classification)
2. features/{feature_name}/DESIGN.md

## Step 1: Determine Classification

Read LIFECYCLE_STATE.json and extract "classification" field.

Valid values:
- service
- servicespec_extension
- service_enhancement (also "enhancement")
- infrastructure
- bug_fix

## Step 2: Apply Requirements Matrix

Based on classification, determine required sections:

**service / servicespec_extension:**
Required: ALL sections (0-16, including 9.6, 9.7)

**service_enhancement / enhancement:**
Required: 0, 1, 7, 9.6, 9.7, 10, 11, 12, 13, 14, 15, 16
Optional: 2, 3, 4, 5, 6, 8, 9.5, 9.8

**infrastructure:**
Required: 1, 7, 9, 10, 11, 12, 13, 14, 15, 16
Optional: 0, 2, 3, 4, 5, 6, 8, 9.6, 9.7

**bug_fix:**
Required: 1, 7, 12, 13
Optional: All others

## Step 3: Scan DESIGN.md

Search for these section header patterns:

```
## 0. Working Backwards Summary
## 1. Executive Summary
## 2. Problem Discovery
## 3. Stakeholders
## 4. Requirements
## 5. Scope Definition
## 6. Use Cases
## 7. Solution Design
### 7.7 State Machine
## 8. Ontology Integration
## 9. Technical Decisions
### 9.5 Infrastructure
### 9.6 Service Layer
### 9.7 Data Access
### 9.8 Cloud Abstraction
## 10. Component Breakdown
## 11. Validation & Testing
## 12. Architecture Compliance
## 13. Risks & Mitigations
## 14. Open Questions
## 15. Decision Log
## 16. Approval
```

Accept variations like "## 1." or "## 1. Executive Summary" or "## 1 Executive Summary"

## Validation Checklist

### STRUCT-VER-*: Template Version
- [ ] STRUCT-VER-01: Template version in header
- [ ] STRUCT-VER-02: Version is 2.0.0

### STRUCT-*: Section Presence
For each section, mark based on classification:
- REQUIRED + PRESENT → PASS
- REQUIRED + MISSING → FAIL
- OPTIONAL + MISSING → SKIP
- OPTIONAL + PRESENT → PASS

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "structural-completeness",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "classification": "enhancement",
    "template_version": "2.0.0 or Not specified",
    "sections_required": 12,
    "sections_present": 10,
    "sections_missing": 2,
    ...
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Read LIFECYCLE_STATE.json FIRST
2. Apply classification-specific requirements
3. Check ONLY STRUCT-* checks
4. Return ONLY JSON output
5. Include classification in summary
6. Missing OPTIONAL sections are SKIP, not FAIL
```
