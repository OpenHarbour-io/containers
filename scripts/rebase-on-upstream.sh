#!/usr/bin/env bash
set -euo pipefail

# rebase-on-upstream.sh
# Rebase a local branch (default: main) onto latest upstream-main tracking branch.
# Usage: ./scripts/rebase-on-upstream.sh [branch]
# Example: ./scripts/rebase-on-upstream.sh feature/my-work

TARGET_BRANCH="${1:-main}"
TRACKING_BRANCH="upstream-main"
REMOTE_NAME="upstream"

# Ensure tracking branch is current
if ! git show-ref --verify --quiet refs/heads/"$TRACKING_BRANCH"; then
  echo "❌ Tracking branch $TRACKING_BRANCH missing. Run ./scripts/update-upstream.sh first." >&2
  exit 1
fi

# Fetch remote just in case it advanced
echo "⬇️  Refreshing $REMOTE_NAME refs..."
git fetch --prune "$REMOTE_NAME"

echo "📦 Checking out target branch: $TARGET_BRANCH"
git checkout "$TARGET_BRANCH"

# Rebase
echo "🌀 Rebasing $TARGET_BRANCH onto $TRACKING_BRANCH (fast-forwarding history)"
set +e
REBASING_OUTPUT=$(git rebase "$TRACKING_BRANCH" 2>&1)
REBASING_STATUS=$?
set -e

if [ $REBASING_STATUS -ne 0 ]; then
  echo "$REBASING_OUTPUT"
  echo "⚠️  Rebase encountered conflicts. Resolve them, then run: git rebase --continue"
  echo "    Or to abort: git rebase --abort"
  exit $REBASING_STATUS
fi

echo "✅ Rebase complete. Review and test before pushing: git push origin $TARGET_BRANCH"