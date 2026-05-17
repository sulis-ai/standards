---
name: run-wp
description: >
  Dispatch the executor on a single Work Package. Usage:
  /sulis-execution:run-wp WP-NNN. Power-user / debugging entry point.
  Reads the WP file, the TDD, the ADRs, and runs the 10-step
  lifecycle (steps 1-6 in v0.1; steps 7-10 in v0.2/v0.3).
---

# /sulis-execution:run-wp

Dispatch the **executor** agent on a single Work Package.

## Usage

```
/sulis-execution:run-wp WP-NNN
```

Where `WP-NNN` is the WP ID (e.g. `WP-007`). The skill reads
`.architecture/{project}/work-packages/WP-NNN-*.md`, the TDD section
it references, and the ADRs it references; then dispatches the
executor with the WP loaded as context.

## What it produces

Per the executor's output contract (see `agents/executor.md`):

- **Success path (steps 1-6 in v0.1):** branch on remote with the
  WP's commit pushed, INDEX entry updated to `in_progress`,
  acceptance evidence appended to the WP file, one plain-English
  status line for the invoking session.

- **Escalation path:** `BLOCKER-WP-NNN.md` written to
  `.architecture/{project}/work-packages/`, INDEX entry updated to
  `blocked`, one plain-English status line for the invoking
  session.

## When to use this skill

- **Power-user / debugging path** — when you want to run one specific
  WP rather than walking the whole INDEX. The orchestrator's
  `/sulis-execution:run-all` is the normal path; `run-wp` is for
  targeted execution.
- **Re-running a blocked WP** after fixing an external blocker.
  Alternatively, use `/sulis-execution:retry WP-NNN` which is
  semantically identical but more discoverable for the resume case.
- **Manual decomposition gaps** — when the orchestrator can't make
  progress because a WP has primitive coverage v0.1 doesn't support
  (REORGANISE, SUBSTITUTE, etc.), you can still run individual
  EXPAND-group WPs manually with `run-wp`.

## What it does NOT do

- It does not walk dependencies — if the target WP's `dependsOn` WPs
  aren't `done`, the executor will halt at step 1 with a BLOCKER.
  Use `/sulis-execution:run-all` for dependency-aware execution.
- It does not promote `dev → main` — that's the concierge's
  founder-authorised ceremony.
- It does not modify the WP file's frontmatter (Contract, Sequence,
  Cost) — those are SEA's. The executor only appends to the
  `## Acceptance Evidence` section.

## Gotchas

- The skill expects a `.architecture/{project}/work-packages/`
  directory with the WP file present. If not present, halt with a
  clear error.
- If the WP's `primitive` is outside the v0.1 EXPAND scope, the
  executor escalates immediately with a BLOCKER pointing at v0.5
  primitive coverage. This is by design — don't try to override it.

## See also

- `agents/executor.md` — the agent invoked.
- `references/lifecycle.md` — the 10-step contract in detail.
- `/sulis-execution:run-all` — orchestrator path.
- `/sulis-execution:status` — read-only INDEX summary.
- `/sulis-execution:retry` — alias for the resume case.
