# IVS Validator

> **Purpose:** Validate IVS.md requirements structure and verification specs.
> **Check Prefix:** IVS-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/IVS.md` - Root IVS (single-scope or cross-scope requirements)
- `features/{feature}/{scope}/IVS.md` - Per-scope IVS (multi-scope features)
- `features/{feature}/LIFECYCLE_STATE.json` - Scope and classification metadata
- `features/{feature}/{scope}/DESIGN.md` - Technical design (cross-reference)
- `features/{feature}/DESIGN.md` - Root technical design (single-scope fallback)

**Reference:**
- `methodology/delivery/product/STANDARDS.md` - Product standards and IVS category definitions

---

## Scope Handling

- **Multi-scope features:** IVS-05, IVS-06, IVS-07 enforce scope-category partitioning. Backend IVS must contain SEC-*/OBS-*/REL-*/ARC-* only. Frontend IVS must contain ACC-*/PERF-*/COMPAT-*/USAB-* only. Root IVS holds cross-scope requirements only.
- **Single-scope features:** IVS-08 enforces all applicable categories in a single flat IVS.md at root.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent or `multi_scope` is false, default to single-scope at root.

---

## Validation Checklist

### IVS-* (Structure)

| ID | Check | Severity |
|----|-------|----------|
| IVS-01 | IVS.md exists (per scope for multi-scope, root for single-scope) | BLOCKING |
| IVS-02 | Each requirement has valid category prefix (SEC/OBS/REL/ACC/ARC/PERF/COMPAT/USAB) | BLOCKING |
| IVS-03 | Requirement IDs sequential per category (e.g., SEC-01, SEC-02, SEC-03) | WARNING |
| IVS-04 | Each requirement has title and description | BLOCKING |

### IVS-* (Multi-Scope Partitioning)

| ID | Check | When | Severity |
|----|-------|------|----------|
| IVS-05 | `backend/IVS.md` contains SEC-*/OBS-*/REL-*/ARC-* only | Multi-scope with backend | BLOCKING |
| IVS-06 | `frontend-web/IVS.md` contains ACC-*/PERF-*/COMPAT-*/USAB-* only | Multi-scope with frontend-web | BLOCKING |
| IVS-07 | Root IVS.md contains cross-scope requirements only | Multi-scope | BLOCKING |
| IVS-08 | All applicable categories present in flat IVS.md | Single-scope | BLOCKING |

### IVS-* (Coverage)

| ID | Check | Severity |
|----|-------|----------|
| IVS-09 | At least one requirement per applicable category | BLOCKING |
| IVS-10 | No duplicate requirement IDs across all IVS files | BLOCKING |

### IVS-* (Quality)

| ID | Check | Severity |
|----|-------|----------|
| IVS-11 | Each requirement has verification method (test, inspection, analysis) | WARNING |
| IVS-12 | Backend IVS includes ARC-* requirements (Ports & Adapters) | BLOCKING |
| IVS-13 | Frontend IVS includes ACC-*, PERF-*, COMPAT-*, USAB-* requirements | BLOCKING |
| IVS-14 | Cross-scope requirements pass 3-criteria entry test | WARNING |

---

## Validation Logic

### IVS-01: Existence Check

```
IF LIFECYCLE_STATE.json -> scopes.multi_scope == true:
    FOR EACH scope IN scopes.resolved:
        CHECK {scope}/IVS.md exists
    CHECK root IVS.md exists (for cross-scope)
ELSE:
    CHECK root IVS.md exists
```

### IVS-02: Category Prefix Validation

```
VALID_PREFIXES = [SEC, OBS, REL, ACC, ARC, PERF, COMPAT, USAB]

FOR EACH requirement ID found (pattern: ^[A-Z]+-\d+):
    Extract prefix (everything before the hyphen-number)
    IF prefix NOT IN VALID_PREFIXES:
        FAIL IVS-02 with "Invalid category prefix: {prefix}"
```

### IVS-03: Sequential ID Check

```
FOR EACH category prefix:
    Collect all IDs for that prefix across all IVS files
    Sort numerically
    Verify no gaps in sequence (01, 02, 03... not 01, 03, 05)
    WARN on gaps
```

### IVS-05 / IVS-06: Scope-Category Partitioning

```
BACKEND_CATEGORIES = [SEC, OBS, REL, ARC]
FRONTEND_CATEGORIES = [ACC, PERF, COMPAT, USAB]

IF multi_scope:
    IF "backend" IN scopes.resolved:
        FOR EACH requirement in backend/IVS.md:
            IF prefix NOT IN BACKEND_CATEGORIES:
                FAIL IVS-05 with "{prefix}-{id} in backend/ but belongs in frontend scope"

    IF "frontend-web" IN scopes.resolved:
        FOR EACH requirement in frontend-web/IVS.md:
            IF prefix NOT IN FRONTEND_CATEGORIES:
                FAIL IVS-06 with "{prefix}-{id} in frontend-web/ but belongs in backend scope"
```

### IVS-07: Cross-Scope Entry Test

```
IF multi_scope AND root IVS.md exists:
    FOR EACH requirement in root IVS.md:
        IF prefix IN BACKEND_CATEGORIES OR prefix IN FRONTEND_CATEGORIES:
            FAIL IVS-07 with "{prefix}-{id} in root but should be in scope directory"
```

### IVS-09: Category Coverage

```
IF single_scope OR "backend" IN scopes:
    Verify at least one SEC-*, OBS-*, REL-*, ARC-* exists
IF single_scope OR "frontend-web" IN scopes:
    Verify at least one ACC-*, PERF-*, COMPAT-*, USAB-* exists
```

### IVS-10: Duplicate Detection

```
Collect ALL requirement IDs across ALL IVS files (root + scope directories)
Check for duplicates
FAIL on any duplicate with locations of both occurrences
```

### IVS-14: Cross-Scope 3-Criteria Entry Test

```
FOR EACH requirement in root IVS.md (multi-scope only):
    Verify requirement description indicates:
      1. Verifiable chain spanning 2+ scopes
      2. Both scopes must be verified together
      3. Cannot decompose into single-scope requirements
    WARN if criteria not clearly documented
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "ivs",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 14,
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
| 1.0.0 | 2026-02-24 | Initial IVS validator. IVS-01 to IVS-14. Scope-category partitioning enforcement (backend: SEC/OBS/REL/ARC, frontend: ACC/PERF/COMPAT/USAB). Cross-scope 3-criteria entry test. Duplicate detection across all IVS files. |
