#!/usr/bin/env bash
# Per-repo setup: AGENTS.md + openspec/config.yaml.
# Run this in each project after install.sh has been run globally.
#
# Usage:
#   ./setup-repo.sh [TARGET_DIR]   (default: current directory)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$(pwd)}"
TARGET="$(cd "$TARGET" && pwd)"

if [[ "$TARGET" == "$SCRIPT_DIR" ]]; then
  echo "error: TARGET_DIR cannot be the repo itself." >&2
  exit 1
fi

echo "Setting up ospx workflow in: $TARGET"

# ── AGENTS.md ────────────────────────────────────────────────────────────────

AGENTS="$TARGET/AGENTS.md"
if [[ -f "$AGENTS" ]]; then
  echo "  AGENTS.md exists — appending ospx skill discovery section..."
  # Only append if the skill discovery block isn't already there
  if ! grep -q "openspec-propose" "$AGENTS" 2>/dev/null; then
    cat >> "$AGENTS" << 'EOF'

---

## Skill Discovery

```
Task arrives
    │
    ├── Exploring an idea or problem?              → openspec-explore
    ├── Ready to create a change with artifacts?   → openspec-propose
    ├── Implementing tasks from a change?          → openspec-apply-change
    ├── Done implementing, ready to archive?       → openspec-archive-change
    ├── Have a spec, need tasks / test plan?       → openspec-plan
    ├── Implementing code?                         → openspec-tdd
    │   ├── Something broke?                      → openspec-debug
    │   └── Stakes high / unfamiliar?             → list assumptions, then openspec-tdd
    ├── Code ready to merge?                       → openspec-review
    │   ├── Too complex?                          → simplify first
    │   └── Security concerns?                    → openspec-security
    └── Ready to commit/merge?                     → openspec-ship
```

Skills are installed globally. Schema: openspec/schemas/ospx-best-practices
EOF
    echo "  ✓ Skill discovery section appended to AGENTS.md"
  else
    echo "  ✓ AGENTS.md already has skill discovery section"
  fi
else
  cp "$SCRIPT_DIR/AGENTS.md" "$AGENTS"
  echo "  ✓ AGENTS.md created"
fi

# ── CLAUDE.md → AGENTS.md symlink ────────────────────────────────────────────

CLAUDE_MD="$TARGET/CLAUDE.md"
if [[ -L "$CLAUDE_MD" && "$(readlink "$CLAUDE_MD")" == "AGENTS.md" ]]; then
  echo "  ✓ CLAUDE.md already symlinked to AGENTS.md"
else
  rm -f "$CLAUDE_MD"
  ln -s AGENTS.md "$CLAUDE_MD"
  echo "  ✓ CLAUDE.md → AGENTS.md"
fi

# ── openspec/config.yaml ─────────────────────────────────────────────────────

mkdir -p "$TARGET/openspec"
CONFIG="$TARGET/openspec/config.yaml"
if grep -q "ospx-best-practices" "$CONFIG" 2>/dev/null; then
  echo "  ✓ openspec/config.yaml already uses ospx-best-practices"
else
  cat > "$CONFIG" << 'EOF'
schema: ospx-best-practices

context: |
  Engineering workflow: ospx-best-practices schema.
  TDD required. Five-axis review before merge. STRIDE threat model in design.
  Skills: openspec-propose, openspec-explore, openspec-apply-change,
  openspec-archive-change, openspec-sync-specs,
  openspec-tdd, openspec-review,
  openspec-debug, openspec-security, openspec-ship.
EOF
  echo "  ✓ openspec/config.yaml created (schema: ospx-best-practices)"
fi

echo ""
echo "Done. Project is ready."
echo "  Skill discovery tree is in AGENTS.md."
echo "  CLAUDE.md → AGENTS.md"
echo "  openspec/config.yaml uses ospx-best-practices schema."
