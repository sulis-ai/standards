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

**Recommend the canonical model for the customer-value pattern, then check it.** Do
not present the table as a neutral menu (per CP-01..CP-05). Apply the convention map
below; only deviate when the user can name a specific constraint the canonical model
cannot satisfy.

**Canonical pricing model by customer-value pattern:**

| Customer-value pattern | Canonical model | Why this is the boring default |
|---|---|---|
| Predictable continuous value, sales-led mid-market+ | **Tiered subscription** (Salesforce, HubSpot pattern) | Forecastable revenue, well-understood unit economics, every CFO knows how to read it |
| Predictable continuous value, self-serve SMB | **Freemium → tiered subscription** (Notion, Linear pattern) | Free tier seeds the funnel; paid tiers convert when natural usage limits hit |
| Variable workload, infrastructure-style consumption | **Usage-based / metered** (AWS, Stripe, Vercel pattern) | Cost-to-serve scales with revenue; aligns customer ROI with spend |
| Collaboration value scales with team size | **Per-seat subscription** (Slack, Figma pattern) | Maps revenue to natural growth signal; easy procurement |
| Custom integration / regulatory / high-touch needs | **Enterprise (negotiated)** | Standard SaaS contracts don't accommodate procurement / security / SLA bespoke terms |
| One-time outcome, no recurring value | **One-time licence or transaction fee** | Subscription would create churn cosmetics without underlying value |

**Anti-conventions you DO NOT recommend by default** (require explicit rationale):

- "Pay what you want" / donation pricing — usually correlates with hobby product or
  ideological positioning, not commercial viability.
- Per-feature unbundled pricing — operationally expensive and friction-heavy; only
  recommend when the buyer explicitly demands à la carte.
- Custom bespoke pricing models — almost always reducible to one of the canonical
  models above; surface the canonical equivalent first.

**Reality probe before locking the model:** What do the user's top 3 competitors
charge, and on what unit? If the user's proposed model is materially different (not
just price level — model shape), name the convention they're departing from and
require the rationale. The competitive norm is part of the boring default per CP-04
(pattern-match to dominant player).

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
