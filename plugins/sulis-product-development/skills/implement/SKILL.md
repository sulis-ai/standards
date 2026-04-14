---
name: implement
description: |
  Execute autonomous implementation following the task plan (TASKS.yaml).
  Uses TDD (RED → GREEN → REFACTOR) with per-task quality checks and sub-agent orchestration.

  TRIGGER KEYWORDS: implement, build, code, develop, execute tasks, run tasks,
  tdd, red green refactor, start implementation, begin coding, autonomous implementation.

  USE WHEN:
  - Plan phase complete (TASKS.yaml exists)
  - GATE 2 (Plan Approval) has passed
  - Ready to start coding
  - Resuming interrupted implementation

  EXECUTION:
  - Autonomous mode - continues until all tasks complete
  - TDD for every implementation task
  - Per-task quality checks
  - Progress tracked in LIFECYCLE_STATE.json

allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion, Task
---

# Implement Skill - Thin Adapter

> **DC-09 Compliant:** This skill is a thin invocation adapter.
> The complete TDD methodology lives in the outcome definition.
>
> **Source of Truth:** Fetch via GitHub MCP: `delivery/product/outcomes/solution-implementation/OUTCOME.md`

---

## Methodology Fetch

Before executing, fetch the outcome definition from the methodology repo:
```
mcp__github__get_file_contents(owner, repo, path="methodology/delivery/product/outcomes/solution-implementation/OUTCOME.md", ref)
```
Use `ofm-bindings.yaml` for repo config. See `skills/shared/bindings.md` for resolution pattern.

---

## Outcome Reference

| Attribute | Value |
|-----------|-------|
| **Outcome ID** | `solution-implementation` |
| **Location** | `delivery/product/outcomes/solution-implementation/OUTCOME.md` (fetch via GitHub MCP) |
| **DAG** | `delivery/product/outcomes/solution-implementation/DAG.yaml` (fetch via GitHub MCP) |
| **Triad** | Implementation Governance Triad |
| **Lead Lens** | Code Quality Guardian |

---

## Invocation

### Via Outcome Executor

```bash
/outcome-executor solution-implementation --feature {feature-name}
```

### Via This Skill

```bash
/implement {feature-name}
```

Both routes execute the same methodology defined in the outcome.

---

## Prerequisites

Before invoking, verify:

1. **Plan artifacts exist:**
   ```
   features/{feature-name}/
   ├── PLAN.md              ✓ Implementation strategy
   ├── TASKS.yaml           ✓ Machine-readable tasks
   └── LIFECYCLE_STATE.json ✓ Shows plan phase complete
   ```

2. **GATE 2 passed:** `LIFECYCLE_STATE.json` shows plan complete

---

## Prime Directives

> **AUTONOMOUS MODE RULES - NON-NEGOTIABLE**

| Directive | Description |
|-----------|-------------|
| **NEVER STOP** | Continue until all tasks in TASKS.yaml are complete |
| **NEVER SKIP** | Every task, test, and verification must be executed |
| **FIX IMMEDIATELY** | Any failing test must be fixed before proceeding |
| **NO DEFERRALS** | Everything planned must be completed (C-05) |

---

## Process Overview

The outcome defines 4 phases with 17 activities:

| Phase | Lead Lens | Activities |
|-------|-----------|------------|
| **Phase 1: Setup** | Velocity Monitor | 1.1-1.3 (Load, Detect, Initialize) |
| **Phase 2: TDD** | Code Quality Guardian | 2.1-2.7 (RED-GREEN-REFACTOR loop) |
| **Phase 3: Verification** | Velocity Monitor | 3.1-3.4 (IVS, META, Entity, Final) |
| **Phase 4: Completion** | Integration Analyst | 4.1-4.3 (State, IVS Check, Handoff) |

**Full methodology:** See outcome OUTCOME.md for complete activity definitions.

---

## Key Activities

### TDD Loop (Phase 2)

Activities 2.1-2.7 form the core TDD loop and MUST remain distinct:

1. **2.1** Mark Task In Progress
2. **2.2** RED - Write Failing Test
3. **2.3** GREEN - Make Test Pass
4. **2.4** REFACTOR - Clean Up
5. **2.5** Per-Task Quality Check
6. **2.6** Mark Task Complete
7. **2.7** Commit Changes

### IVS Completeness Check (Activity 4.2)

> **MANDATORY:** No blank cells allowed in IVS verification table.

This activity prevents late detection at GATE 3 (ARC Cycle 2 finding).

---

## Scope Resolution

Before starting implementation, resolve the feature's technology scopes:

1. Read `features/{feature-name}/LIFECYCLE_STATE.json` → `scopes` array
2. For each code-producing scope (exclude `spec`):
   - Read `{app_root}/scope-profile.yaml` (path from `product/MANIFEST.yaml` → `stack.scopes[]`)
   - Extract tool commands: `test_runner`, `test_all`, `linter`, `formatter_check`, `type_checker`, `pre_commit`
3. For each task in TASKS.yaml:
   - Determine the task's scope from its `impl_file` path (e.g., `apps/api/` → backend, `apps/web/` → frontend-web)
   - Use that scope's tool commands for RED/GREEN/REFACTOR and quality checks

**Multi-scope features:** Tasks targeting different scopes use different tool commands.
A task creating `apps/web/src/components/sidebar.tsx` uses the frontend-web profile's
`test_runner` (vitest), while a task creating `apps/api/sulis/services/auth/handler.py`
uses the backend profile's `test_runner` (pytest).

---

## Integration Points

| Skill | Purpose |
|-------|---------|
| `backend-development` | Pattern reference for backend scope (handlers, ports, adapters) |
| `test-scenarios` | Test implementation guidance (all scopes) |
| `pre-commit-checks` | Scope-aware quality validation |

---

## Lenses

| Lens | Question | Definition |
|------|----------|------------|
| **Code Quality Guardian** | "Does this follow TDD?" | [lenses/code-quality-guardian.md](../../methodology/outcomes/product/solution-implementation/lenses/code-quality-guardian.md) |
| **Velocity Monitor** | "Are we progressing to plan?" | [lenses/velocity-monitor.md](../../methodology/outcomes/product/solution-implementation/lenses/velocity-monitor.md) |
| **Integration Analyst** | "Does this integrate correctly?" | [lenses/integration-analyst.md](../../methodology/outcomes/product/solution-implementation/lenses/integration-analyst.md) |

---

## Version

| Version | Date | Changes |
|---------|------|---------|
| 2.1.0 | 2026-03-19 | Scope resolution section: multi-scope feature support, scope-profile.yaml tool command resolution, scope-conditional pattern references. ADR-141. |
| 2.0.0 | 2026-02-01 | DC-09 refactor: Thin adapter pointing to outcome |
| 1.0.0 | 2026-01-19 | Initial implementation (methodology embedded) |
