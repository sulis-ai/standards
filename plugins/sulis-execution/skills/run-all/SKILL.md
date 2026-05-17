---
name: run-all
description: >
  Dispatch the orchestrator to walk the Work Package INDEX. Picks the
  next ready WP (no unmet dependencies), dispatches the executor for
  it, advances on completion, records blockers, continues until all
  ready WPs are exhausted. Usage: /sulis-execution:run-all.
---

# /sulis-execution:run-all

Dispatch the **orchestrator** to walk the full Work Package INDEX.
This is the concierge's Phase 5 default path.

## Usage

```
/sulis-execution:run-all
```

No arguments. The orchestrator reads
`.architecture/{project}/work-packages/INDEX.md`, builds the ready
set, and dispatches the executor on each ready WP in topological
order (lowest `sequence_id` first; ties by ID alphabetical).

## What happens during a run

1. Orchestrator reads INDEX.
2. Picks next ready WP (status: pending, all dependsOn done).
3. Marks WP `in_progress` in INDEX with timestamp.
4. Dispatches executor with the WP ID.
5. Waits for executor to finish.
6. On `done` → advance to next ready WP.
7. On `blocked` → record blocker; mark transitively-dependent WPs
   `dependency_blocked`; advance to next non-blocked ready WP.
8. Loop until ready set is exhausted.
9. Terminal status: how many done, how many blocked, how many still
   pending.

## What it produces

- Updated `INDEX.md` reflecting all WP statuses.
- One or more `BLOCKER-WP-NNN.md` files (if any WPs were blocked
  during the run).
- Updated WP files' `## Acceptance Evidence` sections for each
  completed WP.
- One terminal status line for the invoking session, summarising
  the run.

## When to use this skill

- **The default path.** Set up a session, run this command, watch
  the orchestrator walk the index.
- **The concierge's Phase 5.** When the concierge enters Phase 5
  (Implement), it spawns the orchestrator via the Agent tool, which
  is equivalent to invoking this skill.

## What it does NOT do

- **It does not deploy `dev → main`.** That's the founder's
  ceremony, surfaced by the concierge.
- **It does not retry blocked WPs.** Use `/sulis-execution:retry
  WP-NNN` after fixing the external blocker.
- **It does not run executors in parallel** (in v0.4). v0.5 adds
  opt-in parallelism per the orchestrator's parallelism rules.

## Gotchas

- The skill expects a non-empty
  `.architecture/{project}/work-packages/INDEX.md`. If empty (no
  WPs decomposed yet), surface a clear error: *"INDEX is empty.
  Run `/sea:decompose` first to produce work packages."*
- If the INDEX has WPs with primitives outside v0.1's EXPAND scope
  (REORGANISE / SUBSTITUTE / CONTRACT / REINFORCE-beyond-Test), the
  orchestrator will dispatch them, the executor will escalate
  immediately with a primitive-coverage BLOCKER, and the
  orchestrator will record the blocker and move on. v0.5 closes
  this gap.

## See also

- `agents/orchestrator.md` — the agent invoked.
- `agents/executor.md` — what the orchestrator dispatches.
- `/sulis-execution:run-wp WP-NNN` — single-WP dispatch path.
- `/sulis-execution:status` — read-only INDEX summary.
- `/sulis-execution:retry WP-NNN` — re-run a blocked WP.
