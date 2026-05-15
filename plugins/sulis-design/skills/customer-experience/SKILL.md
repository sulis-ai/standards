# Customer Experience Skill

> **"Context before solutions. Evidence before intuition."**
>
> **Canonical methodology: ISO 9241-210 Human-Centred Design.** This is not
> one approach among several — it is the international standard for
> human-centred design and the default this skill always applies. Its four
> phases (specify context of use → specify user requirements → produce
> design solutions → evaluate against requirements) are the convention;
> deviations require an explicit reason cited in the artifact (e.g. a
> Design Sprint adaptation, lean-discovery constraint, or regulator-imposed
> alternative).
>
> Context-of-use analysis must precede design. Behavioural patterns must
> cite evidence, not rely on instinct.
>
> **Philosophy:** Experience design is a science-informed discipline.
> Every interaction principle traces to user research. Every behavioural
> nudge cites evidence (EAST, COM-B, dual-process — established frameworks,
> never bespoke). Per Convention Preference (CP-01), the canonical
> framework is the default; novel methodologies require explicit defence.

---

## Command Integration

This skill is invoked via `/sulis customer-experience`:

```bash
/sulis customer-experience                  # View current experience state
/sulis customer-experience create           # Guided experience framework creation
/sulis customer-experience create --from {file.md}  # Extract from existing UX materials
/sulis customer-experience evolve           # Evolve experience with new inputs
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "customer experience", "experience design", "CX design"
- "interaction principles", "experience framework"
- "behavioural design", "nudge design", "EAST framework"
- "human centred design", "ISO 9241"

### Broad Match (Discovery)
- experience, interaction, persona, journey, behaviour
- nudge, framing, progress, engagement, onboarding

---

## Execution

### Outcome

Invoke `customer-experience-design` via the outcome-executor:

```
Outcome: customer-experience-design
Path: methodology/delivery/design/outcomes/customer-experience-design/OUTCOME.md
```

### Prerequisites

| Input | Required | Source |
|-------|----------|--------|
| DESIGN_LANGUAGE.md | Yes | `product/design/DESIGN_LANGUAGE.md` (from design-foundation) |
| VISION.md | Yes | `product/offerings/primary/VISION.md` (personas, context of use) |
| BRAND.md | No | `product/organization/BRAND.md` (brand personality informs tone) |
| Journey definitions | No | `product/offerings/primary/journeys/` |
| User research | No | `product/knowledge/` |

### Outputs

| Artifact | Location |
|----------|----------|
| CUSTOMER_EXPERIENCE.md | `product/offerings/primary/CUSTOMER_EXPERIENCE.md` |

### Standards Enforced

- **DS-04:** ISO 9241-210 human-centred design process (context -> requirements -> design -> evaluate)
- **DS-08:** Evidence-based behavioural design using EAST framework with citations
- **DS-02:** WCAG 2.1 AA for interaction patterns

### Sequencing

Customer experience depends on design-foundation:

```
design-foundation -> customer-experience-design -> design-coherence
```

---

## View Mode

When invoked without a subcommand, display the current state:

1. Check if `product/offerings/primary/CUSTOMER_EXPERIENCE.md` exists
2. If it exists, show interaction principles and persona coverage
3. If it doesn't, check prerequisites and recommend next steps
