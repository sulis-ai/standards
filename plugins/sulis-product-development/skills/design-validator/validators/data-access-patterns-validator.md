# Data Access Patterns Validator

> **Purpose:** Validate DESIGN.md Section 9.7 Data Access & Performance Patterns.
> **Check Prefix:** DACCESS-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/{scope}/DESIGN.md` - Per-scope technical design (backend scope only)
- `features/{feature}/DESIGN.md` - Root technical design (single-scope fallback)
- `features/{feature}/TEST_SCENARIOS.md` - Test scenarios (cross-reference for PERF tests)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification and scope metadata

**Reference:**
- `methodology/delivery/product/outcomes/solution-design/templates/DESIGN_TEMPLATE.md` Section 9.7

---

## Classification

**Applies to:** `service`, `service_extension`, `service_enhancement`, `extension` classifications.

**Skip for:** `infrastructure`, `bug_fix` classifications. Emit skip notice and PASS.

---

## Scope Handling

- **Multi-scope features:** Run all DACCESS-* checks against `backend/DESIGN.md` only. Section 9.7 is a backend concern. Tag findings with scope (e.g., `DACCESS-N1-01 [backend]`). Skip non-backend scopes.
- **Single-scope features:** Run against root `DESIGN.md`.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### DACCESS-SECTION-* (Section Presence)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-SECTION-01 | Section 9.7 "Data Access & Performance Patterns" present in DESIGN.md | BLOCKING |

### DACCESS-N1-* (N+1 Query Prevention)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-N1-01 | N+1 anti-patterns identified with wrong-way examples | BLOCKING |
| DACCESS-N1-02 | Correct patterns shown with right-way examples | BLOCKING |
| DACCESS-N1-03 | No queries inside loops documented as anti-pattern | BLOCKING |
| DACCESS-N1-04 | Batch methods (e.g., `get_batch`, `list_by_ids`) documented | BLOCKING |

### DACCESS-CACHE-* (Caching Strategy)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-CACHE-01 | Caching strategy documented (even if "no caching required") | BLOCKING |
| DACCESS-CACHE-02 | Cache keys include `platform_id` for tenant isolation | BLOCKING |
| DACCESS-CACHE-03 | TTLs defined per data type | WARNING |
| DACCESS-CACHE-04 | Cache invalidation on mutations documented | WARNING |

### DACCESS-QRY-* (Query Patterns)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-QRY-01 | Filters applied at database level (not in-memory) | BLOCKING |
| DACCESS-QRY-02 | Pagination for list operations documented | BLOCKING |
| DACCESS-QRY-03 | Repository Protocol with required methods defined | WARNING |

### DACCESS-METRICS-* (Query Observability)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-METRICS-01 | Query complexity limits defined | WARNING |
| DACCESS-METRICS-02 | Query count tracking documented | WARNING |

### DACCESS-TEST-* (Performance Testing)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-TEST-01 | Performance test scenarios (TS-PERF-*) referenced in TEST_SCENARIOS.md | BLOCKING |

### DACCESS-CHECKLIST-* (Completeness)

| ID | Check | Severity |
|----|-------|----------|
| DACCESS-CHECKLIST-01 | Section 9.7.7 "Data Access Checklist" present | BLOCKING |

---

## Validation Logic

### Classification Gate

```
IF classification NOT IN [service, service_extension, service_enhancement, extension]:
    SKIP all DACCESS-* checks
    RETURN PASS with skip notice
```

### Section 9.7 Detection

```
Search DESIGN.md for heading matching: ^## 9\.7[\.\s]
OR: ^### 9\.7[\.\s]
Must find substantive content beyond placeholder text.
```

### N+1 Pattern Verification (DACCESS-N1-*)

```
Search Section 9.7 for:
  - "N+1" OR "n+1" (general presence)
  - Anti-pattern markers: content near "wrong" or "anti-pattern" indicators (DACCESS-N1-01)
  - Correct-pattern markers: content near "correct" or "right" indicators (DACCESS-N1-02)
  - "loop" OR "for each" near "query" (DACCESS-N1-03)
  - "get_batch" OR "list_by_ids" OR "batch" method (DACCESS-N1-04)
```

### Caching Verification (DACCESS-CACHE-*)

```
Search Section 9.7 for:
  - "cach" (covers cache, caching, cached) (DACCESS-CACHE-01)
  - "platform_id" near "cache" OR "key" (DACCESS-CACHE-02)
  - "TTL" OR "time.to.live" OR "expir" (DACCESS-CACHE-03)
  - "invalidat" near "cache" (DACCESS-CACHE-04)
```

### Performance Test Cross-Reference (DACCESS-TEST-01)

```
IF TEST_SCENARIOS.md exists:
    Search for "TS-PERF-" pattern
    Verify at least one TS-PERF-* scenario exists
ELSE:
    FAIL DACCESS-TEST-01 with "TEST_SCENARIOS.md not found"
```

### Checklist Verification (DACCESS-CHECKLIST-01)

```
Search Section 9.7 for subsection matching: 9\.7\.7.*[Cc]hecklist
Verify section contains checklist items (lines matching: ^- \[[ x]\])
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "data-access-patterns",
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
| 1.0.0 | 2026-02-24 | Initial data access patterns validator. DACCESS-SECTION-01, DACCESS-N1-01 to DACCESS-N1-04, DACCESS-CACHE-01 to DACCESS-CACHE-04, DACCESS-QRY-01 to DACCESS-QRY-03, DACCESS-METRICS-01 to DACCESS-METRICS-02, DACCESS-TEST-01, DACCESS-CHECKLIST-01. Backend scope only. Classification-gated for service/extension types. |
