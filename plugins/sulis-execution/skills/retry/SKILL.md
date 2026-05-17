---
name: retry
description: >
  Re-run a blocked Work Package after the external blocker has been
  resolved. Usage: /sulis-execution:retry WP-NNN. Reads the existing
  BLOCKER record, archives it, dispatches the executor fresh.
---

# /sulis-execution:retry

Re-run a Work Package that was previously blocked, after the
external blocker has been resolved.

## Usage

```
/sulis-execution:retry WP-NNN
```

Where `WP-NNN` is the ID of a WP currently in `status: blocked`
state. If the WP is not blocked, the skill surfaces an error
suggesting `/sulis-execution:run-wp` instead.

## What happens

1. **Read the existing BLOCKER record**
   (`.architecture/{project}/work-packages/BLOCKER-WP-NNN.md`).
2. **Archive it** — move to
   `.architecture/{project}/work-packages/.archive/BLOCKER-WP-NNN-<timestamp>.md`
   so the audit trail is preserved.
3. **Reset INDEX entry** — `status: blocked` → `status: pending`;
   clear the BLOCKER reference field.
4. **Clean up the prior worktree** if one exists at
   `../wp-NNN-worktree/`. (The previous executor left it as
   evidence per the scope-guard rule; retry starts fresh.)
5. **Reset the per-WP working journal** (`.executor-WP-NNN.md`) —
   archive to `.archive/` alongside the BLOCKER, then create a
   fresh empty journal.
6. **Dispatch the executor** on the WP from a clean state.

The executor then runs the 10-step lifecycle as it normally would
for a fresh WP. The archive of the previous BLOCKER + journal gives
a future investigator the full history if the retry also blocks.

## When to use

- **External blocker resolved.** Common case: a BLOCKER said
  *"staging cluster at capacity — platform team needs to free up
  quota."* Platform team did. Run retry.
- **CI infra fix landed.** A BLOCKER said *"CI runner missing
  dependency X."* Someone fixed the CI config. Run retry.
- **Dependency WP completed.** A BLOCKER said *"WP-009 depends on
  WP-007 which hasn't been done yet."* WP-007 is now done. Run
  retry on WP-009.

## When NOT to use

- **The blocker is in scope.** If the BLOCKER's verdict was
  `in-scope (budget exhausted)`, the retry won't help — the
  executor would hit the same wall. Re-decompose the WP first.
- **The WP is `permanently_blocked`** (orchestrator's verdict after
  multiple blocked retries). Re-decomposition or hand-implementation
  is needed.
- **The WP is `done` already.** No-op; retry on a done WP makes no
  sense.

## What it does NOT do

- **It does not silently retry repeatedly.** Each retry is an
  explicit invocation. The orchestrator's `run-all` does not
  auto-retry blocked WPs.
- **It does not rewrite the BLOCKER record.** The archived record
  is preserved as historical evidence.
- **It does not modify WP frontmatter** (Contract, Sequence, Cost).
  Those are SEA's. Retry just resets the status.

## See also

- `agents/executor.md` — the agent dispatched.
- `/sulis-execution:run-wp WP-NNN` — equivalent for non-blocked WPs.
- The `executor-loop-standard.md` BLOCKER record format (EL-08).
