---
name: srd-templates
description: >
  Artifact templates for Software Requirements Documents. Contains templates for
  the SRD itself, use cases, sequence diagrams, process flows, state diagrams,
  data flows, NFRs, and glossary. Preloaded into the requirements-analyst agent.
user-invocable: false
---

# SRD Artifact Templates

These templates define the structure for all artifacts produced during requirements
facilitation. Use them as the skeleton when generating artifacts in Phase 4 (Artifact
Generation). Replace `{placeholders}` with content from the facilitation session.

---

## SRD Template

# Software Requirements Document: {Project Name}

**Version:** {version}
**Date:** {date}
**Status:** Draft | Review | Approved
**Author:** {author} (facilitated by Requirements Analyst)

---

### 1. Introduction

#### 1.1 Purpose
{Why this document exists. What system, feature, or integration it specifies.}

#### 1.2 Scope
{What is in scope and what is explicitly out of scope.}

#### 1.3 Intended Audience
{Who will read this document and what they need from it.}

#### 1.4 Definitions and Acronyms
See [GLOSSARY.md](GLOSSARY.md) for the full domain glossary.

#### 1.5 References
{Related documents, existing specifications, external standards.}

---

### 2. Overall Description

#### 2.1 Product Perspective
{How this system fits into the larger context. Existing systems, integrations, users.}

#### 2.2 Product Functions (Summary)
{High-level summary of major functions. Detail is in Section 4.}

| Function | Description |
|----------|-------------|
| {F-01} | {Brief description} |

#### 2.3 User Classes and Characteristics

| Actor | Description | Frequency of Use | Technical Proficiency |
|-------|-------------|-------------------|----------------------|
| {Actor 1} | {Description} | {Daily/Weekly/etc.} | {High/Medium/Low} |

#### 2.4 Operating Environment
{Platforms, browsers, devices, infrastructure constraints.}

#### 2.5 Design and Implementation Constraints
{Technology constraints, regulatory requirements, standards compliance.}

#### 2.6 Assumptions and Dependencies
{What must be true for these requirements to be valid.}

---

### 3. External Interface Requirements

#### 3.1 User Interfaces
{UI requirements, accessibility requirements, responsive design constraints.}

#### 3.2 Hardware Interfaces
{If applicable.}

#### 3.3 Software Interfaces
{APIs consumed, databases, external services. Detail in diagrams/sequence-diagrams.md.}

#### 3.4 Communications Interfaces
{Protocols, data formats, sync/async patterns.}

---

### 4. System Features

#### 4.1 {Feature Name} [F-01]

**Priority:** {High | Medium | Low}

##### 4.1.1 Description
{What this feature does and why it exists.}

##### 4.1.2 Use Cases
See [diagrams/use-cases.md](diagrams/use-cases.md) — {UC-01, UC-02}.

##### 4.1.3 Functional Requirements

| ID | Requirement | Priority | Acceptance Criteria |
|----|-------------|----------|---------------------|
| FR-{01} | {Requirement} | {H/M/L} | {Measurable criterion} |

---

### 5. Non-Functional Requirements

See [NFR.md](NFR.md) for full non-functional requirements specification.

| Category | Summary |
|----------|---------|
| Performance | {Key performance targets} |
| Scalability | {Scaling requirements} |
| Security | {Security requirements} |
| Availability | {Uptime targets} |
| Data | {Data requirements} |

---

### 6. Diagrams

All diagrams use Mermaid notation for portability and version control.

| Diagram Type | File | Purpose |
|-------------|------|---------|
| Use Case | [diagrams/use-cases.md](diagrams/use-cases.md) | Actor-goal relationships |
| Process Flow | [diagrams/process-flows.md](diagrams/process-flows.md) | Activity/workflow diagrams |
| Sequence | [diagrams/sequence-diagrams.md](diagrams/sequence-diagrams.md) | Integration and interaction sequences |
| State | [diagrams/state-diagrams.md](diagrams/state-diagrams.md) | Entity lifecycle state machines |
| Data Flow | [diagrams/data-flows.md](diagrams/data-flows.md) | Data movement between components |

---

### 7. Traceability Matrix

| Goal | Use Cases | Diagrams | NFRs | Features |
|------|-----------|----------|------|----------|
| {G-01} | {UC-01, UC-02} | {use-cases, sequence} | {NFR-01} | {F-01} |

---

### 8. Appendices

#### 8.1 Exploration Journal
See [EXPLORATION_JOURNAL.md](EXPLORATION_JOURNAL.md) for the facilitation record.

#### 8.2 Completeness Report
See [COMPLETENESS_REPORT.md](COMPLETENESS_REPORT.md) for the verification assessment.

#### 8.3 Handover Brief
See [HANDOVER.md](HANDOVER.md) for the execution agent handover.

---

## Use Case Template

### UC-{ID}: {Use Case Name}

**Actor:** {Primary actor}
**Goal:** {What the actor is trying to achieve}
**Priority:** {High | Medium | Low}
**Preconditions:**
- {What must be true before this use case can begin}

**Postconditions (success):**
- {What is true when the use case completes successfully}

**Postconditions (failure):**
- {What is true when the use case fails}

#### Basic Flow

| Step | Actor | System |
|------|-------|--------|
| 1 | {Actor action} | |
| 2 | | {System response} |
| 3 | {Actor action} | |
| 4 | | {System response} |

#### Alternate Flows

**{AF-01}: {Alternate flow name}**
- Branches from: Step {N}
- Condition: {When this alternate flow triggers}

| Step | Actor | System |
|------|-------|--------|
| {N}.1 | {Action} | |
| {N}.2 | | {Response} |

- Rejoins: Step {M} | Ends

#### Exception Flows

**{EF-01}: {Exception name}**
- Branches from: Step {N}
- Condition: {Error condition}

| Step | Actor | System |
|------|-------|--------|
| {N}.1 | | {Error handling} |
| {N}.2 | | {User notification} |

- Result: {Outcome — retry, abort, degrade}

#### Business Rules

| ID | Rule | Applies To |
|----|------|------------|
| BR-{01} | {Business rule description} | Step {N} |

#### Use Case Diagram (Mermaid)

```mermaid
graph LR
    Actor1["{Actor 1}"]
    subgraph System["{System Name}"]
        UC01("{UC-01: Use Case Name}")
    end
    Actor1 --> UC01
```

---

## Sequence Diagram Template

### {SD-ID}: {Sequence Name}

**Related Use Case:** {UC-ID}
**Participants:** {List of systems/components involved}
**Trigger:** {What initiates this sequence}

```mermaid
sequenceDiagram
    participant U as {User/Actor}
    participant A as {Component A}
    participant B as {Component B}
    participant C as {External System}

    U->>A: {Request}
    activate A
    A->>B: {Internal call}
    activate B
    B->>C: {External call}
    activate C
    C-->>B: {Response}
    deactivate C
    B-->>A: {Result}
    deactivate B
    A-->>U: {Response}
    deactivate A

    alt {Error condition}
        C-->>B: {Error response}
        B-->>A: {Error handling}
        A-->>U: {Error message}
    end
```

#### Interaction Notes

| Step | From | To | Data | Notes |
|------|------|----|------|-------|
| 1 | {From} | {To} | {Payload description} | {Protocol, auth, format} |

#### Error Handling

| Error Condition | Handler | User Impact | Recovery |
|----------------|---------|-------------|----------|
| {Condition} | {Component} | {What user sees} | {Auto-retry / manual / abort} |

#### Performance Expectations

| Interaction | Expected Latency | Timeout | Retry Policy |
|-------------|-----------------|---------|--------------|
| {Call} | {Target} | {Timeout} | {Retry count and backoff} |

---

## Process Flow Template

### {PF-ID}: {Process Name}

**Related Use Case:** {UC-ID}
**Trigger:** {What starts this process}
**End State:** {What constitutes process completion}

```mermaid
flowchart TD
    Start([Start: {Trigger}])
    Step1[{Step 1 description}]
    Decision1{"{Decision question}"}
    Step2[{Step 2a description}]
    Step3[{Step 2b description}]
    Step4[{Step 3 description}]
    End([End: {End state}])

    Start --> Step1
    Step1 --> Decision1
    Decision1 -->|Yes| Step2
    Decision1 -->|No| Step3
    Step2 --> Step4
    Step3 --> Step4
    Step4 --> End
```

#### Process Steps

| Step | Description | Actor/System | Inputs | Outputs | Business Rules |
|------|-------------|-------------|--------|---------|----------------|
| 1 | {Description} | {Who/what} | {Required inputs} | {Produced outputs} | {BR-IDs} |

#### Decision Points

| Decision | Criteria | Yes Path | No Path |
|----------|----------|----------|---------|
| {Decision} | {How the decision is made} | {Path} | {Path} |

---

## State Diagram Template

### {ST-ID}: {Entity Name} Lifecycle

**Entity:** {Entity name}
**Related Use Cases:** {UC-IDs}
**Purpose:** {Why this entity has state — what decisions depend on its current state}

```mermaid
stateDiagram-v2
    [*] --> Created
    Created --> Active: activate
    Active --> Suspended: suspend
    Suspended --> Active: reactivate
    Active --> Completed: complete
    Suspended --> Cancelled: cancel
    Active --> Cancelled: cancel
    Completed --> [*]
    Cancelled --> [*]
```

#### States

| State | Description | Entry Conditions | Allowed Actions |
|-------|-------------|-----------------|-----------------|
| {Created} | {Description} | {How entity enters this state} | {What can happen in this state} |

#### Transitions

| From | To | Trigger | Guard Conditions | Side Effects |
|------|----|---------|-----------------|--------------|
| {State A} | {State B} | {What causes transition} | {Conditions that must be true} | {What else happens} |

#### Invalid Transitions

| From | To | Why Invalid |
|------|----|------------|
| {State A} | {State B} | {Why this transition is not allowed} |

---

## Data Flow Template

### {DF-ID}: {Data Flow Name}

**Scope:** {System-level | Feature-level | Integration-level}
**Related Use Cases:** {UC-IDs}

```mermaid
flowchart LR
    subgraph External
        ES1[("{External Source 1}")]
        ES2[("{External Sink 1}")]
    end

    subgraph System["{System Name}"]
        P1["{Process 1}"]
        P2["{Process 2}"]
        DS1[("{Data Store 1}")]
    end

    ES1 -->|"{data description}"| P1
    P1 -->|"{transformed data}"| DS1
    DS1 -->|"{query results}"| P2
    P2 -->|"{output data}"| ES2
```

#### Data Stores

| ID | Name | Type | Contents | Access Pattern |
|----|------|------|----------|----------------|
| DS-{01} | {Name} | {Database/Cache/File/Queue} | {What data is stored} | {Read-heavy/Write-heavy/Both} |

#### Data Flows

| ID | From | To | Data | Format | Volume | Frequency |
|----|------|----|------|--------|--------|-----------|
| {Flow-01} | {Source} | {Destination} | {Description} | {JSON/CSV/Binary/etc.} | {Expected volume} | {Real-time/Batch/On-demand} |

#### Privacy and Sensitivity

| Data Element | Classification | Handling Requirements |
|-------------|---------------|----------------------|
| {Element} | {PII/Sensitive/Public} | {Encryption/Masking/Retention} |

---

## NFR Template

### Performance

| ID | Requirement | Metric | Target | Measurement Method |
|----|-------------|--------|--------|-------------------|
| NFR-P01 | {Requirement} | {Metric name} | {Specific threshold} | {How measured} |

### Scalability

| ID | Requirement | Metric | Target | Measurement Method |
|----|-------------|--------|--------|-------------------|
| NFR-S01 | {Requirement} | {Metric name} | {Specific threshold} | {How measured} |

### Security

| ID | Requirement | Category | Implementation | Verification |
|----|-------------|----------|----------------|-------------|
| NFR-SEC01 | {Requirement} | {Auth/Encryption/Access/Audit} | {How implemented} | {How verified} |

### Availability

| ID | Requirement | Metric | Target | Measurement Method |
|----|-------------|--------|--------|-------------------|
| NFR-A01 | {Requirement} | {Metric name} | {Specific threshold} | {How measured} |

### Data

| ID | Requirement | Category | Implementation | Verification |
|----|-------------|----------|----------------|-------------|
| NFR-D01 | {Requirement} | {Retention/Backup/Recovery/Privacy} | {How implemented} | {How verified} |

**NFR Quality Criteria:** Every NFR MUST be measurable (specific threshold), testable
(pass/fail against threshold), traceable (linked to business goal), and achievable.

---

## Glossary Template

| Term | Definition | Context | First Appeared |
|------|-----------|---------|----------------|
| {Term} | {Precise definition as used in this domain} | {Where/how this term is used} | {Phase/turn where it was introduced} |

### Synonyms and Disambiguation

| Preferred Term | Also Known As | NOT the Same As |
|---------------|---------------|-----------------|
| {Preferred} | {Synonyms used during exploration} | {Terms that sound similar but mean different things} |
