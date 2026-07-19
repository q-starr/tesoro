#!/usr/bin/env bash
# Tesoro — deploy to tesoro.q-starr.app
# Mirrors the Torre flow: git + GitHub (q-starr) + Vercel.
# Requires: gh (authed), vercel (authed). Run from the tesoro/ folder.
set -euo pipefail

PROJECT="tesoro"
ORG="q-starr"
DOMAIN="tesoro.q-starr.app"

echo "── Tesoro deploy → https://${DOMAIN}"

command -v gh >/dev/null || { echo "✗ gh CLI not found — install/auth it, or drag the folder into vercel.com/new"; exit 1; }
command -v vercel >/dev/null || { echo "✗ vercel CLI not found — npm i -g vercel && vercel login"; exit 1; }

# 1 · git + GitHub
if [ ! -d .git ]; then
  git init -q && git add -A && git commit -qm "Tesoro: AI treasury demo"
  echo "✓ git repo initialized"
fi
if ! gh repo view "${ORG}/${PROJECT}" >/dev/null 2>&1; then
  gh repo create "${ORG}/${PROJECT}" --public --source=. --remote=origin --push
  echo "✓ created + pushed github.com/${ORG}/${PROJECT}"
else
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/${ORG}/${PROJECT}.git"
  git add -A && git diff --cached --quiet || git commit -qm "Update Tesoro demo"
  git push -u origin HEAD
  echo "✓ pushed to github.com/${ORG}/${PROJECT}"
fi

# 2 · Vercel (static: serves root-level index.html; .vercelignore trims the rest)
vercel deploy --prod --yes --name "${PROJECT}" .
echo "✓ deployed to Vercel project '${PROJECT}'"

# 3 · Domain
if vercel domains add "${DOMAIN}" "${PROJECT}" >/dev/null 2>&1; then
  echo "✓ ${DOMAIN} attached to project"
else
  echo "• attach the domain in Vercel → project '${PROJECT}' → Settings → Domains → ${DOMAIN}"
fi

echo "── Done: https://${DOMAIN}"
