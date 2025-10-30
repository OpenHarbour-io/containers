#!/usr/bin/env bash
set -euo pipefail

# update-upstream.sh
# Fetch latest upstream Bitnami containers main branch and hard reset local tracking branch `upstream-main`.
# Idempotent: safe to run multiple times.
# Usage: ./scripts/update-upstream.sh

REMOTE_NAME="upstream"
REMOTE_URL="https://github.com/bitnami/containers.git"
TRACKING_BRANCH="upstream-main"
SOURCE_REF="upstream/main"

# Ensure upstream remote exists
if ! git remote get-url "$REMOTE_NAME" >/dev/null 2>&1; then
  echo "🔗 Adding remote $REMOTE_NAME -> $REMOTE_URL"
  git remote add "$REMOTE_NAME" "$REMOTE_URL"
fi

# Fetch latest commits
echo "⬇️  Fetching latest from $REMOTE_NAME..."
git fetch --prune "$REMOTE_NAME"

# Create or update tracking branch
if git show-ref --verify --quiet refs/heads/"$TRACKING_BRANCH"; then
  echo "🔄 Updating existing branch $TRACKING_BRANCH to $SOURCE_REF"
  git checkout "$TRACKING_BRANCH"
else
  echo "🌱 Creating tracking branch $TRACKING_BRANCH from $SOURCE_REF"
  git checkout -b "$TRACKING_BRANCH" "$SOURCE_REF"
fi

# Hard reset to ensure exact match
git reset --hard "$SOURCE_REF"

echo "✅ $TRACKING_BRANCH now at $(git rev-parse --short HEAD) from $SOURCE_REF"