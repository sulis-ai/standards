# SRD Plugin Hooks

Experimental hook scripts for background codebase mapping and tree synthesis.

## How It Works

By default, the requirements-analyst agent runs codebase mapping and tree synthesis
**synchronously** — it maps the codebase before asking its first question. This is
reliable but adds 10-30 seconds before the conversation starts.

These hooks provide an **alternative background approach**: when the agent starts, a
hook fires that spawns a headless Claude process to do the mapping in the background.
The main conversation starts immediately, and the agent picks up the results when they
become available.

## Setup

Add this to your `.claude/settings.local.json` (project-level, not committed):

```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "srd:requirements-analyst",
        "hooks": [
          {
            "type": "command",
            "command": "./plugins/srd/.claude-plugin/hooks/codebase-mapping.sh",
            "async": true,
            "timeout": 120
          }
        ]
      }
    ]
  }
}
```

**Note:** The `SubagentStart` event and `async` flag need verification in your Claude
Code version. If either is unavailable, fall back to the synchronous approach (which
is the default and requires no configuration).

## Scripts

### `codebase-mapping.sh`

- Checks for a meaningful codebase (package manifests, source files)
- Performs staleness check against existing CODEBASE_INDEX.json
- Runs headless Claude (`claude -p`) to map the codebase
- Uses Sonnet for speed, capped at 15 turns and $0.50
- Greenfield projects are detected and skipped silently

### `tree-synthesis.sh`

- Runs after codebase mapping produces CODEBASE_INDEX.json
- Synthesises PRIMITIVE_TREE.jsonld from the index (brownfield only)
- Greenfield tree synthesis happens in-conversation, not via hook
- Uses Sonnet for speed, capped at 10 turns and $0.50

## Interaction with Synchronous Approach

If the hook runs successfully, the agent's synchronous step will detect the existing
CODEBASE_INDEX.json via the staleness check and skip rescanning. Both approaches can
coexist — the hook is an optimisation, not a replacement.

If the hook fails silently (which it will on greenfield projects or if `claude` is not
on PATH), the synchronous approach handles everything.
