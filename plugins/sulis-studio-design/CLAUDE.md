# Design Studio

This studio translates strategic direction into visual identity, design language, and customer experience. It consumes brand artifacts (BRAND.md, TONE_OF_VOICE.md) from the business-strategy studio and produces the design system that product-development consumes.

## Studio Context

On session start or when design work begins, fetch studio context from the methodology repo using GitHub MCP:

```
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/design/FUNCTION.md", ref={ref})
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/design/STANDARDS.md", ref={ref})
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/design/VOCABULARY.md", ref={ref})
```

Where `{ref}` comes from `ofm-bindings.yaml` methodology.ref (default: `main`).

## Commands

```bash
/sulis-studio-design:design-foundation     # Design language, tokens, and HIG
/sulis-studio-design:visual-identity       # Logo, colour, typography, iconography
/sulis-studio-design:customer-experience   # Target experience frameworks
/sulis-studio-design:design-coherence      # Cross-artifact consistency verification
```

## Design Artifact Lifecycle

Design artifacts are specification-as-deliverable documents stored at canonical locations under `product/design/` and `product/offerings/`.

| Artifact | Location | Outcome |
|----------|----------|---------|
| DESIGN_LANGUAGE.md | `product/design/` | design-foundation |
| DESIGN_TOKENS.json | `product/design/` | design-foundation |
| HIG.md | `product/design/` | design-foundation |
| Visual identity SVGs | `product/design/assets/` | visual-identity |
| USAGE_GUIDELINES.md | `product/design/` | visual-identity |
| VISUAL_IDENTITY_PACKAGE.md | `product/design/` | visual-identity |
| CUSTOMER_EXPERIENCE.md | `product/offerings/primary/` | customer-experience-design |
| COHERENCE_REPORT.md | `product/design/` | design-coherence |

## Internal Dependency Ordering

```
design-foundation -> visual-identity
design-foundation -> customer-experience-design
visual-identity + customer-experience-design -> design-coherence
```

design-foundation MUST complete first. visual-identity and customer-experience-design may execute in parallel. design-coherence runs after both.

## Standards

- **Three-Tier Token Architecture** -- Global -> alias -> component, W3C DTCG format
- **WCAG 2.1 AA** -- Accessibility verified at design time, not retrofitted
- **Systematic Identity Evaluation** -- Rand criteria, not subjective aesthetics
- **Human-Centred Design** -- ISO 9241-210 process, context before solutions
- **Cross-Outcome Coherence** -- Pairwise mechanistic checks between artifacts
- **Evidence-Based Behavioural Design** -- EAST framework with evidence citations

## Upstream Dependency

Requires brand artifacts from the business-strategy studio before design work begins:
- `product/organization/BRAND.md` -- Brand identity that design expresses
- `product/organization/TONE_OF_VOICE.md` -- Communication style
