# GTM Planning Skill

> **Purpose:** Guide Go-to-Market planning using Crossing the Chasm methodology,
> beachhead market selection, positioning, and launch readiness assessment.
>
> **Command:** `/sulis gtm`
> **Reference:** Moore, G. (2014) *Crossing the Chasm*. 3rd edn. HarperBusiness.
>
> **CRITICAL REFERENCE:** `methodology/standards/CRITICAL_THINKING_STANDARD.md`
> GTM planning MUST include:
> - **Pre-Mortem:** Before finalizing, document "If this launch fails, it will be because..."
> - **Positioning Validation:** Positioning statements must cite actual customer evidence
> - **Market Size Skepticism:** TAM/SAM/SOM claims must cite sources or mark as "ESTIMATE"

---

## Command Integration

This skill is invoked via `/sulis gtm` and supports multiple modes:

```bash
/sulis gtm "product/feature"                  # Full GTM planning
/sulis gtm "product" --beachhead              # Beachhead market selection
/sulis gtm "product" --positioning            # Positioning exercise
/sulis gtm "product" --readiness              # Launch readiness check
/sulis gtm "product" --chasm                  # Chasm analysis
```

### Output Locations

| Mode | Output Location |
|------|-----------------|
| Full GTM | `features/{feature}/GTM_PLAN.md` or `product/gtm/{product}.md` |
| Beachhead | Same as above with beachhead section |
| Positioning | Same as above with positioning section |
| Launch Readiness | `features/{feature}/LAUNCH_READINESS.md` |

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### GTM Action Verbs
go to market, go-to-market, gtm, launch, release, ship, deploy to market,
bring to market, market launch, product launch, feature launch, commercial launch,
releasing, shipping, launching, rolling out, going live

### Crossing the Chasm Keywords
crossing the chasm, chasm, technology adoption, adoption curve, adoption lifecycle,
early adopters, early majority, late majority, laggards, innovators,
pragmatists, visionaries, bowling alley, whole product, tornado, main street

### Market Strategy Keywords
beachhead, beachhead market, target market, market entry, market penetration,
segment selection, niche market, initial market, first market, market focus,
land and expand, wedge strategy, expansion strategy

### Positioning Keywords
positioning, market positioning, product positioning, competitive positioning,
positioning statement, value proposition, differentiation, unique selling point,
messaging, narrative, story, pitch, positioning exercise

### Launch Keywords
launch plan, launch readiness, launch checklist, ready to launch, launch criteria,
launch gate, pre-launch, post-launch, launch metrics, launch day,
release plan, release readiness, ship criteria

### Channel Keywords
channel strategy, distribution, sales channel, go-to-market channel,
direct sales, self-serve, partner channel, reseller, marketplace,
channel mix, channel selection

---

## When This Skill Activates

**ACTIVATE for:**
- "Plan the go-to-market for our new feature"
- "How do we cross the chasm?"
- "What should our beachhead market be?"
- "Create a positioning statement"
- "Are we ready to launch?"
- "What's our channel strategy?"
- "How do we reach early adopters?"

**DO NOT ACTIVATE for (use other skills):**
- "Design the feature" -> feature-lifecycle
- "Price the product" -> COMMERCIAL.md / Van Westendorp
- "Research the market" -> competitive-research
- "Build the feature" -> implement

---

## The Crossing the Chasm Framework

### Technology Adoption Lifecycle

```
    Adoption Curve (% of market)
    │
    │         ┌───────────────────────────────────────────────────┐
    │         │                      THE CHASM                    │
    │         │         ↓                                         │
    │      ┌──┴──┐   ┌──┴──┐   ┌───────┐   ┌───────┐   ┌───────┐
    │      │ INN │   │ EA  │   │  EM   │   │  LM   │   │ LAG   │
    │    ──┤     ├───┤     ├───┤       ├───┤       ├───┤       ├──
    │      │2.5% │   │13.5%│   │  34%  │   │  34%  │   │  16%  │
    │      └─────┘   └─────┘   └───────┘   └───────┘   └───────┘
    │
    └─────────────────────────────────────────────────────────────→ Time

    INN = Innovators (Technology Enthusiasts)
    EA  = Early Adopters (Visionaries)
    EM  = Early Majority (Pragmatists)
    LM  = Late Majority (Conservatives)
    LAG = Laggards (Skeptics)
```

### Segment Characteristics

| Segment | Mindset | Buying Behavior | Reference Base |
|---------|---------|-----------------|----------------|
| **Innovators** | Technology for its own sake | Self-serve, will tolerate bugs | Other innovators |
| **Early Adopters** | Strategic advantage seekers | Will customize, high touch | Innovators |
| **Early Majority** | Pragmatic productivity gains | Need complete solution, references | Other pragmatists |
| **Late Majority** | Risk-averse, proven solutions | Need heavy support, low risk | Industry standards |
| **Laggards** | Tradition-bound, skeptical | Only when required | N/A |

### The Chasm Explained

> **The Chasm:** The gap between Early Adopters and Early Majority is NOT
> just another adoption transition - it's a fundamentally different buying
> process that requires a complete GTM reset.

| Pre-Chasm (Visionaries) | Post-Chasm (Pragmatists) |
|-------------------------|--------------------------|
| Buy the vision | Buy the whole product |
| Willing to customize | Want out-of-box solution |
| Risk-tolerant | Risk-averse |
| Reference other visionaries | Reference other pragmatists |
| Project-based purchase | Standards-based purchase |
| High touch sales | Scalable sales |

---

## Beachhead Market Selection

> **"The D-Day Strategy:** Focus all resources on taking one beach,
> then use that as a launching point to take the next."

### Selection Criteria

| Criterion | Weight | Questions |
|-----------|--------|-----------|
| **Compelling Reason to Buy** | 30% | Is there urgent pain? Budget allocated? |
| **Whole Product Feasibility** | 25% | Can we deliver 100% solution? |
| **Competition** | 15% | Can we be #1 in this segment? |
| **Strategic Value** | 15% | Does this lead to adjacent markets? |
| **Access** | 15% | Can we reach and sell to them? |

### Beachhead Evaluation Matrix

```markdown
## Beachhead Candidate Evaluation

| Criterion | Segment A | Segment B | Segment C |
|-----------|-----------|-----------|-----------|
| **Compelling Reason (30%)** | {1-5} | {1-5} | {1-5} |
| Pain urgency | | | |
| Budget exists | | | |
| Active search | | | |
| **Whole Product (25%)** | {1-5} | {1-5} | {1-5} |
| Core complete | | | |
| Integrations ready | | | |
| Support capable | | | |
| **Competition (15%)** | {1-5} | {1-5} | {1-5} |
| Can be #1 | | | |
| Differentiated | | | |
| **Strategic Value (15%)** | {1-5} | {1-5} | {1-5} |
| Adjacent markets | | | |
| Reference value | | | |
| **Access (15%)** | {1-5} | {1-5} | {1-5} |
| Can reach | | | |
| Sales cycle fit | | | |
| **WEIGHTED SCORE** | {score} | {score} | {score} |
```

### The Bowling Alley Strategy

After taking the beachhead, expansion follows the "bowling alley":

```
BEACHHEAD      ADJACENT 1      ADJACENT 2      TORNADO
  [B] ────────→ [1] ──────────→ [2] ─────────→ [T]
   │             │               │
   │  Word of    │  Reference    │  Market
   │  mouth      │  selling      │  momentum
   └─────────────┴───────────────┘

Each "pin" is a niche segment. Hit one, it knocks down the next.
```

---

## Whole Product Concept

> **"The Pragmatist's Checklist:** They don't buy products, they buy
> solutions. The whole product is everything needed to achieve the
> compelling reason to buy."

### Whole Product Layers

```
┌───────────────────────────────────────────────────────────────┐
│                    WHOLE PRODUCT                               │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │               AUGMENTED PRODUCT                          │  │
│  │  ┌───────────────────────────────────────────────────┐  │  │
│  │  │           EXPECTED PRODUCT                         │  │  │
│  │  │  ┌─────────────────────────────────────────────┐  │  │  │
│  │  │  │         GENERIC PRODUCT                     │  │  │  │
│  │  │  │  (Core technology/capability)               │  │  │  │
│  │  │  └─────────────────────────────────────────────┘  │  │  │
│  │  │  + Minimum capabilities for target market         │  │  │
│  │  └───────────────────────────────────────────────────┘  │  │
│  │  + Capabilities matching competition + best practice    │  │
│  └─────────────────────────────────────────────────────────┘  │
│  + Future potential, ancillary products, add-ons              │
└───────────────────────────────────────────────────────────────┘
```

### Whole Product Checklist

| Component | Status | Owner/Partner | Gap Closure Plan |
|-----------|--------|---------------|------------------|
| **Core Product** | | | |
| {Feature A} | {Ready/Gap} | Internal | {Plan} |
| {Feature B} | {Ready/Gap} | Internal | {Plan} |
| **Integrations** | | | |
| {Integration 1} | {Ready/Gap} | Partner/Build | {Plan} |
| {Integration 2} | {Ready/Gap} | Partner/Build | {Plan} |
| **Services** | | | |
| Implementation support | {Ready/Gap} | Internal/Partner | {Plan} |
| Training | {Ready/Gap} | Internal | {Plan} |
| Support | {Ready/Gap} | Internal | {Plan} |
| **Ecosystem** | | | |
| Documentation | {Ready/Gap} | Internal | {Plan} |
| Community | {Ready/Gap} | Internal | {Plan} |
| Marketplace | {Ready/Gap} | Partner | {Plan} |

---

## Positioning Framework

### Positioning Statement Template

> **For** {target customer - beachhead segment}
> **Who** {statement of the compelling need or opportunity}
> **The** {product name} **is a** {product category}
> **That** {statement of key benefit - the compelling reason to buy}
> **Unlike** {primary competitive alternative}
> **Our product** {statement of primary differentiation}

### Positioning by Adoption Segment

| Segment | Position As | Emphasize |
|---------|-------------|-----------|
| **Innovators** | Cutting-edge technology | Technical innovation, APIs |
| **Early Adopters** | Strategic advantage | Vision, customization, ROI |
| **Early Majority** | Productivity solution | Ease of use, support, references |
| **Late Majority** | Industry standard | Risk reduction, proven track record |

### Competitive Positioning Map

```
                   HIGH PRICE
                      │
                      │      Enterprise
        Specialized   │        │
            │         │        │
            └─────────┼────────┘
                      │
    ──────────────────┼──────────────────
                      │
        Budget        │      {Your
            │         │      Position}
            └─────────┼────────┘
                      │
                   LOW PRICE

          NARROW ←────┼────→ BROAD
          SCOPE       │      SCOPE
```

---

## Channel Strategy

### Channel Selection Matrix

| Channel | Best For | Cost | Control | Scale |
|---------|----------|------|---------|-------|
| **Direct Sales** | High-touch, complex | High | High | Low |
| **Inside Sales** | Mid-market, demo-driven | Medium | High | Medium |
| **Self-Serve** | Simple, low-touch | Low | High | High |
| **Channel Partners** | Market access, expertise | Medium | Low | High |
| **Marketplace** | Discovery, trust | Low-Medium | Low | High |
| **OEM** | Embedded distribution | Low | Low | Very High |

### Channel by Adoption Segment

| Segment | Primary Channel | Sales Motion |
|---------|-----------------|--------------|
| **Innovators** | Self-serve, community | Inbound, technical |
| **Early Adopters** | Direct sales | Consultative, vision-selling |
| **Early Majority** | Inside sales, partners | Reference-based, ROI |
| **Late Majority** | Partners, marketplace | Standardized, low-risk |

### Channel Readiness Checklist

| Element | Ready? | Notes |
|---------|--------|-------|
| **Self-Serve** | | |
| Sign-up flow | {Y/N} | |
| Onboarding | {Y/N} | |
| Self-service support | {Y/N} | |
| Pricing page | {Y/N} | |
| **Sales-Assisted** | | |
| Sales playbook | {Y/N} | |
| Demo environment | {Y/N} | |
| ROI calculator | {Y/N} | |
| Contract templates | {Y/N} | |
| **Partner** | | |
| Partner program | {Y/N} | |
| Partner portal | {Y/N} | |
| Co-marketing | {Y/N} | |

---

## Launch Readiness Assessment

### Launch Readiness Checklist

```markdown
## Launch Readiness: {Product/Feature}

**Target Launch Date:** {Date}
**Beachhead Market:** {Segment}
**Go/No-Go Decision:** {Date}

### PRODUCT READINESS

| Item | Owner | Status | Blocker? |
|------|-------|--------|----------|
| Core functionality complete | | {Ready/Not Ready} | |
| Whole product gaps closed | | {Ready/Not Ready} | |
| Quality/stability acceptable | | {Ready/Not Ready} | |
| Performance meets requirements | | {Ready/Not Ready} | |
| Security review complete | | {Ready/Not Ready} | |

### MARKET READINESS

| Item | Owner | Status | Blocker? |
|------|-------|--------|----------|
| Beachhead segment validated | | {Ready/Not Ready} | |
| Positioning finalized | | {Ready/Not Ready} | |
| Competitive differentiation clear | | {Ready/Not Ready} | |
| Pricing validated | | {Ready/Not Ready} | |

### CHANNEL READINESS

| Item | Owner | Status | Blocker? |
|------|-------|--------|----------|
| Primary channel operational | | {Ready/Not Ready} | |
| Sales/signup flow tested | | {Ready/Not Ready} | |
| Partner enablement complete | | {Ready/Not Ready} | |

### MARKETING READINESS

| Item | Owner | Status | Blocker? |
|------|-------|--------|----------|
| Messaging finalized | | {Ready/Not Ready} | |
| Website/landing pages live | | {Ready/Not Ready} | |
| Launch content ready | | {Ready/Not Ready} | |
| PR/announcement planned | | {Ready/Not Ready} | |

### OPERATIONS READINESS

| Item | Owner | Status | Blocker? |
|------|-------|--------|----------|
| Support trained | | {Ready/Not Ready} | |
| Monitoring in place | | {Ready/Not Ready} | |
| Escalation path defined | | {Ready/Not Ready} | |
| Scale capacity ready | | {Ready/Not Ready} | |

### PRE-MORTEM (MANDATORY)

> **Critical Thinking Standard:** Before finalizing, document potential failure reasons.
> Be honest - this protects against blind optimism and prepares mitigation strategies.

**If this launch fails, the most likely reasons are:**

1. **Market Risk:** {What could we be wrong about regarding market demand?}
   - Mitigation: {How we would address}

2. **Product Risk:** {What could prevent the product from delivering value?}
   - Mitigation: {How we would address}

3. **Channel Risk:** {What could prevent us from reaching customers?}
   - Mitigation: {How we would address}

4. **Competitive Risk:** {How could competitors respond or outmaneuver us?}
   - Mitigation: {How we would address}

5. **Execution Risk:** {What operational issues could derail the launch?}
   - Mitigation: {How we would address}

**What would make us STOP or PIVOT:**
- {Specific signal 1}
- {Specific signal 2}
- {Specific signal 3}

**Confidence Assessment:**
- Market validation evidence strength: {STRONG / MODERATE / WEAK}
- Positioning validation source: {Customer quotes / Assumed / Untested}
- TAM/SAM estimate basis: {Cited research / Industry estimate / UNVALIDATED}

---

### LAUNCH METRICS DEFINED

| Metric | Target | Measurement |
|--------|--------|-------------|
| Signups/Leads | {X} | {How measured} |
| Activation rate | {X}% | {How measured} |
| Time to value | {X days} | {How measured} |
| NPS/Satisfaction | {X} | {How measured} |

### GO/NO-GO DECISION

**Critical Blockers:** {None / List}
**Recommendation:** {GO / NO-GO / CONDITIONAL}
**Conditions (if conditional):** {List}
```

---

## GTM Plan Template

```markdown
# Go-to-Market Plan: {Product/Feature}

**Date:** {Date}
**Owner:** {Name}
**Status:** Draft | In Review | Approved

---

## Executive Summary

{2-3 paragraph summary of GTM strategy}

---

## Market Context

### Target Market

**Beachhead Segment:** {Segment description}
**Size:** {TAM/SAM/SOM}
**Compelling Reason to Buy:** {Pain point}

### Adoption Stage

**Current Position:** {Pre-Chasm / Crossing / Post-Chasm}
**Target Customers:** {Innovators / Early Adopters / Early Majority}

### Competition

| Competitor | Position | Our Differentiation |
|------------|----------|---------------------|
| {Comp A} | {Position} | {How we're different} |
| {Comp B} | {Position} | {How we're different} |

---

## Positioning

### Positioning Statement

For {target customer}
Who {compelling need}
The {product} is a {category}
That {key benefit}
Unlike {alternative}
Our product {differentiation}

### Key Messages

| Audience | Message | Proof Point |
|----------|---------|-------------|
| {Segment A} | {Message} | {Evidence} |
| {Segment B} | {Message} | {Evidence} |

---

## Whole Product

### Product Readiness

| Component | Status | Gap Closure |
|-----------|--------|-------------|
| {Component} | {Ready/Gap} | {Plan} |

### Partner Requirements

| Partner Type | Partners | Status |
|--------------|----------|--------|
| Integration | {Partners} | {Status} |
| Implementation | {Partners} | {Status} |
| Reseller | {Partners} | {Status} |

---

## Channel Strategy

### Primary Channel

**Channel:** {Direct / Inside Sales / Self-Serve / Partner}
**Rationale:** {Why this channel for this segment}

### Sales Motion

| Stage | Activities | Tools/Content |
|-------|------------|---------------|
| Awareness | {Activities} | {Content} |
| Evaluation | {Activities} | {Content} |
| Purchase | {Activities} | {Content} |
| Onboarding | {Activities} | {Content} |

---

## Pricing

**Model:** {Subscription / Usage / Tiered}
**Price Point:** {$X}
**Rationale:** {Why this price}

Reference: COMMERCIAL.md, Van Westendorp analysis

---

## Launch Plan

### Timeline

| Milestone | Date | Owner |
|-----------|------|-------|
| Beta | {Date} | {Owner} |
| Limited GA | {Date} | {Owner} |
| Full GA | {Date} | {Owner} |

### Launch Activities

| Activity | Date | Owner | Status |
|----------|------|-------|--------|
| {Activity} | {Date} | {Owner} | {Status} |

---

## Metrics

### Success Metrics

| Metric | 30-Day | 90-Day | 1-Year |
|--------|--------|--------|--------|
| {Metric 1} | {Target} | {Target} | {Target} |
| {Metric 2} | {Target} | {Target} | {Target} |

### Leading Indicators

| Indicator | Target | Measurement |
|-----------|--------|-------------|
| {Indicator} | {Target} | {How} |

---

## Risks and Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| {Risk} | {H/M/L} | {H/M/L} | {Plan} |

---

## Bowling Alley (Expansion Plan)

### Adjacent Segments

| Segment | Timing | Entry Strategy |
|---------|--------|----------------|
| {Segment 1} | +{X} months | {Strategy} |
| {Segment 2} | +{X} months | {Strategy} |

---

## References

- COMMERCIAL.md - Pricing philosophy
- BUSINESS_MODEL_CANVAS.md - Full business model
- features/{feature}/ - Feature artifacts
- product/research/competitive/ - Market research
```

---

## Integration with OFM

### Feature GTM Timing

| Feature Phase | GTM Activity |
|-----------|--------------|
| **Design** | Preliminary beachhead identification |
| **Plan** | Whole product gap analysis |
| **Implement** | Channel/partner preparation |
| **Deploy** | Launch readiness, GTM execution |
| **Complete** | Metrics review, expansion planning |

### Artifact Integration

| Feature Artifact | GTM Input/Output |
|--------------|------------------|
| PR_FAQ.md | Informs positioning and messaging |
| USER_GUIDE.md | Defines whole product scope |
| COMMERCIAL context | Pricing for GTM plan |
| TEST_SCENARIOS.md | Quality gates for launch |
| DESIGN.md | Integration partner requirements |

---

## References

- Moore, G. (2014) *Crossing the Chasm: Marketing and Selling Disruptive Products
  to Mainstream Customers*. 3rd edn. New York: HarperBusiness.
- Moore, G. (1999) *Inside the Tornado: Strategies for Developing, Leveraging,
  and Surviving Hypergrowth Markets*. New York: HarperBusiness.
- Blank, S. and Dorf, B. (2012) *The Startup Owner's Manual*. Pescadero: K&S Ranch.
- Ries, A. and Trout, J. (2001) *Positioning: The Battle for Your Mind*.
  New York: McGraw-Hill.
