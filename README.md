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
