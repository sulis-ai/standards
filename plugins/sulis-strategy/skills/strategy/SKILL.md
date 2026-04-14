# Strategy Skill

> **"What we're betting on now."**
>
> This skill creates, evolves, and manages product strategy. It encodes the
> expertise of strategic planning—so defining your bets doesn't require
> decades of product leadership experience.
>
> **Philosophy:** Strategy is a hypothesis, not a plan. This skill helps
> you articulate and test your bets.
>
> **CRITICAL REFERENCE:** `methodology/standards/CRITICAL_THINKING_STANDARD.md`
> All strategic bets MUST include falsification criteria. Key requirements:
> - **Falsifiability:** Every bet must state "We will STOP if..."
> - **Pre-Mortem:** Document "If this fails, it will be because..."
> - **Review Triggers:** Define conditions that force re-evaluation

---

## Command Integration

This skill is invoked via `/sulis strategy`:

```bash
# CREATION & EVOLUTION
/sulis strategy create                        # Guided strategy creation
/sulis strategy create --from {file.md}       # Create from inputs (vision, research)
/sulis strategy evolve                        # Update strategy for new period
/sulis strategy evolve --from {file.md}       # Evolve with specific inputs

# VIEWING
/sulis strategy                               # View current strategy
/sulis strategy bets                          # View strategic bets
/sulis strategy focus                         # View NOW/NEXT/LATER

# VALIDATION
/sulis strategy check {journey}               # Check journey against strategy
```

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### Strategy Creation Keywords
create strategy, write strategy, define strategy, strategic plan, strategy document,
quarterly planning, annual planning, strategic bets, product strategy, roadmap strategy,
what to build next, prioritization, focus areas, strategic priorities

### Strategy Evolution Keywords
update strategy, evolve strategy, quarterly review, strategy refresh, reprioritize,
pivot strategy, shift focus, new quarter, planning cycle, OKR planning

### Strategy Validation Keywords
strategic fit, on strategy, off strategy, priority check, focus check,
now next later, strategic alignment, bet alignment

---

## Strategy Creation Workflow

> **Strategy answers: "Given our vision, what should we bet on NOW?"**
>
> Strategy is time-boxed (typically quarterly), specific, and testable.
> It's a hypothesis about what will move us toward the vision.

### The Strategy Framework

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           STRATEGY FRAMEWORK                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  VISION (Years)                                                             │
│  "Raising the floor for the next generation of innovators"                  │
│                              │                                               │
│                              ▼                                               │
│  STRATEGY (Quarters)                                                        │
│  "This quarter, we bet that [hypothesis] will move us toward the vision"   │
│                              │                                               │
│                              ▼                                               │
│  EXECUTION (Weeks)                                                          │
│  Journeys, features, tasks that execute on the strategy                    │
│                                                                              │
│  ────────────────────────────────────────────────────────────────────────   │
│                                                                              │
│  Strategy connects stable vision to dynamic execution.                      │
│  It's the "what we're betting on" layer.                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Phase 1: Context Gathering

Before creating strategy, gather:

```
INPUT SOURCES:
├── Vision (product/offerings/primary/VISION.md) - REQUIRED
├── Previous strategy (if exists)
├── Market research (product/research/)
├── Customer feedback
├── Competitive landscape
├── Resource constraints
└── User-provided inputs (--from flag)
```

**Key Questions:**
1. What does the vision tell us to prioritize?
2. What did we learn from the last period?
3. What market signals should we respond to?
4. What resources do we have?

### Phase 2: Strategic Bets

> **A bet is a hypothesis that, if true, moves us toward the vision.**

**Bet Formula:**

```
BET: [Name]

We believe that [action/investment]
Will result in [measurable outcome]
Because [rationale/evidence]

SUCCESS SIGNALS:
We'll know we're right when [success signal]

FAILURE SIGNALS (MANDATORY):
We'll know we're wrong when [failure signal]
We will STOP or PIVOT if: [specific measurable condition]
We will RE-EVALUATE if: [trigger condition]

PRE-MORTEM (MANDATORY):
If this bet fails, the most likely reasons are:
1. [Reason 1 - be honest about risks]
2. [Reason 2 - include uncomfortable truths]
3. [Reason 3 - what could we be wrong about?]

Investment: [Resources required]
Timeframe: [When we'll know]
Evidence Base: [What evidence supports this bet? How strong?]
```

**Quality Criteria for Bets:**
- [ ] Clearly derived from vision
- [ ] Testable within the strategy period
- [ ] Has success/failure signals defined
- [ ] **Has explicit "STOP if..." falsification criteria (MANDATORY)**
- [ ] **Has pre-mortem with 3+ failure reasons (MANDATORY)**
- [ ] Investment is sized and realistic
- [ ] Represents a real choice (we're NOT betting on alternatives)
- [ ] Evidence base is documented (avoid unfounded optimism)

### Phase 3: NOW/NEXT/LATER Prioritization

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         NOW / NEXT / LATER                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  NOW (This Quarter)                                                         │
│  ──────────────────                                                         │
│  Active work. Resources committed. Success criteria defined.                │
│  • Journey/Feature 1                                                        │
│  • Journey/Feature 2                                                        │
│                                                                              │
│  NEXT (Next Quarter)                                                        │
│  ───────────────────                                                        │
│  Planned but not started. Will begin when NOW completes.                   │
│  • Journey/Feature 3                                                        │
│  • Journey/Feature 4                                                        │
│                                                                              │
│  LATER (Future)                                                             │
│  ─────────────────                                                          │
│  On radar but not committed. May change based on learning.                 │
│  • Journey/Feature 5                                                        │
│  • Journey/Feature 6                                                        │
│                                                                              │
│  NOT DOING (Explicit)                                                       │
│  ────────────────────                                                       │
│  Opportunities we're explicitly passing on this period.                    │
│  • Opportunity A (reason)                                                   │
│  • Opportunity B (reason)                                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Prioritization Criteria:**

| Criterion | Weight | Questions |
|-----------|--------|-----------|
| **Vision Alignment** | 30% | Does this serve our WHY? |
| **Bet Alignment** | 25% | Does this test a strategic bet? |
| **Customer Impact** | 20% | How many users? How much pain? |
| **Feasibility** | 15% | Can we do this with current resources? |
| **Learning Value** | 10% | What will we learn even if it fails? |

### Phase 4: Success Metrics

> **Strategy without metrics is wishful thinking.**

**Metric Types:**

| Type | Purpose | Example |
|------|---------|---------|
| **Leading** | Early signals of progress | Weekly active users trying feature |
| **Lagging** | Outcome confirmation | Revenue from new segment |
| **Learning** | What we discovered | Customer interview insights |

**Metrics Formula:**

```
METRIC: [Name]

Definition: [Exactly what we're measuring]
Current: [Baseline value]
Target: [Goal for this period]
Source: [Where data comes from]
Frequency: [How often measured]

Leading indicators:
• [Early signal 1]
• [Early signal 2]
```

### Phase 5: Generate STRATEGY.md

```markdown
# Product Strategy

> **Period:** {Q1 2025 / H1 2025}
> **Theme:** {Strategic theme in ~5 words}
>
> {One paragraph summary of strategy}

---

## Strategic Context

### Vision Reminder
{Key points from VISION.md that guide this strategy}

### What We Learned Last Period
{Key learnings that inform this strategy}

### Market Context
{Relevant market signals}

---

## Strategic Bets

### Bet 1: {Name}

**Hypothesis:** We believe that {action}
will result in {outcome}
because {rationale}.

**Success Signal:** {How we'll know it's working}
**Failure Signal:** {How we'll know to stop}
**Investment:** {Resources}
**Timeframe:** {When we'll evaluate}

### Bet 2: {Name}

{Same structure}

---

## Priorities

### NOW (This Period)

| Priority | Journey/Feature | Bet Alignment | Success Metric |
|----------|-----------------|---------------|----------------|
| 1 | {Name} | Bet 1 | {Metric} |
| 2 | {Name} | Bet 2 | {Metric} |

### NEXT (Following Period)

| Priority | Journey/Feature | Dependency |
|----------|-----------------|------------|
| 1 | {Name} | {What must complete first} |

### LATER (On Radar)

- {Item 1}
- {Item 2}

### NOT DOING (Explicit Pass)

| Opportunity | Why We're Passing |
|-------------|-------------------|
| {Opportunity} | {Reason} |

---

## Success Metrics

### Primary Metrics

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| {Metric 1} | {value} | {value} | {On/Off track} |
| {Metric 2} | {value} | {value} | {On/Off track} |

### Leading Indicators

| Indicator | Current | Target | Frequency |
|-----------|---------|--------|-----------|
| {Indicator 1} | {value} | {value} | Weekly |

---

## Constraints

### Resources
{What we have to work with}

### Dependencies
{External dependencies}

### Risks
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| {Risk} | {H/M/L} | {H/M/L} | {Plan} |

---

## Review Schedule

**Weekly:** {What we check}
**Monthly:** {What we evaluate}
**End of Period:** {Full strategy review}

---

## References

- **Vision:** `product/offerings/primary/VISION.md`
- **Principles:** `product/organization/PRINCIPLES.md`
- **Journeys:** `product/offerings/primary/journeys/index.md`
- **Features:** `features/index.md`
```

---

## Strategy Evolution Workflow

> **Strategy evolves at period boundaries (quarterly) or when bets are invalidated.**

### When to Evolve

| Situation | Action |
|-----------|--------|
| New quarter/period | **Evolve** - Review bets, update priorities |
| Bet validated | **Evolve** - Double down or expand |
| Bet invalidated | **Evolve** - Pivot or abandon |
| Major market shift | **Evolve** - Reassess bets |
| Vision change | **Create new** - Strategy must align to new vision |

### Evolution Process

```
Step 1: Review current strategy performance
        ├── Which bets validated?
        ├── Which bets invalidated?
        └── What did we learn?

Step 2: Load new inputs
        ├── New research/feedback
        ├── Market changes
        └── Resource changes

Step 3: Update bets
        ├── Keep validated bets
        ├── Modify partially validated
        └── Replace invalidated

Step 4: Reprioritize NOW/NEXT/LATER
        └── Based on updated bets

Step 5: Reset metrics
        └── New baselines and targets
```

---

## Integration with OFM

### Journey Validation

Before starting a journey, check strategy alignment:

```
Journey: {name}
Strategy Period: {Q1 2025}

Bet Alignment: {Which bet does this test?}
Priority: {NOW / NEXT / LATER / NOT ALIGNED}
Metric Impact: {Which strategy metric?}

Recommendation: PROCEED / DEFER / REJECT
```

### Feature Context

When designing features, reference:

```markdown
## Strategic Context

**Strategy Period:** {Q1 2025}
**Aligned Bet:** {Bet name}
**Success Metric:** {How this contributes}
```

---

## Reference

- **Command:** `commands/sulis-strategy.md`
- **Vision:** `product/offerings/primary/VISION.md`
- **Strategy:** `product/offerings/primary/STRATEGY.md`
- **Principles:** `product/organization/PRINCIPLES.md`
