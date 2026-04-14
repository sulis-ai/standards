# Market Evidence Validator

> **Focus:** Validates MARKET_EVIDENCE.md exists and PR_FAQ.md references it.
> **Checks:** ART-00*, KANO-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures the feature has validated market evidence before proceeding. This prevents building solutions for imaginary problems.

## Files to Read

1. `features/{feature}/MARKET_EVIDENCE.md`
2. `features/{feature}/PR_FAQ.md`
3. `features/{feature}/DESIGN.md` (for Kano scope validation)

## Validation Checks

### Artifact Existence (ART-00*)

| Check ID | Check | Severity |
|----------|-------|----------|
| ART-00 | MARKET_EVIDENCE.md exists | BLOCKING |
| ART-00a | Has "Problem Validation Status" section with VALIDATED/WEAK_APPROVED/OVERRIDE | BLOCKING |
| ART-00b | If VALIDATED: has 5+ independent community sources | BLOCKING |
| ART-00c | PR_FAQ.md has "Market Evidence" section referencing findings | BLOCKING |
| ART-00d | PR_FAQ.md has "Market Context" section | BLOCKING |

### Kano Scope Validation (KANO-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| KANO-01 | MARKET_EVIDENCE.md has "Launch Scope Analysis" section | BLOCKING |
| KANO-02 | Must-Be items are identified with evidence | BLOCKING |
| KANO-03 | ALL Must-Be items appear in DESIGN.md scope | BLOCKING |
| KANO-04 | ALL Performance items appear in DESIGN.md scope | BLOCKING |
| KANO-05 | ALL Delighter items appear in DESIGN.md scope | BLOCKING |
| KANO-06 | "Scope Validation Summary" section completed | BLOCKING |
| KANO-07 | If Kano gaps exist, "Scope Change Requirements" documents additions | BLOCKING |
| KANO-08 | Indifferent items are NOT in scope | WARNING |

## Validation Process

### Step 1: Check MARKET_EVIDENCE.md Exists

```
Read: features/{feature}/MARKET_EVIDENCE.md
If file not found → ART-00 FAIL (BLOCKING)
```

### Step 2: Validate Problem Status

```
Search for: "Problem Validation Status" or "Validation Status"
Valid values: VALIDATED, WEAK_APPROVED, OVERRIDE
If not found or invalid → ART-00a FAIL
```

### Step 3: Count Sources (if VALIDATED)

```
If status == VALIDATED:
  Count sections with community sources (Stack Overflow, GitHub, Reddit, etc.)
  If count < 5 → ART-00b FAIL
```

### Step 4: Check PR_FAQ Integration

```
Read: features/{feature}/PR_FAQ.md
Search for: "## Market Evidence" section
If not found → ART-00c FAIL

Search for: "## Market Context" or "### Market Context"
If not found → ART-00d FAIL
```

### Step 5: Kano Scope Validation

```
Read: MARKET_EVIDENCE.md "Launch Scope Analysis" section
Extract: Must-Be items, Performance items, Delighter items

Read: DESIGN.md
For each Kano item:
  Search for item in DESIGN.md (Section 5 Scope, Section 7 Solution)
  If not found → KANO-03/04/05 FAIL depending on category
```

## Agent Prompt

```
You are the Market Evidence Validator - a focused validator that checks ONLY market evidence and Kano scope compliance.

## Your Task

Validate market evidence for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/MARKET_EVIDENCE.md
2. features/{feature_name}/PR_FAQ.md
3. features/{feature_name}/DESIGN.md

## Validation Checklist

### ART-00*: Market Evidence Existence
- [ ] ART-00: MARKET_EVIDENCE.md exists
- [ ] ART-00a: Has validation status (VALIDATED/WEAK_APPROVED/OVERRIDE)
- [ ] ART-00b: If VALIDATED, has 5+ independent sources
- [ ] ART-00c: PR_FAQ.md has "Market Evidence" section
- [ ] ART-00d: PR_FAQ.md has "Market Context" section

### KANO-*: Kano Scope Validation
- [ ] KANO-01: "Launch Scope Analysis" section exists in MARKET_EVIDENCE.md
- [ ] KANO-02: Must-Be items identified with evidence
- [ ] KANO-03: ALL Must-Be items in DESIGN.md scope
- [ ] KANO-04: ALL Performance items in DESIGN.md scope
- [ ] KANO-05: ALL Delighter items in DESIGN.md scope
- [ ] KANO-06: "Scope Validation Summary" completed
- [ ] KANO-07: Kano gaps documented if any
- [ ] KANO-08: Indifferent items NOT in scope (WARNING only)

## Output Format

You MUST return a JSON object following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "market-evidence",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601 timestamp}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 13,
    "checks_passed": X,
    "checks_failed": X,
    "checks_skipped": X,
    "blocking_issues": X,
    "warning_issues": X
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Read ONLY the files listed above
2. Check ONLY the ART-00* and KANO-* checks listed
3. Return ONLY the JSON output - no other text
4. Be thorough but focused
5. If a file doesn't exist, mark relevant checks as FAIL
```
