# Design Coherence Skill

> **"Individually correct is not collectively coherent."**
>
> This skill runs pairwise coherence verification across design artifacts
> produced by different outcomes. Each check is mechanistic -- PASS/FAIL
> with no subjective interpretation.
>
> **Philosophy:** Design coherence is a verification discipline, not a
> design activity. It happens after creation, not during.

---

## Command Integration

This skill is invoked via `/sulis design-coherence`:

```bash
/sulis design-coherence                     # Run full coherence check
/sulis design-coherence --pair tokens-brand  # Run specific pairwise check
/sulis design-coherence report              # View latest coherence report
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "design coherence", "coherence check", "coherence verification"
- "cross-outcome check", "pairwise verification"
- "design consistency", "artifact consistency"

### Broad Match (Discovery)
- coherence, consistency, alignment, verification
- cross-check, pairwise, COH

---

## Execution

### Outcome

Invoke `design-coherence` via the outcome-executor:

```
Outcome: design-coherence
Path: methodology/delivery/design/outcomes/design-coherence/OUTCOME.md
```

### Prerequisites

At least 2 of the following must exist (coherence requires artifact pairs):

| Input | Required | Source |
|-------|----------|--------|
| DESIGN_TOKENS.json | Conditional | `product/design/DESIGN_TOKENS.json` |
| DESIGN_LANGUAGE.md | Conditional | `product/design/DESIGN_LANGUAGE.md` |
| BRAND.md | Conditional | `product/organization/BRAND.md` |
| USAGE_GUIDELINES.md | Conditional | `product/design/USAGE_GUIDELINES.md` |
| CUSTOMER_EXPERIENCE.md | Conditional | `product/offerings/primary/CUSTOMER_EXPERIENCE.md` |
| HIG.md | Conditional | `product/design/HIG.md` |

### Outputs

| Artifact | Location |
|----------|----------|
| COHERENCE_REPORT.md | `product/design/COHERENCE_REPORT.md` |

### Pairwise Checks (DS-05)

| Check | Artifact Pair | Pass Criterion |
|-------|---------------|----------------|
| COH-01 | BRAND.md <-> DESIGN_TOKENS.json | Every brand colour has a semantic token |
| COH-02 | DESIGN_LANGUAGE.md <-> CUSTOMER_EXPERIENCE.md | Every named interaction pattern is defined |
| COH-03 | DESIGN_TOKENS.json <-> DESIGN_LANGUAGE.md | Every referenced token category exists |
| COH-04 | BRAND.md <-> USAGE_GUIDELINES.md | Every brand element has usage guidance |

### Sequencing

Design coherence is the terminal node in the design dependency chain:

```
visual-identity + customer-experience-design -> design-coherence
```

Both visual-identity and customer-experience-design should complete before coherence runs, though partial checks are valid when only some artifacts exist.

---

## View Mode

When invoked without a subcommand, run the full coherence check and display results.
