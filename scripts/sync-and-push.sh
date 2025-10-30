#!/usr/bin/env bash
set -euo pipefail

# sync-and-push.sh
# Full flow: update upstream tracking branch, rebase target branch, push to origin.
# Usage: ./scripts/sync-and-push.sh [branch]
# Example: ./scripts/sync-and-push.sh main

TARGET_BRANCH="${1:-main}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📦 Syncing upstream main..."
"$SCRIPT_DIR"/update-upstream.sh

echo "🌀 Rebasing $TARGET_BRANCH onto upstream-main..."
"$SCRIPT_DIR"/rebase-on-upstream.sh "$TARGET_BRANCH"

echo "🚀 Pushing $TARGET_BRANCH to origin (fast-forward only)..."
# Use --force-with-lease only if non-fast-forward; here we attempt normal push first
set +e
PUSH_OUTPUT=$(git push origin "$TARGET_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -ne 0 ]]; then
  echo "$PUSH_OUTPUT"
  echo "⚠️  Normal push failed (possibly non-fast-forward). If history rewrite intended, run: git push --force-with-lease origin $TARGET_BRANCH"
  exit $PUSH_STATUS
fi

echo "✅ Branch $TARGET_BRANCH synchronized and pushed."