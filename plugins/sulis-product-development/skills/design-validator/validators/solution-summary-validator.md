# Solution Summary Validator

> **Purpose:** Validate SOLUTION_SUMMARY.md completeness.
> **Check Prefix:** SUM-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/SOLUTION_SUMMARY.md` - Executive dashboard
- `features/{feature}/PR_FAQ.md` - Press release (cross-reference)
- `features/{feature}/DESIGN.md` - Technical design (cross-reference, single-scope)
- `features/{feature}/{scope}/DESIGN.md` - Technical design (cross-reference, multi-scope)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

**Reference:**
- `methodology/delivery/product/outcomes/solution-design/templates/SOLUTION_SUMMARY_TEMPLATE.md`

---

## Scope Handling

- **Multi-scope and single-scope features:** SOLUTION_SUMMARY.md is always at the feature root. It is a cross-cutting artifact that summarises all scopes.
- **No per-scope variants.** All SUM-* checks apply to the single root file.

---

## Validation Checklist

### SUM-META-* (Metadata)

| ID | Check | Severity |
|----|-------|----------|
| SUM-META-01 | Status field populated (e.g., Draft, Review, Approved) | BLOCKING |
| SUM-META-02 | Phase field populated (e.g., Design, Planning, Implementation) | BLOCKING |
| SUM-META-03 | Classification field populated (e.g., service, extension) | BLOCKING |

### SUM-EXEC-* (Executive Summary)

| ID | Check | Severity |
|----|-------|----------|
| SUM-EXEC-01 | Press Release Headline present | BLOCKING |
| SUM-EXEC-02 | Summary present (2-3 sentences of substantive content) | BLOCKING |
| SUM-EXEC-03 | Business Impact table with 2+ metrics | BLOCKING |

### SUM-OVERVIEW-* (Solution Overview)

| ID | Check | Severity |
|----|-------|----------|
| SUM-OVERVIEW-01 | Problem-to-Solution table present | BLOCKING |
| SUM-OVERVIEW-02 | Architecture Snapshot diagram (mermaid block) | WARNING |

### SUM-DECISIONS-* (Key Decisions)

| ID | Check | Severity |
|----|-------|----------|
| SUM-DECISIONS-01 | 3+ key decisions documented | BLOCKING |

### SUM-COVERAGE-* (Coverage Tables)

| ID | Check | Severity |
|----|-------|----------|
| SUM-COVERAGE-01 | Requirements Coverage table present | BLOCKING |
| SUM-COVERAGE-02 | Test Scenario Coverage table present | BLOCKING |
| SUM-COVERAGE-03 | Platform Compliance table present | BLOCKING |

### SUM-RISK-* (Risk Assessment)

| ID | Check | Severity |
|----|-------|----------|
| SUM-RISK-01 | 3+ risks documented | BLOCKING |

### SUM-ARTIFACTS-* (Artifact Index)

| ID | Check | Severity |
|----|-------|----------|
| SUM-ARTIFACTS-01 | Artifact index with links to design artifacts | BLOCKING |

### SUM-APPROVAL-* (Gate Status)

| ID | Check | Severity |
|----|-------|----------|
| SUM-APPROVAL-01 | Gate status table present (GATE 1 through GATE 4) | BLOCKING |

### SUM-NAV-* (Navigation)

| ID | Check | Severity |
|----|-------|----------|
| SUM-NAV-01 | Navigation table present (links to related artifacts) | WARNING |

---

## Validation Logic

### SUM-META-* Verification

```
Search SOLUTION_SUMMARY.md header area (first 30 lines) for:
  - "Status:" followed by non-empty value (SUM-META-01)
  - "Phase:" followed by non-empty value (SUM-META-02)
  - "Classification:" followed by non-empty value (SUM-META-03)
```

### SUM-EXEC-* Verification

```
Search for Executive Summary section:
  - Heading containing "Press Release" or "Headline" (SUM-EXEC-01)
  - Summary paragraph with 2+ sentences (SUM-EXEC-02)
  - Table with "Impact" or "Metric" column containing 2+ data rows (SUM-EXEC-03)
```

### SUM-OVERVIEW-01 Verification

```
Search for table containing both "Problem" and "Solution" column headers
OR: Table with rows mapping problems to solutions
```

### SUM-OVERVIEW-02 Verification

```
Search for mermaid code block (```mermaid)
WARN if absent (architecture snapshot is recommended but not blocking)
```

### SUM-DECISIONS-01 Verification

```
Search for "Decision" section heading
Count decision entries (numbered items, table rows, or headed subsections)
Verify count >= 3
```

### SUM-COVERAGE-* Verification

```
Search for tables containing:
  - "Requirement" column header (SUM-COVERAGE-01)
  - "Test" or "Scenario" column header (SUM-COVERAGE-02)
  - "Platform" or "Compliance" column header (SUM-COVERAGE-03)
Each must have at least one data row.
```

### SUM-RISK-01 Verification

```
Search for "Risk" section heading
Count risk entries (numbered items, table rows, or headed subsections)
Verify count >= 3
```

### SUM-ARTIFACTS-01 Verification

```
Search for "Artifact" section heading
Verify section contains markdown links (pattern: \[.*\]\(.*\))
Verify at least 3 linked artifacts
```

### SUM-APPROVAL-01 Verification

```
Search for "Gate" section heading
Verify table contains rows for GATE 1 through GATE 4
OR: Verify at least 4 gate entries with status indicators
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "solution-summary",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 16,
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
| 1.0.0 | 2026-02-24 | Initial solution summary validator. SUM-META-01 to SUM-META-03, SUM-EXEC-01 to SUM-EXEC-03, SUM-OVERVIEW-01 to SUM-OVERVIEW-02, SUM-DECISIONS-01, SUM-COVERAGE-01 to SUM-COVERAGE-03, SUM-RISK-01, SUM-ARTIFACTS-01, SUM-APPROVAL-01, SUM-NAV-01. Root-only artifact, no per-scope variants. |
