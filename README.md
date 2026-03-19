# Sulis AI Standards

A Claude Code plugin marketplace for requirements analysis and facilitation tools.

## What's Here

This repo is a [Claude Code custom marketplace](https://docs.anthropic.com/en/docs/claude-code). It contains:

- **SRD Plugin** — a requirements analyst that facilitates building Software Requirements Documents through guided one-question-at-a-time conversation. Produces UML artifacts (use cases, sequences, process flows, state diagrams, data flows) in Mermaid.
- **Engineering reference standards** — principles for test-first development, reuse-first design, security, cognitive load, coaching, critical thinking, and content quality. Used as reference material by the SRD plugin.

## Quick Start

### Install from marketplace

```bash
# Add the marketplace to your Claude Code settings
# In settings.json:
{
  "extraKnownMarketplaces": ["sulis-ai/standards"]
}

# Then install the plugin
/plugin install srd@sulis-ai-standards
```

### Install from local clone

```bash
git clone https://github.com/sulis-ai/standards.git
claude --plugin-dir ./standards/plugins/srd
```

### Start a facilitation session

```bash
claude --agent srd:requirements-analyst --dangerously-skip-permissions
```

## Why This Exists

> "You have productivity on tap, what you need to have are very good plans so that
> these agents are highly utilized and stay busy. So being a company that can plan
> well and know what you want to do is actually going to become more important, not
> less important."
>
> — Gustav Söderström, Spotify Co-CEO, Q4 2025 Earnings Call (Feb 10, 2026)

Spotify's best developers haven't written a line of code since December 2025. They
generate and supervise. The same pattern is playing out across every team with access
to AI-assisted execution: building gets faster, but knowing *what* to build stays hard.

A spec-driven development movement has emerged to address this — tools like GitHub's
Spec Kit, BMAD, OpenSpec, and GSD help teams write structured specifications and
orchestrate AI coding agents. These tools are good at what they do. They solve a real
problem.

They also assume you already know what to build.

SRD sits upstream. It facilitates the analysis that produces the specification — the
part where you figure out what the system actually needs to do, who uses it, what
happens when things go wrong, and where the requirements are thin. The output is a
complete Software Requirements Document that a development team (or a spec-driven
tool) can build from without making undocumented assumptions.

## SRD Plugin

The SRD (Software Requirements Document) plugin sits upstream of spec-driven development tools like GitHub Spec Kit, BMAD, GSD, and OpenSpec. It facilitates the analysis that produces the specification — the part where you figure out what the system actually needs to do.

### Available commands

| Command | What It Does |
|---------|-------------|
| `claude --agent srd:requirements-analyst` | Start a facilitation session |
| `/srd:codebase-mapping` | Map the current codebase to `CODEBASE_INDEX.json` |
| `/srd:tree-synthesis` | Synthesise `PRIMITIVE_TREE.jsonld` from codebase or description |
| `/srd:requirements-validation` | Run five-perspective completeness check |
| `/srd:spec-index` | Regenerate `INDEX.md` from all `SPEC.yaml` files |
| `/srd:critical-thinking` | Apply the critical thinking standard to the current task |

See [`plugins/srd/README.md`](plugins/srd/README.md) for full documentation.

## Repo Structure

```
standards/
├── marketplace.json           # Marketplace registry
├── docs/                      # Marketplace-level documentation
├── plugins/
│   └── srd/                   # Requirements Analyst plugin
│       ├── agents/            # Agent definitions
│       ├── skills/            # Slash-command skills
│       ├── references/        # Engineering & quality standards
│       └── docs/              # Plugin development specs
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add skills, add plugins, and the release process.

## License

MIT License. See [LICENSE](LICENSE) for full text.
