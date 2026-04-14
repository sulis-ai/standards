# Business Strategy Studio

This studio provides strategic foundation skills: vision, strategy, principles, anti-goals, commercial, BMC, GTM, roadmap, and domain-specific research (competitive, company, brand, win/loss).

## Studio Context

On session start or when strategy work begins, fetch studio context from the methodology repo using GitHub MCP:

```
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/business-strategy/FUNCTION.md", ref={ref})
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/business-strategy/STANDARDS.md", ref={ref})
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/business-strategy/VOCABULARY.md", ref={ref})
```

Where `{ref}` comes from `ofm-bindings.yaml` methodology.ref (default: `main`).

## Commands

```bash
/sulis-studio-strategy:vision              # Create or view product vision
/sulis-studio-strategy:strategy            # Define strategic bets
/sulis-studio-strategy:principles          # Define decision principles
/sulis-studio-strategy:anti-goals          # Define what you won't do
/sulis-studio-strategy:bmc                 # Business Model Canvas
/sulis-studio-strategy:commercial          # Pricing and packaging
/sulis-studio-strategy:gtm                 # Go-to-market planning
/sulis-studio-strategy:roadmap             # View and manage roadmap
/sulis-studio-strategy:competitive-research # Competitive landscape analysis
/sulis-studio-strategy:company-research    # Company deep-dive
/sulis-studio-strategy:brand-research      # Brand and domain research
/sulis-studio-strategy:win-loss-analysis   # Win/loss pattern analysis
```

## Strategic Artifact Lifecycle

Strategic artifacts are version-controlled documents stored at canonical locations under `product/`.

| Artifact | Location | Outcome |
|----------|----------|---------|
| VISION.md | `product/offerings/{offering}/` | strategic-positioning |
| STRATEGY.md | `product/offerings/{offering}/` | strategy-formulation |
| PRINCIPLES.md | `product/organization/` | principles-codification |
| ANTI_GOALS.md | `product/offerings/{offering}/` | strategic-positioning |
| COMMERCIAL.md | `product/offerings/{offering}/` | commercial-validation |
| BMC.md | `product/organization/` | commercial-validation |
| GTM_PLAN.md | `product/offerings/{offering}/` | gtm-planning |
| ROADMAP.md | `product/roadmap/` | product-roadmapping |

## Standards

- **Strategy-as-Code** -- Strategic decisions live in git, not slide decks
- **Change Protocol** -- Changes require rationale, impact assessment, founder review
- **Stability Metric** -- Target <2 changes per quarter per artifact (health indicator, not hard limit)
- **Extraction Mode** -- Supports both creation and extraction from existing materials
