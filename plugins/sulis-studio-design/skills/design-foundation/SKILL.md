# Design Foundation Skill

> **"The system before the expression."**
>
> This skill establishes the design language, design tokens (three-tier
> architecture), and human interface guidelines that all other design
> outcomes consume. Foundation must complete before visual identity or
> customer experience can begin.
>
> **Philosophy:** Design starts with the system. The language must be
> defined before it can be expressed visually or experientially.

---

## Command Integration

This skill is invoked via `/sulis design-foundation`:

```bash
/sulis design-foundation                    # View current design system state
/sulis design-foundation create             # Guided design language creation
/sulis design-foundation create --from {file.md}  # Extract from existing design materials
/sulis design-foundation evolve             # Evolve design system with new inputs
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "design language", "design tokens", "design system", "HIG"
- "create design system", "establish design language"
- "human interface guidelines", "interaction patterns"
- "token architecture", "design foundation"

### Broad Match (Discovery)
- tokens, typography, spacing, colours, palette, breakpoints
- components, patterns, states, responsive, theming

---

## Execution

### Outcome

Invoke `design-foundation` via the outcome-executor:

```
Outcome: design-foundation
Path: methodology/delivery/design/outcomes/design-foundation/OUTCOME.md
```

### Prerequisites

| Input | Required | Source |
|-------|----------|--------|
| BRAND.md | Yes | `product/organization/BRAND.md` (from business-strategy studio) |
| TONE_OF_VOICE.md | Yes | `product/organization/TONE_OF_VOICE.md` (from business-strategy studio) |
| Existing design materials | No | Figma exports, style guides, CSS variables |
| IDENTITY.md | No | `product/organization/IDENTITY.md` |

### Outputs

| Artifact | Location |
|----------|----------|
| DESIGN_LANGUAGE.md | `product/design/DESIGN_LANGUAGE.md` |
| DESIGN_TOKENS.json | `product/design/DESIGN_TOKENS.json` |
| HIG.md | `product/design/HIG.md` |

### Standards Enforced

- **DS-01:** Three-tier token architecture (global -> alias -> component), W3C DTCG format
- **DS-02:** WCAG 2.1 AA contrast ratios verified at token level

### Sequencing

Design foundation is the root of the design dependency chain:

```
brand artifacts (strategy) -> design-foundation -> visual-identity + customer-experience -> coherence
```

If BRAND.md does not exist, recommend running identity articulation first.

---

## View Mode

When invoked without a subcommand, display the current state:

1. Check if `product/design/DESIGN_LANGUAGE.md` exists
2. Check if `product/design/DESIGN_TOKENS.json` exists
3. Check if `product/design/HIG.md` exists
4. Summarise what exists and what's missing
5. If all exist, show key metrics (token count, tier distribution, colour palette)
