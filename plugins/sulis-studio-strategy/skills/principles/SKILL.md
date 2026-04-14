# Principles Skill

> **"How we decide when there's no clear answer."**
>
> This skill creates, evolves, and applies decision principles. It encodes
> the expertise of consistent decision-making—so choosing wisely doesn't
> require decades of leadership experience.
>
> **Philosophy:** Good decisions come from good principles, applied consistently.
> Principles are opinions that guide action.

---

## Command Integration

This skill is invoked via `/sulis principles`:

```bash
# CREATION & EVOLUTION
/sulis principles create                      # Guided principles creation
/sulis principles create --from {file.md}    # Create from inputs
/sulis principles evolve                      # Add or refine principles
/sulis principles evolve --from {file.md}    # Evolve with specific inputs

# VIEWING
/sulis principles                             # View all principles
/sulis principles core                        # View core principles only
/sulis principles {category}                  # View category (technical, product, business)

# APPLICATION
/sulis principles apply {decision}            # Get principle guidance for a decision
```

---

## TRIGGER KEYWORDS (SEO-OPTIMIZED)

### Principles Creation Keywords
create principles, write principles, define principles, decision rules,
guiding principles, core values, design principles, engineering principles,
how we decide, decision framework, operating principles

### Principles Application Keywords
apply principles, which principle, principle conflict, decision guidance,
how should we decide, what's the right choice, trade-off, priority conflict

### Principles Evolution Keywords
add principle, new principle, update principle, refine principle,
principle review, principles retrospective

---

## Principles Creation Workflow

> **Principles answer: "When we face this type of decision, we choose THIS way."**
>
> Good principles are opinions. They have trade-offs. Someone could
> reasonably disagree with them—that's what makes them useful.

### The Principles Framework

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        PRINCIPLES HIERARCHY                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  CORE PRINCIPLES (P1, P2, P3...)                                            │
│  ─────────────────────────────────                                          │
│  Highest priority. Apply to all decisions. Rarely overridden.               │
│  Derived directly from vision and beliefs.                                  │
│                              │                                               │
│                              ▼                                               │
│  DOMAIN PRINCIPLES                                                          │
│  ─────────────────                                                          │
│  Apply within specific domains. Defer to core when in conflict.            │
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   TECHNICAL     │  │    PRODUCT      │  │    BUSINESS     │             │
│  │   (T1, T2...)   │  │   (PR1, PR2...) │  │   (B1, B2...)   │             │
│  │                 │  │                 │  │                 │             │
│  │ Architecture    │  │ User experience │  │ Commercial      │             │
│  │ Code quality    │  │ Feature design  │  │ Partnerships    │             │
│  │ Operations      │  │ Prioritization  │  │ Growth          │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  CONFLICT RESOLUTION: Core > Technical > Product > Business                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Phase 1: Context Gathering

**Input Sources:**
```
├── Vision (product/offerings/primary/VISION.md) - REQUIRED
│   └── Principles should embody the WHY and HOW
├── Existing principles (if any)
├── Past decisions that felt "right"
├── Past decisions that felt "wrong"
├── Team values and culture
└── User-provided inputs (--from flag)
```

**Key Questions:**
1. What decisions keep coming up?
2. When we made good decisions, what guided us?
3. When we made bad decisions, what were we missing?
4. What trade-offs do we consistently make one way?

### Phase 2: Principle Discovery

> **A principle is a pre-made decision for a class of situations.**

**Principle Discovery Exercise:**

For each decision type that recurs:
1. What are the options usually?
2. What do we usually choose?
3. Why do we choose that way?
4. What are we giving up by choosing that way?

**Example:**

```
Decision Type: Speed vs. Quality
Options: Ship fast with tech debt, or ship slower with quality
We Choose: Quality (usually)
Why: Long-term maintenance costs exceed short-term speed gains
Trade-off: We accept slower initial delivery

PRINCIPLE: "Quality over speed. We'd rather ship later and right
than sooner and broken. Tech debt is a tax on future velocity."
```

### Phase 3: Principle Formulation

**Principle Formula:**

```
[ID]: [Name]

Statement: [Clear, actionable principle]
Rationale: [Why this principle exists]
Trade-off: [What we're giving up]
Example: [Concrete application]
Anti-example: [What violating this looks like]
```

**Quality Criteria:**
- [ ] It's an opinion (someone could disagree)
- [ ] It's actionable (guides specific decisions)
- [ ] It has a trade-off (we're choosing one thing over another)
- [ ] It's derived from vision/beliefs
- [ ] It can be applied consistently

### Phase 4: Hierarchy and Conflicts

**Assigning Priority:**

| Level | Criteria | Override Conditions |
|-------|----------|---------------------|
| **Core (P)** | Applies to all decisions, embodies vision | Almost never |
| **Technical (T)** | Architecture, code, operations | When core conflicts |
| **Product (PR)** | UX, features, prioritization | When core/tech conflict |
| **Business (B)** | Commercial, growth, partnerships | When any higher conflicts |

**Conflict Resolution Rules:**

```
When principles conflict:

1. Higher category wins (Core > Technical > Product > Business)
2. Within category, lower number wins (P1 > P2)
3. If still unclear, escalate to human decision
4. Document the decision for future reference
```

### Phase 5: Generate PRINCIPLES.md

```markdown
# Decision Principles

> **"When we face a decision with no clear answer, these principles guide us."**
>
> Principles are pre-made decisions. They embody our values and beliefs,
> applied consistently across all choices we make.

---

## How to Use Principles

1. **Identify** the decision type
2. **Find** relevant principles
3. **Apply** highest-priority principle
4. **Document** if principles conflicted

### Conflict Resolution

When principles conflict:
- Core (P) > Technical (T) > Product (PR) > Business (B)
- Within category, lower number wins (P1 > P2)
- When unclear, escalate to human decision

---

## Core Principles

> **Apply to ALL decisions. Highest priority. Derived from vision.**

### P1: {Name}

**Principle:** {Clear statement}

**Rationale:** {Why this exists}

**Trade-off:** {What we're giving up}

**Example:** {When to apply}

**Anti-example:** {What violating looks like}

### P2: {Name}

{Same structure}

### P3: {Name}

{Same structure}

---

## Technical Principles

> **Apply to architecture, code, and operations decisions.**

### T1: {Name}

**Principle:** {Clear statement}

**Rationale:** {Why this exists}

**Trade-off:** {What we're giving up}

**Example:** {When to apply}

### T2: {Name}

{Same structure}

---

## Product Principles

> **Apply to user experience, features, and prioritization decisions.**

### PR1: {Name}

**Principle:** {Clear statement}

**Rationale:** {Why this exists}

**Trade-off:** {What we're giving up}

**Example:** {When to apply}

### PR2: {Name}

{Same structure}

---

## Business Principles

> **Apply to commercial, growth, and partnership decisions.**

### B1: {Name}

**Principle:** {Clear statement}

**Rationale:** {Why this exists}

**Trade-off:** {What we're giving up}

**Example:** {When to apply}

---

## Applying Principles

### Decision Template

When facing a decision, use this template:

```markdown
## Decision: {What we're deciding}

**Options:**
1. {Option A}
2. {Option B}

**Relevant Principles:**
- {P1}: Suggests {option}
- {T2}: Suggests {option}

**Conflict:** {Yes/No - if yes, which wins}

**Decision:** {What we chose}

**Rationale:** {Why, citing principles}
```

---

## Principle Evolution

### Adding Principles

New principles require:
1. Clear statement with trade-off
2. Derivation from vision/beliefs
3. Examples of application
4. Review and approval

### Modifying Principles

Modifications require:
1. Evidence principle isn't working
2. Proposed new wording
3. Impact on past decisions
4. Review and approval

---

## References

- **Vision:** `product/offerings/primary/VISION.md` - Source of core principles
- **Strategy:** `product/offerings/primary/STRATEGY.md` - Context for application
- **Anti-Goals:** `product/offerings/primary/ANTI_GOALS.md` - Related boundaries
```

---

## Principles Evolution Workflow

### When to Evolve

| Situation | Action |
|-----------|--------|
| New decision type keeps recurring | **Add** principle |
| Principle consistently leads to bad outcomes | **Modify** principle |
| Principles conflict frequently | **Clarify** hierarchy |
| Vision changed | **Review all** for alignment |

### Evolution Process

```
Step 1: Identify trigger
        ├── New decision type?
        ├── Principle not working?
        └── Conflict recurring?

Step 2: Gather evidence
        ├── Decisions affected
        ├── Outcomes observed
        └── Team feedback

Step 3: Propose change
        ├── New/modified wording
        ├── Rationale
        └── Impact assessment

Step 4: Review and approve
        └── Requires human sign-off

Step 5: Document change
        └── Update PRINCIPLES.md with rationale
```

---

## Reference

- **Command:** `commands/sulis-principles.md`
- **Principles:** `product/organization/PRINCIPLES.md`
- **Vision:** `product/offerings/primary/VISION.md`
