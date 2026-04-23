# Identity Articulation Skill

> **"WHY before HOW before WHAT."**
>
> This skill crystallises organisational identity through the Golden Circle
> methodology — discovering and articulating the beliefs, purpose, and
> distinctive assets that make the organisation substitution-proof.
>
> **Philosophy:** Identity is upstream of design. Visual work without
> crystallised identity is decoration.

---

## Command Integration

This skill is invoked via `/sulis-design:identity-articulation`:

```bash
/sulis-design:identity-articulation              # View current identity state
/sulis-design:identity-articulation create       # Guided identity crystallisation
/sulis-design:identity-articulation evolve       # Evolve identity with new strategic inputs
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "identity", "brand identity", "who are we", "why we exist"
- "golden circle", "identity articulation", "brand crystallisation"
- "distinctive assets", "substitution test", "brand positioning"
- "tone of voice", "brand voice", "brand beliefs"

### Broad Match (Discovery)
- mission, values, purpose, beliefs, personality, voice
- what makes us different, why would someone choose us

---

## Execution

### Outcome

Invoke `identity-articulation` via the outcome-executor:

```
Outcome: identity-articulation
Path: methodology/outcomes/utility/identity-articulation/OUTCOME.md
```

### Prerequisites

| Input | Required | Source |
|-------|----------|--------|
| VISION.md | Recommended | `product/offerings/primary/VISION.md` |
| STRATEGY.md | Recommended | `product/offerings/primary/STRATEGY.md` |
| Existing brand materials | No | Previous brand guidelines, about pages, pitch decks |

### Outputs

| Artifact | Location |
|----------|----------|
| IDENTITY.md | `product/organization/IDENTITY.md` |
| BRAND.md | `product/organization/BRAND.md` |
| TONE_OF_VOICE.md | `product/organization/TONE_OF_VOICE.md` |

### Standards Enforced

- **IDC-01:** Golden Circle integrity — WHY articulated before HOW and WHAT
- **IDC-02:** Competitor substitution test — 2+ competitors, each fails the substitution
- **IDC-03:** Distinctive Asset Strategy — 3-7 Primary Distinctive Assets documented in BRAND.md

### Sequencing

Identity articulation is the root of the design dependency chain:

```
identity-articulation -> design-foundation -> visual-identity + customer-experience -> coherence
```

May be skipped only when IDENTITY.md, BRAND.md, and TONE_OF_VOICE.md already exist
with `production-approved` provenance.

---

## View Mode

When invoked without a subcommand, display the current state:

1. Check if `product/organization/IDENTITY.md` exists
2. Check if `product/organization/BRAND.md` exists (with Distinctive Asset Strategy section)
3. Check if `product/organization/TONE_OF_VOICE.md` exists
4. Check provenance labels on each artifact
5. Summarise what exists, what's missing, and whether design-foundation can proceed
