#!/usr/bin/env sh

# This script is used to commit changes to a git repository.
git add .
git commit -m "smth $(date)"
git push
