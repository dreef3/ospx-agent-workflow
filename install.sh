#!/usr/bin/env bash
# Install ospx-agent-workflow into a target project.
#
# Usage:
#   ./install.sh [TARGET_DIR]
#
# If TARGET_DIR is omitted, installs into the current working directory.
# The script is idempotent: running it again is safe.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$(pwd)}"

# Resolve to absolute path
TARGET="$(cd "$TARGET" && pwd)"

if [[ "$TARGET" == "$SCRIPT_DIR" ]]; then
  echo "error: TARGET_DIR cannot be the repo itself." >&2
  exit 1
fi

echo "Installing ospx-agent-workflow into: $TARGET"

# ── 1. openspec CLI ──────────────────────────────────────────────────────────

install_openspec() {
  if command -v openspec &>/dev/null; then
    echo "✓ openspec $(openspec --version) already installed"
    return
  fi

  echo "Installing openspec CLI..."

  if command -v bun &>/dev/null; then
    bun add -g @fission-ai/openspec@latest
  elif command -v npm &>/dev/null; then
    npm install -g @fission-ai/openspec@latest
  elif command -v pnpm &>/dev/null; then
    pnpm add -g @fission-ai/openspec@latest
  elif command -v yarn &>/dev/null; then
    yarn global add @fission-ai/openspec@latest
  else
    echo "error: no package manager found (bun, npm, pnpm, or yarn required)" >&2
    exit 1
  fi

  echo "✓ openspec $(openspec --version) installed"
}

install_openspec

# Ensure the just-installed openspec binary is on PATH
for dir in "$HOME/.bun/bin" "$HOME/.npm/bin" "$HOME/.local/bin" \
            "$HOME/.yarn/bin" "$(npm bin -g 2>/dev/null)"; do
  [[ -d "$dir" ]] && export PATH="$dir:$PATH"
done

# ── 2. OpenSpec project init (skills + changes/specs dirs) ───────────────────

echo "Running openspec init --tools claude,github-copilot,opencode --force ..."
cd "$TARGET"
openspec init --tools claude,github-copilot,opencode --force
echo "✓ OpenSpec initialised"

# Remove generated commands (skills are the delivery mechanism, not slash commands)
rm -rf .claude/commands .github/prompts .opencode/commands
echo "✓ Generated commands removed (using skills instead)"

# ── 3. Custom schema ─────────────────────────────────────────────────────────

echo "Copying ospx-best-practices schema..."
mkdir -p "$TARGET/openspec/schemas"
cp -r "$SCRIPT_DIR/openspec/schemas/ospx-best-practices" \
       "$TARGET/openspec/schemas/ospx-best-practices"
echo "✓ Schema installed"

# ── 4. Custom skills (canonical source) ─────────────────────────────────────

echo "Copying canonical skills..."
mkdir -p "$TARGET/openspec/skills"
cp "$SCRIPT_DIR/openspec/skills/"*.md "$TARGET/openspec/skills/"
echo "✓ Skills copied to openspec/skills/"

# ── 5. Per-tool skill directories (symlinks) ─────────────────────────────────

echo "Wiring skills into tool directories..."

for skill in tdd plan review debug security ship; do
  for tool_dir in .claude .github .opencode; do
    dest="$TARGET/$tool_dir/skills/ospx-${skill}"
    mkdir -p "$dest"
    # Relative path from $tool_dir/skills/ospx-$skill/ back to repo root = ../../../
    ln -sf "../../../openspec/skills/${skill}.md" "$dest/SKILL.md"
  done
done

echo "✓ ospx-* skills linked in .claude, .github, .opencode"

# ── 6. openspec/config.yaml (set schema to ospx-best-practices) ──────────────

CONFIG="$TARGET/openspec/config.yaml"
if grep -q "ospx-best-practices" "$CONFIG" 2>/dev/null; then
  echo "✓ config.yaml already uses ospx-best-practices"
else
  echo "Updating openspec/config.yaml..."
  cp "$SCRIPT_DIR/openspec/config.yaml" "$CONFIG"
  echo "✓ config.yaml updated"
fi

# ── 7. AGENTS.md ─────────────────────────────────────────────────────────────

echo "Installing AGENTS.md..."
cp "$SCRIPT_DIR/AGENTS.md" "$TARGET/AGENTS.md"
echo "✓ AGENTS.md installed"

# ── 8. CLAUDE.md → symlink to AGENTS.md ─────────────────────────────────────

CLAUDE_MD="$TARGET/CLAUDE.md"
if [[ -L "$CLAUDE_MD" && "$(readlink "$CLAUDE_MD")" == "AGENTS.md" ]]; then
  echo "✓ CLAUDE.md already symlinked to AGENTS.md"
else
  rm -f "$CLAUDE_MD"
  ln -s AGENTS.md "$CLAUDE_MD"
  echo "✓ CLAUDE.md → AGENTS.md"
fi

# ── 9. opencode.json ─────────────────────────────────────────────────────────

OPENCODE_JSON="$TARGET/opencode.json"
if [[ ! -f "$OPENCODE_JSON" ]]; then
  cp "$SCRIPT_DIR/opencode.json" "$OPENCODE_JSON"
  echo "✓ opencode.json created"
else
  echo "✓ opencode.json already exists (not overwritten)"
fi

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "Installation complete."
echo ""
echo "Skills installed:"
echo "  OpenSpec: openspec-propose, openspec-explore, openspec-apply-change,"
echo "            openspec-archive-change, openspec-sync-specs"
echo "  Custom:   ospx-tdd, ospx-plan, ospx-review, ospx-debug,"
echo "            ospx-security, ospx-ship"
echo ""
echo "Next steps:"
echo "  Restart your IDE / agent for skills to take effect."
echo "  Start a change: tell your agent 'propose a change' or use openspec-propose."
