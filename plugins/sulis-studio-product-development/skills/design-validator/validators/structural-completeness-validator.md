# Structural Completeness Validator

> **Purpose:** Verify DESIGN.md contains all sections required by the feature's classification per DESIGN_TEMPLATE.md.
> **Check IDs:** STRUCT-01 to STRUCT-10
> **Template Version:** 3.0.0
> **ADR:** ADR-084 (solution-design-enforcement)

---

## Co-Evolution Constraint

**Any change to DESIGN_TEMPLATE.md section structure MUST include a corresponding update to this validator.** Both files MUST declare a shared template version. See ADR-084 binding condition.

---

## Scope Handling

- **Multi-scope features:** Run all STRUCT-* checks against each `{scope}/DESIGN.md` independently. Tag findings with scope (e.g., `STRUCT-02 [backend]: Missing Section 6`).
- **Single-scope features:** Run against root `DESIGN.md`. No scope tagging needed.
- **Scope discovery:** Read `LIFECYCLE_STATE.json` → `scopes.resolved` array. If absent, default to single-scope at root.

---

## Classification-Based Requirements

Reference: `templates/DESIGN_TEMPLATE.md` Classification-Based Requirements table.

| Classification | Required Sections |
|----------------|-------------------|
| **service** | ALL (0-16) |
| **service_extension** | ALL (0-16) |
| **service_enhancement** | 0, 1, 7, 9.6, 9.7, 10-16 |
| **infrastructure** | 1, 7, 9, 10-16 |
| **bug_fix** | 1, 7, 12, 13 |
| **capability** | ALL (0-16) — default to most restrictive for unlisted classifications |
| **extension** | ALL (0-16) — default to most restrictive for unlisted classifications |

**If classification is not in this table:** Treat as `service` (most restrictive). Emit STRUCT-01 WARNING about unknown classification.

---

## Checks

### STRUCT-01: Classification Identified

**Severity:** BLOCKING
**Mechanism:** Read `LIFECYCLE_STATE.json`. Verify `classification` field exists and contains a known value from the table above.
**Failure:** "LIFECYCLE_STATE.json missing or has no classification field."

### STRUCT-02: Required Sections Present Per Classification

**Severity:** BLOCKING
**Mechanism:**
1. Determine required sections from the classification table above.
2. Read the DESIGN.md under review.
3. For each required section, search for a heading matching the number-prefix regex pattern: `^## \d+\.?\d*\.?\s` (e.g., `## 4.`, `## 7.2`, `## 12.`).
4. Report each missing required section.

**Failure:** "DESIGN.md missing required section §{N}: {Section Name} (required for {classification} classification)."

### STRUCT-03: No Empty Required Sections

**Severity:** BLOCKING
**Mechanism:** For each required section found by STRUCT-02, verify it contains substantive content beyond the template placeholder text. A section with only the template's placeholder comment (e.g., `<!-- Description -->`) or fewer than 2 non-blank lines of content (excluding the heading) is considered empty.
**Failure:** "Section §{N} exists but contains no substantive content."

### STRUCT-04: Optional Sections Have "N/A" or Content

**Severity:** WARNING
**Mechanism:** For sections that are NOT required for this classification but ARE present in the DESIGN.md, verify they contain either:
- Content (more than placeholder), OR
- An explicit "N/A - {reason}" declaration
**Failure:** "Optional section §{N} is present but empty without N/A declaration."

### STRUCT-05: Template Version Declared

**Severity:** WARNING
**Mechanism:** Search DESIGN.md header area (first 30 lines) for a line matching `Template Version: \d+\.\d+\.\d+`. If found, compare against this validator's declared template version (3.0.0). Emit WARNING on mismatch.
**Failure:** "No Template Version declared in DESIGN.md header." or "Template Version mismatch: DESIGN.md declares {X}, validator expects 3.0.0."

### STRUCT-06: Scope Field Present (Multi-Scope Only)

**Severity:** BLOCKING (multi-scope only; skip for single-scope)
**Mechanism:** For multi-scope features, verify DESIGN.md header contains `Scope: {scope}` where `{scope}` matches the directory name containing this DESIGN.md.
**Failure:** "Multi-scope DESIGN.md missing Scope field." or "Scope field '{declared}' does not match directory '{actual}'."

### STRUCT-07: Threat Model Present (§4.6)

**Severity:** BLOCKING
**Applies to:** `service`, `service_extension`, `capability`, `extension` classifications only. Skip for `service_enhancement`, `infrastructure`, `bug_fix`.
**Mechanism:** Verify Section 4.6 exists AND contains:
- A STRIDE analysis table (search for "STRIDE" or table with columns matching Spoofing/Tampering/Repudiation/Information Disclosure/Denial of Service/Elevation of Privilege)
- Trust boundaries (search for "trust boundar" case-insensitive)
**Failure:** "Section §4.6 Threat Model missing or incomplete (requires STRIDE table + trust boundaries)."

### STRUCT-08: Use Cases Present (§6)

**Severity:** BLOCKING
**Applies to:** `service`, `service_extension`, `capability`, `extension` classifications only. Skip for `service_enhancement`, `infrastructure`, `bug_fix`.
**Mechanism:** Verify Section 6 exists AND contains at least one use case identifier matching pattern `UC-\d+`.
**Failure:** "Section §6 Use Cases missing or contains no UC-XX definitions."

### STRUCT-09: Architecture Diagrams Present (§7.2-7.7)

**Severity:** BLOCKING
**Applies to:** `service`, `service_extension`, `capability`, `extension` classifications only. For `infrastructure` and `service_enhancement`, only §7 (Solution Design overview) is required — subsection diagrams are optional.
**Mechanism:** Verify Section 7 contains at least one mermaid code block (` ```mermaid `). For full-section classifications, verify subsections 7.2 through 7.5 each have content.
**Failure:** "Section §7 Solution Design missing architecture diagrams (requires mermaid blocks)."

### STRUCT-10: State Machine Present (§7.7)

**Severity:** WARNING (upgrades to BLOCKING only if Section 8.1 Entity Lifecycle declares lifecycle states)
**Applies to:** `service`, `service_extension` classifications when entities have lifecycle states.
**Mechanism:**
1. Check if Section 8.1 (Entity Lifecycle) contains lifecycle state definitions (non-empty, non-N/A content).
2. If yes: verify Section 7.7 contains a `stateDiagram` mermaid block. Severity = BLOCKING.
3. If no (entities are stateless or Section 8.1 is N/A): Severity = WARNING only.
**Failure:** "Section §7.7 State Machine missing but Section §8.1 declares entity lifecycle states."

---

## Output Format

```
STRUCTURAL COMPLETENESS VALIDATION
===================================
Feature: {feature_name}
Classification: {classification}
Template Version: 3.0.0
Scope: {scope} (or "root" for single-scope)

CHECKS:
[PASS] STRUCT-01: Classification identified ({classification})
[PASS] STRUCT-02: All {N} required sections present
[FAIL] STRUCT-03: Section §4.6 empty (no substantive content)
[WARN] STRUCT-05: Template version mismatch (DESIGN declares 2.0.0)
...

RESULT: {PASS | FAIL}
Blocking failures: {count}
Warnings: {count}
```

---

## Version

| Version | Date | Template Version | Changes |
|---------|------|-----------------|---------|
| 1.0.0 | 2026-02-24 | 3.0.0 | Initial creation. STRUCT-01 to STRUCT-10. Classification-gated enforcement. Number-prefix regex matching. ADR-084. |
