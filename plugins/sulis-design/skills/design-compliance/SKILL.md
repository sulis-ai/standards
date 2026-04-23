# Design Compliance Skill

> **"Drift is silent. Detection is deliberate."**
>
> This skill scans consumer code against implementation-system primitives
> to detect design drift. First run establishes a baseline. Subsequent
> runs produce delta reports. Shared gate between design-lifecycle (design
> authority) and product-development (code owner).
>
> **Philosophy:** Compliance is not a one-time check — it is a continuous
> signal that the implementation reflects the design authority layer.

---

## Command Integration

This skill is invoked via `/sulis-design:design-compliance`:

```bash
/sulis-design:design-compliance                 # Run drift detection scan
/sulis-design:design-compliance baseline        # Force a fresh baseline
/sulis-design:design-compliance report          # View latest violation report
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "design compliance", "drift detection", "design drift"
- "token drift", "primitive compliance", "component API violations"
- "design audit", "implementation audit", "design system audit"
- "gotchas violations", "value canon violations"

### Broad Match (Discovery)
- drift, compliance, violations, design system health
- are we following the design system, token usage check

---

## Execution

### Outcome

Invoke `design-compliance` via the outcome-executor:

```
Outcome: design-compliance
Path: methodology/outcomes/utility/design-compliance/OUTCOME.md
```

### Prerequisites

| Input | Required | Source |
|-------|----------|--------|
| TOKEN_MAP.json | Yes | implementation-system adapter output |
| VALUE_CANON.json | Yes | implementation-system adapter output |
| COMPONENT_API manifests | Yes | implementation-system adapter output |
| GOTCHAS.index.json | Yes | implementation-system adapter output |
| Consumer code | Yes | `apps/web/src/` (or configured scan root) |

### Outputs

| Artifact | Location |
|----------|----------|
| VIOLATION_REPORT.md | `product/design/` |
| AUDIT_STATE.json | `.sulis/design-compliance/` |

### Shared Gate

design-compliance is co-owned by two studios:

| Studio | Invokes As | When |
|--------|-----------|------|
| design-lifecycle | Design authority | After implementation-system runs; when drift is suspected |
| product-development | Code owner | After frontend implementation; before production-quality gate |

The authority source is always design-lifecycle studio primitives, regardless of who invokes the scan.

### Re-baseline Mode

When invoked via design-evolve ring-1 cascade (after implementation-system emits a CHANGE_MANIFEST):
- Detects updated primitives via incoming CHANGE_MANIFEST at `.sulis/change-manifests/implementation-system.json`
- Re-runs scan against updated primitives
- Emits CHANGE_MANIFEST to `.sulis/change-manifests/design-compliance.json`
- Inherits `ring_context.propagation_id` from incoming implementation-system manifest

### Sequencing

```
implementation-system -> design-compliance
```

design-compliance requires implementation-system primitives to exist. On first run,
produces BASELINE_ESTABLISHED. On subsequent runs, produces COMPLIANT or VIOLATIONS_FOUND.

---

## View Mode

When invoked without a subcommand, run the full compliance scan and display results:

1. Confirm implementation-system primitives exist and are current (check recorded_checksums.json)
2. Run drift scan against consumer code
3. Display VIOLATION_REPORT.md summary (COMPLIANT / VIOLATIONS_FOUND / BASELINE_ESTABLISHED)
4. If violations found, list by category with file/line references
