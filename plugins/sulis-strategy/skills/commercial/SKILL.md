# Commercial Skill

> **"How we capture value."**
>
> This skill creates, evolves, and manages commercial models. It encodes
> the expertise of pricing and packaging—so monetization doesn't require
> decades of business experience.
>
> **Philosophy:** Pricing is a product decision. How we charge shapes
> how users experience the product.

---

## Command Integration

This skill is invoked via `/sulis commercial`:

```bash
# CREATION & EVOLUTION
/sulis commercial create                      # Guided commercial model creation
/sulis commercial create --from {file.md}    # Create from inputs (research, pricing data)
/sulis commercial evolve                      # Update commercial model
/sulis commercial evolve --from {file.md}    # Evolve with specific inputs

# VIEWING
/sulis commercial                             # View commercial model summary
/sulis commercial tiers                       # View tier structure
/sulis commercial philosophy                  # View pricing philosophy

# PRICING RESEARCH
/sulis commercial pricing {product}           # Run Van Westendorp analysis

# VALIDATION
/sulis commercial check {journey}             # Check journey commercial fit
```

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### Commercial Creation Keywords
create commercial model, pricing strategy, pricing model, monetization,
revenue model, how to price, tier design, packaging, freemium, subscription,
usage-based pricing, enterprise pricing, pricing page

### Pricing Research Keywords
van westendorp, price sensitivity, willingness to pay, price point,
optimal price, price testing, competitive pricing, price validation

### Commercial Evolution Keywords
update pricing, change tiers, new tier, pricing review, monetization change,
reprice, adjust pricing

---

## Commercial Model Creation Workflow

> **Commercial answers: "How do we capture value from the value we create?"**
>
> Good pricing aligns incentives—we make more when customers succeed more.

### The Commercial Framework

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       COMMERCIAL MODEL FRAMEWORK                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  PHILOSOPHY                                                                 │
│  ──────────                                                                 │
│  Core beliefs about how we capture value.                                  │
│  "We charge for outcomes, not access."                                      │
│                              │                                               │
│                              ▼                                               │
│  PRICING MODEL                                                              │
│  ─────────────                                                              │
│  The mechanism of how we charge.                                           │
│  Free / Freemium / Subscription / Usage / Enterprise                       │
│                              │                                               │
│                              ▼                                               │
│  TIER STRUCTURE                                                             │
│  ──────────────                                                             │
│  How we package features and limits.                                       │
│  Free / Pro / Team / Enterprise                                            │
│                              │                                               │
│                              ▼                                               │
│  JOURNEY MAPPING                                                            │
│  ──────────────                                                             │
│  Which journeys belong in which tiers.                                     │
│  Onboarding → Free, Growth → Paid, Admin → Enterprise                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Phase 1: Context Gathering

**Input Sources:**
```
├── Vision (product/offerings/primary/VISION.md) - REQUIRED
│   └── Who we serve shapes what we charge
├── Market research (product/research/)
│   └── Competitive pricing, Van Westendorp
├── Customer segments
│   └── Different segments, different willingness to pay
├── Cost structure
│   └── What it costs us to serve
└── User-provided inputs (--from flag)
```

**Key Questions:**
1. Who are we serving? (From vision)
2. What value do they get? (Value proposition)
3. What do competitors charge? (Market context)
4. What does it cost us? (Cost floor)
5. What would customers pay? (Willingness to pay)

### Phase 2: Pricing Philosophy

> **Philosophy guides specific pricing decisions.**

**Philosophy Questions:**

1. **Value Capture Timing**
   - Do we charge upfront or after value delivered?
   - Do we charge for access or usage?

2. **Incentive Alignment**
   - Does our revenue grow when customers succeed?
   - Do we penalize success (e.g., per-seat)?

3. **Transparency**
   - Can customers predict their bill?
   - Are there hidden costs?

4. **Free Tier Philosophy**
   - Is free a product or a trap?
   - What makes free genuinely useful?

**Philosophy Template:**

```markdown
## Pricing Philosophy

1. **{Principle 1}**
   {Explanation and rationale}

2. **{Principle 2}**
   {Explanation and rationale}

3. **{Principle 3}**
   {Explanation and rationale}
```

### Phase 3: Pricing Model Selection

| Model | Best For | Alignment | Complexity |
|-------|----------|-----------|------------|
| **Free** | Acquisition, community | High | Low |
| **Freemium** | Self-serve growth | High (if natural tiers) | Medium |
| **Subscription** | Predictable value | Medium | Low |
| **Usage-Based** | Variable workloads | High | High |
| **Tiered** | Segmented market | Medium | Medium |
| **Seat-Based** | Collaboration tools | Low-Medium | Low |
| **Enterprise** | Custom needs | Variable | High |

**Selection Criteria:**

| Criterion | Questions |
|-----------|-----------|
| **Value Pattern** | Continuous or burst? |
| **Usage Pattern** | Predictable or variable? |
| **Customer Segment** | Self-serve or sales-driven? |
| **Competitive Norm** | What do users expect? |
| **Cost Structure** | Fixed or usage-based? |

### Phase 4: Tier Design

**The Default 3-Tier Structure:**

| Tier | Purpose | Target | Features |
|------|---------|--------|----------|
| **Free** | Acquisition, activation | Individuals, evaluation | Core journey, limited |
| **Pro/Team** | Core value, growth | Teams, serious users | Full features, higher limits |
| **Enterprise** | Scale, compliance | Organizations | SSO, audit, support, SLA |

**Tier Boundary Principles:**

1. **Natural boundaries** - Limits feel natural, not arbitrary
2. **Value-driven upgrades** - Upgrade triggers = value moments
3. **No punishment for success** - Growth shouldn't feel penalizing
4. **Features over limits** - Prefer feature differentiation

**Tier Design Template:**

```markdown
### {Tier Name}

**Target:** {Who this is for}
**Price:** {$ amount and model}
**Purpose:** {Why this tier exists}

**Includes:**
- {Feature 1}
- {Feature 2}
- {Limit: X units}

**Upgrade Trigger:** {What makes users want more}
```

### Phase 5: Journey Mapping

> **Map user journeys to commercial treatment.**

| Journey Type | Default Treatment | Rationale |
|--------------|-------------------|-----------|
| **Onboarding** | Free | Reduce friction, prove value |
| **Daily Use (Basic)** | Freemium | Core accessible, power paid |
| **Daily Use (Advanced)** | Paid | Clear value delivery |
| **Growth/Team** | Pro tier | Team features = upgrade |
| **Admin/Compliance** | Enterprise | Organizational need |
| **Recovery** | Free | Don't charge to fix problems |
| **Migration** | Free/Subsidized | Reduce switching friction |

### Phase 6: Van Westendorp Pricing

> **Validate pricing with market research.**

See `skills/research/SKILL.md` for full Van Westendorp methodology.

**Key Price Points:**
- **PMC** (Point of Marginal Cheapness) - Price floor
- **OPP** (Optimal Price Point) - Starting price
- **IDP** (Indifference Price) - Target price
- **PME** (Point of Marginal Expensiveness) - Price ceiling

### Phase 7: Generate COMMERCIAL.md

```markdown
# Commercial Model

> **"How we capture value from the value we create."**
>
> This document defines our pricing philosophy, tier structure,
> and commercial treatment of user journeys.

---

## Philosophy

### Core Beliefs

1. **{Principle 1}**
   {Explanation}

2. **{Principle 2}**
   {Explanation}

3. **{Principle 3}**
   {Explanation}

### Commercial Anti-Patterns

Things we won't do:
- {Anti-pattern 1}
- {Anti-pattern 2}

---

## Pricing Model

**Primary Model:** {Freemium / Subscription / Usage / etc.}

**Rationale:** {Why this model for our product and customers}

---

## Tier Structure

### Free

**Target:** {Who}
**Price:** $0
**Purpose:** {Why}

**Includes:**
- {Feature/Limit}

**Excludes:**
- {Feature}

### Pro

**Target:** {Who}
**Price:** ${X}/month
**Purpose:** {Why}

**Includes:**
- Everything in Free
- {Additional feature/limit}

**Upgrade Trigger:** {What drives upgrade}

### Enterprise

**Target:** {Who}
**Price:** Custom
**Purpose:** {Why}

**Includes:**
- Everything in Pro
- {Enterprise features}

**Contact:** {How to engage}

---

## Journey Commercial Mapping

| Journey | Treatment | Tier | Metering |
|---------|-----------|------|----------|
| {Journey 1} | {Free/Paid} | {Tier} | {What to track} |
| {Journey 2} | {Free/Paid} | {Tier} | {What to track} |

---

## Billing Implementation

### Metering Points

| Metric | How Measured | Tier Limits |
|--------|--------------|-------------|
| {Metric 1} | {Method} | Free: X, Pro: Y |

### Overage Handling

| Tier | At Limit Behavior |
|------|-------------------|
| Free | {Block / Throttle / Prompt upgrade} |
| Pro | {Overage charge / Hard limit} |

---

## Competitive Context

| Competitor | Model | Price Point | Our Differentiation |
|------------|-------|-------------|---------------------|
| {Comp A} | {Model} | ${X} | {How we differ} |

---

## Pricing Validation

**Method:** {Van Westendorp / Conjoint / Customer interviews}
**Date:** {When validated}
**Key Finding:** {What we learned}

**Price Points:**
- PMC (Floor): ${X}
- OPP (Optimal): ${X}
- IDP (Target): ${X}
- PME (Ceiling): ${X}

---

## References

- **Vision:** `product/offerings/primary/VISION.md`
- **Strategy:** `product/offerings/primary/STRATEGY.md`
- **BMC:** `product/organization/BUSINESS_MODEL_CANVAS.md`
- **Pricing Research:** `product/research/pricing/`
```

---

## Commercial Evolution Workflow

### When to Evolve

| Situation | Action |
|-----------|--------|
| New tier needed | **Evolve** - Add tier |
| Pricing not competitive | **Evolve** - Adjust prices |
| New journey added | **Evolve** - Map to tier |
| Fundamental model change | **Create new** - New commercial model |

### Evolution Process

```
Step 1: Identify trigger
        ├── Market feedback?
        ├── Competitive pressure?
        └── New capability?

Step 2: Research
        ├── Van Westendorp for pricing
        ├── Competitive analysis
        └── Customer interviews

Step 3: Propose change
        ├── New pricing/tiers
        ├── Migration plan for existing customers
        └── Grandfather policy

Step 4: Validate
        └── Test with subset if possible

Step 5: Communicate
        └── Clear communication to customers

Step 6: Update COMMERCIAL.md
```

---

## Integration with OFM

### Feature Commercial Context

When designing features:

```markdown
## Commercial Context

**Tier Availability:** {Free / Pro / Enterprise / All}
**Metered:** {Yes/No}
**Billing Impact:** {How this affects billing}
**Upgrade Trigger:** {Does this drive upgrades?}
```

### Journey Commercial Classification

When defining journeys:

```markdown
## Commercial Classification

**Treatment:** {Free / Freemium / Paid / Enterprise}
**Tier:** {Which tier enables this journey}
**Rationale:** {Why this treatment}
**Metering:** {What to track}
**Upgrade Triggers:** {When users would upgrade}
```

---

## Reference

- **Command:** `commands/sulis-commercial.md`
- **Commercial:** `product/offerings/primary/COMMERCIAL.md`
- **BMC:** `product/organization/BUSINESS_MODEL_CANVAS.md`
- **Van Westendorp:** `skills/research/SKILL.md`
