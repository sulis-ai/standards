# Engineering Standards for AI-Assisted Development

A starter set of engineering standards for teams using Claude Code or similar AI-assisted development tools. Three principles, four rules. Clone it, use it, extend it.

## Who it's for

Any team that wants consistent engineering standards applied automatically when working with AI coding assistants. The standards address the most common failure mode: AI-generated code that duplicates existing patterns instead of reusing and refactoring.

## Quick start

```bash
git clone <this-repo> standards
cp standards/CLAUDE.md your-project/CLAUDE.md
cp -r standards/standards/ your-project/standards/
```

Claude Code picks up `CLAUDE.md` automatically. The standards are active immediately.

## What's included

### Standards

| File | Role |
|------|------|
| `CLAUDE.md` | Entry point. Non-negotiable rules, quality gates, severity conventions. Loaded automatically by Claude Code. |
| `standards/ENGINEERING_PRINCIPLES.md` | Three active principles with detailed guidance, anti-patterns, and verification criteria. |
| `standards/SECURITY_STANDARD.md` | Seven security principles (SEC-01 through SEC-07) covering input validation, secrets, authorization, injection prevention, error handling, dependencies, and logging. |
| `standards/COGNITIVE_LOAD.md` | Six principles (CL-01 through CL-06) from Sweller's Cognitive Load Theory. Governs user-facing design — extraneous load elimination, intrinsic load management, choice reduction, consistency. |
| `standards/COACHING_WITHOUT_CONFLICT.md` | Seven tenets for delivering feedback without triggering defensiveness. Structural over personal, diagnostic over prescriptive, hypotheses over conclusions. |
| `standards/CRITICAL_THINKING_STANDARD.md` | Thirteen principles for evidence-based reasoning — MECE, falsifiability, confidence calibration, no hyperbole, pyramid principle, honest uncertainty, adversarial testing posture. |
| `roadmap/ROLLOUT_PLAN.md` | Nine further principles staged across three tiers, with promotion criteria. Guidance for growing beyond the starter set. |

### SRD Plugin (Claude Code)

| Path | Role |
|------|------|
| `srd/` | Requirements Analyst plugin for Claude Code. Facilitates building Software Requirements Documents through guided one-question-at-a-time conversation. Produces UML artifacts in Mermaid. |
| `srd/agents/requirements-analyst.md` | Agent definition — six-phase facilitation model with teaching integration. |
| `srd/skills/` | Standalone skills: `/srd:codebase-mapping`, `/srd:tree-synthesis`, `/srd:requirements-validation`, `/srd:spec-index`. Plus `srd-templates` (agent-only, not user-invocable). |

See [`srd/README.md`](srd/README.md) for plugin documentation.

## The three active principles

- **EP-02: Quality is Paramount** — Test-first development. RED → GREEN → REFACTOR cycle. The refactor step is mandatory, not optional.
- **EP-03: Reuse First** — Search before building. When two components implement the same pattern, extract the shared primitive now, not later.
- **EP-07: SOLID and Clean Code** — Leave every file better than you found it. Mechanical changes are free; structural changes require a characterisation test first.

## Extending

Add your own standards:

1. Create a file in `standards/` (e.g. `standards/TESTING_STANDARD.md`)
2. Add a row to the index table in `CLAUDE.md`
3. Set "Load When" to **Always** or to a specific condition

The rollout plan in `roadmap/ROLLOUT_PLAN.md` has nine more principles ready to promote when your team is ready. Each tier builds on the previous one.

## Philosophy

Start small. These three principles address the most common problem with AI-assisted development: duplication and lack of refactoring. Add more when these are habitual. The rollout plan has the sequence.

## License

MIT License. See [LICENSE](LICENSE) for full text.

This project is provided as-is with no warranty. Use it, fork it, adapt it — no restrictions on commercial or non-commercial use.
