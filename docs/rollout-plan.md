# Engineering Principles — Rollout Plan

> This is guidance for growing beyond the starter set, not active standards.
> Staged introduction of principles beyond the active set (EP-02, EP-03, EP-07).
> Each tier is introduced only when the previous tier is embedded and producing
> consistent results.

---

## Promotion Criteria

A tier is ready for promotion when:
- The active principles are followed without prompting in 3+ consecutive PRs
- No regressions in previously active principles
- The team can articulate why a principle matters, not just what it says

When promoting a tier: move principles into the Active Principles section of
`standards/ENGINEERING_PRINCIPLES.md`, add to the non-negotiables in `CLAUDE.md` if MUST,
and update both version histories.

---

## Tier 2 — Code Discipline

**Introduce when:** Active principles (EP-02, EP-03, EP-07) are habitual (~2-3 weeks).

**Why this tier next:** These principles support the refactoring habit established in
Tier 1. Without them, refactored code drifts back toward bloat and half-finished states.

| Principle | Summary | Severity |
|-----------|---------|----------|
| **EP-05: The Hard Road** | Prioritise accuracy, clarity, and minimalism over speed. Simplify, don't ship "good enough." | MUST |
| **EP-08: No Code Bloat** | Every line must be needed. Remove unused imports, dead code, speculative implementations. | MUST |
| **EP-04: Finish What You Start** | Never leave work in progress. Every commit leaves the codebase deployable. | MUST |

**Non-negotiables to add on promotion:**
- Every line must be needed. Remove unused imports, dead code, speculative implementations. (EP-08)
- Never leave work in progress. No `TODO: fix later`, no commented-out code, no skipped tests. (EP-04)

**Observation notes:** _(record evidence of readiness here as it accumulates)_
-

---

## Tier 3 — Security & Process

**Introduce when:** Tier 2 is stable (~2-3 weeks after Tier 2 promotion).

**Why this tier next:** With code quality and discipline established, the team can
absorb security constraints without them feeling like overhead bolted on top.

| Principle | Summary | Severity |
|-----------|---------|----------|
| **EP-01: Security by Design** | Zero-trust model. Validate all inputs at boundaries. Defence-in-depth. | MUST |
| **EP-09: Authorization-First Design** | Authorization defined before the operation it protects. Handler-level checks. | MUST |
| **EP-06: Systematic Execution** | Structured planning, task breakdown, progress tracking. | SHOULD |

**Non-negotiables to add on promotion:**
- Authorization is defined before the operation it protects. Never add auth "after the feature works." (EP-09)
- Secrets never appear in code, logs, or committed files. (EP-01)

**Companion standards to write before promotion:**
- `SECURITY_STANDARD.md` — operationalises EP-01 and EP-09
- `TESTING_STANDARD.md` — should exist by this point to support EP-02 fully

**Observation notes:** _(record evidence of readiness here as it accumulates)_
-

---

## Tier 4 — Architectural Maturity

**Introduce when:** Tier 3 is stable and the codebase has enough shared infrastructure
to make these principles meaningful rather than theoretical.

**Why this tier last:** These are sophisticated architectural principles. They require
the team to already be refactoring well (Tier 1), writing clean code (Tier 2), and
thinking about security boundaries (Tier 3). Without that foundation, these principles
produce confusion, not quality.

| Principle | Summary | Severity |
|-----------|---------|----------|
| **EP-10: Desired State Over Procedures** | Declarative over imperative. Manifests over scripts. | SHOULD |
| **EP-11: Service Contract Conformance** | Consumers conform to service contracts. Adapter logic on the caller side. | SHOULD |
| **EP-12: Infrastructure Domain Independence** | Shared infrastructure is domain-agnostic. Any-consumer test. | SHOULD |

> EP-11 and EP-12 start at SHOULD per the evolution policy (zero execution evidence).
> Promote to MUST after 3+ successful executions demonstrate value and agent comprehension.

**Companion standards to write before promotion:**
- `ARCHITECTURE_STANDARD.md` — operationalises EP-11 and EP-12

**Observation notes:** _(record evidence of readiness here as it accumulates)_
-

---
