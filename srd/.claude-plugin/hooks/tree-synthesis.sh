#!/bin/bash
# Hook script: Background tree synthesis via headless Claude
#
# Synthesises PRIMITIVE_TREE.jsonld from a CODEBASE_INDEX.json. If no index
# exists, automatically triggers codebase-mapping.sh first. If mapping also
# finds no codebase (genuinely greenfield), exits cleanly — the agent handles
# greenfield tree synthesis in-conversation from user input.
#
# Can be chained after codebase-mapping.sh, triggered separately, or invoked
# standalone. The main agent picks up PRIMITIVE_TREE.jsonld at the next
# reflection checkpoint.
#
# Usage (standalone, in .claude/settings.json or .claude/settings.local.json):
# This script is called by codebase-mapping.sh when mapping succeeds,
# or can be configured as a separate hook.

set -euo pipefail

# Read hook input from stdin (or accept CWD as $1 when called from codebase-mapping.sh)
if [ -n "${1:-}" ]; then
  CWD="$1"
else
  INPUT=$(cat)
  CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
fi

if [ -z "$CWD" ]; then
  exit 0
fi

cd "$CWD" || exit 0

# Find the specification folder with a CODEBASE_INDEX.json
SPEC_DIR=""
for dir in .specifications/*/; do
  if [ -f "${dir}CODEBASE_INDEX.json" ]; then
    SPEC_DIR="${dir%/}"
    break
  fi
done

if [ -z "$SPEC_DIR" ]; then
  # No codebase index yet — attempt codebase mapping first
  # Find any specification folder to use as the target
  SPEC_DIR_CANDIDATE=$(find .specifications -maxdepth 1 -mindepth 1 -type d 2>/dev/null | head -1)

  if [ -z "$SPEC_DIR_CANDIDATE" ]; then
    # No specification folder at all — nothing to do
    exit 0
  fi

  # Run codebase mapping, passing CWD via stdin as the hook expects
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  echo "{\"cwd\": \"$CWD\"}" | "$SCRIPT_DIR/codebase-mapping.sh"

  # Check if mapping produced an index
  if [ -f "$SPEC_DIR_CANDIDATE/CODEBASE_INDEX.json" ]; then
    SPEC_DIR="$SPEC_DIR_CANDIDATE"
  else
    # Mapping ran but produced no index — genuinely greenfield
    exit 0
  fi
fi

# Skip if tree already exists and is newer than the index
if [ -f "$SPEC_DIR/PRIMITIVE_TREE.jsonld" ] && \
   [ "$SPEC_DIR/PRIMITIVE_TREE.jsonld" -nt "$SPEC_DIR/CODEBASE_INDEX.json" ]; then
  exit 0
fi

# Run tree synthesis via headless Claude
claude -p "Synthesise a PRIMITIVE_TREE.jsonld from the codebase index at $SPEC_DIR/CODEBASE_INDEX.json. Read the index, identify the domain-specific architectural building blocks, and produce a directed acyclic graph with typed nodes (domain-entity, action, integration, data-store, state-machine, policy, event), dependency edges, health statuses (all start as 'untested'), attack patterns per node type, invalidation signals, and facilitation phase assignments. Write the output to $SPEC_DIR/PRIMITIVE_TREE.jsonld." \
  --model sonnet \
  --allowedTools "Bash,Read,Glob,Grep,Write" \
  --max-turns 10 \
  --max-budget-usd 0.50 \
  --output-format text \
  > /dev/null 2>&1

exit 0
