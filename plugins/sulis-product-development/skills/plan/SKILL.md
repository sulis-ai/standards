---
name: plan
description: |
  Create implementation plans and machine-readable task specifications from design artifacts.
  Enables autonomous sub-agents to execute implementation without human coordination.

  TRIGGER KEYWORDS: plan implementation, create tasks, break down, decompose, task list,
  implementation plan, what are the steps, how to implement, generate tasks, create plan,
  tasks for, action items, work breakdown, sprint plan, implementation steps,
  PLAN.md, TASKS.yaml, TASKS.md.

  USE WHEN:
  - Design artifacts (DESIGN.md, IVS.md, NFR.md) are complete
  - Ready to start implementation
  - Need to generate implementation tasks for sub-agents
  - Creating a plan from design specifications
  - GATE 1 (Design Approval) has passed

  GENERATES:
  - PLAN.md - Human-readable implementation strategy
  - TASKS.yaml - Machine-readable task specifications for autonomous agents
  - TASKS.md - Human-readable task checklist with ServiceSpec traceability

allowed-tools: Read, Write, Edit, Glob, Grep
---

# Plan Skill - Thin Adapter

> **DC-09 Compliant:** This skill is a thin invocation adapter.
> The complete planning methodology lives in the outcome definition.
>
> **Source of Truth:** Fetch via GitHub MCP: `outcomes/utility/production-plan/OUTCOME.md`
> **Parameterised by:** Fetch via GitHub MCP: `delivery/product/VOCABULARY.md` (work unit types)
>
> Fetch both before executing:
> ```
> mcp__github__get_file_contents(owner, repo, path="methodology/outcomes/utility/production-plan/OUTCOME.md", ref)
> mcp__github__get_file_contents(owner, repo, path="methodology/delivery/product/VOCABULARY.md", ref)
> ```
> Use `ofm-bindings.yaml` for repo config. See `skills/shared/bindings.md` for resolution pattern.

---

## Outcome Reference

| Attribute | Value |
|-----------|-------|
| **Outcome ID** | `production-plan` |
| **Location** | `methodology/outcomes/utility/production-plan/OUTCOME.md` |
| **PLS Concern** | C-4: Decompose into units with defined completion criteria |
| **Sequence Position** | product-delivery Step 5 |

**Note:** This outcome replaces the deprecated `feature-planning` outcome (ADR-073). The `production-plan` utility outcome is parameterised by the product function's VOCABULARY.md (8 work unit types) and STANDARDS.md (verification categories SEC-*/OBS-*/REL-*).

---

## Invocation

### Primary: Compiled Workflow

```bash
cd apps/api && nox -s plan -- {feature-name}
```

This executes the production-plan workflow via `plan_executor.py`:
- Loads GRAPH.yaml, builds graph definition, injects process and content node handlers
- Executes 17 nodes (10 LLM calls) via workflow service (GenericGraphCompiler → LangGraph)
- Reaches gate-plan-approval with generated artifacts
- Writes PLAN.md, TASKS.yaml, TASKS.md to `features/{feature-name}/`

### Escalation: Inline Reasoning

If compiled execution fails (graph compilation error, runtime exception, or inadequate output quality):

```bash
/outcome-executor production-plan --feature {feature-name}
```

### Via This Skill

```bash
/plan {feature-name}
```

Invokes the compiled workflow path by default.

---

## Prerequisites

Before invoking, verify:

1. **Design artifacts exist:**
   ```
   features/{feature-name}/
   ├── DESIGN.md            ✓ Technical architecture
   ├── IVS.md               ✓ Verification requirements
   ├── NFR.md               ✓ Operational constraints
   ├── TEST_SCENARIOS.md    ✓ Test specifications
   └── LIFECYCLE_STATE.json ✓ Shows design phase complete
   ```

2. **GATE 1 passed:** `LIFECYCLE_STATE.json` shows design complete

---

## Process Overview

The production-plan outcome decomposes approved designs into self-contained work units:

| Phase | Activities |
|-------|-----------|
| **Phase 1: Analysis** | Load design artifacts, extract requirements, identify NFR constraints |
| **Phase 2: Decomposition** | Identify work units (using product VOCABULARY.md types), map dependencies |
| **Phase 3: Specification** | Generate self-contained task packages with embedded context, TDD cycles, IVS mapping |
| **Phase 4: Generation** | Produce PLAN.md, TASKS.yaml, TASKS.md; validate schema; present for GATE 2 |

**Full methodology:** See outcome OUTCOME.md for complete activity definitions.

---

## Key Activities

### IVS Coverage Check

> **CRITICAL:** 100% IVS coverage required before GATE 2.

All SEC-*, OBS-*, REL-* requirements must have mapped tasks.

### Dependency Validation

> **CRITICAL:** No cycles allowed in dependency graph.

Topological sort must succeed before proceeding.

### TASKS.yaml Schema Validation

> **CRITICAL:** TASKS.yaml must validate against schema.

Schema: `skills/shared/schema/artifacts/tasks-yaml.json`

---

## Outputs

| Artifact | Location | Purpose |
|----------|----------|---------|
| PLAN.md | `features/{feature}/PLAN.md` | Human-readable strategy |
| TASKS.yaml | `features/{feature}/TASKS.yaml` | Machine-readable tasks |
| TASKS.md | `features/{feature}/TASKS.md` | Task checklist |

---

## Integration Points

| Skill | Purpose |
|-------|---------|
| `design` | Provides input artifacts (DESIGN.md, IVS.md, NFR.md) |
| `implement` | Consumes TASKS.yaml for execution |
| `backend-development` | Pattern reference |

---

## Version

| Version | Date | Changes |
|---------|------|---------|
| 4.0.0 | 2026-04-05 | Compiled workflow as primary invocation (nox → plan_executor → GRAPH.yaml → LangGraph). Inline reasoning as escalation. |
| 3.0.0 | 2026-02-23 | Updated to invoke production-plan (replaces feature-planning, ADR-074) |
| 2.0.0 | 2026-02-01 | DC-09 refactor: Thin adapter pointing to outcome |
| 1.0.0 | 2026-01-19 | Initial implementation (methodology embedded) |
