#!/usr/bin/env bash
# Sports Car Build Library — security authorizations menu.
#
# Run this after the agents have read README.md and before Phase 1:
#   bash scripts/authorize.sh
#
# It asks the owner to approve or deny each security-sensitive action
# the build might need, then records the decisions in
# authorizations.md at the repo root. Anything not listed there is
# denied by default. Re-run it any time to change a decision.
#
# Uses `gum` (ships with Omarchy) when available; otherwise a plain
# y/N prompt. No network access, no writes outside this repo.

set -euo pipefail
cd "$(dirname "$0")/.."
AUTH_FILE="authorizations.md"

ITEMS=(
  "Write and edit files inside this repo folder (the build itself — needed, say Yes)"
  "Read files outside this folder (for example the TealsUnltd tech library and the RX-7 13BT repo, to seed the founder entry)"
  "Run a local preview server on this machine only (python3 -m http.server, localhost)"
  "Fetch anything from the internet during the build"
  "Install new packages or tools (pacman / npm)"
  "Push anything to GitHub"
  "Publish the site (enable GitHub Pages, buy or point a domain)"
  "Touch the TealsUnltd repo, the Big Cartel store, or tealsunltd.com"
  "Use or access secrets (API keys, tokens, passwords)"
)
DECISIONS=()

ask() {
  local prompt="$1"
  local answer="no"
  if command -v gum >/dev/null 2>&1; then
    if gum confirm "$prompt"; then
      answer="yes"
    else
      answer="no"
    fi
  else
    local reply=""
    printf '%s [y/N] ' "$prompt"
    IFS= read -r reply || true
    case "$reply" in
      y|Y|yes|YES) answer="yes" ;;
      *) answer="no" ;;
    esac
  fi
  DECISIONS+=("$answer")
}

echo "Sports Car Build Library — security authorizations"
echo "Answer each item. Anything you do not approve stays off."
echo

i=1
for item in "${ITEMS[@]}"; do
  ask "$i. $item"
  i=$((i + 1))
done

{
  echo "# Security authorizations — Sports Car Build Library"
  echo
  echo "Decided by the owner on $(date '+%Y-%m-%d %H:%M %Z')."
  echo "Recorded by scripts/authorize.sh. Re-run that script to change"
  echo "a decision. Anything not listed here is denied by default."
  echo
  echo "| # | Action | Decision |"
  echo "|---|---|---|"
  i=1
  for item in "${ITEMS[@]}"; do
    echo "| $i | $item | ${DECISIONS[$((i - 1))]} |"
    i=$((i + 1))
  done
  echo
  echo "Rules the agents always follow, whatever is decided above:"
  echo "- Never print, log, or store a password, token, or API key."
  echo "- Never commit or push unless item 6 says yes."
  echo "- Never publish unless item 7 says yes."
} > "$AUTH_FILE"

echo
echo "Saved to $AUTH_FILE:"
grep -E '^\| [0-9]' "$AUTH_FILE"
echo
echo "The build may proceed only within these decisions."
