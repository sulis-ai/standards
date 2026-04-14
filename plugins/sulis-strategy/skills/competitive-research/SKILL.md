# Competitive Research Skill

> **"Know thy enemy and know thyself; in a hundred battles you will never be in peril."**
> — Sun Tzu
>
> **Purpose:** Conduct systematic competitive and market analysis using established
> strategic frameworks to understand market dynamics, competitive positioning,
> and strategic opportunities.
>
> **Command:** `/sulis competitive`
>
> **CRITICAL REFERENCE:** `methodology/standards/CRITICAL_THINKING_STANDARD.md`
> Competitive analysis MUST follow critical thinking standards:
> - **Balanced Investigation:** Search for competitor strengths, not just weaknesses
> - **Honest Assessment:** If a competitor is genuinely better at something, say so
> - **Source Verification:** Verify claims about competitors, don't assume
> - **No Hyperbole:** Avoid superlatives like "market leader" without citation
> - **Counter-Arguments:** Document "What if we're wrong about..." for key assumptions

---

## Command Integration

```bash
/sulis competitive "{product/market}"                    # Full competitive analysis
/sulis competitive "{product}" --framework porters       # Porter's 5 Forces
/sulis competitive "{market}" --framework 7domains       # 7 Domains outer ring
/sulis competitive "{product}" --framework wardley       # Wardley Mapping
/sulis competitive "{market}" --framework pestle         # PESTLE macro analysis
/sulis competitive "{product}" --players                 # Player mapping only
/sulis competitive "{product}" --positioning             # Positioning analysis
/sulis competitive "{product}" --swot                    # SWOT analysis
```

### Output Location

```
product/research/competitive/{product-or-market}/
├── COMPETITIVE_ANALYSIS.md           # Full analysis
├── porters-5-forces.md               # Porter's analysis
├── 7-domains-market.md               # Market attractiveness
├── wardley-map.md                    # Wardley strategic map
├── pestle-analysis.md                # Macro-environment scan
├── player-landscape.md               # Competitor profiles
├── positioning-map.md                # Strategic positioning
└── swot-analysis.md                  # SWOT matrix
```

---

## TRIGGER KEYWORDS

### Strategic Analysis Verbs
competitive analysis, competitor research, market analysis, strategic analysis,
industry analysis, market research, market dynamics, landscape analysis,
benchmark against, analyze market, analyze competition, competitive intelligence

### Framework References
porters 5 forces, porter's five forces, five forces, bargaining power,
threat of new entrants, threat of substitutes, supplier power, buyer power,
competitive rivalry, 7 domains, seven domains, market attractiveness,
industry attractiveness, macro environment, SWOT, strengths weaknesses,
opportunities threats, value chain, strategic groups, positioning map,
wardley map, wardley mapping, evolution, situational awareness, value chain mapping,
genesis, custom, product, commodity, component evolution, strategic landscape,
pestle, pestel, macro environment, political factors, economic factors,
social factors, technological factors, legal factors, environmental factors,
regulatory environment, macro trends, external environment, environment scan

### Competitive Nouns
competitor, competition, rival, alternative, substitute, market player,
incumbent, disruptor, market leader, challenger, follower, niche player,
direct competitor, indirect competitor, potential entrant

### Market Nouns
market, industry, sector, segment, vertical, space, ecosystem, landscape,
market share, market size, TAM, SAM, SOM, growth rate, market dynamics,
market structure, market forces, market trends

### Question Phrases
who are the competitors, what is the competitive landscape, how does X compare,
what are the alternatives to, who are the market leaders, what is the market like,
competitive position of, market dynamics of, strategic options for

---

## Strategic Frameworks

### Framework 1: Porter's Five Forces

> **Purpose:** Analyze industry structure and competitive intensity.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       THREAT OF NEW ENTRANTS                                │
│                                                                              │
│  • Capital requirements         • Economies of scale                        │
│  • Brand loyalty               • Access to distribution                     │
│  • Government regulations      • Switching costs                            │
│  • Expected retaliation        • Proprietary technology                     │
│                                                                              │
│                              ↓                                               │
│  ┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐      │
│  │ SUPPLIER POWER   │ →  │ COMPETITIVE      │ ←  │ BUYER POWER      │      │
│  │                  │    │ RIVALRY          │    │                  │      │
│  │ • # of suppliers │    │                  │    │ • # of buyers    │      │
│  │ • Differentiation│    │ • # competitors  │    │ • Switching cost │      │
│  │ • Switching cost │    │ • Growth rate    │    │ • Price sens.    │      │
│  │ • Forward integ. │    │ • Fixed costs    │    │ • Backward integ.│      │
│  │ • Importance     │    │ • Differentiation│    │ • Volume         │      │
│  └──────────────────┘    │ • Exit barriers  │    └──────────────────┘      │
│                          └──────────────────┘                               │
│                              ↑                                               │
│                                                                              │
│                     THREAT OF SUBSTITUTES                                   │
│                                                                              │
│  • Substitute availability    • Relative price performance                  │
│  • Switching costs           • Buyer propensity to substitute               │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Force Assessment Matrix

| Force | Factors | Low (1) | Medium (3) | High (5) |
|-------|---------|---------|------------|----------|
| **Threat of New Entrants** | Capital, Scale, Switching | Easy entry | Moderate barriers | High barriers |
| **Supplier Power** | Concentration, Differentiation | Many suppliers | Some leverage | Few suppliers |
| **Buyer Power** | Concentration, Price sensitivity | Fragmented | Moderate leverage | Concentrated |
| **Threat of Substitutes** | Availability, Performance | Few alternatives | Some alternatives | Many alternatives |
| **Competitive Rivalry** | Competitors, Growth, Exit | Low competition | Moderate rivalry | Intense rivalry |

#### Analysis Output

```markdown
## Porter's Five Forces Analysis: {Market/Industry}

**Date:** YYYY-MM-DD
**Overall Industry Attractiveness:** High | Medium | Low
**Profitability Potential:** High | Medium | Low

### Force 1: Threat of New Entrants

**Rating:** Low (1) | Medium (3) | High (5)

**Factors:**
| Factor | Assessment | Evidence |
|--------|------------|----------|
| Capital requirements | {High/Med/Low} | {Evidence} |
| Economies of scale | {High/Med/Low} | {Evidence} |
| Brand loyalty | {High/Med/Low} | {Evidence} |
| Switching costs | {High/Med/Low} | {Evidence} |
| Access to distribution | {High/Med/Low} | {Evidence} |
| Regulatory barriers | {High/Med/Low} | {Evidence} |

**Implications:** {What this means for strategy}

### Force 2: Supplier Bargaining Power

{Continue pattern...}

### Strategic Implications

**Industry Attractiveness:** {Assessment}

**Recommended Strategies:**
1. {Strategy to address strongest force}
2. {Strategy to exploit weakest force}
3. {Positioning recommendation}
```

---

### Framework 2: 7 Domains Framework (Outer Ring - Market Analysis)

> **Purpose:** Assess market attractiveness from macro and micro perspectives.
>
> The outer ring of the 7 Domains framework focuses on MARKET factors
> (as opposed to the inner ring which focuses on TEAM factors).

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          7 DOMAINS OUTER RING                               │
│                        (Market Attractiveness)                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  MACRO LEVEL                          MICRO LEVEL                           │
│  ────────────                         ───────────                           │
│                                                                              │
│  ┌─────────────────────┐              ┌─────────────────────┐              │
│  │ Market              │              │ Target Segment      │              │
│  │ Attractiveness      │              │ Benefits            │              │
│  │                     │              │                     │              │
│  │ • Market size (TAM) │              │ • Unmet needs       │              │
│  │ • Growth rate       │              │ • Pain severity     │              │
│  │ • Macro trends      │              │ • Willingness to pay│              │
│  │ • Profitability     │              │ • Accessibility     │              │
│  └─────────────────────┘              └─────────────────────┘              │
│                                                                              │
│  ┌─────────────────────┐              ┌─────────────────────┐              │
│  │ Industry            │              │ Sustainable         │              │
│  │ Attractiveness      │              │ Advantage           │              │
│  │                     │              │                     │              │
│  │ • Porter's forces   │              │ • Differentiation   │              │
│  │ • Profit margins    │              │ • Defensibility     │              │
│  │ • Value chain power │              │ • Network effects   │              │
│  │ • Industry lifecycle│              │ • Switching costs   │              │
│  └─────────────────────┘              └─────────────────────┘              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Domain Assessment Questions

**Domain 1: Market Attractiveness (Macro)**

| Question | Poor | Moderate | Excellent |
|----------|------|----------|-----------|
| What is the TAM? | <$100M | $100M-$1B | >$1B |
| What is the growth rate? | <5% | 5-15% | >15% |
| What are macro trends? | Declining | Stable | Tailwinds |
| What are margins like? | <20% | 20-40% | >40% |

**Domain 2: Industry Attractiveness (Macro)**

| Question | Poor | Moderate | Excellent |
|----------|------|----------|-----------|
| Competitive intensity? | Brutal | Moderate | Benign |
| Supplier/buyer power? | High | Balanced | Low |
| Substitute threats? | Many | Some | Few |
| Barriers to entry? | None | Moderate | High |

**Domain 3: Target Segment Benefits (Micro)**

| Question | Poor | Moderate | Excellent |
|----------|------|----------|-----------|
| How severe is the pain? | Vitamin | Painkiller | Surgery |
| How unmet is the need? | Well-served | Underserved | Unserved |
| Willingness to pay? | Low | Medium | High |
| How accessible? | Hard to reach | Moderate | Easy |

**Domain 4: Sustainable Advantage (Micro)**

| Question | Poor | Moderate | Excellent |
|----------|------|----------|-----------|
| Differentiation level? | Me-too | Some | Unique |
| Defensibility? | None | Moderate | High moat |
| Network effects? | None | Weak | Strong |
| Switching costs? | Low | Medium | High |

---

### Framework 3: Competitive Positioning Map

> **Purpose:** Visualize competitive positioning across key dimensions.

```
                         HIGH VALUE
                              │
                              │
            ┌─────────────────┼─────────────────┐
            │                 │                 │
            │   Premium       │    Leaders      │
            │   Niche         │                 │
            │   (High value,  │    (High value, │
            │    high price)  │    competitive) │
            │                 │                 │
LOW PRICE ──┼─────────────────┼─────────────────┼── HIGH PRICE
            │                 │                 │
            │   Commodity     │    Overpriced   │
            │                 │                 │
            │   (Low value,   │    (Low value,  │
            │    low price)   │    high price)  │
            │                 │                 │
            └─────────────────┼─────────────────┘
                              │
                         LOW VALUE
```

#### Positioning Dimensions

Choose TWO dimensions most relevant to the market:

| Dimension | Description | Examples |
|-----------|-------------|----------|
| Price | Cost to customer | Low ←→ Premium |
| Value | Benefits delivered | Basic ←→ Comprehensive |
| Simplicity | Ease of use | Complex ←→ Simple |
| Scope | Feature breadth | Narrow ←→ Broad |
| Integration | Ecosystem fit | Standalone ←→ Integrated |
| Target | Customer segment | SMB ←→ Enterprise |
| Deployment | How delivered | Self-hosted ←→ Managed |
| Customization | Flexibility | Opinionated ←→ Flexible |

---

### Framework 4: Player Landscape Analysis

> **Purpose:** Profile and categorize competitors by type and threat level.

#### Player Categories

| Category | Definition | Strategic Concern |
|----------|------------|-------------------|
| **Direct Competitors** | Same solution, same market | Highest - compete for same customers |
| **Indirect Competitors** | Different solution, same problem | Medium - compete for same budget |
| **Potential Entrants** | Could enter if attractive | Monitor - future threat |
| **Substitutes** | Alternative approaches | Medium - customer might choose instead |
| **Complementors** | Enhance our value | Opportunity - potential partners |

#### Player Profile Template

```markdown
## Competitor Profile: {Name}

**Category:** Direct | Indirect | Potential | Substitute | Complementor
**Threat Level:** Critical | High | Medium | Low | Opportunity
**Founded:** {Year}
**Funding:** {Amount raised or revenue if public}
**Size:** {Employees or customer count}

### Positioning
**Target Market:** {Who they serve}
**Value Proposition:** {Core promise}
**Pricing Model:** {How they charge}

### Strengths
- {Strength 1}
- {Strength 2}

### Weaknesses
- {Weakness 1}
- {Weakness 2}

### Market Share
**Estimated Share:** {X}%
**Trend:** Growing | Stable | Declining

### Our Competitive Advantage
{How we differentiate against this competitor}

### Sources
- {Source 1}
- {Source 2}
```

---

### Framework 5: SWOT Analysis

> **Purpose:** Internal and external strategic assessment.

```
┌─────────────────────────────┬─────────────────────────────┐
│         STRENGTHS           │         WEAKNESSES          │
│         (Internal +)        │         (Internal -)        │
├─────────────────────────────┼─────────────────────────────┤
│                             │                             │
│ • {Strength 1}              │ • {Weakness 1}              │
│ • {Strength 2}              │ • {Weakness 2}              │
│ • {Strength 3}              │ • {Weakness 3}              │
│                             │                             │
├─────────────────────────────┼─────────────────────────────┤
│       OPPORTUNITIES         │          THREATS            │
│         (External +)        │         (External -)        │
├─────────────────────────────┼─────────────────────────────┤
│                             │                             │
│ • {Opportunity 1}           │ • {Threat 1}                │
│ • {Opportunity 2}           │ • {Threat 2}                │
│ • {Opportunity 3}           │ • {Threat 3}                │
│                             │                             │
└─────────────────────────────┴─────────────────────────────┘
```

#### SWOT → Strategy Matrix (TOWS)

| | **Strengths** | **Weaknesses** |
|---|---|---|
| **Opportunities** | **SO Strategies** (Use strengths to capture opportunities) | **WO Strategies** (Overcome weaknesses to capture opportunities) |
| **Threats** | **ST Strategies** (Use strengths to mitigate threats) | **WT Strategies** (Minimize weaknesses and avoid threats) |

---

### Framework 6: Wardley Mapping

> **Purpose:** Understand the strategic landscape through evolution and value chain positioning.
> Wardley Maps provide situational awareness by visualizing the components needed to serve
> user needs and their evolutionary stage.
>
> **Source:** Simon Wardley's mapping methodology

```
                              GENESIS    CUSTOM    PRODUCT    COMMODITY
                                 │          │         │           │
                                 │          │         │           │
    ┌────────────────────────────┼──────────┼─────────┼───────────┼────┐
    │                            │          │         │           │    │
    │  USER NEED                 │          │         │           │    │
    │      │                     │          │         │           │    │
    │      ▼                     │          │         │           │    │
V   │  [Component A] ────────────┼──────────┼────●────┼───────────┼    │
A   │      │                     │          │         │           │    │
L   │      ▼                     │          │         │           │    │
U   │  [Component B] ────────────┼──────────┼─────────┼─────●─────┼    │
E   │      │                     │          │         │           │    │
    │      ├──────────┐          │          │         │           │    │
C   │      ▼          ▼          │          │         │           │    │
H   │  [Comp C]   [Comp D] ──────┼────●─────┼─────────┼───────────┼    │
A   │      │          │          │          │         │           │    │
I   │      ▼          ▼          │          │         │           │    │
N   │  [Comp E]   [Comp F] ──────┼──────────┼─────────┼─────●─────┼    │
    │                            │          │         │           │    │
    └────────────────────────────┼──────────┼─────────┼───────────┼────┘
                                 │          │         │           │
                              GENESIS    CUSTOM    PRODUCT    COMMODITY
                              (Novel)   (Emerging) (Good)    (Utility)
                                         EVOLUTION →
```

#### Evolution Stages

| Stage | Characteristics | Strategic Implication |
|-------|-----------------|----------------------|
| **Genesis** | Novel, poorly understood, uncertain, high failure | Explore, experiment, accept failure |
| **Custom** | Divergent, rapidly changing, emerging patterns | Build differentiating capabilities |
| **Product** | Converging, increasingly understood, best practices | Compete on features, performance |
| **Commodity** | Standardized, well-defined, utility | Outsource, use as building block |

#### Movement Patterns

| Pattern | Description | Strategic Response |
|---------|-------------|-------------------|
| **Inertia** | Resistance to component evolution | Watch for disruption opportunities |
| **Componentization** | Breaking into smaller parts | Look for commoditization plays |
| **Co-evolution** | Practices evolving with technology | Anticipate new practices needed |
| **Industrialization** | Custom → Product → Commodity | Build on commodities, differentiate above |

#### Wardley Mapping Protocol

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 1: IDENTIFY USER NEED                                                 │
│  → What is the user trying to accomplish?                                   │
│  → Place at top of value chain                                              │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 2: MAP VALUE CHAIN                                                    │
│  → What components are needed to meet user need?                            │
│  → Draw dependencies (what needs what)                                      │
│  → Higher = closer to user, Lower = foundational                            │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 3: PLOT EVOLUTION                                                     │
│  → Where is each component on evolution axis?                               │
│  → Genesis → Custom → Product → Commodity                                   │
│  → Consider: How well understood? How competitive? How standardized?        │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 4: IDENTIFY MOVEMENT                                                  │
│  → What's moving right (commoditizing)?                                     │
│  → What new genesis components are emerging?                                │
│  → Where is inertia creating opportunity?                                   │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 5: STRATEGIC PLAYS                                                    │
│  → Where to invest (genesis/custom for differentiation)                     │
│  → Where to leverage (commodity for efficiency)                             │
│  → Where competitors are vulnerable (inertia)                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Strategic Doctrines from Wardley

| Doctrine | Description |
|----------|-------------|
| **Use appropriate methods** | Agile for genesis, lean for custom, six sigma for commodity |
| **Focus on user needs** | Not technology, not competitors—users |
| **Remove bias and duplication** | Map to find redundancy |
| **Think small teams** | Genesis work needs small, empowered teams |
| **Be humble** | Maps are imperfect; iterate and learn |
| **Exploit the landscape** | Position based on movement, not current state |

#### Wardley Map Output Template

```markdown
## Wardley Map: {Domain/Product}

**Date:** YYYY-MM-DD
**User Need:** {Primary user need being served}

### Value Chain Components

| Component | Evolution Stage | Certainty | Strategic Action |
|-----------|-----------------|-----------|------------------|
| {User Need} | N/A | High | Anchor point |
| {Component 1} | Product | Medium | Compete on features |
| {Component 2} | Commodity | High | Leverage/outsource |
| {Component 3} | Genesis | Low | Experiment |

### Movement Observations

**Commoditizing (moving right):**
- {Component X}: Custom → Product (18 months)

**Emerging (new genesis):**
- {New component} appearing in response to {trend}

**Inertia Detected:**
- {Incumbent} showing resistance at {Component Y}

### Strategic Implications

1. **Build:** {Components where we should invest for differentiation}
2. **Leverage:** {Commodities we should use as building blocks}
3. **Disrupt:** {Where competitor inertia creates opportunity}

### Visual Map

[ASCII representation or reference to diagram]
```

---

### Framework 7: PESTLE Analysis

> **Purpose:** Scan the macro-environment for factors that could impact the business.
> PESTLE examines Political, Economic, Social, Technological, Legal, and Environmental factors.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            PESTLE ANALYSIS                                  │
│                         (Macro-Environment Scan)                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   POLITICAL     │  │   ECONOMIC      │  │    SOCIAL       │             │
│  │                 │  │                 │  │                 │             │
│  │ • Government    │  │ • Growth rates  │  │ • Demographics  │             │
│  │ • Regulation    │  │ • Interest rates│  │ • Culture       │             │
│  │ • Trade policy  │  │ • Inflation     │  │ • Attitudes     │             │
│  │ • Tax policy    │  │ • Exchange rates│  │ • Lifestyle     │             │
│  │ • Stability     │  │ • Unemployment  │  │ • Education     │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │ TECHNOLOGICAL   │  │     LEGAL       │  │ ENVIRONMENTAL   │             │
│  │                 │  │                 │  │                 │             │
│  │ • R&D activity  │  │ • Employment law│  │ • Climate       │             │
│  │ • Automation    │  │ • IP protection │  │ • Sustainability│             │
│  │ • Tech transfer │  │ • Data privacy  │  │ • Carbon regs   │             │
│  │ • Innovation    │  │ • Antitrust     │  │ • Green trends  │             │
│  │ • Disruption    │  │ • Consumer law  │  │ • ESG pressure  │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Factor Categories

**P - Political**

| Factor | Questions to Ask | Impact on Tech/SaaS |
|--------|------------------|---------------------|
| Government policy | What policies affect our market? | Data sovereignty, AI regulation |
| Political stability | Is the operating environment stable? | Investment confidence |
| Trade agreements | How do trade policies affect us? | Cross-border data flows |
| Tax policy | What tax incentives/burdens exist? | R&D credits, digital services tax |
| Regulation appetite | Is regulation increasing? | Compliance costs, barriers |

**E - Economic**

| Factor | Questions to Ask | Impact on Tech/SaaS |
|--------|------------------|---------------------|
| Economic growth | Is the economy growing/contracting? | IT spending budgets |
| Interest rates | How do rates affect investment? | Startup funding, enterprise spending |
| Inflation | How does inflation affect pricing? | Cost pressure, pricing power |
| Exchange rates | How do currency moves affect us? | International pricing, costs |
| Labor market | Is talent available and affordable? | Hiring costs, offshoring |

**S - Social**

| Factor | Questions to Ask | Impact on Tech/SaaS |
|--------|------------------|---------------------|
| Demographics | Who is our workforce/customer base? | Talent pipeline, market size |
| Work patterns | How is work changing? | Remote work tools demand |
| Consumer attitudes | What do people value? | Privacy concerns, sustainability |
| Education levels | What skills exist in the market? | Developer availability |
| Lifestyle trends | How are lifestyles evolving? | Product design implications |

**T - Technological**

| Factor | Questions to Ask | Impact on Tech/SaaS |
|--------|------------------|---------------------|
| Emerging tech | What technologies are maturing? | AI, quantum, edge computing |
| R&D activity | Where is innovation happening? | Competitive threats, opportunities |
| Automation | What's becoming automated? | Product opportunities, job displacement |
| Infrastructure | What infrastructure is available? | Cloud adoption, 5G/connectivity |
| Disruption | What could disrupt our market? | New entrants, paradigm shifts |

**L - Legal**

| Factor | Questions to Ask | Impact on Tech/SaaS |
|--------|------------------|---------------------|
| Data privacy | What privacy laws apply? | GDPR, CCPA compliance costs |
| IP protection | How strong is IP law? | Patent strategy, trade secrets |
| Employment law | What labor regulations apply? | Contractor rules, remote work |
| Antitrust | Are there competition concerns? | M&A limitations, market power |
| Industry regulation | What sector-specific rules exist? | Financial services, healthcare |

**E - Environmental**

| Factor | Questions to Ask | Impact on Tech/SaaS |
|--------|------------------|---------------------|
| Climate change | How does climate affect operations? | Data center location, energy costs |
| Sustainability | What sustainability pressures exist? | ESG reporting, green computing |
| Resource scarcity | What resources are constrained? | Chip shortages, rare earth materials |
| Environmental regs | What environmental rules apply? | Carbon reporting, e-waste |
| Consumer pressure | Do customers demand green? | Marketing, product design |

#### PESTLE Assessment Matrix

| Factor | Current Impact | Future Trend | Time Horizon | Strategic Implication |
|--------|----------------|--------------|--------------|----------------------|
| {Factor} | High/Med/Low | ↑/→/↓ | 1-3yr/3-5yr/5+yr | {Implication} |

#### Relevance Filter for Tech/SaaS

Not all PESTLE factors are equally relevant. For technology companies, prioritize:

| HIGH Relevance | MEDIUM Relevance | LOWER Relevance |
|----------------|------------------|-----------------|
| Data privacy (L) | Economic growth (E) | Climate (E) |
| AI regulation (P) | Interest rates (E) | Raw materials (E) |
| IP protection (L) | Demographics (S) | Physical environment |
| Tech disruption (T) | Work patterns (S) | |
| Antitrust (L) | Talent market (E/S) | |

#### PESTLE Output Template

```markdown
## PESTLE Analysis: {Market/Industry}

**Date:** YYYY-MM-DD
**Scope:** {Geographic and industry scope}
**Time Horizon:** {1-3 years / 3-5 years}

### Executive Summary

{Key macro-environmental factors affecting the market}

### Political Factors

| Factor | Current State | Trend | Impact | Strategic Response |
|--------|---------------|-------|--------|-------------------|
| {Factor} | {State} | ↑/→/↓ | H/M/L | {Response} |

**Key Political Implications:**
- {Implication 1}
- {Implication 2}

### Economic Factors

{Same table format}

### Social Factors

{Same table format}

### Technological Factors

{Same table format}

### Legal Factors

{Same table format}

### Environmental Factors

{Same table format}

### Summary: Top 5 Macro Factors

| Rank | Factor | Category | Impact | Urgency |
|------|--------|----------|--------|---------|
| 1 | {Factor} | {P/E/S/T/L/E} | Critical | Immediate |
| 2 | {Factor} | {P/E/S/T/L/E} | High | 12 months |
| 3 | {Factor} | {P/E/S/T/L/E} | High | 12-24 months |
| 4 | {Factor} | {P/E/S/T/L/E} | Medium | Monitor |
| 5 | {Factor} | {P/E/S/T/L/E} | Medium | Monitor |

### Strategic Recommendations

1. **Respond to:** {Factor requiring immediate action}
2. **Prepare for:** {Factor with future impact}
3. **Monitor:** {Factor to track}
```

---

## Research Protocol

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 1: DEFINE SCOPE                                                       │
│  → What market/industry?                                                    │
│  → What geography?                                                          │
│  → What time horizon?                                                       │
│  → Which frameworks to apply?                                               │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 2: MARKET SIZING                                                      │
│  → TAM (Total Addressable Market)                                           │
│  → SAM (Serviceable Addressable Market)                                     │
│  → SOM (Serviceable Obtainable Market)                                      │
│  → Growth rates and projections                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 3: PLAYER IDENTIFICATION                                              │
│  → Direct competitors (same solution)                                       │
│  → Indirect competitors (same problem)                                      │
│  → Potential entrants (adjacent players)                                    │
│  → Substitutes (alternative approaches)                                     │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 4: FRAMEWORK APPLICATION                                              │
│  → Apply Porter's 5 Forces (industry structure)                             │
│  → Apply 7 Domains outer ring (market attractiveness)                       │
│  → Create positioning map (competitive positioning)                         │
│  → Profile key players (competitor analysis)                                │
│  → Conduct SWOT (strategic assessment)                                      │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 5: SYNTHESIS                                                          │
│  → Key findings across frameworks                                           │
│  → Strategic implications                                                   │
│  → Positioning recommendations                                              │
│  → Competitive response strategies                                          │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 6: REPORT GENERATION                                                  │
│  → Executive summary                                                        │
│  → Framework outputs                                                        │
│  → Strategic recommendations                                                │
│  → Save to product/research/competitive/{market}/                                  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Source Requirements

| Source Type | Use For | Tier |
|-------------|---------|------|
| **Industry reports** (Gartner, Forrester, IDC) | Market sizing, trends | Tier 1-2 |
| **Company websites** | Official positioning, pricing | Tier 2 |
| **Crunchbase/PitchBook** | Funding, company data | Tier 2 |
| **G2/Capterra reviews** | Customer perception | Tier 3 |
| **LinkedIn** | Team size, growth | Tier 3 |
| **News articles** | Recent developments | Tier 2-3 |
| **Financial filings** | Revenue, strategy (public cos) | Tier 1 |
| **Job postings** | Strategy signals | Tier 3 |

---

## Competitive Analysis Report Template

```markdown
# Competitive Analysis: {Market/Product}

**Date:** YYYY-MM-DD
**Analyst:** Claude Code (Competitive Research Skill)
**Scope:** {Market definition}

---

## Executive Summary

{2-3 paragraphs summarizing key findings and strategic implications}

---

## Market Overview

### Market Definition
{What market we're analyzing}

### Market Size
| Metric | Value | Source |
|--------|-------|--------|
| TAM | ${X}B | {Source} |
| SAM | ${X}B | {Source} |
| SOM | ${X}M | {Source} |
| CAGR | {X}% | {Source} |

### Key Trends
1. {Trend 1}
2. {Trend 2}
3. {Trend 3}

---

## Porter's Five Forces

{Full analysis per framework section}

---

## 7 Domains Market Assessment

{Full analysis per framework section}

---

## Player Landscape

### Competitor Map

| Player | Category | Threat | Strengths | Weaknesses |
|--------|----------|--------|-----------|------------|
| {Name} | Direct | High | {List} | {List} |
| {Name} | Indirect | Medium | {List} | {List} |

### Detailed Profiles

{Player profiles for top 5 competitors}

---

## Positioning Analysis

{Positioning map with all players plotted}

---

## SWOT Analysis

{SWOT matrix and TOWS strategies}

---

## Strategic Implications

### Key Findings
1. {Finding 1}
2. {Finding 2}
3. {Finding 3}

### Recommended Positioning
{Where to position and why}

### Competitive Strategies
1. **Against {Competitor 1}:** {Strategy}
2. **Against {Competitor 2}:** {Strategy}

### Opportunities
1. {Opportunity 1}
2. {Opportunity 2}

### Threats to Monitor
1. {Threat 1}
2. {Threat 2}

---

## References

{Harvard-formatted citations}
```

---

## Integration with OFM

```
product/research/competitive/{market}/COMPETITIVE_ANALYSIS.md
       │
       │  Informs product strategy
       ↓
┌─────────────────────────────────────┐
│  product/offerings/primary/STRATEGY.md │
│  → Strategic positioning            │
│  → Competitive focus                │
└─────────────────────────────────────┘
       │
       │  Informs journey/feature design
       ↓
┌─────────────────────────────────────┐
│  product/offerings/primary/journeys/{journey}/               │
│  → Differentiation in PR_FAQ        │
│  → Competitive advantage in design  │
└─────────────────────────────────────┘
```

---

## Tool Usage

| Tool | Purpose |
|------|---------|
| **WebSearch** | Find market data, competitor info |
| **WebFetch** | Read competitor websites, reports |
| **Read** | Access internal strategy docs |
| **Write** | Save analysis outputs |

---

## Files in This Skill

```
skills/competitive-research/
└── SKILL.md                    # This file

skills/shared/
├── source-credibility.md       # Source evaluation
└── harvard-referencing.md      # Citation format

product/research/competitive/          # Analysis outputs
```

---

## References

Porter, M.E. (1979) 'How Competitive Forces Shape Strategy', Harvard Business
Review, March-April. Available at: https://hbr.org/1979/03/how-competitive-forces-shape-strategy
(Accessed: 19 January 2026).

Mullins, J.W. (2017) The New Business Road Test: What Entrepreneurs and
Investors Should Do Before Launching a Lean Start-up. 5th edn. London:
FT Publishing International.

Humphrey, A. (2005) 'SWOT Analysis for Management Consulting', SRI Alumni
Newsletter, December.

Wardley, S. (2020) Wardley Maps: The Art of Strategy. Available at:
https://learnwardleymapping.com (Accessed: 19 January 2026).

Wardley, S. (2016) 'An Introduction to Wardley Maps', Medium. Available at:
https://medium.com/wardleymaps (Accessed: 19 January 2026).

Aguilar, F.J. (1967) Scanning the Business Environment. New York: Macmillan.
[Original PESTLE framework]

CIPD (2024) 'PESTLE Analysis'. Available at:
https://www.cipd.org/uk/knowledge/factsheets/pestle-analysis-factsheet
(Accessed: 19 January 2026).
