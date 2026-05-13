---
name: blueprint
description: >
  Use when the user has an SRD specification (typically at
  .specifications/{project}/) and needs a hardened Technical Design Document
  (TDD) plus Architecture Decision Records. Greenfield workflow — parses SRD,
  NFR, and PRIMITIVE_TREE outputs and synthesises a TDD that addresses all
  three MECE-3 pillars (Form, Armor, Proof). Produces .architecture/{project}/
  TDD.md and one ADR per non-trivial decision.
---

# Blueprint — Greenfield Technical Design

When invoked, produce a Technical Design Document and supporting ADRs for a
project, driven by the upstream SRD specification.

If arguments are provided, treat them as the path to the spec folder (e.g.
`/sea:blueprint .specifications/payments-service`). If no path is provided,
use the most recently modified folder in `.specifications/`.

If no SRD specification exists, stop and tell the user — refer them to
`srd:requirements-analyst`. **Do not invent requirements.**

---

## Inputs You Read

| File | Why |
|---|---|
| `SRD.md` | Functional requirements, use cases, business rules, per-use-case Negative Requirements → Form pillar (and seeds Armor) |
| `NFR.md` | Non-functional requirements → drives Armor pillar + pattern selection |
| `MISUSE_CASES.md` (SRD v1.11.0+) | Abuse cases, misuse flows, **System Response (REQUIRED)** for each → seeds Armor primitives (rate limits, audit logging, replay protection, integrity guards) and shapes the TDD's security boundary |
| `PRIMITIVE_TREE.jsonld` | Structural decomposition of building blocks → component inventory |
| `GLOSSARY.md` | Locked vocabulary from SRD Phase 3.5 Disambiguation Sweep — use preferred terms exactly in the TDD and ADRs |
| `diagrams/*.md` | Sequence, process, data-flow diagrams → integration design |
| `EXPLORATION_JOURNAL.md` `## Deferred to SEA` (if present) | Architecture-and-implementation content parked by SRD mid-session — treat as additional design intent from the user |
| `HANDOVER.md` (if present) | Suggested implementation sequence → may inform WP ordering |
| `HANDOFF_TO_SEA.md` (if present, instead of SRD.md) | SRD took the Early Handover path — user arrived with predominantly technical content. Read it as the sole upstream context; fill business-intent gaps by asking the user, not by inventing. |

Read all of them. If any are missing, list them and ask the user how to
proceed before writing anything.

**MISUSE_CASES.md is required reading when present.** Each MUC's System Response
becomes Armor input. Skipping it means you write a TDD that addresses the happy
path but not the adversarial path SRD already specified.

---

## Outputs You Write

```
.architecture/{project}/
├── ARCH.yaml
├── TDD.md
└── adrs/
    ├── ADR-001-{slug}.md
    └── ...
```

### `ARCH.yaml`

```yaml
id: ARCH-001
title: Payments Service Architecture
status: designed                 # draft | designed | decomposed | implemented | verified
sourced_from: ../../.specifications/payments-service/SPEC.yaml
created: 2026-05-12
pillars:
  form: covered
  armor: covered
  proof: covered
```

### `TDD.md` — Required Sections

The TDD has a fixed structure. Each section maps to MECE-3 pillars. See
`references/tdd-template.md` for the full template; the headline structure is:

1. **Overview** — one-paragraph summary of what is being designed and why.
2. **Source Specification** — link to `SRD.md`, `NFR.md`, key requirements.
3. **Form — Structural Design**
   - Component inventory (from `PRIMITIVE_TREE.jsonld`)
   - Module boundaries and dependency graph
   - Ports (interfaces in the domain)
   - Adapters (implementations in infrastructure)
   - Composition root layout
4. **Armor — Operational Hardening**
   - External dependency table — every cross-process call lists timeout, retry policy, circuit-breaker config
   - Security boundary — what's authenticated, authorised, encrypted (mTLS, TLS, at-rest)
   - Secrets — where they live, how they rotate
   - Observability — trace coverage, log structure, metrics (RED per operation, USE per resource)
5. **Proof — Verification Protocol**
   - Contract tests per port
   - Integration tests against real adapters (testcontainers, ephemeral DBs)
   - Chaos assertions per resiliency primitive
6. **Trade-offs** — patterns chosen, alternatives rejected, with one-line reasons
7. **Open questions** — anything the SRD does not specify that the architecture needs

### ADRs

Emit one ADR per non-trivial decision. "Non-trivial" means: the decision
affects more than one component, locks in a technology choice, or rejects
a viable alternative.

ADR file format:

```markdown
---
id: ADR-001
title: Use PostgreSQL with logical replication for the order store
status: accepted              # proposed | accepted | superseded
date: 2026-05-12
deciders: [iain]
---

## Context
{What forced the decision; constraints from NFR/SRD; existing system shape.}

## Decision
{One paragraph stating the choice in active voice.}

## Options Considered
- PostgreSQL with logical replication — chosen
- DynamoDB — rejected because {reason}
- MySQL — rejected because {reason}

## Consequences
- Positive: {what becomes easier}
- Negative: {what becomes harder; what new operational concerns appear}
- Neutral: {what stays the same}
```

---

## Workflow

1. **Discover** — locate the spec folder; read all inputs in the table above; report what's missing. If `HANDOFF_TO_SEA.md` is present and `SRD.md` is absent, read the handoff file first and ask the user for any business intent it doesn't capture before proceeding.
2. **Inventory** — parse `PRIMITIVE_TREE.jsonld` for components. List them. Map each to a TDD section.
3. **Select patterns** — for each NFR, pick patterns from `references/architecture-patterns.md`. Surface trade-offs explicitly.
4. **Translate misuse cases** — for each MUC in `MISUSE_CASES.md`, translate its `System Response (REQUIRED)` into one or more Armor-pillar primitives in the TDD. Cross-reference: every MUC ID must appear in the TDD's Armor section. See `references/hardening-deltas.md` for the MUC → delta/primitive translation pattern (the same translation applies to greenfield TDD entries).
5. **Cover all three pillars** — for every component, ensure Form, Armor, and Proof are addressed. If you cannot address one pillar for a component, flag it in Open Questions; do not silently skip.
6. **Draft TDD** — write `TDD.md` following the template. Use GLOSSARY.md's preferred terms exactly.
7. **Extract ADRs** — for each non-trivial decision in the TDD, factor it out into an ADR file. The TDD references the ADR by ID.
8. **Write `ARCH.yaml`** — link back to the source SPEC.
9. **Report** — summarise what was produced, what patterns were chosen, what open questions remain, and which misuse cases drove which Armor primitives.

After the blueprint is accepted, the user typically runs `/sea:decompose`
next.

---

## Adapting Depth

- **Quick** ("draft a TDD shape") — populate skeleton, leave each section's content as bullet placeholders, surface gaps. ~30 minutes.
- **Full** (default) — complete TDD with all sections filled, ADRs for every non-trivial decision.
- **Audit-mode** ("compare proposed TDD to MECE-3") — read an existing TDD, score it against the three pillars, return a gap list.

---

## Gotchas

- **No SRD, no TDD — except for Early Handover.** If `SRD.md` does not exist and `HANDOFF_TO_SEA.md` does not exist, the skill blocks. Refer the user back to `srd:requirements-analyst`. Do not invent requirements. If `HANDOFF_TO_SEA.md` exists, you may proceed with a lightweight TDD provided you record the absent SRD as an explicit gap in the first ADR.
- **No NFR, no Armor.** The NFRs determine which resiliency and security patterns are needed. If `NFR.md` is missing or thin, surface that as the first Open Question — do not pick patterns by guesswork.
- **No MISUSE_CASES.md when one is expected.** If `SRD.md` exists but `MISUSE_CASES.md` does not, the SRD was produced by a pre-v1.11.0 facilitation or the adversarial sweep was skipped. Note this in the TDD's Open Questions: "Adversarial spec absent — Armor primitives derived from NFR only. Recommend the user re-run `/srd:requirements-analyst` for the misuse-case sweep, or accept the gap."
- **One ADR per decision.** Resist bundling. "Why we chose PostgreSQL" and "Why we chose logical replication" are two ADRs if both decisions had viable alternatives.
- **TDD is design, not implementation.** No code in the TDD beyond illustrative type signatures. Implementation lives in Work Packages.
- **Cross-reference the PRIMITIVE_TREE.** Every node in the tree should map to at least one TDD component. Nodes that don't map are gaps — flag them.
- **Cross-reference MISUSE_CASES.md.** Every MUC should map to at least one Armor primitive in the TDD. MUCs that don't map are gaps — flag them.
- **Use the locked vocabulary.** Use only the preferred terms from `GLOSSARY.md` — do not introduce synonyms or use forms the glossary marks as deprecated.

---

## See Also

- `references/tdd-template.md` — full TDD section structure with prompts
- `references/architecture-patterns.md` — pattern catalogue (plugin root)
- `references/mece-3-architecture.md` — the three pillars (plugin root)
