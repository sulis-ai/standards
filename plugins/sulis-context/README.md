# sulis-context — Context Cartographer

> Discover existing context in any project. Produce a classified index that
> downstream Sulis plugins respect instead of restating.

`sulis-context` solves a recurring failure mode of generative architecture
and requirements tooling: **agents writing artifacts in repos that already
have rich knowledge bases, ignoring everything that's already there.**

When SRD facilitates requirements, it should know that `DOMAIN_MODEL.md`
already defines the entity vocabulary. When SEA writes a TDD, it should
reference the existing `ARCHITECTURE.md` for Clean Architecture rather than
re-deriving it. When sulis-security audits, it should not flag a standard
that the team already enforces in `architecture/standards/`.

The Context Cartographer scans your project for existing architecture
documentation, ADRs, conventions, standards, patterns, domain models, and
specs — then asks you to classify each finding. The result is a single file:
`.context/{project}/INDEX.md`. Downstream plugins read this first and apply
the **Respect-Don't-Restate** rule.

---

## Why This Exists

Three concrete failures motivated this plugin:

1. **The 849-line TDD.** A SEA blueprint run on a project that already had
   22 ADRs and a comprehensive `ARCHITECTURE.md` produced 849 lines of new
   TDD plus 11 new ADRs — most of which restated or contradicted what was
   already there.

2. **The mid-session park.** SRD facilitation hit a wall when the user
   referenced existing domain entities that the agent had no awareness of.

3. **Cross-plugin drift.** SEA, SRD, and sulis-security each were
   developing their own ad-hoc discovery patterns. Without a shared
   protocol, the three would drift toward incompatible classifications.

`sulis-context` extracts context discovery into a single, fleet-level
capability. Every artifact-producing plugin reads the same index.

---

## Quick Start

### From marketplace

```bash
# Once
/plugin marketplace add sulis-ai/agents
/plugin install sulis-context

# Per project
/sulis-context:discover
```

### Commands

| Command | What it does | When to use |
|---|---|---|
| `/sulis-context:discover` | First-time scan; classify findings; write index | New project, or before running SRD/SEA for the first time |
| `/sulis-context:refresh` | Re-validate the index against current state | After significant doc changes, or every 90 days |
| `/sulis-context:show` | Read-only print of the current index | When you want to know what downstream tools will see |

---

## What It Produces

A single file per project:

```
.context/{project-slug}/INDEX.md
```

Structure (full template in `references/context-index-template.md`):

- **Authoritative Sources** — the docs/ADRs/standards that are load-bearing
- **External ADR Registry** — count and highest number of pre-existing ADRs
  (so SEA doesn't collide)
- **Conventions & Standards** — explicit engineering rules
- **Patterns Library** — reusable patterns the team has documented
- **Informational** — useful but not binding
- **Superseded** — older versions; ignored by downstream
- **Out of Scope** — explicitly excluded
- **Known Gaps** — topics the existing docs don't cover (SEA's licence to add new artifacts)

---

## The Cardinal Rule: Respect-Don't-Restate

Every artifact-producing plugin in the Sulis marketplace is expected to:

1. **Read `.context/{project}/INDEX.md` before writing anything.**
2. **For each `authoritative` source covering topic X — reference, don't restate.**
3. **Number new artifacts to avoid collision** (e.g. SEA ADRs start after the highest external ADR).
4. **Surface anything not covered as a gap** — don't silently invent.

This is enforced by:
- **SRD v1.12.0+** — Phase 1 reads the index; Respect-Don't-Restate becomes a MUST rule.
- **SEA v0.4.0+** — Phase 0 reads the index; TDD/ADR generation respects the registry.
- **sulis-security v0.2.0+** — Findings reconciled against authoritative standards.

When a downstream plugin runs on a non-trivial codebase without
`.context/{project}/INDEX.md`, it auto-suggests `/sulis-context:discover`
before continuing. Users can override with a "continue without context"
phrase.

---

## How It Fits the Fleet

```
                         ┌──────────────────────┐
                         │  sulis-context       │
                         │  (this plugin)       │
                         │                      │
                         │  /discover           │
                         │  /refresh            │
                         │  /show               │
                         └─────────┬────────────┘
                                   │
                                   ▼
                         .context/{project}/INDEX.md
                                   │
              ┌────────────────────┼────────────────────┐
              │                    │                    │
              ▼                    ▼                    ▼
        ┌──────────┐         ┌──────────┐        ┌──────────────┐
        │   srd    │         │   sea    │        │ sulis-       │
        │ Phase 1  │         │ Phase 0  │        │ security     │
        │ reads    │         │ reads    │        │ reads        │
        └──────────┘         └──────────┘        └──────────────┘
              │                    │                    │
              ▼                    ▼                    ▼
        .specifications/     .architecture/        .security/
        {project}/           {project}/            {project}/
```

---

## Design Principles

**Folder-structure-agnostic.** The discovery protocol scans by purpose, not
by hard-coded paths. Works on projects that put architecture in
`architecture/`, `docs/architecture/`, or scatter it across the repo.

**User classifies, agent catalogues.** The cartographer never assumes that
a file's existence means it should be treated as authoritative. The user
chooses the classification. Defaults are conservative.

**Sticky classifications across refreshes.** Once a source is classified,
refresh doesn't re-ask unless the file has changed.

**No discovery means no discovery.** A zero-finding index is still valuable.
Downstream plugins should know the cartographer looked and found nothing —
that's different from never having looked.

**One file, one purpose.** The output is `.context/{project}/INDEX.md` and
nothing else. Plugins know exactly where to look.

---

## Configuration

None. The plugin is intentionally configuration-free. Behaviour is governed
by the references in this package:

- `references/discovery-protocol.md` — what to scan, where, and how
- `references/classification-taxonomy.md` — the four classifications and how downstream consumes them
- `references/context-index-template.md` — the index file schema

To customise discovery for your project, edit `.context/{project}/INDEX.md`
directly after running discover/refresh. The plugin respects manual edits.

---

## Installation

### From marketplace

```
/plugin marketplace add sulis-ai/agents
/plugin install sulis-context
```

### From local clone

```bash
git clone https://github.com/sulis-ai/agents.git
claude --plugin-dir ./agents/plugins/sulis-context
```

---

## License

MIT — see [LICENSE](../../LICENSE).
