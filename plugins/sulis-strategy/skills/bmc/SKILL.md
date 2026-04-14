# Business Model Canvas Skill

> **"How we create, deliver, and capture value—at a glance."**
>
> This skill creates, evolves, and uses the Business Model Canvas. It encodes
> the expertise of business model design—so understanding your business
> doesn't require an MBA.
>
> **Philosophy:** A business model should fit on one page. If you can't explain
> how you make money simply, you don't understand it yet.

---

## Command Integration

This skill is invoked via `/sulis bmc`:

```bash
# CREATION & EVOLUTION
/sulis bmc create                             # Guided canvas creation
/sulis bmc create --from {file.md}           # Create from inputs
/sulis bmc evolve                             # Update canvas
/sulis bmc evolve --from {file.md}           # Evolve with specific inputs

# VIEWING
/sulis bmc                                    # View full canvas
/sulis bmc {block}                            # View specific block
                                                  # (segments, value, channels, relationships,
                                                  #  revenue, resources, activities, partners, costs)

# ANALYSIS
/sulis bmc validate                           # Check canvas coherence
/sulis bmc unit-economics                     # Calculate unit economics
```

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### BMC Creation Keywords
business model canvas, bmc, create canvas, business model, value proposition canvas,
osterwalder, how we make money, revenue model, business model design,
customer segments, value proposition, channels, key resources, key activities

### BMC Analysis Keywords
unit economics, cac, ltv, payback period, gross margin, customer acquisition cost,
lifetime value, business viability, sustainable business, economics check

### BMC Evolution Keywords
update canvas, pivot, business model change, new segment, new channel,
new revenue stream, partnership change, cost restructure

---

## Business Model Canvas Framework

> **The canvas captures how value flows through your business.**

### The 9 Building Blocks

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       BUSINESS MODEL CANVAS                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┬─────────────┬─────────────┬─────────────┬─────────────┐   │
│  │             │             │             │             │             │   │
│  │     KEY     │     KEY     │    VALUE    │  CUSTOMER   │  CUSTOMER   │   │
│  │  PARTNERS   │ ACTIVITIES  │ PROPOSITION │ RELATION-   │  SEGMENTS   │   │
│  │             │             │             │   SHIPS     │             │   │
│  │    [8]      │    [7]      │    [2]      │    [4]      │    [1]      │   │
│  │             │             │             │             │             │   │
│  │             ├─────────────┤             ├─────────────┤             │   │
│  │             │             │             │             │             │   │
│  │             │     KEY     │             │  CHANNELS   │             │   │
│  │             │  RESOURCES  │             │             │             │   │
│  │             │             │             │    [3]      │             │   │
│  │             │    [6]      │             │             │             │   │
│  │             │             │             │             │             │   │
│  ├─────────────┴─────────────┴─────────────┴─────────────┴─────────────┤   │
│  │                                                                      │   │
│  │              COST STRUCTURE                    REVENUE STREAMS       │   │
│  │                  [9]                               [5]               │   │
│  │                                                                      │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  Fill in order: 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9                          │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Block Relationships

```
VALUE CREATION SIDE              VALUE DELIVERY SIDE
(How we produce value)           (How we reach customers)

┌─────────────────┐              ┌─────────────────┐
│  Key Partners   │              │Customer Segments│
│       [8]       │              │       [1]       │
└────────┬────────┘              └────────┬────────┘
         │                                │
         ▼                                ▼
┌─────────────────┐              ┌─────────────────┐
│ Key Activities  │◄────────────►│Value Proposition│
│       [7]       │              │       [2]       │
└────────┬────────┘              └────────┬────────┘
         │                                │
         ▼                                ▼
┌─────────────────┐              ┌─────────────────┐
│  Key Resources  │              │    Channels     │
│       [6]       │              │       [3]       │
└────────┬────────┘              └────────┬────────┘
         │                                │
         │                                ▼
         │                       ┌─────────────────┐
         │                       │Customer Relation│
         │                       │       [4]       │
         │                       └────────┬────────┘
         │                                │
         ▼                                ▼
┌─────────────────────────────────────────────────┐
│  Cost Structure [9]      Revenue Streams [5]    │
└─────────────────────────────────────────────────┘
```

---

## Canvas Creation Workflow

### Phase 1: Customer Segments [1]

> **"For whom are we creating value?"**

**Questions:**
- Who are our most important customers?
- What jobs are they trying to do?
- What pains do they experience?
- What gains do they seek?

**Segment Types:**
- Mass Market (no segmentation)
- Niche Market (specialized)
- Segmented (slight variations)
- Diversified (unrelated segments)
- Multi-sided (2+ interdependent)

**Output:**
```markdown
### Customer Segments

**Primary:** {Segment name}
- Jobs: {What they're trying to do}
- Pains: {What frustrates them}
- Gains: {What they want}

**Secondary:** {Segment name}
- Jobs: {What they're trying to do}
```

### Phase 2: Value Proposition [2]

> **"What value do we deliver?"**

**Questions:**
- What problem do we solve?
- What needs do we satisfy?
- What makes us different?

**Value Types:**
- Newness
- Performance
- Customization
- Getting the job done
- Design
- Brand/Status
- Price
- Cost reduction
- Risk reduction
- Accessibility
- Convenience

**Output:**
```markdown
### Value Proposition

**For** {segment}
**We provide** {value}
**That** {benefit}
**Unlike** {alternatives}
```

### Phase 3: Channels [3]

> **"How do we reach customers?"**

**Channel Phases:**
1. Awareness - How do they discover us?
2. Evaluation - How do they evaluate us?
3. Purchase - How do they buy?
4. Delivery - How do we deliver value?
5. After-sales - How do we support them?

**Channel Types:**
- Direct (own sales, web, stores)
- Indirect (partner stores, wholesalers)
- Partner (resellers, affiliates)

**Output:**
```markdown
### Channels

| Phase | Channel | Type |
|-------|---------|------|
| Awareness | {Channel} | {Direct/Partner} |
| Evaluation | {Channel} | {Direct/Partner} |
| Purchase | {Channel} | {Direct/Partner} |
| Delivery | {Channel} | {Direct/Partner} |
| Support | {Channel} | {Direct/Partner} |
```

### Phase 4: Customer Relationships [4]

> **"What relationship does each segment expect?"**

**Relationship Types:**
- Personal assistance
- Dedicated personal
- Self-service
- Automated services
- Communities
- Co-creation

**Goals:**
- Acquisition (get new customers)
- Retention (keep customers)
- Upselling (grow revenue per customer)

**Output:**
```markdown
### Customer Relationships

| Segment | Relationship | Goal |
|---------|--------------|------|
| {Segment} | {Type} | {Acquisition/Retention/Upsell} |
```

### Phase 5: Revenue Streams [5]

> **"For what value are customers willing to pay?"**

**Revenue Types:**
- Asset sale
- Usage fee
- Subscription
- Licensing
- Brokerage
- Advertising

**Pricing Mechanisms:**
- Fixed (list price, volume-based)
- Dynamic (negotiation, yield management)

**Output:**
```markdown
### Revenue Streams

| Segment | Revenue Type | Pricing | Est. % |
|---------|--------------|---------|--------|
| {Segment} | {Type} | ${X}/mo | {%} |
```

### Phase 6: Key Resources [6]

> **"What do we need to deliver our value proposition?"**

**Resource Types:**
- Physical (facilities, equipment)
- Intellectual (IP, patents, data)
- Human (expertise, culture)
- Financial (capital, credit)

**Output:**
```markdown
### Key Resources

| Resource | Type | Strategic Importance |
|----------|------|---------------------|
| {Resource} | {Type} | {Critical/Important/Nice} |
```

### Phase 7: Key Activities [7]

> **"What must we do to deliver our value proposition?"**

**Activity Categories:**
- Production (making, manufacturing)
- Problem-solving (consulting, knowledge)
- Platform/Network (managing, building)

**Output:**
```markdown
### Key Activities

| Activity | Category | Frequency |
|----------|----------|-----------|
| {Activity} | {Category} | {Daily/Weekly/Monthly} |
```

### Phase 8: Key Partners [8]

> **"Who helps us deliver value?"**

**Partnership Types:**
- Strategic alliances (non-competitors)
- Coopetition (competitors partnering)
- Joint ventures (new business)
- Buyer-supplier (reliability)

**Partnership Motivations:**
- Optimization (reduce cost)
- Risk reduction (reduce uncertainty)
- Resource acquisition (get capabilities)

**Output:**
```markdown
### Key Partners

| Partner | Type | What We Get | What They Get |
|---------|------|-------------|---------------|
| {Partner} | {Type} | {Value} | {Value} |
```

### Phase 9: Cost Structure [9]

> **"What are the most important costs?"**

**Cost Focus:**
- Cost-driven (minimize costs)
- Value-driven (premium focus)

**Cost Types:**
- Fixed (same regardless of volume)
- Variable (scales with volume)

**Output:**
```markdown
### Cost Structure

| Cost | Fixed/Variable | Est. Amount | % of Total |
|------|----------------|-------------|------------|
| {Cost} | {F/V} | ${X} | {%} |

**Characteristics:**
- Economies of scale: {Yes/No}
- Economies of scope: {Yes/No}
```

---

## Unit Economics Analysis

> **Validate the business model is sustainable.**

### Key Metrics

| Metric | Formula | Healthy Range |
|--------|---------|---------------|
| **CAC** | Marketing + Sales / New Customers | Varies |
| **LTV** | ARPU × Gross Margin × Customer Lifespan | 3x+ CAC |
| **LTV:CAC** | LTV / CAC | 3:1 or better |
| **Payback** | CAC / (ARPU × Gross Margin) | <12 months |
| **Gross Margin** | (Revenue - COGS) / Revenue | 70%+ for SaaS |

### Unit Economics Template

```markdown
## Unit Economics

### Customer Acquisition
- CAC: ${X}
- Breakdown: Marketing ${Y}, Sales ${Z}

### Customer Value
- ARPU: ${X}/month
- Gross Margin: {X}%
- Avg Lifespan: {X} months
- LTV: ${X}

### Efficiency
- LTV:CAC Ratio: {X}:1
- Payback Period: {X} months

### Assessment
{Sustainable / Needs improvement / Not viable}
```

---

## Canvas Validation

### Coherence Check

| Question | Pass Criteria |
|----------|---------------|
| Do segments match value proposition? | Each segment has clear value |
| Do channels reach segments? | All segments have channel coverage |
| Do relationships match segments? | Relationship type fits segment needs |
| Do revenue streams cover costs? | Revenue > Costs at target scale |
| Do resources enable activities? | All activities have required resources |
| Do partners fill gaps? | Resource gaps covered by partners |

### Red Flags

- Value proposition that doesn't match segments
- Channels that can't reach target segments
- Revenue that doesn't cover costs
- Missing critical resources with no partner coverage
- Unit economics that don't work at scale

---

## Canvas Evolution

### When to Evolve

| Situation | Action |
|-----------|--------|
| New customer segment | **Evolve** - Add segment, check value fit |
| New revenue stream | **Evolve** - Add stream, update costs |
| Partnership change | **Evolve** - Update partners, check activities |
| Pivot | **Create new** - Fundamental model change |

### Evolution Process

```
Step 1: Identify which block changed

Step 2: Trace dependencies
        └── Changes cascade through connected blocks

Step 3: Update affected blocks

Step 4: Re-validate coherence

Step 5: Re-calculate unit economics
```

---

## Generate BUSINESS_MODEL_CANVAS.md

See `product/organization/BUSINESS_MODEL_CANVAS.md` for the full template.

The canvas document should be updated whenever the business model changes,
and reviewed quarterly alongside strategy.

---

## Integration with OFM

### Journey Context

When defining journeys, reference canvas:

```markdown
## Business Model Context

**Segment:** {Which canvas segment}
**Value Element:** {Which value proposition element}
**Revenue Impact:** {How this affects revenue}
**Cost Impact:** {How this affects costs}
```

### Feature Commercial Context

When designing features, reference canvas:

```markdown
## Canvas Alignment

**Segment Served:** {Block 1}
**Value Delivered:** {Block 2}
**Channel Used:** {Block 3}
**Revenue Stream:** {Block 5}
```

---

## Reference

- **Command:** `commands/sulis-bmc.md`
- **BMC:** `product/organization/BUSINESS_MODEL_CANVAS.md`
- **Commercial:** `product/offerings/primary/COMMERCIAL.md`
- **Vision:** `product/offerings/primary/VISION.md`
- **Source:** Osterwalder & Pigneur (2010) *Business Model Generation*
