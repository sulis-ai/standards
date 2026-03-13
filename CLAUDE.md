# CLAUDE.md

> Authoritative standards index for all AI-assisted development.
> Loaded automatically by Claude Code. Detail lives in the referenced standards files.

---

## How This Works

Claude Code loads this file automatically at the start of every task. The standards index
below points to detailed principles. To add your own standards: create a file in `standards/`,
add a row to the index table, and specify when it should be loaded.

---

## Standards Index

| Standard | File | Load When |
|----------|------|-----------|
| Engineering Principles | `standards/ENGINEERING_PRINCIPLES.md` | **Always** |
| Security | `standards/SECURITY_STANDARD.md` | **Always** |
| Cognitive Load | `standards/COGNITIVE_LOAD.md` | Agent facilitation tasks |
| Coaching Without Conflict | `standards/COACHING_WITHOUT_CONFLICT.md` | Agent facilitation tasks |
| Critical Thinking | `standards/CRITICAL_THINKING_STANDARD.md` | Agent facilitation tasks |
| Content Quality | `standards/CONTENT_QUALITY.md` | Content generation tasks |

Standards marked **Always** are loaded for every task regardless of scope.

---

## Non-Negotiables

Four rules. If a plan would violate any of these, the plan is wrong.

1. **New code: no implementation without a failing test first.** Write the test, see it
   fail, then write code. The REFACTOR step is not optional — it is where shared
   primitives get extracted. (EP-02)

2. **Check before building new.** Before creating any component, verify that no existing
   component can be extended or adapted. Search the codebase first. When you find two or
   more components implementing the same pattern — stop and extract the shared primitive
   before continuing. Do this in the same PR, not "later." (EP-03)

3. **Existing code: leave every file better than you found it — but prove behaviour
   first.** When you touch a file, review what's already there. For structural changes
   (extracting functions, splitting classes, changing interfaces), follow Fowler's
   refactoring discipline: write a characterisation test, confirm it passes, refactor,
   confirm it still passes. Mechanical changes (renames, dead code removal, import
   cleanup) do not require a characterisation test. (EP-07)

4. **Scope your improvements.** Boy Scout improvements apply to the file you are working
   in. If an improvement requires changes across multiple files, capture it and plan it
   as a separate piece of work — not an unbounded side-quest from your current PR. (EP-07)

### Quality Gates

Before every commit, verify:
- All tests pass
- No linting errors
- No type errors
- No known issues deferred
- A plan with no test strategy is incomplete regardless of how detailed the implementation is

### Conscious Deferral

If deferral is genuinely necessary (production incident, insufficient context to refactor
safely, time-critical delivery), add a comment in the code at the point of deferral.
Adapt the syntax to your project's language:

```
// TODO(deferred): Extract shared validation logic from OrderService and PaymentService
// REASON: Insufficient test coverage on PaymentService to refactor safely
// RESOLVE_BY: 2026-03-25
// PR: https://github.com/org/repo/pull/142
```

Undocumented deferral is not acceptable. A documented deferral is a decision; an
undocumented one is negligence.

---

## Severity Convention

Used consistently across all standards files:

| Severity | Meaning |
|----------|---------|
| **MUST** | Non-negotiable. Violations block delivery. |
| **SHOULD** | Default behaviour. Deviation requires explicit justification documented in the plan. |
| **MAY** | Permitted option. Use judgement. |

---

## Standards Authorship & Evolution

Standards are living documents. When a principle proves wrong, incomplete, or impractical
in practice, raise it — don't work around it silently.

New principles start at SHOULD with a 90-day calibration note. Promotion to MUST requires
evidence from 3+ executions. Demotion or removal requires documented rationale.

All changes to standards files are tracked in the version history section of the relevant file.
