# SRD: Requirements Analyst Plugin for Claude Code

A Claude Code plugin that produces handover-ready Software Requirements Documents
through guided conversation. One question at a time. Structured artifacts out the
other end.

---

## Why This Exists

> "You have productivity on tap, what you need to have are very good plans so that
> these agents are highly utilized and stay busy. So being a company that can plan
> well and know what you want to do is actually going to become more important, not
> less important."
>
> — Gustav Söderström, Spotify Co-CEO, Q4 2025 Earnings Call (Feb 10, 2026)

Spotify's best developers haven't written a line of code since December 2025. They
generate and supervise. The same pattern is playing out across every team with access
to AI-assisted execution: building gets faster, but knowing *what* to build stays hard.

A spec-driven development movement has emerged to address this — tools like GitHub's
Spec Kit, BMAD, OpenSpec, and GSD help teams write structured specifications and
orchestrate AI coding agents. These tools are good at what they do. They solve a real
problem.

They also assume you already know what to build.

SRD sits upstream. It facilitates the analysis that produces the specification — the
part where you figure out what the system actually needs to do, who uses it, what
happens when things go wrong, and where the requirements are thin. The output is a
complete Software Requirements Document that a development team (or a spec-driven
tool) can build from without making undocumented assumptions.

---

## Quick Start

```bash
# Install the plugin
/plugin marketplace add sulis-ai/agents
/plugin install srd@sulis-ai-agents

# Start a facilitation session
claude --agent srd:requirements-analyst --dangerously-skip-permissions
```

### Commands

| Command | What It Does |
|---------|-------------|
| `claude --agent srd:requirements-analyst` | Start a facilitation session as the primary agent |
| `claude --agent srd:requirements-analyst --dangerously-skip-permissions` | Same, skip permission prompts |
| `claude --agent default` | Return to the default Claude agent |
| `/srd:codebase-mapping` | Map the current codebase to `CODEBASE_INDEX.json` |
| `/srd:tree-synthesis` | Synthesise `PRIMITIVE_TREE.jsonld` from codebase or description |
| `/srd:requirements-validation` | Run five-perspective completeness check |
| `/srd:spec-index` | Regenerate `INDEX.md` from all `SPEC.yaml` files |
| `@"srd:requirements-analyst"` | Invoke as a sub-agent for one-off tasks |

---

## How It Works

The agent runs as your primary conversational partner — not a sub-agent relaying
through Claude, but the direct interface. You talk, it asks, you answer, it builds
the specification from what you say.

Eight phases, each with a clear purpose:

1. **Orientation** — What are you specifying? Who is it for? **Intent triage** classifies
   user input as business intent vs. architecture, parks architecture content for SEA,
   and offers early handover if input is predominantly technical.
2. **Divergent Exploration** — Systematically explore six domains: actors, capabilities,
   business rules, integrations, process flows, and constraints. One question at a time,
   following threads where they lead.
3. **Convergent Specification** — Transform broad understanding into precise, testable
   requirements. Exact steps, exact conditions, exact error handling.
3.5. **Disambiguation Sweep** — Lock the vocabulary. Resolve synonyms, pin referents,
   approve a glossary before any artifact is written.
3.6. **Adversarial Sweep** — Abuse cases, STRIDE-lite, and pre-mortem. Produces
   MISUSE_CASES.md and negative requirements (what the system MUST refuse, detect, or
   log). SRD owns *what shouldn't happen*; SEA owns *how to defend*.
4. **Artifact Generation** — Produce the SRD, UML diagrams, NFRs, glossary, and
   MISUSE_CASES.md. Each artifact reviewed before moving to the next.
5. **Completeness Verification** — Seven perspectives: traceability, integration
   completeness, NFR coverage, tree completeness, referential integrity, term
   consistency, and adversarial coverage.
6. **Handover** — Everything a development team needs to start building. Recommends
   `/sea:blueprint` as the natural next step.

A mid-session **Concern-Type Drift** reality probe catches conversation drift into
architecture territory and offers to park the technical thread for SEA.

**Brownfield projects** get codebase mapping before the first question — the agent
reads your code so it can ask grounded questions instead of starting from scratch.

**Greenfield projects** start immediately. The agent synthesises a structural model
once enough scope is established.

---

## Where SRD Fits

The spec-driven development space has matured quickly. Each tool below solves a
specific part of the specification-to-implementation pipeline. They have different
strengths because they address different moments in the workflow.

### The technical counterpart: SEA

The most direct downstream handoff is to **[SEA](../sea/)** — the Senior
Engineering Architect plugin in this marketplace. Where SRD handles
*What* and *Why*, SEA handles *How* and *Hardening*.

| | SRD | SEA |
|---|---|---|
| **Role** | Requirements Analyst | Senior Engineering Architect |
| **Question** | What does the system need to do, and why? | How should it be built, and how is it hardened? |
| **Inputs** | User conversation, optional codebase | SRD's `SRD.md` + `NFR.md` + `PRIMITIVE_TREE.jsonld` |
| **Outputs** | `.specifications/{project}/` (SRD, diagrams, NFRs, glossary) | `.architecture/{project}/` (TDD, ADRs, Work Packages, Hardening Deltas) |
| **Next step after** | Run `/sea:blueprint` to begin technical design | Hand Work Packages to an execution agent |

A typical end-to-end flow:

```
srd:requirements-analyst   →   sea:engineering-architect   →   execution agent
(What & Why)                   (How & Hardening)               (Implementation)
   SRD.md                        TDD.md                          Code + tests
   NFR.md                        ADR-*.md                        Green CI
   PRIMITIVE_TREE.jsonld         WP-*.md (Red-Green-Blue)        Merged PRs
```

Install both side-by-side:

```bash
/plugin install srd@sulis-ai-agents
/plugin install sea@sulis-ai-agents
```

When SRD finishes facilitation with a PASS verdict, it recommends
`/sea:blueprint` as the natural next step. SEA in turn refuses to invent
requirements — if no `.specifications/{project}/` exists, it refers the
user back to `srd:requirements-analyst`. The two are designed to fit.

### Specification frameworks for coding agents

These tools structure specifications so AI coding agents can execute reliably.

| Tool | What It Does Well | Artifacts |
|------|-------------------|-----------|
| [GitHub Spec Kit](https://github.com/github/spec-kit) | Clean four-phase workflow (Specify → Plan → Tasks → Implement). Templates for multiple AI coding tools. Lightweight, well-maintained. | Spec doc, plan, task list |
| [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) | 21 specialised AI agents across the full development lifecycle. Deep workflow coverage from product management through implementation. | PRD, user stories, architecture docs |
| [OpenSpec](https://github.com/Fission-AI/OpenSpec) | Delta-based specs for brownfield work. Tracks what's added, modified, and removed rather than specifying the entire system. | Change proposals, delta specs, task lists |
| [Kiro](https://kiro.dev/) (AWS) | Full IDE with built-in spec workflow. EARS format for requirements. Polished experience for teams already in the AWS ecosystem. | requirements.md, design.md, tasks.md |

### Orchestration and execution frameworks

These tools manage the discuss → plan → execute → verify cycle, coordinating AI
agents across tasks and maintaining state between sessions.

| Tool | What It Does Well | Artifacts |
|------|-------------------|-----------|
| [GSD](https://github.com/gsd-build/get-shit-done) | Solves context rot by dispatching tasks to fresh sub-agent contexts. Project → Milestone → Phase → Task hierarchy with six slash commands. Runs on Claude Code, OpenCode, and Gemini CLI. | PROJECT.md, REQUIREMENTS.md, ROADMAP.md, codebase maps |
| [spec-workflow-mcp](https://github.com/Pimzino/spec-workflow-mcp) | MCP server with real-time dashboard and approval workflows. Strong for team-based specification review. | Steering docs, specs, verification reports |
| [cc-sdd](https://github.com/gotalab/cc-sdd) | Kiro-style slash commands across multiple AI tools. Good cross-platform support (Claude Code, Codex, Cursor, Gemini). | Requirements, design reviews, task plans |

### Claude Code Plan mode

Claude Code has a built-in Plan mode (`--permission-mode plan` or Shift+Tab twice)
that operates read-only — Claude analyses your codebase and creates implementation
plans without modifying anything. Plans persist across sessions and can be edited
before execution. It's a natural handoff point: feed it a specification, get back
a concrete implementation plan.

### What SRD does differently

SRD is a requirements *analyst*, not a specification *template* or an execution
*orchestrator*.

The tools above start at different points: Spec Kit starts with "write down what
you want to build." GSD starts with "discuss what you're building, then plan and
execute." Claude Code Plan mode starts with "here's the codebase, what should we
change?" All of them assume a level of clarity about what the system needs to do.

SRD sits before that clarity exists. It facilitates the analysis that produces it —
the part where you figure out what the system actually needs to do, who uses it,
what happens when things go wrong, and where the requirements are thin. The output
is a specification precise enough that the downstream tools can work from it without
making undocumented assumptions.

Concrete differences:

- **Conversational elicitation.** One question at a time, grounded in your answers.
  Not a form to fill in.
- **Codebase-grounded questions.** For existing projects, the agent reads your code
  and asks about what it finds rather than starting from scratch.
- **Multi-perspective completeness tracking.** Five verification perspectives catch
  gaps that structural checks miss — including referential integrity between what was
  decided and what was written.
- **Structured UML artifacts.** Use case diagrams, sequence diagrams, process flows,
  state machines, and data flows in Mermaid. Integrated into the requirements workflow,
  not generated as an afterthought.
- **NFRs, glossary, handover docs.** The full specification package, not just
  functional requirements.
- **Teaching through doing.** The agent names patterns, explains diagram types, and
  surfaces analytical thinking — building your systems analysis skills as you work.

### SRD output as input

The artifacts SRD produces — SRD.md, diagrams, NFR.md, HANDOVER.md — are designed
to feed directly into the tools above. Each tool consumes the specification
differently, but the handoff is the same: SRD defines *what and why*, the downstream
tool handles *how*.

| Downstream Tool | What It Consumes from SRD | How |
|----------------|--------------------------|-----|
| **SEA** (recommended) | SRD.md + NFR.md + PRIMITIVE_TREE.jsonld + diagrams | `/sea:blueprint` reads the full spec folder and produces a hardened TDD, ADRs, and atomic Work Packages with Red-Green-Blue verification |
| **sulis-security** | NFR.md (for spec-drift detection) | `/sulis-security:codebase-assess` audits the codebase across 25 primitives. If NFR.md exists, findings that contradict NFRs are flagged as specification drift |
| **Claude Code Plan mode** | SRD.md + diagrams | Reference the spec in Plan mode: "Create an implementation plan based on @.specifications/project/SRD.md" |
| **GSD** | HANDOVER.md implementation sequence | Use the recommended sequence as GSD milestones and phases. Feed individual requirements into `/gsd:discuss-phase` |
| **Spec Kit** | Individual use cases from SRD.md | Each use case becomes a Spec Kit specification. The NFRs and business rules carry forward as constraints |
| **BMAD** | SRD.md + GLOSSARY.md | Feed the SRD into BMAD's Product Manager agent as the PRD source. The glossary ensures consistent terminology |
| **OpenSpec** | Use cases as delta specs | For brownfield projects, map SRD use cases to ADDED/MODIFIED changes against the existing codebase |

A practical workflow:

1. Run SRD to produce the complete specification
2. Run `/sea:blueprint` to convert it into a hardened TDD and atomic Work Packages
3. Hand Work Packages to your preferred execution tool — Claude Code, GSD,
   Spec Kit, or an engineering team

Alternative paths (e.g. SRD → Plan mode directly, skipping SEA) are valid
when the architectural design is trivial or already decided.

---

## What It Produces

Each session creates a specification folder at `.specifications/{project-name}/`:

```
.specifications/
  .next-id                        # Counter for unique specification IDs
  INDEX.md                        # Generated index of all specifications
  {project-name}/
    SPEC.yaml                     # Metadata — ID, status, type, owner
    SRD.md                        # The Software Requirements Document
    EXPLORATION_JOURNAL.md        # Session record — questions, answers, assumptions
    CODEBASE_INDEX.json           # Codebase map (brownfield only)
    PRIMITIVE_TREE.jsonld          # Structural decomposition of building blocks
    diagrams/
      use-cases.md                # Actor-capability diagrams
      process-flows.md            # Workflow diagrams
      sequence-diagrams.md        # Integration interaction diagrams
      state-diagrams.md           # Entity lifecycle diagrams
      data-flows.md               # Data movement diagrams
    NFR.md                        # Non-functional requirements
    MISUSE_CASES.md               # Abuse cases + negative requirements (adversarial sweep)
    GLOSSARY.md                   # Domain glossary with synonyms and disambiguation
    COMPLETENESS_REPORT.md        # Verification results (seven perspectives)
    HANDOVER.md                   # Implementation guide for development teams
```

**SPEC.yaml** assigns each specification a unique ID (`SPEC-001`, `SPEC-002`, ...)
and tracks its lifecycle: `draft` → `in-progress` → `specified` → `implemented` →
`verified`. Run `/srd:spec-index` to regenerate `INDEX.md` from all SPEC.yaml files.

**PRIMITIVE_TREE.jsonld** is the agent's structural hypothesis about the system's
architectural building blocks. It drives gap-targeted question selection — the agent
explores what's unspecified rather than following a fixed checklist.

---

## Who It's For

**People learning systems analysis.** The agent teaches through the work itself —
naming patterns as they emerge, explaining what diagrams show, surfacing analytical
dimensions you might not have considered. You learn requirements engineering by
producing a real specification, not by reading about it.

**Teams that need structured specifications.** Founders, product owners, and
developers who know the domain but need to capture requirements formally before
handing off to a development team or AI coding workflow.

---

## Installation

### From marketplace

```
/plugin marketplace add sulis-ai/agents
/plugin install srd@sulis-ai-agents
```

### From local clone

```bash
claude --plugin-dir ./plugins/srd
```

---

## Usage

### Starting a session

Run Claude Code with the requirements analyst as the primary agent:

```bash
claude --agent srd:requirements-analyst --dangerously-skip-permissions
```

This gives you a direct conversation — no relay through the main Claude agent.
The `--agent` flag is the right invocation for the 40+ turn facilitation sessions
this tool is designed for.

To make it the default for a project, add to `.claude/settings.json`:

```json
{
  "agent": "srd:requirements-analyst"
}
```

### `--agent` vs `@`-mention

| Invocation | Use When |
|-----------|----------|
| `claude --agent srd:requirements-analyst` | Facilitation sessions — direct conversation, full context window |
| `@"srd:requirements-analyst"` | One-off tasks — "explain this use case", "update this diagram" |

The `@`-mention runs as a sub-agent with messages relayed through the main Claude
agent. This adds latency and loses conversational flow. Use `--agent` for anything
longer than a single exchange.

### Standalone skills

Skills can be run independently outside of facilitation sessions:

| Skill | Produces |
|-------|----------|
| `/srd:codebase-mapping` | `CODEBASE_INDEX.json` — technology stack, services, integrations, data models |
| `/srd:tree-synthesis` | `PRIMITIVE_TREE.jsonld` — structural decomposition with typed nodes and dependencies |
| `/srd:requirements-validation` | `COMPLETENESS_REPORT.md` — five-perspective verification with PASS/GAPS_FOUND verdict |
| `/srd:spec-index` | `INDEX.md` — generated index of all specifications from SPEC.yaml files |

---

## License

MIT
