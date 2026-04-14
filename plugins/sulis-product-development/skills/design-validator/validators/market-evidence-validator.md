# Market Evidence Validator

> **Purpose:** Validate market evidence quality, source credibility, and Kano scope coverage.
> **Check Prefix:** MKT-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/MARKET_EVIDENCE.md` - Market evidence document
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and metadata

---

## Scope Handling

- **Multi-scope features:** MARKET_EVIDENCE.md is always at feature root (not per-scope). All MKT-* checks apply to the single root artifact.
- **Single-scope features:** Same behavior. MARKET_EVIDENCE.md at root.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. Scope does not affect MKT-* checks.

---

## Validation Checklist

### MKT-* (Artifact & Structure)

| ID | Check | Severity |
|----|-------|----------|
| MKT-01 | MARKET_EVIDENCE.md exists in feature root | BLOCKING |
| MKT-02 | Status field is `VALIDATED` (not `DRAFT` or `IN_PROGRESS`) | BLOCKING |

### MKT-* (Evidence Quality)

| ID | Check | Severity |
|----|-------|----------|
| MKT-03 | At least 3 evidence sources cited | BLOCKING |
| MKT-04 | Each source has credibility tier assigned (Tier 1-4) | WARNING |
| MKT-05 | Problem validation section populated with substantive content | BLOCKING |

### MKT-* (Coverage)

| ID | Check | Severity |
|----|-------|----------|
| MKT-06 | Market sizing or opportunity section populated | WARNING |
| MKT-07 | Kano classification documented (if applicable to feature type) | WARNING |
| MKT-08 | Competitive landscape section populated | WARNING |

---

## Validation Logic

### MKT-02: Status Check

```
Read MARKET_EVIDENCE.md header (first 20 lines).
Search for line matching: Status: {value}
IF value != "VALIDATED":
    FAIL "Status is '{value}', expected 'VALIDATED'"
```

### MKT-03: Source Count

```
Count distinct evidence sources in MARKET_EVIDENCE.md.
Sources identified by:
  - Harvard-style citations (Author, Year)
  - Numbered references section
  - Inline URL citations
IF count < 3:
    FAIL "Only {count} evidence sources found, minimum 3 required"
```

### MKT-04: Credibility Tiers

```
FOR EACH source identified in MKT-03:
    Search for "Tier [1-4]" annotation near source reference
    IF no tier found:
        WARN "Source '{source}' missing credibility tier"
```

### MKT-05: Problem Validation

```
Search for section heading matching "Problem" (case-insensitive).
IF section missing OR content < 3 non-blank lines:
    FAIL "Problem validation section missing or insufficient"
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "market-evidence",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 8,
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
| 1.0.0 | 2026-02-24 | Initial market evidence validator. MKT-01 to MKT-08. Source credibility tier validation. Problem validation and Kano coverage checks. |
