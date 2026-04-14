# Infrastructure Agent (infra-agent)

> **Purpose:** Generate deployment configuration from NFR.md requirements.
> **Operates:** Atomically, without human clarification.

---

## Responsibilities

1. Generate `sulis.yaml` manifest from NFR constraints
2. Create optimized `Dockerfile` for resource constraints
3. Configure auto-scaling based on SCALE-* requirements
4. Validate configuration against platform capabilities
5. Estimate deployment costs

---

## Inputs (Required)

| Artifact | Path | What to Extract |
|----------|------|-----------------|
| **NFR.md** | `features/{feature}/NFR.md` | All COMP-*, PERF-*, INFRA-*, COST-*, SCALE-* |
| **DESIGN.md** | `features/{feature}/DESIGN.md` | Component architecture, dependencies |
| **PLATFORM_CAPABILITIES** | `architecture/PLATFORM_CAPABILITIES.md` | Available resources, limits |
| **sulis.yaml** | `sulis.yaml` (if exists) | Current manifest to update |

---

## Outputs

| Output | Path | Description |
|--------|------|-------------|
| `sulis.yaml` | Project root | Updated/created deployment manifest |
| `Dockerfile` | Per artifact | Optimized container configuration |
| Cost estimate | NFR.md Section 5.3 | Filled cost estimation table |
| Capability report | stdout | Validation results |

---

## Decision Logic

### Workload Type Selection

```python
def select_workload_type(nfr: NFR) -> str:
    """
    Select appropriate workload type from NFR requirements.
    """
    # COMP-01 is explicit constraint
    if nfr.comp_01:
        return nfr.comp_01  # Use specified type

    # Infer from other requirements
    if nfr.scale_10_min_instances == 0 and nfr.perf_04_cold_start == "acceptable":
        return "service"  # Scale-to-zero friendly

    if nfr.infra_22_queue:
        return "worker_pool"  # Queue processing

    if nfr.perf_12_batch_rate:
        return "job"  # Batch processing

    return "service"  # Default
```

### Resource Sizing

```python
def size_resources(nfr: NFR) -> ResourceConfig:
    """
    Size container resources from NFR constraints.
    """
    # Start with target (hint), validate against max (constraint)
    cpu = nfr.comp_10_target or "0.5"
    memory = nfr.comp_11_target or "512Mi"

    # Validate against platform limits
    assert float(cpu) <= PLATFORM.max_vcpu
    assert parse_memory(memory) <= PLATFORM.max_memory

    return ResourceConfig(
        cpu=cpu,
        memory=memory,
        # Use min from NFR or default
        min_instances=nfr.scale_10_min_instances or 0,
        max_instances=nfr.scale_11_max_instances or 10,
    )
```

### Scaling Configuration

```python
def configure_scaling(nfr: NFR) -> ScalingConfig:
    """
    Configure auto-scaling from NFR requirements.
    """
    return ScalingConfig(
        min_instances=nfr.scale_10_min_instances,
        max_instances=nfr.scale_11_max_instances,
        target_concurrency=nfr.scale_12_trigger or 80,
        scale_to_zero=nfr.cost_10_scale_to_zero == "Required",
    )
```

---

## sulis.yaml Generation

### Template

```yaml
version: "1.0"

app:
  name: "{app_name}"
  account_id: "{account_id}"

project:
  type: "{project_type}"
  framework: "{framework}"
  description: "{description}"

artifacts:
  - name: "{artifact_name}"
    type: "{workload_type}"  # From COMP-01
    source: "{source_path}"
    dockerfile: "{dockerfile_path}"

    # From NFR COMP-* constraints
    compute:
      cpu: "{cpu}"           # From COMP-10 target
      memory: "{memory}"     # From COMP-11 target
      min_instances: {min}   # From SCALE-10
      max_instances: {max}   # From SCALE-11
      timeout: {timeout}     # From COMP-20

    # From NFR SCALE-* requirements
    scaling:
      target_concurrency: {concurrency}  # From SCALE-12
      scale_to_zero: {bool}              # From COST-10

    # From NFR INFRA-* requirements
    routes:
      - path: "{path}"

environments:
  development:
    platform_id: "{dev_platform}"
    domain: "{dev_domain}"
  production:
    platform_id: "{prod_platform}"
    domain: "{prod_domain}"

sdk:
  # From DESIGN.md dependencies
  identity:
    enabled: {bool}
  billing:
    enabled: {bool}

secrets:
  # From COMP-31
  - name: "{secret_name}"
    description: "{description}"
```

---

## Dockerfile Optimization

### Guidelines from NFR

| NFR Requirement | Dockerfile Impact |
|-----------------|-------------------|
| COMP-11 Memory max | Use slim/alpine base images |
| COMP-32 Runtime | Select appropriate base image |
| PERF-04 Cold start | Multi-stage builds, minimize layers |
| COST-10 Scale-to-zero | Optimize startup time |

### Template

```dockerfile
# Multi-stage build for smaller image (PERF-04, COST-10)
FROM python:3.11-slim as builder

WORKDIR /app

# Install dependencies first (cache layer)
COPY pyproject.toml uv.lock ./
RUN pip install uv && uv sync --frozen --no-dev

# Production image
FROM python:3.11-slim

WORKDIR /app

# Copy only what's needed
COPY --from=builder /app/.venv /app/.venv
COPY src/ ./src/

# Set environment
ENV PATH="/app/.venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

# Health check (from DESIGN.md)
HEALTHCHECK --interval=10s --timeout=5s \
  CMD curl -f http://localhost:8000/health || exit 1

# Resource hints for orchestrator
# CPU: {cpu} (from COMP-10)
# Memory: {memory} (from COMP-11)

EXPOSE 8000

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

---

## Cost Estimation

### Calculation

```python
def estimate_monthly_cost(nfr: NFR, pricing: Pricing) -> CostEstimate:
    """
    Estimate monthly cost from NFR requirements.
    """
    # Assumptions from SCALE-*
    requests_per_day = nfr.scale_02_requests_per_day
    peak_multiplier = nfr.scale_04_peak_multiplier or 1

    # Compute cost
    avg_instances = calculate_avg_instances(
        requests_per_day,
        nfr.perf_10_throughput,
        nfr.scale_10_min_instances
    )

    vcpu_hours = avg_instances * float(nfr.comp_10_target or 0.5) * 24 * 30
    gib_hours = avg_instances * parse_gib(nfr.comp_11_target or "512Mi") * 24 * 30

    compute_cost = (
        vcpu_hours * pricing.vcpu_hour +
        gib_hours * pricing.gib_hour
    )

    # Storage cost
    storage_cost = (
        parse_gib(nfr.infra_10_object_storage or "0") * pricing.gib_month +
        nfr.infra_11_document_count * pricing.document_cost
    )

    # Bandwidth cost (estimate 1KB per request)
    bandwidth_gib = (requests_per_day * 30 * 1024) / (1024 ** 3)
    bandwidth_cost = bandwidth_gib * pricing.egress_gib

    total = compute_cost + storage_cost + bandwidth_cost

    return CostEstimate(
        compute=compute_cost,
        storage=storage_cost,
        bandwidth=bandwidth_cost,
        total=total,
        budget=nfr.cost_01_budget,
        within_budget=total <= nfr.cost_01_budget
    )
```

---

## Validation Checks

Before generating output:

- [ ] All COMP-* constraints within platform limits
- [ ] Workload type available on platform
- [ ] No blocking capability gaps
- [ ] Cost estimate within budget (COST-01)
- [ ] Scaling config within platform quotas

---

## Escalation Triggers

| Condition | Action |
|-----------|--------|
| CPU/Memory exceeds platform max | Escalate with options (reduce, request elevation) |
| Cost estimate exceeds budget | Escalate with optimization recommendations |
| Required capability unavailable | Escalate with workaround or gap analysis |
| Conflicting requirements | Escalate for clarification |

---

## Example Execution

**Input NFR.md:**
```markdown
COMP-01: Workload type = service
COMP-10: CPU target = 0.5 vCPU, max = 2 vCPU
COMP-11: Memory target = 512Mi, max = 2Gi
COST-01: Budget = 500 credits/month
COST-10: Scale-to-zero = Required
SCALE-10: Min instances = 0
SCALE-11: Max instances = 10
```

**Output sulis.yaml:**
```yaml
artifacts:
  - name: "api"
    type: "service"
    compute:
      cpu: "0.5"
      memory: "512Mi"
      min_instances: 0
      max_instances: 10
    scaling:
      scale_to_zero: true
```

**Output Cost Estimate:**
```markdown
| Component | Estimated Monthly |
|-----------|-------------------|
| Compute   | 150 credits       |
| Storage   | 10 credits        |
| Bandwidth | 20 credits        |
| **Total** | **180 credits**   |
| vs Budget | Under by 320      |
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-16 | Initial infra-agent skill definition |
