#!/usr/bin/env bash
set -euo pipefail

# update-upstream.sh
# Update local tracking branch `upstream-main` to match `upstream/main` WITHOUT checking it out.
# Usage: ./scripts/update-upstream.sh

REMOTE_NAME="upstream"
REMOTE_URL="https://github.com/bitnami/containers.git"
TRACKING_BRANCH="upstream-main"
REMOTE_BRANCH="upstream/main"

# Ensure upstream remote exists
if ! git remote get-url "$REMOTE_NAME" >/dev/null 2>&1; then
	echo "🔗 Adding remote $REMOTE_NAME -> $REMOTE_URL"
	git remote add "$REMOTE_NAME" "$REMOTE_URL"
fi

echo "⬇️  Fetching latest from $REMOTE_NAME..."
git fetch --prune "$REMOTE_NAME"

# Update the local tracking branch reference without checking it out
if git show-ref --verify --quiet "refs/heads/$TRACKING_BRANCH"; then
	echo "🔄 Updating existing branch $TRACKING_BRANCH to $REMOTE_BRANCH"
	git update-ref "refs/heads/$TRACKING_BRANCH" "refs/remotes/$REMOTE_BRANCH"
else
	echo "✨ Creating $TRACKING_BRANCH from $REMOTE_BRANCH"
	git branch "$TRACKING_BRANCH" "$REMOTE_BRANCH"
fi

echo "✅ $TRACKING_BRANCH now at $(git rev-parse --short $TRACKING_BRANCH) from $REMOTE_BRANCH"
