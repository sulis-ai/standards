# Artifact Presence Validator

> **Purpose:** Verify all required design artifacts exist for the feature.
> **Check Prefix:** ART-*

## Files to Read

**Feature Directory:**
- `features/{feature}/` - Directory listing for artifact presence
- `features/{feature}/LIFECYCLE_STATE.json` - Scope and classification metadata

**Scope Directories (multi-scope):**
- `features/{feature}/{scope}/` - Per-scope directory listing

---

## Scope Handling

- **Multi-scope features:** ART-04 and ART-05 are checked per scope directory (e.g., `backend/DESIGN.md`, `frontend-web/IVS.md`). All other artifacts are checked at root.
- **Single-scope features:** All artifacts checked at feature root. No scope subdirectories expected.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` -> `scopes.resolved` array. If absent, default to single-scope at root.

---

## Validation Checklist

### ART-* (Core Artifacts)

| ID | Check | When | Severity |
|----|-------|------|----------|
| ART-01 | PR_FAQ.md exists in feature root | Always | BLOCKING |
| ART-02 | USER_GUIDE.md exists in feature root | Always | BLOCKING |
| ART-03 | TEST_SCENARIOS.md exists in feature root | Always | BLOCKING |
| ART-04 | DESIGN.md exists per scope | Always | BLOCKING |
| ART-05 | IVS.md exists per scope | Always | BLOCKING |
| ART-06 | NFR.md exists in feature root | Always | BLOCKING |
| ART-07 | ONTOLOGY.jsonld exists in feature root | Always | BLOCKING |
| ART-08 | TRACEABILITY.jsonld exists in feature root | Always | BLOCKING |
| ART-09 | SOLUTION_SUMMARY.md exists in feature root | Always | BLOCKING |
| ART-10 | MARKET_EVIDENCE.md exists in feature root | Always | BLOCKING |
| ART-11 | LIFECYCLE_STATE.json exists in feature root | Always | BLOCKING |

### ART-* (Conditional Artifacts)

| ID | Check | When | Severity |
|----|-------|------|----------|
| ART-12 | UX_PROTOTYPE.md exists in `frontend-web/` | `frontend-web` in scopes | BLOCKING |
| ART-13 | ENTITY_MODEL_DELTA.md exists in `backend/` or root | Feature adds entities AND `backend` in scopes | BLOCKING |
| ART-14 | COMPONENT_SPEC.md exists in `frontend-web/` | `frontend-web` in scopes | BLOCKING |

---

## Validation Logic

### ART-04 / ART-05 Scope Resolution

```
IF LIFECYCLE_STATE.json → scopes.multi_scope == true:
    FOR EACH scope IN scopes.resolved:
        CHECK {scope}/DESIGN.md exists
        CHECK {scope}/IVS.md exists
ELSE:
    CHECK DESIGN.md exists at root
    CHECK IVS.md exists at root
```

### ART-12 / ART-13 / ART-14 Conditional Logic

```
IF "frontend-web" IN scopes.resolved:
    CHECK frontend-web/UX_PROTOTYPE.md exists        → ART-12
    CHECK frontend-web/COMPONENT_SPEC.md exists       → ART-14

IF "backend" IN scopes.resolved:
    IF DESIGN.md mentions new entities:
        CHECK backend/ENTITY_MODEL_DELTA.md exists    → ART-13
        OR CHECK root ENTITY_MODEL_DELTA.md exists    → ART-13
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "artifact-presence",
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
| 1.0.0 | 2026-02-24 | Initial artifact presence validator. ART-01 to ART-14. Scope-aware checking for DESIGN.md and IVS.md. Conditional artifacts for frontend-web and backend scopes. |
