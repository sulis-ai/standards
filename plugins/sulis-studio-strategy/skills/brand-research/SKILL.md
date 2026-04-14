# Brand Research Skill

> **"A good name is better than riches."**
> — Proverb
>
> **Purpose:** Conduct systematic brand name and domain research to validate
> naming choices before commitment. Checks availability, overcrowding, trademark
> conflicts, and brand strength.
>
> **Command:** `/sulis brand`
>
> **CRITICAL REFERENCE:** `methodology/standards/CRITICAL_THINKING_STANDARD.md`
>
> **SEARCH LIMITATIONS DISCLOSURE (MANDATORY):**
> Brand research has inherent limitations that MUST be disclosed in every report:
> - Trademark searches may miss common law (unregistered) trademark rights
> - Domain "available" status may change between research and registration
> - Premium/aftermarket domains may have unpredictable pricing
> - Social handle availability can change rapidly
> - International trademark databases may not be fully searchable
>
> **Always recommend:** "Consult a trademark attorney before committing to a brand name."

---

## Command Integration

```bash
/sulis brand "{name}"                        # Full brand research
/sulis brand "{name}" --domain               # Domain availability focus
/sulis brand "{name}" --trademark            # Trademark search focus
/sulis brand "{name}" --social               # Social handle availability
/sulis brand "{name}" --alternatives         # Generate alternative names
/sulis brand generate "{concept}"            # Generate name candidates
```

### Output Location

```
product/research/brand/{name}/
├── BRAND_RESEARCH.md             # Full analysis
├── domain-availability.md        # Domain findings
├── trademark-search.md           # Trademark findings
├── social-handles.md             # Social media availability
├── competitive-names.md          # Similar names in market
└── alternatives.md               # Alternative name suggestions
```

---

## TRIGGER KEYWORDS

### Brand/Naming Verbs
brand research, name research, naming, brand check, name check, brand validation,
name validation, brand availability, name availability, trademark search,
trademark check, domain check, domain availability, brand analysis, naming analysis

### Brand Nouns
brand name, product name, company name, service name, domain name, trademark,
trade mark, brand identity, naming, nomenclature, brand, name

### Availability Nouns
domain, TLD, extension, .com, .io, .dev, .app, social handle, twitter handle,
username, availability, registration, trademark registration, USPTO

### Question Phrases
is the name available, can we use the name, is there a trademark, check the domain,
who owns the domain, is the name taken, are there similar names, name crowding,
brand confusion, is it too similar to, will there be trademark issues

---

## Brand Research Dimensions

### Dimension 1: Domain Availability

> **Purpose:** Check if the name is available as a domain across key TLDs.

#### TLD Priority Matrix

| Priority | TLD | Use Case | Notes |
|----------|-----|----------|-------|
| **P1 - Essential** | .com | Primary brand domain | Gold standard, check first |
| **P1 - Essential** | .io | Tech/developer products | Common in tech, premium |
| **P2 - Important** | .dev | Developer tools | Google-owned, developer focus |
| **P2 - Important** | .app | Applications | Google-owned, requires HTTPS |
| **P3 - Alternative** | .co | Startup-friendly | Common alternative to .com |
| **P3 - Alternative** | .ai | AI products | Anguilla ccTLD, trendy |
| **P4 - Regional** | .com.au, .co.uk | Regional presence | Country-specific |

#### Domain Check Protocol

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  DOMAIN AVAILABILITY CHECK                                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1. Check exact match: {name}.com, {name}.io, {name}.dev                    │
│                                                                              │
│  2. If taken, check:                                                        │
│     • Who owns it (WHOIS)                                                   │
│     • Is it parked/for sale?                                                │
│     • Is it actively used?                                                   │
│     • Estimated acquisition cost                                            │
│                                                                              │
│  3. Check variations:                                                        │
│     • get{name}.com, {name}hq.com, {name}app.com                           │
│     • try{name}.com, use{name}.com, {name}io.com                           │
│                                                                              │
│  4. Document all findings in availability matrix                            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Domain Availability Matrix

| Domain | Available | Owner/Status | Estimated Cost | Recommendation |
|--------|-----------|--------------|----------------|----------------|
| {name}.com | Yes/No | {Owner or "Available"} | ${X} or N/A | Primary/Backup/Avoid |
| {name}.io | Yes/No | {Owner or "Available"} | ${X} or N/A | Primary/Backup/Avoid |
| {name}.dev | Yes/No | {Owner or "Available"} | ${X} or N/A | Primary/Backup/Avoid |

---

### Dimension 2: Trademark Search

> **Purpose:** Identify potential trademark conflicts before committing to a name.

#### Trademark Databases to Search

| Database | Coverage | URL | Notes |
|----------|----------|-----|-------|
| **USPTO TESS** | United States | https://tmsearch.uspto.gov | Primary for US market |
| **EUIPO** | European Union | https://euipo.europa.eu | EU trademark search |
| **WIPO Global Brand** | International | https://branddb.wipo.int | 40+ countries |
| **UK IPO** | United Kingdom | https://trademarks.ipo.gov.uk | UK-specific |
| **IP Australia** | Australia | https://search.ipaustralia.gov.au | AU-specific |

#### Trademark Search Protocol

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  TRADEMARK SEARCH PROTOCOL                                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1. EXACT MATCH SEARCH                                                      │
│     • Search exact name in USPTO TESS                                       │
│     • Search in relevant Nice Classes (typically Class 9, 42 for software) │
│                                                                              │
│  2. PHONETIC EQUIVALENTS                                                    │
│     • Search for similar-sounding names                                     │
│     • Common misspellings                                                   │
│     • Homophones                                                            │
│                                                                              │
│  3. SIMILAR MARKS                                                           │
│     • Visual similarity                                                     │
│     • Conceptual similarity                                                 │
│     • Names that could cause confusion                                      │
│                                                                              │
│  4. INTERNATIONAL SEARCH                                                    │
│     • WIPO Global Brand Database                                            │
│     • Key markets (EU, UK, AU if relevant)                                 │
│                                                                              │
│  5. COMMON LAW SEARCH                                                       │
│     • Google search for "{name} software"                                   │
│     • Search GitHub, npm, PyPI for packages                                │
│     • Check app stores                                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Nice Classification (Software Relevant)

| Class | Description | Register If |
|-------|-------------|-------------|
| **Class 9** | Computer software, downloadable software | Software products |
| **Class 35** | Business services, advertising | SaaS platforms |
| **Class 38** | Telecommunications | Communication services |
| **Class 42** | Computer services, SaaS, hosting | Cloud services |

#### Trademark Risk Assessment

| Risk Level | Criteria | Recommendation |
|------------|----------|----------------|
| **HIGH** | Exact match in same class, actively used | AVOID - Legal risk |
| **MEDIUM** | Similar mark in related class, or exact in different class | CONSULT ATTORNEY |
| **LOW** | No exact matches, minor similar marks | PROCEED WITH CAUTION |
| **CLEAR** | No conflicts found in any search | RECOMMENDED |

---

### Dimension 3: Name Crowding Analysis

> **Purpose:** Assess how crowded the namespace is with similar names.

#### Crowding Check Protocol

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  NAME CROWDING ANALYSIS                                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1. DIRECT COMPETITORS                                                      │
│     • Search for "{name}" in target market                                  │
│     • Note companies with same/similar name                                 │
│                                                                              │
│  2. ADJACENT MARKETS                                                        │
│     • Search for "{name}" + "software"                                      │
│     • Search for "{name}" + "tech"                                          │
│     • Search for "{name}" + "platform"                                      │
│                                                                              │
│  3. DEVELOPER ECOSYSTEM                                                     │
│     • npm: npm search {name}                                                │
│     • PyPI: Search for {name}                                               │
│     • GitHub: Search repos named {name}                                     │
│     • Docker Hub: Search for {name}                                         │
│                                                                              │
│  4. APP STORES                                                              │
│     • Apple App Store search                                                │
│     • Google Play Store search                                              │
│                                                                              │
│  5. QUANTIFY CROWDING                                                       │
│     • Count entities using name                                             │
│     • Assess brand confusion risk                                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Crowding Assessment

| Crowding Level | Criteria | Implication |
|----------------|----------|-------------|
| **SEVERE** | 10+ products with same name | AVOID - SEO nightmare, brand confusion |
| **HIGH** | 5-10 products with same/similar name | RISKY - Differentiation difficult |
| **MODERATE** | 2-4 products, none dominant | CAUTION - May need modifier |
| **LOW** | 0-1 minor uses | GOOD - Clear namespace |
| **UNIQUE** | No uses found | EXCELLENT - Own the name |

---

### Dimension 4: Social Media Availability

> **Purpose:** Check if consistent social handles are available.

#### Platform Priority

| Priority | Platform | Handle Format | Check URL |
|----------|----------|---------------|-----------|
| **P1** | GitHub | github.com/{name} | Required for dev tools |
| **P1** | Twitter/X | @{name} | Brand presence |
| **P2** | LinkedIn | linkedin.com/company/{name} | B2B presence |
| **P2** | YouTube | youtube.com/@{name} | Content marketing |
| **P3** | Discord | discord.gg/{name} | Community |
| **P3** | Slack | {name}.slack.com | Community |
| **P4** | Reddit | r/{name} | Community |
| **P4** | Instagram | @{name} | Consumer presence |

#### Handle Availability Matrix

| Platform | @{name} | @{name}hq | @get{name} | @{name}app |
|----------|---------|-----------|------------|------------|
| GitHub | ✓/✗ | ✓/✗ | ✓/✗ | ✓/✗ |
| Twitter | ✓/✗ | ✓/✗ | ✓/✗ | ✓/✗ |
| LinkedIn | ✓/✗ | ✓/✗ | ✓/✗ | ✓/✗ |

---

### Dimension 5: Brand Strength Assessment

> **Purpose:** Evaluate the intrinsic strength of the name as a brand.

#### Brand Name Spectrum

```
WEAK ──────────────────────────────────────────────────────────── STRONG

Generic    Descriptive    Suggestive    Arbitrary    Fanciful
─────────────────────────────────────────────────────────────────────────

"Computer   "Fast          "Netflix"     "Apple"      "Xerox"
 Store"      Delivery"     (Net+Flicks)  (for         (Invented
                                         computers)   word)
```

| Type | Definition | Trademark Strength | Examples |
|------|------------|-------------------|----------|
| **Generic** | Common name for product | NONE - Cannot trademark | "Email Service" |
| **Descriptive** | Describes product | WEAK - Hard to protect | "QuickBooks" |
| **Suggestive** | Hints at quality | MODERATE - Protectable | "Netflix", "Airbnb" |
| **Arbitrary** | Real word, unrelated | STRONG - Easily protected | "Apple", "Amazon" |
| **Fanciful** | Invented word | STRONGEST - Best protection | "Xerox", "Kodak" |

#### Brand Name Evaluation Criteria

| Criterion | Poor (1) | Good (3) | Excellent (5) |
|-----------|----------|----------|---------------|
| **Memorability** | Hard to recall | Memorable | Unforgettable |
| **Pronounceability** | Unclear pronunciation | Clear | Intuitive |
| **Spellability** | Multiple spellings | Some ambiguity | Obvious spelling |
| **Meaning** | Negative connotations | Neutral | Positive associations |
| **Distinctiveness** | Generic | Somewhat unique | Highly distinctive |
| **Scalability** | Limits expansion | Some limits | No limits |
| **International** | Problematic in other languages | OK | Works globally |

---

## Research Protocol

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 1: UNDERSTAND THE NAME                                                │
│  → What is the name?                                                        │
│  → What does it mean/represent?                                             │
│  → What market/product is it for?                                           │
│  → What TLDs are priority?                                                  │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 2: DOMAIN AVAILABILITY                                                │
│  → Check priority TLDs (.com, .io, .dev, .app)                             │
│  → Check variations if primary taken                                        │
│  → Research who owns taken domains                                          │
│  → Document acquisition costs if applicable                                 │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 3: TRADEMARK SEARCH                                                   │
│  → Search USPTO TESS (exact and phonetic)                                  │
│  → Search WIPO Global Brand Database                                        │
│  → Search relevant Nice Classes (9, 42 for software)                       │
│  → Assess trademark risk level                                              │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 4: CROWDING ANALYSIS                                                  │
│  → Google search for similar products                                       │
│  → Search developer ecosystems (npm, PyPI, GitHub)                         │
│  → Search app stores                                                        │
│  → Count and categorize similar uses                                        │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 5: SOCIAL MEDIA AVAILABILITY                                          │
│  → Check priority platforms (GitHub, Twitter, LinkedIn)                    │
│  → Check handle variations                                                  │
│  → Document availability matrix                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 6: BRAND STRENGTH ASSESSMENT                                          │
│  → Classify on trademark spectrum                                           │
│  → Score evaluation criteria                                                │
│  → Note any international concerns                                          │
└─────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  STEP 7: SYNTHESIS AND RECOMMENDATION                                       │
│  → Overall viability assessment                                             │
│  → Risk summary                                                             │
│  → Recommendation: PROCEED / CAUTION / AVOID                               │
│  → Alternative suggestions if needed                                        │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Brand Research Report Template

```markdown
# Brand Research Report: {Name}

**Date:** YYYY-MM-DD
**Researcher:** Claude Code (Brand Research Skill)
**Purpose:** {Product/service/company name for X}

---

## Executive Summary

**Overall Recommendation:** PROCEED | PROCEED WITH CAUTION | AVOID

**Key Findings:**
- Domain: {Available/Taken/Acquirable}
- Trademark: {Clear/Risk/Conflict}
- Crowding: {Low/Moderate/High}
- Social: {Available/Partial/Unavailable}
- Brand Strength: {Strong/Moderate/Weak}

---

## Domain Availability

### Primary Domains

| Domain | Status | Owner/Notes | Action |
|--------|--------|-------------|--------|
| {name}.com | ✓/✗ | {Details} | {Action} |
| {name}.io | ✓/✗ | {Details} | {Action} |
| {name}.dev | ✓/✗ | {Details} | {Action} |

### Alternative Domains

| Domain | Status | Notes |
|--------|--------|-------|
| get{name}.com | ✓/✗ | {Notes} |
| {name}hq.com | ✓/✗ | {Notes} |

### Domain Recommendation
{Which domain strategy to pursue}

---

## Trademark Analysis

### USPTO Search Results

| Mark | Class | Status | Owner | Risk |
|------|-------|--------|-------|------|
| {Mark} | {Class} | {Live/Dead} | {Owner} | {High/Med/Low} |

### International Search Results

| Database | Matches Found | Risk Level |
|----------|---------------|------------|
| WIPO | {Count} | {Risk} |
| EUIPO | {Count} | {Risk} |

### Trademark Risk Assessment
**Risk Level:** HIGH | MEDIUM | LOW | CLEAR
**Rationale:** {Why}
**Recommendation:** {Action to take}

---

## Name Crowding Analysis

### Direct Market Search

| Entity | Type | Relevance | Confusion Risk |
|--------|------|-----------|----------------|
| {Entity} | {Competitor/Unrelated} | {High/Med/Low} | {High/Med/Low} |

### Developer Ecosystem

| Platform | Results | Notable Conflicts |
|----------|---------|-------------------|
| GitHub | {Count} repos | {Details} |
| npm | {Count} packages | {Details} |
| PyPI | {Count} packages | {Details} |

### Crowding Assessment
**Level:** UNIQUE | LOW | MODERATE | HIGH | SEVERE
**Implication:** {What this means}

---

## Social Media Availability

| Platform | @{name} | @{name}hq | @get{name} | Recommendation |
|----------|---------|-----------|------------|----------------|
| GitHub | ✓/✗ | ✓/✗ | ✓/✗ | {Handle} |
| Twitter | ✓/✗ | ✓/✗ | ✓/✗ | {Handle} |
| LinkedIn | ✓/✗ | ✓/✗ | ✓/✗ | {Handle} |

### Social Strategy
{Recommended handles to secure}

---

## Brand Strength Assessment

### Trademark Spectrum
**Classification:** Generic | Descriptive | Suggestive | Arbitrary | Fanciful

### Evaluation Scores

| Criterion | Score (1-5) | Notes |
|-----------|-------------|-------|
| Memorability | {Score} | {Notes} |
| Pronounceability | {Score} | {Notes} |
| Spellability | {Score} | {Notes} |
| Meaning/Connotation | {Score} | {Notes} |
| Distinctiveness | {Score} | {Notes} |
| Scalability | {Score} | {Notes} |
| International | {Score} | {Notes} |

**Overall Brand Strength:** {Total}/35 - {Strong/Moderate/Weak}

---

## Risk Summary

| Dimension | Risk | Mitigation |
|-----------|------|------------|
| Domain | {Risk level} | {Mitigation} |
| Trademark | {Risk level} | {Mitigation} |
| Crowding | {Risk level} | {Mitigation} |
| Social | {Risk level} | {Mitigation} |

---

## Recommendations

### Primary Recommendation
**{PROCEED | PROCEED WITH CAUTION | AVOID}**

**Rationale:**
{Detailed explanation}

### If Proceeding

1. **Domain Strategy:** {Acquire X, register Y}
2. **Trademark Strategy:** {File in Class X, consult attorney for Y}
3. **Social Strategy:** {Secure handles X, Y, Z immediately}
4. **Timeline:** {Recommended urgency}

### Alternative Names (if applicable)

If the primary name has issues, consider:

| Alternative | Domain | TM Risk | Crowding | Recommendation |
|-------------|--------|---------|----------|----------------|
| {Alt 1} | {Avail} | {Risk} | {Level} | {Rec} |
| {Alt 2} | {Avail} | {Risk} | {Level} | {Rec} |

---

## Sources

{List of sources consulted}

---

## Disclaimer

This research provides an initial assessment only. For trademark matters,
consult a qualified intellectual property attorney before making final
decisions or filing applications.
```

---

## Name Generation (Optional Feature)

When asked to generate name candidates:

### Generation Strategies

| Strategy | Description | Example |
|----------|-------------|---------|
| **Portmanteau** | Blend two words | Netflix (Net + Flicks) |
| **Metaphor** | Symbolic meaning | Amazon (vast, everything) |
| **Acronym** | Initials | IBM, AWS |
| **Modified Spelling** | Unique spelling | Lyft, Flickr |
| **Foreign Words** | Other languages | Volvo (Latin: "I roll") |
| **Invented** | Completely new | Xerox, Kodak |
| **Compound** | Two words together | Facebook, Salesforce |
| **Prefix/Suffix** | Common affixes | Shopify, Spotify |

### Generation Prompt Template

```
Generate 10 brand name candidates for:

Product: {description}
Target Market: {audience}
Key Attributes: {attributes to convey}
Avoid: {words/concepts to avoid}

For each candidate, provide:
1. The name
2. Rationale/meaning
3. Trademark spectrum classification
4. Quick domain check (.com availability)
```

---

## Tool Usage

| Tool | Purpose |
|------|---------|
| **WebSearch** | Domain availability, trademark searches, crowding |
| **WebFetch** | Read trademark databases, domain registrars |
| **Write** | Save research output |

### Search Queries

| Check | Search Query |
|-------|--------------|
| Domain | `"{name}.com" site:whois.com` OR use domain registrar |
| USPTO | `site:tmsearch.uspto.gov "{name}"` |
| GitHub | `site:github.com "{name}" organization` |
| npm | `site:npmjs.com/package/{name}` |
| General crowding | `"{name}" software OR platform OR app` |

---

## Files in This Skill

```
skills/brand-research/
└── SKILL.md                    # This file

product/research/brand/                # Brand research outputs
└── {name}/
    ├── BRAND_RESEARCH.md
    ├── domain-availability.md
    ├── trademark-search.md
    └── alternatives.md
```

---

## References

USPTO (2026) 'Trademark Electronic Search System (TESS)'. Available at:
https://tmsearch.uspto.gov (Accessed: 19 January 2026).

WIPO (2026) 'Global Brand Database'. Available at:
https://branddb.wipo.int (Accessed: 19 January 2026).

Ries, A. and Trout, J. (2001) Positioning: The Battle for Your Mind.
New York: McGraw-Hill.

Keller, K.L. (2013) Strategic Brand Management: Building, Measuring,
and Managing Brand Equity. 4th edn. Harlow: Pearson.
