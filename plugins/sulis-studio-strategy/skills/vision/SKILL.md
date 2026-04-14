# Product Vision Skill

> **"The north star that guides every decision."**
>
> This skill creates, evolves, and validates product vision. It encodes the
> expertise of how to craft compelling vision documents—so defining your
> north star doesn't require decades of product experience.
>
> **Philosophy:** Vision creation is a skill that can be taught and encoded.
> This skill guides users through the process, not just the output.

---

## Command Integration

This skill is invoked via `/sulis vision`:

```bash
# CREATION & EVOLUTION (NEW)
/sulis vision create                          # Guided vision creation
/sulis vision create --from {file.md}         # Create from existing research/docs
/sulis vision evolve                          # Evolve existing vision with new inputs
/sulis vision evolve --from {file.md}         # Evolve using specific inputs

# VIEWING (Existing)
/sulis vision                                 # View vision summary
/sulis vision full                            # View all product context

# VALIDATION (Existing)
/sulis vision check {journey}                 # Validate journey against vision
/sulis vision principles                      # Show decision principles
/sulis vision strategy                        # Show current strategy
/sulis vision anti-goals                      # Show what we won't do
```

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### Vision Creation Keywords
create vision, write vision, define vision, vision statement, mission statement,
craft vision, develop vision, articulate vision, vision document, north star,
why we exist, product purpose, company mission, founding belief, core belief

### Vision Evolution Keywords
update vision, evolve vision, refine vision, revise vision, retrofit vision,
vision refresh, pivot vision, expand vision, sharpen vision, realign vision

### Golden Circle Keywords
why how what, golden circle, start with why, simon sinek, purpose driven,
belief statement, cause, movement, inspire action

### Vision Validation Keywords
check vision, validate vision, vision alignment, vision fit, on mission,
off mission, mission creep, scope creep, stay focused, strategic fit

---

## Vision Creation Workflow

> **"Start with WHY, then HOW, then WHAT."**
>
> Based on Simon Sinek's Golden Circle: People don't buy WHAT you do,
> they buy WHY you do it. The vision skill guides you from belief to action.

### The Golden Circle Framework

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           THE GOLDEN CIRCLE                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│                        ┌─────────────┐                                      │
│                        │             │                                      │
│                        │     WHY     │  ← Start here (Belief/Cause)         │
│                        │             │                                      │
│                        └──────┬──────┘                                      │
│                               │                                              │
│                    ┌──────────┴──────────┐                                  │
│                    │                     │                                  │
│                    │        HOW          │  ← Then this (Approach/Values)   │
│                    │                     │                                  │
│                    └──────────┬──────────┘                                  │
│                               │                                              │
│             ┌─────────────────┴─────────────────┐                           │
│             │                                   │                           │
│             │              WHAT                 │  ← Finally (Products)     │
│             │                                   │                           │
│             └───────────────────────────────────┘                           │
│                                                                              │
│  WHY  = The belief that drives everything (unchanging, years)               │
│  HOW  = The approach that embodies the belief (principles, values)          │
│  WHAT = The products/services that result (changes frequently)              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Phase 1: Discovery (Gather Inputs)

Before creating vision, gather available context:

```
INPUT SOURCES (check for each):
├── Existing research
│   ├── product/research/**/*.md
│   └── User-provided files (--from flag)
├── Market context
│   ├── CTRLPLANE_VISION.md (if exists)
│   └── product/research/competitive/*.md
├── Founder/team input
│   └── Interview via AskUserQuestion
└── Existing product context
    └── product/*.md (if partially filled)
```

**Step 1.1: Read Available Context**

```python
# Pseudocode for context gathering
inputs = []
if args.from_file:
    inputs.append(read(args.from_file))
if exists("product/research/"):
    inputs.extend(glob("product/research/**/*.md"))
if exists("CTRLPLANE_VISION.md"):
    inputs.append(read("CTRLPLANE_VISION.md"))
```

**Step 1.2: Extract Themes**

From inputs, identify:
- Recurring pain points (what problems keep appearing?)
- Beliefs (what opinions/values emerge?)
- Target users (who is being served?)
- Differentiation (what makes this different?)

### Phase 2: WHY - The Belief

> **The WHY is a belief, not a goal. Goals can be achieved; beliefs are lived.**

**Guiding Questions (ask user if not clear from inputs):**

1. **The Tension:** What do you see in the world that shouldn't be true?
   - "Right now, [X is broken/wrong/unfair]..."

2. **The Belief:** What do you believe should be true instead?
   - "We believe [alternative vision of the world]..."

3. **The Cause:** Why does this matter beyond making money?
   - "This matters because [human impact]..."

**WHY Statement Formula:**

```
We believe [core belief about how the world should work].

[The tension]: Right now, [what's wrong/broken].

[The cause]: [Why this matters / who benefits when we succeed].
```

**Quality Criteria for WHY:**
- [ ] It's a belief, not a product description
- [ ] It could inspire people who never use your product
- [ ] It's timeless (won't change when products change)
- [ ] It's specific enough to guide decisions
- [ ] Someone could disagree with it (it's an opinion)

### Phase 3: HOW - The Approach

> **The HOW is your unique approach to living the WHY.**

**Guiding Questions:**

1. **What principles guide your approach?**
   - How do you embody the belief in practice?

2. **What makes your approach different?**
   - Why will you succeed where others haven't?

3. **What will you NOT do?**
   - What approaches do you reject?

**HOW Statement Formula:**

```
We [approach verb] by [method].

Our approach:
1. [Principle 1]: [How it embodies the WHY]
2. [Principle 2]: [How it embodies the WHY]
3. [Principle 3]: [How it embodies the WHY]
```

**Quality Criteria for HOW:**
- [ ] Each principle traces back to the WHY
- [ ] They're actionable (guide daily decisions)
- [ ] They're differentiated (not generic "be excellent")
- [ ] They have trade-offs (choosing this means not that)

### Phase 4: WHAT - The Offerings

> **The WHAT is the tangible expression of WHY and HOW.**

**Guiding Questions:**

1. **What do you make/offer?**
   - Products, services, tools

2. **Who specifically is this for?**
   - Primary persona with context

3. **What problem does it solve for them?**
   - The job-to-be-done

**WHAT Section Formula:**

```
For [specific persona]
Who [job they're trying to do]
Our [product/service] is a [category]
That [key benefit]
Unlike [alternatives]
We [primary differentiation]
```

**Quality Criteria for WHAT:**
- [ ] Clearly derived from WHY and HOW
- [ ] Specific persona, not "everyone"
- [ ] Clear differentiation
- [ ] Benefit is outcome, not feature

### Phase 5: Synthesis - Generate VISION.md

Combine all elements into the VISION.md template:

```markdown
# Product Vision

> **"{Tagline - captures WHY in ~10 words}"**
>
> {One-liner - captures the full value proposition}

---

## Why We Exist

{The belief statement - 2-3 paragraphs}

### The Tension

{What's wrong with the world today}

### The Cause

{Why this matters, who benefits}

---

## Our Approach

{HOW we embody the belief}

### Core Principles

1. **{Principle 1}**
   {How it embodies the WHY}

2. **{Principle 2}**
   {How it embodies the WHY}

3. **{Principle 3}**
   {How it embodies the WHY}

---

## Who We Serve

### Primary Persona

**Name:** {Persona name}
**Role:** {Job title/function}
**Context:** {Situation, company size, industry}

**Goals:**
- {What they're trying to achieve}

**Pains:**
- {What frustrates them today}

**Quote:** "{Captures their mindset}"

### We Are NOT Building For

- {Explicitly excluded persona/segment}
- {Why we're not serving them}

---

## Value Proposition

**For** {target customer}
**Who** {statement of need}
**Our** {product} **is a** {category}
**That** {key benefit}
**Unlike** {alternatives}
**Our product** {primary differentiation}

---

## Success Looks Like

{How we'll know we're achieving the vision - not metrics, but outcomes}

---

## Time Horizon

**This vision guides decisions for:** {3-5 years typically}
**Review cadence:** {Annual or when strategy pivots}
```

---

## Vision Evolution Workflow

> **Visions should be stable but not static. Evolve when inputs change significantly.**

### When to Evolve (vs. Create New)

| Situation | Action |
|-----------|--------|
| New market research validates/refines understanding | **Evolve** |
| Pivot to different market/customer | **Create new** |
| Strategy shift within same mission | **Evolve** |
| Fundamental belief change | **Create new** |
| Adding new persona | **Evolve** |
| Abandoning core persona | **Create new** |

### Evolution Process

**Step 1: Load Current Vision**
```python
current_vision = read("product/offerings/primary/VISION.md")
```

**Step 2: Load New Inputs**
```python
new_inputs = read(args.from_file) if args.from_file else gather_from_user()
```

**Step 3: Identify Deltas**

| Section | Current | New Input | Delta |
|---------|---------|-----------|-------|
| WHY | {current} | {from input} | {change needed?} |
| HOW | {current} | {from input} | {change needed?} |
| WHAT | {current} | {from input} | {change needed?} |
| Persona | {current} | {from input} | {change needed?} |

**Step 4: Propose Changes**

Present changes to user for approval:
- What's changing and why
- What's staying the same
- Impact on downstream documents (Strategy, Journeys)

**Step 5: Update and Cascade**

After vision update:
1. Review STRATEGY.md for alignment
2. Review active journeys for vision fit
3. Note breaking changes in commit message

---

## Product Context Documents

```
product/
├── offerings/primary/
│   ├── VISION.md           # WHY we exist (stable)
│   ├── STRATEGY.md         # WHAT we're betting on (time-boxed)
│   ├── ANTI_GOALS.md       # WHAT we won't do (boundaries)
│   └── COMMERCIAL.md       # HOW we capture value
├── organization/
│   └── PRINCIPLES.md       # HOW we decide (rules)
└── index.md                # Quick reference
```

### Document Purposes

| Document | Purpose | Stability | Used For |
|----------|---------|-----------|----------|
| VISION.md | North star, mission, beliefs | Years | Journey validation, motivation |
| STRATEGY.md | Current focus, bets | Quarters | Priority decisions |
| PRINCIPLES.md | Decision rules | Evolves slowly | Consistent choices |
| ANTI_GOALS.md | Explicit boundaries | Evolves slowly | Scope decisions |

---

## Vision Validation Process

When validating a journey against vision:

### Step 1: Load Context

```python
# Pseudocode
vision = read("product/offerings/primary/VISION.md")
strategy = read("product/offerings/primary/STRATEGY.md")
principles = read("product/organization/PRINCIPLES.md")
anti_goals = read("product/offerings/primary/ANTI_GOALS.md")
journey = read(f"product/offerings/primary/journeys/{journey_name}/JOURNEY.md")
```

### Step 2: Evaluate Dimensions

#### Vision Fit

**Question:** Does this journey serve our stated vision?

**Evaluation:**
- Does the journey goal align with our mission?
- Does it serve our target customer?
- Does it embody our core beliefs?

**Scoring:**
- ✓ ALIGNED - Directly serves vision
- ⚠ PARTIAL - Tangentially related
- ✗ MISALIGNED - Doesn't serve vision

#### Persona Fit

**Question:** Is this journey for our target customer?

**Evaluation:**
- Does the persona match our target?
- Would our target customer take this journey?
- Is this solving their problems?

**Scoring:**
- ✓ ALIGNED - Primary persona match
- ⚠ PARTIAL - Adjacent persona
- ✗ MISALIGNED - Not our target

#### Strategy Alignment

**Question:** Is this the right time for this journey?

**Evaluation:**
- Does this fit current strategic focus?
- Is this in NOW/NEXT/LATER?
- Does it support current bets?

**Scoring:**
- ✓ ALIGNED - Fits current strategy
- ⚠ PARTIAL - Future priority
- ✗ MISALIGNED - Not on strategic radar

#### Anti-Goal Check

**Question:** Does this conflict with any anti-goals?

**Evaluation:**
- Check each anti-goal explicitly
- Identify any conflicts
- Note boundary cases

**Scoring:**
- ✓ CLEAR - No conflicts
- ✗ CONFLICTS - Violates anti-goal(s)

### Step 3: Determine Result

| Vision Fit | Persona Fit | Strategy | Anti-Goals | Result |
|------------|-------------|----------|------------|--------|
| ✓ | ✓ | ✓ | ✓ | **PROCEED** |
| ✓ | ✓ | ⚠ | ✓ | **PROCEED** (note timing) |
| ✓ | ⚠ | ✓ | ✓ | **REVIEW** - Requires explicit justification |
| ⚠ | ✓ | ✓ | ✓ | **REVIEW** - Requires explicit justification |
| ⚠ | ⚠ | ✓ | ✓ | **REVIEW** - Multiple concerns, escalate to human |
| Any | Any | Any | ✗ | **REJECT** |
| ✗ | Any | Any | Any | **REJECT** |

**REVIEW Handling (Critical Thinking Standard):**

When result is REVIEW, do NOT silently proceed. Instead:

1. **Document the concern explicitly** - What is PARTIAL about the alignment?
2. **State what would make it ALIGNED** - What changes would resolve the concern?
3. **Provide exploration path** - If the idea has merit but isn't well-articulated, suggest how to clarify
4. **Ask the user for decision** - Present the concern and let them decide to proceed, modify, or abandon
5. **If user proceeds despite PARTIAL** - Document this decision with rationale

**PARTIAL is NOT "go ahead quietly"** - it's a signal that requires human judgment.

---

## Validation Report Template

```markdown
# Vision Validation: {journey-name}

**Date:** {date}
**Journey Goal:** {goal from JOURNEY.md}

## Vision Fit

**Status:** ✓ ALIGNED | ⚠ PARTIAL | ✗ MISALIGNED

**Evaluation:**
- Vision Statement: {quote relevant part}
- Journey Alignment: {how journey serves/doesn't serve vision}

**Rationale:** {explanation}

## Persona Fit

**Status:** ✓ ALIGNED | ⚠ PARTIAL | ✗ MISALIGNED

**Evaluation:**
- Target Persona: {from VISION.md}
- Journey Persona: {who takes this journey}
- Match: {how they align}

**Rationale:** {explanation}

## Strategy Alignment

**Status:** ✓ ALIGNED | ⚠ PARTIAL | ✗ MISALIGNED

**Evaluation:**
- Current Focus: {from STRATEGY.md}
- Journey Fit: {NOW/NEXT/LATER/Not on radar}

**Rationale:** {explanation}

## Anti-Goal Check

**Status:** ✓ CLEAR | ✗ CONFLICTS

**Checked Against:**
- [ ] AG-P1: {result}
- [ ] AG-P2: {result}
- [ ] AG-T1: {result}
- ...

**Conflicts Found:** {list or "None"}

---

## Validation Result

**Result:** ✓ PROCEED | ⚠ REVIEW | ✗ REJECT

**Recommendation:** {what to do next}

**Notes:** {any additional context}
```

---

## Decision Principles Usage

When facing a decision, apply principles in order:

### Core Principles (P1-P3)

These are highest priority and rarely overridden:

1. **P1: User Value First** - Choose user benefit over convenience
2. **P2: Simplicity Over Features** - Do fewer things better
3. **P3: Explicit Over Implicit** - No magic, users understand

### Domain Principles

Apply based on decision type:

- **Technical decisions** → T1, T2, T3
- **Product decisions** → PR1, PR2, PR3
- **Business decisions** → B1, B2

### Conflict Resolution

When principles conflict:
1. Higher-numbered principle categories defer to lower
2. Core (P) > Technical (T) > Product (PR) > Business (B)
3. When in doubt, escalate to human decision

---

## Anti-Goal Enforcement

Anti-goals are non-negotiable boundaries:

### Checking Process

For each journey/feature:

```python
# Pseudocode
for anti_goal in anti_goals:
    if journey.conflicts_with(anti_goal):
        return REJECT, f"Conflicts with {anti_goal.id}"
    if journey.adjacent_to(anti_goal):
        flag_for_review(anti_goal.id)
```

### Boundary Cases

When something is adjacent to an anti-goal:
1. Flag for human review
2. Document the concern
3. Get explicit approval to proceed

---

## Integration with OFM

### Journey Workflow Update

Vision validation should be Phase 0:

```
Phase 0: VISION VALIDATION (before Discovery)
         ├── Vision Fit
         ├── Persona Fit
         ├── Strategy Alignment
         └── Anti-Goal Check

         Result: PROCEED → Continue to Phase 1
                 REVIEW → Escalate to human
                 REJECT → Stop, document reason
```

### Feature Design

When designing features, reference:

1. **Principles** for design decisions
2. **Anti-Goals** for scope boundaries
3. **Strategy** for priority context

---

## Maintaining Product Context

### Change Process

| Document | Who Can Change | Process |
|----------|----------------|---------|
| VISION.md | Leadership | Requires explicit review |
| STRATEGY.md | Product leadership | Quarterly review |
| PRINCIPLES.md | Anyone (propose) | PR with rationale |
| ANTI_GOALS.md | Leadership | Strategy review |

### Version Control

- All changes committed with rationale
- Significant changes announced
- History tracked in git

---

## Session Support

For long sessions, checkpoint:

```markdown
## Vision Context Loaded

**Session Start:** {timestamp}
**Documents Read:**
- [x] VISION.md
- [x] STRATEGY.md
- [x] PRINCIPLES.md
- [x] ANTI_GOALS.md

**Key Context:**
- Vision: {one-line summary}
- Strategy Theme: {current theme}
- Key Principles: {most relevant}
- Key Anti-Goals: {most relevant}
```

---

## Reference

- **Command:** `commands/sulis-vision.md`
- **Vision:** `product/offerings/primary/VISION.md`
- **Strategy:** `product/offerings/primary/STRATEGY.md`
- **Principles:** `product/organization/PRINCIPLES.md`
- **Anti-Goals:** `product/offerings/primary/ANTI_GOALS.md`
- **OFM:** `methodology standards/GENERATIVE_FEATURE_FRAMEWORK.md`
