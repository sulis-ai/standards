# Critical Thinking Standard

<!-- summary -->
Thirteen analytical principles (BI, SI, FR, CC, MECE, NH, PP, HU, EH, DF, PG, OI, AT)
and nine anti-patterns (AP-01 through AP-09) that govern how research, analysis, and
reasoning are conducted. Ensures rigour, intellectual honesty, and evidence-based
conclusions across all analytical work.
<!-- /summary -->

> **Version:** 1.0.0
> **Status:** Active

---

## Provenance

These principles encode analytical methodology drawing on: structured analytic techniques
(Heuer & Pherson, 2014), Bayesian reasoning, MECE problem decomposition (Minto, 1987),
epistemic humility literature, and practitioner knowledge from research and strategy work.

---

## Boundary Definition

This standard contains **universal critical thinking principles only**. Content belongs
here if and only if it passes the **ProjectX test**: replacing every project name, file
path, and technology-specific example with a fictional "ProjectX" equivalent requires
zero semantic changes to the principle statement.

Content that fails the ProjectX test belongs in the project's architecture file, not here.

---

## Severity Convention

| Severity | Meaning |
|----------|---------|
| **MUST** | Non-negotiable. Violations block delivery. |
| **SHOULD** | Default. Deviation requires explicit justification. |

---

## Core Principles

<!-- detail -->

### BI: Begin with Inquiry

**Severity:** MUST

Before producing any analysis, articulate the question you are answering. If you cannot
state the question clearly, you are not ready to begin analysis.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Every analytical output begins with an explicitly stated question or hypothesis. The question is written down before research begins. |
| **Template** | "The question this analysis answers is: [question]. This question matters because: [context]. We will know the answer is adequate when: [success criteria]." |
| **Verification** | The stated question exists. It is specific enough to be answerable. It includes success criteria. The analysis directly addresses the stated question. |
| **Red Flags** | Analysis that "explores" a topic without a stated question. Conclusions that answer a different question than the one stated. Questions so broad they cannot be falsified ("What is the state of the market?"). |
| **Anti-Pattern** | Starting with research, then retrospectively fitting a question to the findings. |

---

### SI: Source Independence

**Severity:** MUST

Conclusions must be supported by multiple independent sources. A single source, regardless
of its authority, is a data point — not a conclusion.

| Attribute | Detail |
|-----------|--------|
| **Rule** | No factual claim rests on a single source. When only one source exists, the claim is explicitly marked as single-source and treated as provisional. Independent means the sources do not derive from each other. |
| **Template** | "This claim is supported by [N] independent sources: [list]. These sources are independent because [explanation]." Or: "This claim rests on a single source ([source]). It is treated as provisional." |
| **Verification** | Each factual claim cites at least two independent sources. Single-source claims are explicitly flagged. Sources are actually independent (not one quoting the other). |
| **Red Flags** | Multiple citations that all trace back to the same original source. Treating a source as authoritative without corroboration. Citing a secondary summary instead of the primary source. |
| **Anti-Pattern** | Circular sourcing — A cites B, B cites A, presented as two independent sources. |

---

### FR: Falsifiability Requirement

**Severity:** MUST

Every claim must be stated in a form that can, in principle, be proven wrong. If a
claim cannot be falsified, it is not an analytical conclusion — it is an opinion or
a tautology.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Claims are stated in falsifiable form. For each claim, identify what evidence would disprove it. If no evidence could disprove it, restate the claim or acknowledge it as a value judgement. |
| **Template** | "Claim: [statement]. This claim would be falsified by: [specific evidence that would disprove it]." |
| **Verification** | Each analytical claim has an identified falsification condition. If the falsification condition is impossible to observe, the claim is restated or reclassified. |
| **Red Flags** | Claims that are true by definition. Claims so vague that any outcome confirms them. Moving the goalposts when counter-evidence appears. |
| **Anti-Pattern** | "This approach might work" — unfalsifiable because "might" covers all outcomes. Restate as: "This approach will achieve [specific outcome] within [timeframe]." |

---

### CC: Confidence Calibration

**Severity:** MUST

Attach explicit confidence levels to claims. Distinguish between "we are confident
because of strong evidence" and "we believe this but the evidence is thin."

| Attribute | Detail |
|-----------|--------|
| **Rule** | Every non-trivial claim carries an explicit confidence indicator. Confidence is calibrated to evidence quality and quantity, not to the analyst's conviction. |
| **Confidence Scale** | **High** — Multiple independent sources, directly observed data, or well-established research. **Medium** — Some supporting evidence but gaps exist, or evidence is indirect. **Low** — Single source, extrapolation from limited data, or analyst judgement with minimal supporting evidence. |
| **Template** | "Claim: [statement]. Confidence: [High/Medium/Low]. Basis: [evidence summary]. Key uncertainty: [what could change this assessment]." |
| **Verification** | Claims have explicit confidence levels. The stated confidence matches the underlying evidence (not inflated or deflated). Key uncertainties are identified. |
| **Red Flags** | Presenting low-confidence claims with the same certainty as high-confidence claims. No confidence indicators anywhere in the analysis. Confidence levels that don't match the evidence cited. |
| **Anti-Pattern** | Asserting "the market will grow 15%" without indicating whether this is a high-confidence forecast from multiple models or a low-confidence extrapolation from one data point. |

---

### MECE: Mutually Exclusive, Collectively Exhaustive

**Severity:** SHOULD

When decomposing a problem, ensure categories are mutually exclusive (no item belongs
in more than one category) and collectively exhaustive (all items are accounted for).

| Attribute | Detail |
|-----------|--------|
| **Rule** | Problem decompositions, option analyses, and categorisation schemes are MECE. When perfect MECE is impractical, deviations are documented with the rationale. |
| **Template** | "The options/categories are: [list]. These are mutually exclusive because: [explanation]. These are collectively exhaustive because: [explanation or acknowledgement of known gaps]." |
| **Verification** | No item falls into multiple categories. All relevant items are accounted for. If gaps exist, they are documented. |
| **Red Flags** | Overlapping categories that force items into multiple buckets. Missing categories that cause items to fall through. Catch-all "Other" categories that contain more items than named categories. |
| **Anti-Pattern** | "We can build, buy, or partner" — presented as exhaustive when "do nothing" and "acquire" are also valid options that were not considered. |

---

### NH: Null Hypothesis Awareness

**Severity:** SHOULD

Consider the null hypothesis — that nothing has changed, that there is no effect, or
that the status quo is adequate — before concluding that action is needed.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Before recommending action, explicitly consider whether the evidence supports "no change needed" as a viable conclusion. The burden of proof is on the recommendation, not on the status quo. |
| **Template** | "Null hypothesis: [status quo description]. Evidence against the null: [evidence]. Strength of evidence: [assessment]. Conclusion: [action needed / insufficient evidence to reject the null]." |
| **Verification** | The null hypothesis is stated. Evidence against it is presented. The conclusion is proportional to the evidence strength. |
| **Red Flags** | Skipping straight to recommendations without considering whether the problem actually exists. Treating the need for action as self-evident. Dismissing the status quo without evidence. |
| **Anti-Pattern** | "We need to replatform because our architecture is outdated." — Outdated compared to what? By what measure? What is the cost of not replatforming? |

---

### PP: Proportional Precision

**Severity:** SHOULD

Match the precision of your claims to the precision of your evidence. Do not present
rough estimates as exact figures or general trends as specific predictions.

| Attribute | Detail |
|-----------|--------|
| **Rule** | The precision of stated claims matches the precision of the underlying evidence. Ranges are preferred over point estimates when uncertainty is significant. Orders of magnitude are preferred over precise numbers when data is scarce. |
| **Template** | "Based on [evidence], the value is approximately [range] (not [false-precision number])." |
| **Verification** | Claims do not imply more precision than the evidence supports. Ranges are used when appropriate. Significant figures match data quality. |
| **Red Flags** | "The market opportunity is $4,237,000" based on back-of-envelope estimation. "Exactly 73% of users prefer X" from a survey of 30 people. Presenting a forecast with two decimal places when the model has 20% error margins. |
| **Anti-Pattern** | False precision — stating "deployment will take 14 days" when the honest answer is "2–4 weeks depending on factors we haven't fully scoped." |

---

### HU: Hierarchy of Evidence

**Severity:** MUST

Not all evidence is equal. Rank evidence by reliability and make the ranking explicit
when presenting conclusions.

| Attribute | Detail |
|-----------|--------|
| **Rule** | When multiple types of evidence inform a conclusion, rank them by reliability. Higher-ranked evidence takes precedence when evidence conflicts. |
| **Evidence Hierarchy (strongest to weakest)** | 1. Directly observed, measured data from the specific context. 2. Systematic reviews or meta-analyses of relevant research. 3. Controlled experiments or rigorous studies. 4. Observational data from analogous contexts. 5. Expert opinion with stated reasoning. 6. Anecdote, analogy, or common sense. |
| **Verification** | The type of evidence is identified for each claim. When evidence conflicts, higher-ranked evidence takes precedence or the conflict is documented. Conclusions are not based solely on low-ranked evidence when higher-ranked evidence is available. |
| **Red Flags** | Treating an anecdote as equivalent to measured data. Ignoring systematic evidence because it conflicts with expert opinion. Presenting expert opinion as empirical fact. |
| **Anti-Pattern** | "Our CEO thinks the market is moving towards X" treated as equivalent to market research data showing the opposite. |

---

### EH: Epistemic Humility

**Severity:** MUST

Acknowledge the limits of your knowledge explicitly. Distinguish between what you know,
what you think, and what you are guessing.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Every analysis explicitly identifies: what is known (supported by evidence), what is inferred (derived from evidence but not directly observed), and what is assumed (taken as given without direct evidence). Assumptions are documented and flagged for validation. |
| **Template** | "Known: [evidence-based facts]. Inferred: [logical deductions from known facts]. Assumed: [statements taken as given — to be validated]." |
| **Verification** | The analysis distinguishes between known facts, inferences, and assumptions. Assumptions are listed and flagged. The analyst does not present assumptions as facts. |
| **Red Flags** | Presenting assumptions as established facts. No uncertainty language anywhere in the analysis. Claiming to "know" things that are actually inferences. |
| **Anti-Pattern** | "Users want X" stated as fact when no user research has been conducted — this is an assumption, not a known fact. |

---

### DF: Devil's Advocate Filter

**Severity:** SHOULD

Actively argue against your own conclusions before presenting them. If you cannot
construct a strong counter-argument, your analysis may be incomplete.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Before finalising a conclusion, construct the strongest possible argument against it. Document this counter-argument and explain why the conclusion still holds (or revise the conclusion). |
| **Template** | "Conclusion: [statement]. Strongest counter-argument: [argument]. Why the conclusion holds despite this: [rebuttal]. Conditions under which the counter-argument would prevail: [conditions]." |
| **Verification** | A counter-argument exists for each major conclusion. The counter-argument is genuinely strong (not a strawman). The rebuttal addresses the counter-argument directly. |
| **Red Flags** | No counter-arguments considered. Counter-arguments that are weak strawmen. Rebuttals that dismiss rather than address the counter-argument. |
| **Anti-Pattern** | "One might argue X, but that's obviously wrong because Y" — dismissing the counter-argument without engaging with it seriously. |

---

### PG: Precision of Language

**Severity:** SHOULD

Use precise language. Avoid weasel words, hedge stacking, and vague quantifiers.
When you mean "some", don't say "many." When you mean "we believe", don't say "it is
known."

| Attribute | Detail |
|-----------|--------|
| **Rule** | Use specific language. Quantify where possible. Attribute claims to their source. Avoid passive constructions that hide agency. Avoid stacking hedges ("it might possibly perhaps be the case that..."). |
| **Words to Avoid** | "Many" (how many?), "significant" (by what measure?), "it is known that" (known by whom?), "clearly" (if it were clear, you wouldn't need the word), "stakeholders" (which ones?), "best practice" (according to whom? based on what evidence?), "leverage" (use "use"), "synergy" (describe the specific interaction). |
| **Template** | Replace "many users report issues" with "[N] users reported [specific issue] in [time period], based on [data source]." |
| **Verification** | Vague quantifiers are replaced with specific numbers or ranges. Claims are attributed to specific sources. Passive voice is not used to hide agency. Hedge words are used singly, not stacked. |
| **Red Flags** | Multiple hedge words in one sentence. Vague quantifiers without supporting data. Passive constructions that obscure who did what. "Best practice" cited without a source. |
| **Anti-Pattern** | "It is widely believed that best practices suggest leveraging synergies to drive significant value." — This sentence says nothing. |

---

### OI: Outside-In Reasoning

**Severity:** SHOULD

Start from external reality (user needs, market conditions, observed behaviour) and
reason inward to solutions. Do not start from internal structure and reason outward
to justify existing approaches.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Analysis begins with external evidence (user behaviour, market data, observed outcomes) before consulting internal structure (existing systems, current categorisations, organisational boundaries). Internal structure informs feasibility, not desirability. |
| **Template** | "External evidence shows: [observations]. Given this evidence, the ideal approach would be: [unconstrained solution]. Given internal constraints ([constraints]), the feasible approach is: [constrained solution]. Gap between ideal and feasible: [gap]." |
| **Verification** | The analysis starts with external evidence. Internal structure is consulted for feasibility, not as the starting point. Conclusions are not merely rationalisations of the current approach. |
| **Red Flags** | "We should do X because that's how our system is structured" — reasoning from internal structure outward. Skipping external evidence and starting from existing categorisations. Letting organisational boundaries define the analysis rather than the problem. |
| **Anti-Pattern** | Decomposing a customer problem along internal team boundaries rather than along the customer's actual experience. Categorising user needs to match existing features rather than observed behaviour. |

---

### AT: Assumption Tracking

**Severity:** SHOULD

Maintain an explicit list of assumptions underlying any analysis. Revisit and validate
assumptions as work progresses. Expired or invalidated assumptions trigger re-evaluation
of conclusions built on them.

| Attribute | Detail |
|-----------|--------|
| **Rule** | Every analysis maintains a visible list of assumptions. Assumptions are validated or invalidated as new evidence emerges. When a foundational assumption is invalidated, all conclusions built on it are re-evaluated. |
| **Template** | "Assumptions: 1. [Assumption] — Status: [Validated/Unvalidated/Invalidated] — Evidence: [basis]. 2. [Assumption] — Status: [status] — Evidence: [basis]." |
| **Verification** | An assumption list exists. Each assumption has a status. Invalidated assumptions have triggered re-evaluation of dependent conclusions. |
| **Red Flags** | No documented assumptions. Assumptions that have never been validated despite available evidence. Conclusions that depend on invalidated assumptions. |
| **Anti-Pattern** | Building an entire strategy on the assumption that "users want feature X" without ever validating that assumption through research, then being surprised when the feature is not adopted. |

<!-- /detail -->

---

## Anti-Patterns

<!-- detail -->

### AP-01: Confirmation Bias

**Description:** Seeking, interpreting, and prioritising evidence that confirms
pre-existing beliefs while ignoring or downplaying contradictory evidence.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | Cherry-picking data points that support the preferred conclusion. Dismissing contradictory evidence as "outliers" without investigation. Framing research questions to elicit confirming answers. Stopping research as soon as confirming evidence is found. |
| **Detection** | All cited evidence points in the same direction with no acknowledged counter-evidence. Research methodology is designed to confirm rather than test. Contradictory data is absent or dismissed without explanation. |
| **Mitigation** | Apply DF (Devil's Advocate Filter). Actively seek disconfirming evidence. Ask: "What evidence would change my mind?" before starting research. |

---

### AP-02: Anchoring

**Description:** Over-relying on the first piece of information encountered (the
"anchor") and insufficiently adjusting from it as new evidence emerges.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | The first estimate becomes the baseline that all subsequent estimates orbit. Initial framing of a problem constrains all subsequent analysis. A competitor's approach becomes the template even when the context differs. |
| **Detection** | Final conclusions are suspiciously close to initial estimates despite significant new evidence. Analysis framework matches the first source consulted. Alternative framings were not considered. |
| **Mitigation** | Generate estimates independently before consulting existing benchmarks. Consider multiple framings before committing to one. Apply OI (Outside-In Reasoning) to avoid anchoring on internal structure. |

---

### AP-03: Survivorship Bias

**Description:** Drawing conclusions from visible successes while ignoring invisible
failures. The data you see is a biased sample because failures are not represented.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | "Company X did Y and succeeded, so we should do Y" — without considering companies that did Y and failed. Analysing feature adoption by looking only at active users, not churned users. Studying successful projects to learn "what works" without studying failed projects. |
| **Detection** | Analysis sample includes only successes. Failure cases are absent or unexamined. Conclusions generalise from winners without accounting for losers. |
| **Mitigation** | Actively seek failure cases. Ask: "What would this data look like if we included failures?" Apply NH (Null Hypothesis Awareness) — maybe the factor you identified isn't actually causal. |

---

### AP-04: Authority Bias

**Description:** Accepting claims because of the source's authority rather than the
quality of the evidence.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | "The CEO said X, so X is true." Citing a famous expert's opinion as if it were empirical evidence. Accepting a prestigious firm's report without scrutinising its methodology. Dismissing valid criticism because the critic lacks credentials. |
| **Detection** | Claims are supported by appeals to authority rather than evidence. Source prestige substitutes for source evaluation. Counter-evidence from less prestigious sources is dismissed. |
| **Mitigation** | Apply HU (Hierarchy of Evidence). Evaluate the evidence, not the source. Expert opinion is ranked below empirical data. Ask: "Would I accept this claim if it came from an unknown source?" |

---

### AP-05: Sunk Cost Fallacy

**Description:** Continuing an approach because of resources already invested rather
than because the evidence supports continuing.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | "We've already spent 6 months on this, we can't stop now." Refusing to pivot because of emotional investment in the current approach. Evaluating options based on past costs rather than future value. |
| **Detection** | Past investment is cited as a reason to continue. Future-value analysis is absent or subordinated to sunk-cost arguments. Emotional language about "wasted" effort if the approach changes. |
| **Mitigation** | Evaluate all options based on future value only. Apply FR (Falsifiability Requirement) — define upfront what would cause you to abandon the approach. Apply NH — consider whether stopping is a valid option. |

---

### AP-06: Narrative Fallacy

**Description:** Constructing a compelling story that explains the evidence post-hoc,
then treating the story as causal explanation rather than one of many possible
interpretations.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | "We launched feature X, metrics improved, therefore feature X caused the improvement." Retrospective case studies that present a clean narrative of cause and effect. Pattern-matching from a small number of examples to a general rule. |
| **Detection** | Causal claims without controlled comparison. Post-hoc narratives presented as causal analysis. Alternative explanations not considered. Clean, linear stories from messy, non-linear reality. |
| **Mitigation** | Apply CC (Confidence Calibration) — mark post-hoc explanations as low confidence. Consider alternative causal explanations. Demand controlled comparison before accepting causal claims. |

---

### AP-07: False Dichotomy

**Description:** Presenting a situation as having only two options when more exist.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | "We either build this ourselves or we don't do it at all." "Either we launch now or we miss the window." "You're either with us or against us." |
| **Detection** | Exactly two options are presented. No exploration of middle ground, hybrid approaches, or alternative framings. Pressure to choose between the stated options without questioning the frame. |
| **Mitigation** | Apply MECE — enumerate all options, not just two. Ask: "What options are we not seeing?" Apply DF (Devil's Advocate Filter) to challenge the binary framing. |

---

### AP-08: Scope Creep in Analysis

**Description:** Analysis that expands beyond its stated question, consuming time and
resources without improving the quality of the answer to the original question.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | Research that keeps finding "one more interesting angle." Analysis deliverables that grow far beyond the original brief. Tangential findings given equal weight to findings that answer the stated question. |
| **Detection** | Analysis has expanded significantly beyond its original scope. Tangential findings are prominent. The original question is buried or forgotten. Delivery is delayed by scope expansion. |
| **Mitigation** | Apply BI (Begin with Inquiry) — return to the stated question. Ask: "Does this finding help answer the stated question?" Park tangential findings for separate analysis. Set time boundaries on research phases. |

---

### AP-09: Precision Bias

**Description:** Confusing precision (number of decimal places) with accuracy
(closeness to truth). Presenting precise numbers creates an illusion of certainty.

| Attribute | Detail |
|-----------|--------|
| **How It Manifests** | "The ROI will be 14.3%." "We'll need exactly 47 days." "Market share will be 23.7%." All based on estimates with wide error margins. Spreadsheet models with many decimal places built on rough assumptions. |
| **Detection** | High-precision numbers without error margins. Precision that exceeds the quality of input data. Decimal places on estimates built from rough assumptions. |
| **Mitigation** | Apply PP (Proportional Precision). Use ranges, not point estimates, when uncertainty is significant. Show error margins. Match output precision to input precision. |

<!-- /detail -->

---

## Quality Checklist

Before delivering any analytical output, verify:

- [ ] **BI:** The question being answered is explicitly stated with success criteria
- [ ] **SI:** No factual claim rests on a single source (or single-source claims are
  flagged as provisional)
- [ ] **FR:** All claims are stated in falsifiable form with identified falsification
  conditions
- [ ] **CC:** All non-trivial claims carry explicit confidence levels calibrated to
  evidence quality
- [ ] **MECE:** Problem decompositions are mutually exclusive and collectively exhaustive
  (or gaps are documented)
- [ ] **NH:** The null hypothesis has been considered before recommending action
- [ ] **PP:** Claim precision matches evidence precision (no false precision)
- [ ] **HU:** Evidence types are identified and ranked; higher-ranked evidence takes
  precedence
- [ ] **EH:** Known facts, inferences, and assumptions are distinguished; assumptions
  are documented
- [ ] **DF:** Counter-arguments have been constructed and addressed for major conclusions
- [ ] **PG:** Language is precise; vague quantifiers, weasel words, and hedge stacking
  are eliminated
- [ ] **OI:** Analysis starts from external evidence, not internal structure
- [ ] **AT:** Assumptions are tracked with status; invalidated assumptions have triggered
  re-evaluation
- [ ] **Anti-patterns:** Output has been checked against AP-01 through AP-09

---

## Application

These principles apply across all analytical work. The following areas have particular
relevance:

### Research Tasks

All thirteen principles apply. Research is the primary domain for this standard.
Pay particular attention to:
- **SI** (Source Independence) — corroborate findings across independent sources
- **HU** (Hierarchy of Evidence) — rank evidence types explicitly
- **EH** (Epistemic Humility) — distinguish known facts from inferences and assumptions
- **AP-01** (Confirmation Bias) — actively seek disconfirming evidence

### Strategic Analysis

Strategy work is especially vulnerable to narrative construction and false precision.
Pay particular attention to:
- **FR** (Falsifiability Requirement) — ensure strategic claims can be proven wrong
- **CC** (Confidence Calibration) — mark confidence levels on all projections
- **NH** (Null Hypothesis Awareness) — consider "do nothing" as a viable option
- **AP-05** (Sunk Cost Fallacy) — evaluate based on future value, not past investment
- **AP-06** (Narrative Fallacy) — distinguish correlation from causation

### Validation Work

When validating designs, plans, or approaches against requirements or evidence.
Pay particular attention to:
- **BI** (Begin with Inquiry) — state what you are validating and the success criteria
- **DF** (Devil's Advocate Filter) — actively argue against the thing being validated
- **OI** (Outside-In Reasoning) — start from user evidence, not internal assumptions
- **AT** (Assumption Tracking) — surface and validate assumptions in the plan

### Requirements Specification

When defining requirements, user needs, or problem statements.
Pay particular attention to:
- **OI** (Outside-In Reasoning) — derive requirements from external evidence, not
  internal structure
- **MECE** — ensure requirement categories are mutually exclusive and collectively
  exhaustive
- **PP** (Proportional Precision) — match requirement precision to the confidence
  level of the underlying evidence
- **AP-03** (Survivorship Bias) — consider failed approaches and unserved users,
  not just successful ones

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-03-13 | Adapted from analytical framework. 13 principles (BI, SI, FR, CC, MECE, NH, PP, HU, EH, DF, PG, OI, AT), 9 anti-patterns (AP-01 through AP-09). |
