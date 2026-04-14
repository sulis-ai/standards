# Identity Articulation Skill

> **"WHO you are before WHAT you build."**
>
> This skill crystallises organisational identity into three foundational
> artifacts: IDENTITY.md (WHO), BRAND.md (WHAT you believe visually and
> positionally), and TONE_OF_VOICE.md (HOW you communicate). These feed
> every downstream strategic artifact.
>
> **Philosophy:** Identity starts with beliefs. The WHY must be discovered
> before it can be validated or expressed.

---

## Command Integration

This skill is invoked via `/sulis identity`:

```bash
/sulis identity                    # View current identity artifacts
/sulis identity create             # Guided identity discovery (Golden Circle)
/sulis identity create --from {file.md}  # Extract from existing materials
/sulis identity evolve             # Evolve identity with new inputs
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "define identity", "create identity", "brand identity"
- "mission and values", "organizational identity", "who are we"
- "tone of voice", "brand voice", "communication style"
- "golden circle", "start with why"

### Broad Match (Discovery)
- identity, mission, values, brand, tone, voice, purpose, beliefs
- positioning, personality, expression, distinctiveness

---

## Execution

### Outcome

Invoke `identity-articulation` via the outcome-executor:

```
Outcome: identity-articulation
Path: methodology/outcomes/utility/identity-articulation/OUTCOME.md
```

### Two Modes

| Mode | When | Status |
|------|------|--------|
| **Creation** | No identity artifacts exist | Golden Circle discovery through guided dialogue |
| **Extraction** | Existing materials (brand guides, mission statements) | Document and formalise existing identity |

### Triad

| Lens | Question | Focus |
|------|----------|-------|
| **Belief Crystallizer** (Lead) | "What do we fundamentally believe?" | Core beliefs, founding story, WHY |
| **Authenticity Validator** | "Does this ring true?" | Consistency, honesty, distinctiveness |
| **Expression Architect** | "How do we communicate this?" | Voice, brand, external expression |

### Inputs

| Input | Required | Source |
|-------|----------|--------|
| Organisational context | Yes | Founder interviews, existing materials |
| Stakeholder access | Yes | Decision-makers who can commit to identity |
| Market context | No | `product/research/` |
| Existing identity materials | No | Legacy brand guides, mission statements |
| BUSINESS_CONTEXT.md | No | `product/context/BUSINESS_CONTEXT.md` |

### Outputs

| Artifact | Location |
|----------|----------|
| IDENTITY.md | `product/organization/IDENTITY.md` |
| BRAND.md | `product/organization/BRAND.md` |
| TONE_OF_VOICE.md | `product/organization/TONE_OF_VOICE.md` |

### Sequencing

Identity sits early in the strategy chain:

```
context → identity → positioning → strategy → commercial → gtm → roadmap
```

If business context coverage is below 40%, recommend running context intake first.

---

## View Mode

When invoked without a subcommand, display the current state of identity artifacts:

1. Check if `product/organization/IDENTITY.md` exists
2. Check if `product/organization/BRAND.md` exists
3. Check if `product/organization/TONE_OF_VOICE.md` exists
4. Summarise what exists and what's missing
5. If all exist, show key elements (mission, values, brand essence, tone)
