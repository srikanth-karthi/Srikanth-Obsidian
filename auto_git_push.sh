#!/bin/bash

# Variables
REPO_DIR="/Users/srikanth/Documents/srikanth-osbidian"
COMMIT_MESSAGE="daily commit on $(date '+%Y-%m-%d %H:%M:%S')"

# Navigate to the repository
cd "$REPO_DIR" || { echo "Error: Cannot access $REPO_DIR"; exit 1; }

# Check if there are any changes
if [[ -n $(git status --porcelain) ]]; then
    echo "Changes detected. Starting git operations..."

    # Git operations
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin main  # Replace 'main' with your branch name if different

    echo "Successfully pushed changes on $(date)"
else
    echo "No changes to commit. Exiting at $(date)."
fi
