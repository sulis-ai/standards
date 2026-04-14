# Solution Summary Validator

> **Focus:** Validates SOLUTION_SUMMARY.md structure, content, and cross-references
> **Checks:** SUM-01 to SUM-25
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md
> **Version:** 1.0.0 (2026-01-11)

## Purpose

Ensures SOLUTION_SUMMARY.md provides a complete executive dashboard that gives stakeholders confidence in the feature without requiring them to read detailed specifications. Validates that coverage matrices are properly derived from other artifacts.

## Files to Read

1. `features/{feature}/SOLUTION_SUMMARY.md` (primary)
2. `features/{feature}/LIFECYCLE_STATE.json` (for cross-reference)
3. `features/{feature}/PR_FAQ.md` (for cross-reference)
4. `features/{feature}/IVS.md` (for coverage counts)
5. `features/{feature}/TEST_SCENARIOS.md` (for scenario counts)
6. `features/{feature}/DESIGN.md` (for decision/risk cross-reference)

## Validation Checks

### Structure (SUM-01 to SUM-08)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-01 | Header with Status, Phase, Classification, Owner | BLOCKING |
| SUM-02 | Section 1 "Executive Brief" exists | BLOCKING |
| SUM-03 | Section 2 "Solution Overview" exists | BLOCKING |
| SUM-04 | Section 3 "Key Design Decisions" exists | BLOCKING |
| SUM-05 | Section 4 "Coverage Matrix" exists | BLOCKING |
| SUM-06 | Section 5 "Risk Summary" exists | BLOCKING |
| SUM-07 | Section 6 "Artifact Index" exists | BLOCKING |
| SUM-08 | Section 7 "Approval Status" exists | BLOCKING |

### Executive Brief (SUM-09 to SUM-12)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-09 | Press Release Headline present (derived from PR_FAQ) | BLOCKING |
| SUM-10 | Summary is 2-3 sentences (not placeholder) | WARNING |
| SUM-11 | Business Impact table with metrics | BLOCKING |
| SUM-12 | Metrics have Target and Measurement columns | WARNING |

### Solution Overview (SUM-13 to SUM-14)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-13 | Problem → Solution table complete | BLOCKING |
| SUM-14 | Architecture Snapshot diagram present | WARNING |

### Design Decisions (SUM-15 to SUM-16)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-15 | At least 2 key decisions documented | BLOCKING |
| SUM-16 | Decisions have TD-XX identifiers | WARNING |

### Coverage Matrix (SUM-17 to SUM-21)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-17 | Requirements Coverage table present | BLOCKING |
| SUM-18 | SEC-*, OBS-*, REL-* counts match IVS.md | BLOCKING |
| SUM-19 | Test Scenario Coverage table present | BLOCKING |
| SUM-20 | TS-* counts match TEST_SCENARIOS.md | BLOCKING |
| SUM-21 | Platform Compliance table present | BLOCKING |

### Risk and Artifacts (SUM-22 to SUM-24)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-22 | Risk Summary table with at least 1 risk | WARNING |
| SUM-23 | Artifact Index links to all core artifacts | BLOCKING |
| SUM-24 | Artifact status matches LIFECYCLE_STATE.json | WARNING |

### Approval Status (SUM-25)

| Check ID | Check | Severity |
|----------|-------|----------|
| SUM-25 | Gate status table with all 4 gates | BLOCKING |

## Validation Process

### Step 1: Structure Validation

```
Read: SOLUTION_SUMMARY.md
Check for presence of all 8 required sections
Verify header contains Status, Phase, Classification, Owner
```

### Step 2: Cross-Reference Validation

```
Read: PR_FAQ.md
Verify Press Release Headline matches

Read: IVS.md
Count SEC-*, OBS-*, REL-* requirements
Compare with SOLUTION_SUMMARY coverage counts

Read: TEST_SCENARIOS.md
Count TS-* scenarios
Compare with SOLUTION_SUMMARY test counts

Read: DESIGN.md
Verify TD-XX decisions referenced
Verify risks mentioned exist in Section 13
```

### Step 3: Completeness Check

```
Verify no placeholder text like:
- "{Feature Name}"
- "{TODO}"
- "{X}"
- "{Name}"
- "YYYY-MM-DD"

These indicate incomplete sections
```

## Agent Prompt

```
You are the Solution Summary Validator - a focused validator that checks executive dashboard completeness.

## Your Task

Validate SOLUTION_SUMMARY.md for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/SOLUTION_SUMMARY.md (primary)
2. features/{feature_name}/LIFECYCLE_STATE.json
3. features/{feature_name}/PR_FAQ.md
4. features/{feature_name}/IVS.md
5. features/{feature_name}/TEST_SCENARIOS.md
6. features/{feature_name}/DESIGN.md

## Validation Checklist

### Structure (SUM-01 to SUM-08)
- [ ] SUM-01: Header with Status, Phase, Classification, Owner
- [ ] SUM-02: Section 1 "Executive Brief"
- [ ] SUM-03: Section 2 "Solution Overview"
- [ ] SUM-04: Section 3 "Key Design Decisions"
- [ ] SUM-05: Section 4 "Coverage Matrix"
- [ ] SUM-06: Section 5 "Risk Summary"
- [ ] SUM-07: Section 6 "Artifact Index"
- [ ] SUM-08: Section 7 "Approval Status"

### Content Quality (SUM-09 to SUM-14)
- [ ] SUM-09: Press Release Headline present
- [ ] SUM-10: Summary is 2-3 sentences (not placeholder)
- [ ] SUM-11: Business Impact table with metrics
- [ ] SUM-12: Metrics have Target and Measurement
- [ ] SUM-13: Problem → Solution table complete
- [ ] SUM-14: Architecture Snapshot present

### Design Decisions (SUM-15 to SUM-16)
- [ ] SUM-15: At least 2 decisions documented
- [ ] SUM-16: TD-XX identifiers used

### Coverage Accuracy (SUM-17 to SUM-21)
- [ ] SUM-17: Requirements Coverage table present
- [ ] SUM-18: SEC/OBS/REL counts match IVS.md
- [ ] SUM-19: Test Scenario Coverage table present
- [ ] SUM-20: TS-* counts match TEST_SCENARIOS.md
- [ ] SUM-21: Platform Compliance table present

### Cross-References (SUM-22 to SUM-25)
- [ ] SUM-22: Risk Summary with at least 1 risk
- [ ] SUM-23: Artifact Index links all core artifacts
- [ ] SUM-24: Artifact status matches LIFECYCLE_STATE
- [ ] SUM-25: Gate status table complete

## Coverage Count Verification

Count from IVS.md:
- SEC-* requirements: (count)
- OBS-* requirements: (count)
- REL-* requirements: (count)

Verify SOLUTION_SUMMARY matches these counts.

Count from TEST_SCENARIOS.md:
- TS-HP-* (Happy Path): (count)
- TS-EC-* (Edge Cases): (count)
- TS-ERR-* (Error): (count)
- TS-SEC-* (Security): (count)
- TS-PERF-* (Performance): (count)
- TS-INT-* (Integration): (count)

Verify SOLUTION_SUMMARY matches these counts.

## Placeholder Detection

Flag as WARNING if these patterns found:
- "{Feature Name}" or similar placeholders
- "{TODO}" or "{TBD}"
- "{X}" or "{Y}" or "{Z}" in counts
- "{Name}" in Owner/Approver
- "YYYY-MM-DD" in dates

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "solution-summary",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "sections_present": 8,
    "sections_missing": 0,
    "coverage_accurate": true,
    "placeholders_found": 0,
    "cross_references_valid": true,
    ...
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Read SOLUTION_SUMMARY.md FIRST
2. Cross-reference with other artifacts for accuracy
3. Check ONLY SUM-* checks
4. Return ONLY JSON output
5. Placeholders are WARNING (not BLOCKING) to allow drafts
6. Coverage count mismatches are BLOCKING
```

## Cross-Reference Requirements

| SOLUTION_SUMMARY Section | Must Match |
|-------------------------|------------|
| Press Release Headline | PR_FAQ.md first announcement line |
| SEC-* count | IVS.md SEC-* requirement count |
| OBS-* count | IVS.md OBS-* requirement count |
| REL-* count | IVS.md REL-* requirement count |
| Test Scenario counts | TEST_SCENARIOS.md TS-* counts |
| TD-XX decisions | DESIGN.md Section 9 decisions |
| Risk items | DESIGN.md Section 13 risks |
| Phase/Status | LIFECYCLE_STATE.json current_phase |

## Why This Validation Matters

The Solution Summary exists to provide stakeholder confidence. If counts don't match or sections are incomplete:

1. **Stakeholders lose trust** - Inaccurate dashboards undermine confidence
2. **Coverage gaps hidden** - Wrong counts may hide missing requirements
3. **Stale information** - Out-of-sync data causes confusion
4. **Decision quality suffers** - Gate decisions based on bad data

This validator ensures the executive dashboard accurately reflects the feature state.
