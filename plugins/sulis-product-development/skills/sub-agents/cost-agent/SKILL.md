# Cost Agent (cost-agent)

> **Purpose:** Validate cost constraints and provide optimization recommendations.
> **Operates:** Atomically, without human clarification.

---

## Responsibilities

1. Estimate monthly costs from NFR.md and implementation
2. Validate estimates against COST-01 budget constraint
3. Identify cost optimization opportunities
4. Flag budget overruns with actionable recommendations
5. Update NFR.md Section 5.3 (Cost Estimation)

---

## Inputs (Required)

| Artifact | Path | What to Extract |
|----------|------|-----------------|
| **NFR.md** | `features/{feature}/NFR.md` | COST-*, COMP-*, SCALE-* |
| **PLATFORM_CAPABILITIES** | `architecture/PLATFORM_CAPABILITIES.md` | Pricing reference |
| **sulis.yaml** | Project root | Actual deployment configuration |

---

## Outputs

| Output | Description |
|--------|-------------|
| Cost estimate | Detailed breakdown by category |
| Budget validation | PASS/FAIL with delta |
| Optimization report | Recommendations if over budget |
| Updated NFR.md | Section 5.3 filled out |

---

## Cost Model

### Pricing Reference (from PLATFORM_CAPABILITIES.md)

| Category | Metric | Credits | GBP |
|----------|--------|---------|-----|
| Compute | vCPU-hour | 5 | £0.05 |
| Compute | GiB-hour | 2 | £0.02 |
| Compute | Build minute | 10 | £0.10 |
| Storage | GiB-month | 1 | £0.01 |
| Network | Egress GiB | 1 | £0.01 |
| AI | 1K tokens | 1 | £0.01 |
| API | 1K requests | 0.01 | £0.0001 |

### Calculation Formula

```python
def calculate_monthly_cost(
    nfr: NFR,
    sulis: Manifest,
    pricing: Pricing
) -> CostBreakdown:
    """
    Calculate estimated monthly cost.
    """
    # Extract configuration
    cpu = float(sulis.devpute.cpu)
    memory_gib = parse_gib(sulis.devpute.memory)
    min_instances = sulis.devpute.min_instances
    max_instances = sulis.devpute.max_instances

    # Load assumptions from NFR
    requests_per_day = nfr.scale_02_requests_per_day
    peak_multiplier = nfr.scale_04_peak_multiplier or 1

    # Calculate average running instances
    # Simple model: (min + (max * peak_hours_fraction)) / 2
    peak_hours = 8  # Assume 8 hours of peak per day
    avg_instances = (
        min_instances * (24 - peak_hours) +
        min(max_instances, min_instances * peak_multiplier) * peak_hours
    ) / 24

    # Monthly hours
    monthly_hours = avg_instances * 24 * 30

    # Compute costs
    compute_vcpu = monthly_hours * cpu * pricing.vcpu_hour
    compute_memory = monthly_hours * memory_gib * pricing.gib_hour
    compute_total = compute_vcpu + compute_memory

    # Storage costs
    object_storage_gib = parse_gib(nfr.infra_10_object_storage or "0GB")
    document_storage = nfr.infra_11_document_count or 0
    storage_total = (
        object_storage_gib * pricing.gib_month +
        document_storage * 0.001  # Estimate per document
    )

    # Network costs (estimate egress)
    # Assume 1KB average response size
    monthly_requests = requests_per_day * 30
    egress_gib = (monthly_requests * 1024) / (1024 ** 3)
    network_total = egress_gib * pricing.egress_gib

    # Build costs (estimate 2 deploys per month)
    build_minutes = 5  # Average build time
    builds_per_month = 2
    build_total = build_minutes * builds_per_month * pricing.build_minute

    return CostBreakdown(
        compute_vcpu=compute_vcpu,
        compute_memory=compute_memory,
        storage=storage_total,
        network=network_total,
        build=build_total,
        total=compute_vcpu + compute_memory + storage_total + network_total + build_total
    )
```

---

## Budget Validation

```python
def validate_budget(estimate: CostBreakdown, nfr: NFR) -> ValidationResult:
    """
    Validate estimated cost against COST-01 budget.
    """
    budget = nfr.cost_01_budget

    if estimate.total <= budget:
        return ValidationResult(
            status="PASS",
            message=f"Within budget: {estimate.total} / {budget} credits",
            margin=budget - estimate.total,
            margin_percent=(budget - estimate.total) / budget * 100
        )
    else:
        return ValidationResult(
            status="FAIL",
            message=f"Over budget: {estimate.total} / {budget} credits",
            overage=estimate.total - budget,
            overage_percent=(estimate.total - budget) / budget * 100
        )
```

---

## Optimization Recommendations

When over budget, generate actionable recommendations:

### Category 1: Compute Optimization

| Recommendation | Savings | Trade-off |
|----------------|---------|-----------|
| Reduce CPU from X to Y | Z credits | Higher latency under load |
| Reduce memory from X to Y | Z credits | May OOM under load |
| Enable scale-to-zero | Z credits | Cold start latency |
| Reduce max instances | Z credits | Lower peak capacity |

### Category 2: Architecture Optimization

| Recommendation | Savings | Trade-off |
|----------------|---------|-----------|
| Use job instead of service | Z credits | Not real-time |
| Add caching | Z credits | Implementation effort |
| Batch requests | Z credits | Higher latency |

### Category 3: Constraint Relaxation

| Recommendation | Savings | Requires |
|----------------|---------|----------|
| Increase P95 latency target | Z credits | User acceptance |
| Reduce availability target | Z credits | Risk acceptance |
| Extend cold start tolerance | Z credits | User acceptance |

---

## Output Format

### NFR.md Section 5.3 Update

```markdown
### 5.3 Cost Estimation

> **Calculated by:** cost-agent v1.0.0
> **Date:** 2026-01-16
> **Status:** PASS / FAIL

| Component | Monthly Credits | Monthly GBP | Notes |
|-----------|-----------------|-------------|-------|
| Compute (vCPU) | 120 | £1.20 | 0.5 vCPU × avg 4 instances × 720h |
| Compute (Memory) | 48 | £0.48 | 0.5 GiB × avg 4 instances × 720h |
| Storage | 10 | £0.10 | 10 GiB object storage |
| Network | 15 | £0.15 | ~15 GiB egress |
| Build | 20 | £0.20 | ~2 deploys × 10 min |
| **Total** | **213** | **£2.13** | |
| **Budget** | **500** | **£5.00** | COST-01 |
| **Margin** | **287** | **£2.87** | 57% under budget |

**Assumptions:**
- Average 4 instances running (min=0, peak=10, 8h peak/day)
- 100,000 requests/day (from SCALE-02)
- 1KB average response size
- 2 deployments per month
```

### Optimization Report (if over budget)

```markdown
## Cost Optimization Report

**Status:** OVER BUDGET by 150 credits (30%)

### Recommended Actions

| Priority | Action | Savings | Impact |
|----------|--------|---------|--------|
| 1 | Enable scale-to-zero | 80 credits | Cold start (5s) |
| 2 | Reduce CPU to 0.25 vCPU | 60 credits | 2x latency under load |
| 3 | Reduce max instances to 5 | 30 credits | Lower peak capacity |

### Implementation

1. Update NFR.md COST-10: "Scale-to-zero = Required"
2. Update NFR.md COMP-10: "CPU target = 0.25"
3. Update NFR.md SCALE-11: "Max instances = 5"

After applying all recommendations: **Estimated 270 credits** (within budget)
```

---

## Escalation Triggers

| Condition | Action |
|-----------|--------|
| Over budget with no optimization path | Escalate to increase budget or reduce scope |
| Optimization requires constraint changes | Escalate for user approval |
| Estimate uncertainty > 50% | Flag assumptions for review |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-16 | Initial cost-agent skill definition |
