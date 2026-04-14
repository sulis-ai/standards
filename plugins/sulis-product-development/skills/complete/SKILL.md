---
name: complete
description: |
  Thin adapter invoking production-quality outcome + release logistics from product-delivery sequence.
  Finalizes feature lifecycle by verifying implementation, canonicalizing specifications, and updating platform documentation.

  TRIGGER KEYWORDS: complete feature, finalize, canonicalize, spec canonicalization,
  documentation checklist, gate 4, user sign-off, archive feature, wrap up.

  USE WHEN:
  - Implementation phase complete
  - Feature ready for quality verification and release
  - Ready to finalize documentation
  - Need to canonicalize specifications to permanent location

  GENERATES:
  - VERIFICATION_REPORT.md (from production-quality)
  - Canonicalized specifications at `features/services/`, `.extensions/`, or `.capabilities/`
  - DOCUMENTATION_CHECKLIST.md
  - Updated features/index.md

allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Task
---

# Complete Skill - Thin Adapter

> **Invokes:** Two steps from the `product-delivery` sequence:
> 1. `production-quality` (C-6) — fetch via GitHub MCP: `outcomes/utility/production-quality/OUTCOME.md`
> 2. Release logistics (C-7) — fetch via GitHub MCP: `delivery/product/SEQUENCES.md`
>
> **Pattern:** Ports & Adapters - Skill is adapter, Outcome is implementation
>
> Fetch both before executing:
> ```
> mcp__github__get_file_contents(owner, repo, path="methodology/outcomes/utility/production-quality/OUTCOME.md", ref)
> mcp__github__get_file_contents(owner, repo, path="methodology/delivery/product/SEQUENCES.md", ref)
> ```
> Use `ofm-bindings.yaml` for repo config. See `skills/shared/bindings.md` for resolution pattern.

---

## Purpose

This skill is a thin adapter that invokes:
1. **production-quality** — STRICT mode verification against IVS.md (GATE 3)
2. **Release logistics** — Mechanical completion activities (GATE 4)

All methodology is defined in the outcome and sequence; this skill handles invocation only.

**Note:** This replaces the deprecated `feature-release` outcome (ADR-073, ADR-074). The verification concern (C-6) is handled by the cross-cutting `production-quality` utility outcome. The release logistics (C-7) are sequence-level operations defined in product SEQUENCES.md.

---

## Prerequisites

Before invoking, verify:

1. **Implementation complete** — GATE 2 passed
2. **All tests passing** — No failing tests
3. **LIFECYCLE_STATE.json** — Shows implementation phase complete

```json
{
  "current_phase": "release",
  "phases": {
    "implementation": {
      "status": "complete"
    }
  }
}
```

**If prerequisites not met:** Direct user to `/sulis implement` first.

---

## Invocation

### Via Outcome Executor

```bash
/outcome-executor --outcome production-quality --feature {feature-name}
```

### Via Direct Skill

```bash
/complete {feature-name}
```

---

## Execution Flow

```
Step 1: production-quality (C-6)
  → VERIFICATION_REPORT.md with per-category PASS/BLOCKED
  → Production Guardian STRICT mode
  ─── GATE 3: Release Approval ───

Step 2: Release logistics (C-7)
  → Spec canonicalization (freeze versions, remove TODO/TBD)
  → SOLUTION_SUMMARY.md update
  → LIFECYCLE_STATE.json → complete
  → features/index.md update
  → PLATFORM_CONVENTIONS.md update (if new patterns)
  → DOCUMENTATION_CHECKLIST.md generation
  → CHANGELOG.md finalization
  → Completion Validator (automated)
  ─── GATE 4: User Sign-off ───

Step 3: Branch merge (post-GATE 4)
  → Detect current branch (skip if already on dev)
  → Squash-merge to dev (per EXECUTION_BRANCH_CONVENTION.md)
  → Push to origin
```

---

## Key Artifacts Produced

| Artifact | Source | Location |
|----------|--------|----------|
| VERIFICATION_REPORT.md | production-quality | `features/{feature}/VERIFICATION_REPORT.md` |
| DOCUMENTATION_CHECKLIST.md | release logistics | `features/{feature}/DOCUMENTATION_CHECKLIST.md` |
| CHANGELOG.md | release logistics | `features/{feature}/CHANGELOG.md` |
| Canonicalized specs | release logistics | `features/services/`, `.extensions/`, or `.capabilities/` |

---

## Gates

| Gate | Owner | Criteria |
|------|-------|----------|
| GATE 3 — Release Approval | Production Guardian (production-quality) | All verification categories PASS; all tests passing; TASKS.yaml 100% complete |
| GATE 4 — User Sign-off | Completion Validator + user | Specs canonicalized; documentation complete; registry updated |
| Branch merge | Mechanical (post-GATE 4) | Feature branch squash-merged to dev; pushed to origin |

---

## Error Handling

| Error | Resolution |
|-------|------------|
| Prerequisites not met | Run `/sulis implement` first |
| Production Guardian BLOCKED | Fix issues, re-run production-quality |
| Completion Validator BLOCKED | Fix documentation, re-run release logistics |

---

## Related Files

```
Outcome Definition:
├── methodology/outcomes/utility/production-quality/OUTCOME.md
└── methodology/outcomes/utility/production-plan/OUTCOME.md

Sequence Definition:
└── methodology/delivery/product/SEQUENCES.md (release logistics in product-delivery)

Feature Registry:
└── features/index.md
```

---

## Version

| Version | Date | Changes |
|---------|------|---------|
| 3.1.0 | 2026-04-04 | Added Step 3: branch merge to dev (post-GATE 4). Squash-merge, push, auto-delete per EXECUTION_BRANCH_CONVENTION.md |
| 3.0.0 | 2026-02-23 | Updated to invoke production-quality + release logistics (replaces feature-release, ADR-074) |
| 2.0.0 | 2026-02-02 | Refactored to thin adapter (DC-09 compliance) |
| 1.0.0 | 2026-01-15 | Initial implementation |
