# Visual Identity Skill

> **"Systematic identity, not subjective aesthetics."**
>
> This skill produces visual identity assets -- logo, wordmark, colour palette,
> typography system, iconography, and patterns. Every identity element is
> evaluated against Rand criteria, not personal preference.
>
> **Philosophy:** Visual identity is a strategic expression of brand, not
> decoration. Every element earns its place through systematic evaluation.

---

## Command Integration

This skill is invoked via `/sulis visual-identity`:

```bash
/sulis visual-identity                      # View current visual identity state
/sulis visual-identity create               # Guided visual identity creation
/sulis visual-identity create --from {file.md}  # Extract from existing brand assets
/sulis visual-identity evolve               # Evolve identity with new inputs
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "visual identity", "logo design", "brand assets"
- "colour palette", "typography system", "iconography"
- "wordmark", "brand guidelines", "usage guidelines"

### Broad Match (Discovery)
- logo, wordmark, colours, fonts, icons, patterns
- brand, identity, assets, SVG, favicon

---

## Execution

### Outcome

Invoke `visual-identity` via the outcome-executor:

```
Outcome: visual-identity
Path: methodology/delivery/design/outcomes/visual-identity/OUTCOME.md
```

### Prerequisites

| Input | Required | Source |
|-------|----------|--------|
| DESIGN_LANGUAGE.md | Yes | `product/design/DESIGN_LANGUAGE.md` (from design-foundation) |
| DESIGN_TOKENS.json | Yes | `product/design/DESIGN_TOKENS.json` (from design-foundation) |
| BRAND.md | Yes | `product/organization/BRAND.md` (from business-strategy studio) |
| Existing brand assets | No | Logo files, Figma exports, brand guides |

### Outputs

| Artifact | Location |
|----------|----------|
| Visual identity SVGs | `product/design/assets/` |
| USAGE_GUIDELINES.md | `product/design/USAGE_GUIDELINES.md` |
| VISUAL_IDENTITY_PACKAGE.md | `product/design/VISUAL_IDENTITY_PACKAGE.md` |

### Standards Enforced

- **DS-03:** Systematic evaluation against Rand criteria (distinctiveness, memorability, adaptability, cultural appropriateness, production viability, convention-distinction balance)
- **DS-02:** WCAG 2.1 AA colour palette accessibility
- **DS-07:** Tri-track provenance for AI-generated assets

### Sequencing

Visual identity depends on design-foundation:

```
design-foundation -> visual-identity -> design-coherence
```

---

## View Mode

When invoked without a subcommand, display the current state:

1. Check if `product/design/assets/` contains SVG files
2. Check if `product/design/USAGE_GUIDELINES.md` exists
3. Check if `product/design/VISUAL_IDENTITY_PACKAGE.md` exists
4. Summarise what exists and what's missing
5. If assets exist, list them with sizes and provenance status
