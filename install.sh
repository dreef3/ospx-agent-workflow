#!/usr/bin/env bash
# User-level install of the ospx engineering workflow.
# Run once per machine — no per-repo steps needed (except setup-repo.sh).
#
# Usage:
#   ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CLAUDE_SKILLS="$HOME/.claude/skills"
OPENCODE_SKILLS="$HOME/.opencode/skills"
GITHUB_SKILLS="$HOME/.github/skills"
SCHEMA_DIR="$HOME/.local/share/openspec/schemas"

echo "Installing ospx-agent-workflow (user level)"
echo ""

# ── 1. openspec CLI ──────────────────────────────────────────────────────────

install_openspec() {
  if command -v openspec &>/dev/null; then
    echo "✓ openspec $(openspec --version)"
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

  for dir in "$HOME/.bun/bin" "$HOME/.npm/bin" "$HOME/.local/bin" "$HOME/.yarn/bin"; do
    [[ -d "$dir" ]] && export PATH="$dir:$PATH"
  done

  echo "✓ openspec $(openspec --version)"
}

install_openspec

# ── 2. Schema ────────────────────────────────────────────────────────────────

echo "Installing ospx-best-practices schema..."
mkdir -p "$SCHEMA_DIR"
cp -r "$SCRIPT_DIR/openspec/schemas/ospx-best-practices" \
       "$SCHEMA_DIR/ospx-best-practices"
echo "✓ Schema → $SCHEMA_DIR/ospx-best-practices"

# ── 3. Skills ────────────────────────────────────────────────────────────────
# Source layout in this repo:
#   openspec/skills/ospx-*.md           — custom ospx skills (canonical)
#   .claude/skills/openspec-*/SKILL.md  — openspec opsx skills (pre-generated)

install_skills() {
  local dest="$1"
  local label="$2"
  mkdir -p "$dest"

  # OpenSpec opsx skills (pre-generated, copied verbatim)
  for src_dir in "$SCRIPT_DIR/.claude/skills/openspec-"*/; do
    name="$(basename "$src_dir")"
    mkdir -p "$dest/$name"
    cp "$src_dir/SKILL.md" "$dest/$name/SKILL.md"
  done

  # openspec-* custom skills (openspec-tdd, openspec-plan, etc.)
  for src in "$SCRIPT_DIR/openspec/skills/"*.md; do
    skill="$(basename "$src" .md)"
    mkdir -p "$dest/openspec-${skill}"
    cp "$src" "$dest/openspec-${skill}/SKILL.md"
  done

  echo "✓ Skills → $label"
}

install_skills "$CLAUDE_SKILLS"   "~/.claude/skills/"
install_skills "$OPENCODE_SKILLS" "~/.opencode/skills/"
install_skills "$GITHUB_SKILLS"   "~/.github/skills/"

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "User-level installation complete."
echo ""
echo "Skills available in any project:"
echo "  openspec-propose, openspec-explore, openspec-apply-change,"
echo "  openspec-archive-change, openspec-sync-specs"
echo "  openspec-tdd, openspec-review, openspec-debug,"
echo "  openspec-security, openspec-ship"
echo ""
echo "Next: run setup-repo.sh in each project to add AGENTS.md and openspec config."
