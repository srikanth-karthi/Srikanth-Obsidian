#!/bin/bash

# Variables
REPO_DIR="/Users/srikanth/Documents/srikanth-osbidian"
COMMIT_MESSAGE="daily commit on $(date '+%Y-%m-%d %H:%M:%S')"

# Navigate to the repository
cd "$REPO_DIR" || { echo "Error: Cannot access $REPO_DIR"; exit 1; }

# Check for changes
if [[ -n $(git status --porcelain) ]]; then
    echo "Changes detected. Stashing local changes..."

    # Stash any local unstaged changes
    git add .
    git stash push -m "Pre-pull stash on $(date '+%Y-%m-%d %H:%M:%S')"

    # Pull remote changes with rebase
    echo "Pulling latest changes..."
    git pull --rebase origin main || { echo "Error: Failed to pull changes"; exit 1; }

    # Apply stashed changes
    echo "Applying stashed changes..."
    git stash pop || { echo "Error: Failed to apply stashed changes"; exit 1; }

    # Commit and push
    echo "Committing and pushing changes..."
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin main || { echo "Error: Failed to push changes"; exit 1; }

    echo "Successfully pulled, committed, and pushed changes on $(date)"
else
    echo "No changes to commit. Pulling latest changes..."
    git pull --rebase origin main || { echo "Error: Failed to pull changes"; exit 1; }
    echo "Repository is up-to-date. Exiting at $(date)."
fi
