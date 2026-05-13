# Investor Deck Coach (`idc`)

A Claude Code plugin that coaches founders through producing an evidence-backed,
Sequoia-conformant pitch deck — branded in the customer's identity, with rigorous
market research, defensible financial modelling, adversarial review, and a live
rehearsal drill.

## What it does

The plugin runs a guided, one-question-at-a-time facilitation across nine phases:

1. **Orientation** — founder, stage, ask, audience
2. **Discovery** — what's changed, what you do, traction, team
3. **Brand Discovery** — extract or propose the brand applied to all deliverables
4. **Market Research** — evidence-backed TAM/SAM/SOM and competitive landscape
5. **Financial Modelling** — stage-appropriate unit economics and projections
6. **Narrative Synthesis** — Sequoia structure + Pyramid + SCQA per slide
7. **Adversarial Sweep** — in-character investor objections and rebuttal grading
8. **Design & Build** — branded PowerPoint and HTML deck
9. **Rehearsal** — timed delivery and mock Q&A

## Deliverables

Written to `.pitch/{project}/` in the user's repository:

| File | Purpose |
|---|---|
| `deck/PITCH_DECK.pptx` | Microsoft PowerPoint deck, branded |
| `deck/PITCH_DECK.html` | Reveal.js HTML deck, branded |
| `financial/financial-model.xlsx` | Working Excel model |
| `financial/financial-summary.html` | Branded interactive dashboard |
| `BRAND.md` + `brand-assets/` | Customer brand (extracted or proposed) |
| `MARKET_RESEARCH.md` + `sources/` + `proof-points/` | Evidence dossier |
| `ADVERSARIAL_REPORT.md` | Investor objections and mitigation |
| `REHEARSAL_NOTES.md` | Timing and Q&A drill output |
| `COMPLETENESS_REPORT.md` | Pre-handoff verification |

Every numerical claim in any artifact is traceable to a proof-point, and every
proof-point to a tiered source.

## Stage-awareness

The plugin adapts to the funding stage captured in `PITCH.yaml`:

| Stage | Financial horizon | Primary emphasis |
|---|---|---|
| Angel / Pre-seed | Thesis + market signal | Team, vision, founder credibility |
| Seed | 12-month bottom-up | Pilot data, path to PMF |
| Series A | 24-month + cohort | Early unit economics, retention |
| Series B | 36-month + sensitivity | Scaled unit economics, sales efficiency |

## Skills

| Slash command | Phase | Output |
|---|---|---|
| `/idc:discovery` | 1–2 | `DISCOVERY.md`, `PITCH.yaml` |
| `/idc:brand-discovery` | 3 | `BRAND.md`, `brand-assets/` |
| `/idc:market-research` | 4 | `MARKET_RESEARCH.md`, `sources/`, `proof-points/` |
| `/idc:financial-model` | 5 | `financial/*.{yaml,xlsx,html}` |
| `/idc:narrative` | 6 | `NARRATIVE.md`, `slides/*.md` |
| `/idc:adversarial-review` | 7 | `ADVERSARIAL_REPORT.md` |
| `/idc:build-deck` | 8 | `deck/PITCH_DECK.{pptx,html}` |
| `/idc:rehearsal` | 9 | `REHEARSAL_NOTES.md` |
| `/idc:validate` | post-9 | `COMPLETENESS_REPORT.md` |

## Reference standards

Located in `references/`:

- `sequoia-pitch-framework.md` (`SQ-`) — slide structure, timing, conversation model
- `financial-rigor-standard.md` (`FN-`) — TAM/SAM/SOM, unit economics, projections
- `investor-objection-catalogue.md` (`IO-`) — taxonomy and rebuttal patterns
- `deck-narrative-standard.md` (`ND-`) — Pyramid + SCQA per slide
- `visual-design-standard.md` (`VD-`) — slide layout grounded in cognitive load
- `brand-standard.md` (`BR-`) — brand extraction format
- `brand-proposal-standard.md` (`BP-`) — proposing a brand kit when none exists
- `coaching-without-conflict.md` — facilitation pedagogy
- `cognitive-load.md` (`CL-`) — per-slide load limits
- `content-quality.md` (`CQ-`) — prose rigor
- `critical-thinking-standard.md` — three-phase analytical framework

## Tool requirements

- Python 3.10+
- `pip install python-pptx openpyxl pillow` (prompted on first build)

## Installation

```bash
/plugin marketplace add sulis-ai/agents
/plugin install idc@sulis-ai-agents
```

Then in any repository:

```
/idc:discovery
```

## License

MIT. See repository root.
