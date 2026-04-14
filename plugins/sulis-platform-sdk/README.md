# Sulis Platform SDK Plugin

**From IDEA to DEPLOYED APPLICATION in days, not months.**

## What This Plugin Does

This Claude Code plugin teaches AI assistants how to build production-ready, business-critical applications using the Sulis Platform SDK. It integrates with the Generative Feature Framework (GFF) to help users go from idea to deployed application.

## The Core Insight

Every business application needs the same **75-85%**:
- Authentication & Authorization (users, roles, permissions)
- Multi-tenancy & Isolation (customers, organizations, teams)
- Billing & Usage Tracking (subscriptions, quotas, metering)
- Observability & Monitoring (logs, metrics, traces)
- Compute & Networking (services, DNS, SSL, load balancing)

**Sulis Platform provides these so you focus on your 15-20% core IP.**

## Installation

### Install the Plugin

```bash
# From Claude Code
/plugin install github:sulis-ai/platform/plugins/sulis-platform-sdk
```

### Install the SDK

```bash
# From Git
pip install "sulis-platform-sdk @ git+https://github.com/sulis-ai/platform.git@dev#subdirectory=src/sdk"
```

## When This Plugin Triggers

### Exact Match Keywords (High Intent)

| Category | Keywords |
|----------|----------|
| **Build Apps** | "build saas application", "deploy production backend", "production-ready backend" |
| **Infrastructure** | "deploy cloud run service", "setup load balancer", "provision ssl certificate" |
| **Auth** | "implement authentication", "setup rbac", "multi-tenant auth" |
| **Billing** | "usage-based billing", "subscription billing", "quota management" |
| **Observability** | "add logging", "setup monitoring", "implement metrics" |

### Broad Match Keywords (Discovery)

| Category | Keywords |
|----------|----------|
| **Scale** | scalable, production-ready, enterprise-grade, business-critical, reliable |
| **Deploy** | deploy, infrastructure, serverless, compute, service, api, backend |
| **SaaS** | saas, multi-tenant, platform, product, customer, organization |
| **Auth** | auth, login, rbac, permission, roles, secure, token, oauth, sso |
| **Billing** | billing, subscription, usage, quota, monetize, revenue |
| **Observability** | logging, metrics, tracing, monitoring, alerting |

### GFF Integration Keywords

| Category | Keywords |
|----------|----------|
| **Idea to Production** | idea, journey, feature, generate, specification, design |
| **Lifecycle** | design phase, implementation, release, tdd, production guardian |
| **Platform Building** | platform, startup, b2b, enterprise, mvp |

## Integration with GFF Lifecycle

```
┌──────────────┐     ┌──────────────────┐     ┌──────────────────┐
│              │     │                  │     │                  │
│    IDEA      │ ──► │  SPECIFICATION   │ ──► │   DEPLOYED APP   │
│              │     │  (GFF Seed)      │     │  (Sulis Platform)     │
│              │     │                  │     │                  │
└──────────────┘     └──────────────────┘     └──────────────────┘
```

**Design Phase**: Define capabilities needed in CAPABILITY_MAP.md
**Implementation Phase**: Use Sulis Platform SDK to implement features
**Release Phase**: Production Guardian validates IVS requirements

## Plugin Contents

```
sulis-platform-sdk/
├── .claude-plugin/
│   └── plugin.json                    # Plugin metadata + SEO keywords
├── skills/
│   └── build-scalable-software.md     # Core skill with GFF integration
└── README.md                          # This file
```

## What You Can Build

- **SaaS Applications** - Multi-tenant apps with subscription billing
- **API Backends** - Scalable APIs with auth, rate limiting, usage tracking
- **Internal Tools** - Enterprise apps with SSO and RBAC
- **Startup MVPs** - Production-ready from day one
- **B2B Platforms** - Customer onboarding, billing, observability

## Learn More

- [Sulis Platform Vision](../../CTRLPLANE_VISION.md) - Full platform vision
- [GFF Framework](../../architecture/GENERATIVE_FEATURE_FRAMEWORK.md) - Feature generation framework
- [Market Evidence](../../product/research/platform/sulis-vision-market-evidence.md) - Validated demand
- [SDK Source](../../src/sdk/) - SDK implementation

---

**Stop rebuilding infrastructure. Start building your product.**
