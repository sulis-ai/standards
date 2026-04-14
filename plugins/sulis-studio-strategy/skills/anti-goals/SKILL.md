# Anti-Goals Skill

> **"What we explicitly won't do."**
>
> This skill creates, evolves, and applies anti-goals. It encodes the
> discipline of saying no—so maintaining focus doesn't require decades
> of hard-won lessons about scope creep.
>
> **Philosophy:** What you say no to defines you as much as what you say yes to.
> Anti-goals prevent mission creep and preserve strategic focus.

---

## Command Integration

This skill is invoked via `/sulis anti-goals`:

```bash
# CREATION & EVOLUTION
/sulis anti-goals create                      # Guided anti-goals creation
/sulis anti-goals create --from {file.md}    # Create from inputs
/sulis anti-goals evolve                      # Add or refine anti-goals
/sulis anti-goals evolve --from {file.md}    # Evolve with specific inputs

# VIEWING
/sulis anti-goals                             # View all anti-goals
/sulis anti-goals product                     # View product anti-goals
/sulis anti-goals technical                   # View technical anti-goals
/sulis anti-goals business                    # View business anti-goals

# VALIDATION
/sulis anti-goals check {journey}             # Check journey against anti-goals
/sulis anti-goals check {feature}             # Check feature against anti-goals
```

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### Anti-Goals Creation Keywords
create anti-goals, define boundaries, what we won't do, scope boundaries,
non-goals, out of scope, explicit no, strategic boundaries, focus boundaries,
what to reject, what to avoid, negative space

### Anti-Goals Application Keywords
check anti-goals, conflicts with, violates anti-goal, scope creep,
mission creep, off mission, should we do this, is this in scope,
boundary check, anti-goal violation

### Anti-Goals Evolution Keywords
add anti-goal, new boundary, update anti-goals, remove anti-goal,
anti-goals review

---

## Anti-Goals Creation Workflow

> **Anti-goals answer: "Even if there's demand, what will we NOT do?"**
>
> Anti-goals are principled rejections. They're not "we can't" but "we won't"—
> even when we could.

### The Anti-Goals Framework

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ANTI-GOALS FRAMEWORK                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  VISION                                                                     │
│  "Raising the floor for the next generation of innovators"                  │
│                              │                                               │
│                              ▼                                               │
│  ANTI-GOALS = The boundaries that protect the vision                       │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                      │   │
│  │  PRODUCT ANTI-GOALS (AG-P)                                          │   │
│  │  What features/capabilities we won't build                          │   │
│  │  • "We won't build for hobbyists"                                   │   │
│  │  • "We won't sacrifice quality for speed"                           │   │
│  │                                                                      │   │
│  │  TECHNICAL ANTI-GOALS (AG-T)                                        │   │
│  │  What technical approaches we won't take                            │   │
│  │  • "We won't skip testing to ship faster"                           │   │
│  │  • "We won't accumulate tech debt knowingly"                        │   │
│  │                                                                      │   │
│  │  BUSINESS ANTI-GOALS (AG-B)                                         │   │
│  │  What business practices we won't engage in                         │   │
│  │  • "We won't use lock-in as a strategy"                             │   │
│  │  • "We won't hide pricing"                                          │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  Anti-goals are NON-NEGOTIABLE. They're not "try to avoid"—they're "never" │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Phase 1: Context Gathering

**Input Sources:**
```
├── Vision (product/offerings/primary/VISION.md) - REQUIRED
│   └── Anti-goals protect the vision
├── Principles (product/organization/PRINCIPLES.md)
│   └── Related to trade-offs in principles
├── Past scope creep incidents
│   └── What tempted us off course?
├── Competitive differentiation
│   └── What makes us different by NOT doing?
└── User-provided inputs (--from flag)
```

**Key Questions:**
1. What would violate our vision even if customers want it?
2. What have we been tempted to do that we shouldn't?
3. What do competitors do that we explicitly reject?
4. What trade-offs have we made that should be permanent?

### Phase 2: Anti-Goal Discovery

> **An anti-goal is a principled, permanent rejection.**

**Discovery Exercise:**

For each potential anti-goal:
1. Is there demand for this? (Must be yes—otherwise it's not an anti-goal)
2. Could we do this? (Must be yes—otherwise it's not a choice)
3. Why won't we? (Must connect to vision/principles)
4. What happens if we violate this? (Must have real consequences)

**Anti-Goal vs. "Not Now":**

| Anti-Goal | "Not Now" |
|-----------|-----------|
| Permanent rejection | Temporary deferral |
| Principled (based on values) | Practical (based on resources) |
| Even if demand increases | Will reconsider when capacity allows |
| Protects vision | Protects bandwidth |

### Phase 3: Anti-Goal Formulation

**Anti-Goal Formula:**

```
[AG-{Category}{Number}]: [Name]

Statement: We will NOT [specific action/capability/approach]
Rationale: Because [connection to vision/principles]
Even When: [Conditions under which others might do this]
Consequence: [What violating this would damage]
Example: [Concrete instance of this anti-goal]
```

**Quality Criteria:**
- [ ] There is demand for what we're rejecting
- [ ] We could do this if we chose to
- [ ] Connects directly to vision or principles
- [ ] Is permanent, not temporary
- [ ] Has clear consequences if violated

### Phase 4: Categorization

**Product Anti-Goals (AG-P):**
- What customer requests we'll reject
- What features we won't build
- What use cases we won't serve
- What quality trade-offs we won't make

**Technical Anti-Goals (AG-T):**
- What architectural shortcuts we won't take
- What technical debt we won't accumulate
- What operational practices we reject
- What security compromises we won't make

**Business Anti-Goals (AG-B):**
- What commercial practices we reject
- What partnerships we won't form
- What growth tactics we won't use
- What pricing approaches we won't take

### Phase 5: Generate ANTI_GOALS.md

```markdown
# Anti-Goals

> **"What we explicitly won't do, even if there's demand."**
>
> Anti-goals are principled rejections. They protect our vision by
> defining the boundaries we won't cross. They're not "we can't"—
> they're "we won't."

---

## How Anti-Goals Work

1. **Permanent:** These are not "not now"—they're "never"
2. **Principled:** Connected to vision and values, not resources
3. **Non-negotiable:** No exceptions, even under pressure
4. **Defining:** What we say no to shapes who we are

### When to Invoke Anti-Goals

- Evaluating new journeys or features
- Responding to customer requests
- Making architectural decisions
- Considering partnerships or business deals

---

## Product Anti-Goals

> **What we won't build, even if customers ask.**

### AG-P1: {Name}

**We will NOT:** {Specific rejection}

**Rationale:** {Connection to vision}

**Even When:** {When others might}

**Consequence:** {What violation damages}

**Example:** {Concrete instance}

### AG-P2: {Name}

{Same structure}

---

## Technical Anti-Goals

> **What technical approaches we reject.**

### AG-T1: {Name}

**We will NOT:** {Specific rejection}

**Rationale:** {Connection to vision/principles}

**Even When:** {When others might}

**Consequence:** {What violation damages}

**Example:** {Concrete instance}

### AG-T2: {Name}

{Same structure}

---

## Business Anti-Goals

> **What commercial practices we reject.**

### AG-B1: {Name}

**We will NOT:** {Specific rejection}

**Rationale:** {Connection to vision}

**Even When:** {When others might}

**Consequence:** {What violation damages}

**Example:** {Concrete instance}

### AG-B2: {Name}

{Same structure}

---

## Anti-Goal Enforcement

### Checking Process

For every journey, feature, or decision:

```
1. List all anti-goals
2. For each anti-goal:
   - Does this conflict? (Yes/No/Adjacent)
   - If Yes → REJECT
   - If Adjacent → FLAG for review
3. Document the check
```

### Violation Response

If an anti-goal is about to be violated:

1. **STOP** - Do not proceed
2. **ESCALATE** - This requires leadership review
3. **DOCUMENT** - Why was this tempting?
4. **DECIDE** - Is this a true exception or a sign the anti-goal is wrong?

### Exception Process

Anti-goal exceptions are rare and require:

1. Written justification
2. Leadership approval
3. Time-bound (if exception, not permanent change)
4. Documentation for future reference

---

## Evolution

### Adding Anti-Goals

New anti-goals require:
- Pattern of temptation (we keep almost doing this)
- Connection to vision
- Clear, specific statement
- Leadership approval

### Removing Anti-Goals

Removing anti-goals requires:
- Evidence the anti-goal no longer serves vision
- Leadership approval
- Documentation of reasoning

---

## References

- **Vision:** `product/offerings/primary/VISION.md` - What anti-goals protect
- **Principles:** `product/organization/PRINCIPLES.md` - Related decision rules
- **Strategy:** `product/offerings/primary/STRATEGY.md` - Current focus context
```

---

## Anti-Goals Evolution Workflow

### When to Evolve

| Situation | Action |
|-----------|--------|
| Repeatedly tempted by something | **Add** anti-goal |
| Anti-goal blocking valid work | **Review** - Is it still right? |
| Vision changed | **Review all** for alignment |
| Industry changed | **Review** - Still relevant? |

### Evolution Process

```
Step 1: Identify trigger
        ├── Pattern of temptation?
        ├── Anti-goal causing friction?
        └── Context changed?

Step 2: Evaluate
        ├── Still connected to vision?
        ├── Still protecting something important?
        └── Consequences of change?

Step 3: Propose change
        ├── Add / Modify / Remove
        ├── Rationale
        └── Impact assessment

Step 4: Leadership approval
        └── Anti-goals require sign-off

Step 5: Communicate
        └── Team needs to know boundaries changed
```

---

## Integration with OFM

### Journey Validation

Every journey must pass anti-goal check:

```markdown
## Anti-Goal Check

| Anti-Goal | Conflict? | Notes |
|-----------|-----------|-------|
| AG-P1: {Name} | No | |
| AG-P2: {Name} | No | |
| AG-T1: {Name} | No | |
| AG-B1: {Name} | Adjacent | {Concern} |

**Result:** ✓ CLEAR | ⚠ REVIEW | ✗ CONFLICTS
```

### Feature Design

Every feature should document anti-goal awareness:

```markdown
## Anti-Goal Awareness

**Considered Anti-Goals:**
- AG-P1: Not in conflict because {reason}
- AG-T2: Explicitly following this by {how}

**No Conflicts:** ✓
```

---

## Reference

- **Command:** `commands/sulis-anti-goals.md`
- **Anti-Goals:** `product/offerings/primary/ANTI_GOALS.md`
- **Vision:** `product/offerings/primary/VISION.md`
- **Principles:** `product/organization/PRINCIPLES.md`
