#!/bin/bash
set -e

# Bitrise supports 3 triggers: push, PR, and tag
# push and tag require write access to the repo.
# If a user has write access, they are trusted.
#
# PR may come from untrusted forks. We don't want to run PRs from forks
#
# BITRISEIO_PULL_REQUEST_REPOSITORY_URL contains the PR source repo URL
# If the PR originates from git@github.com:instructure/ios.git then it's trusted.
# If the PR is from somewhere else, then automatically fail the build.

if [[ -z "$BITRISEIO_PULL_REQUEST_REPOSITORY_URL" ]]; then
    echo "Not a pull request"
else
  if [[ "$BITRISEIO_PULL_REQUEST_REPOSITORY_URL" = git@github.com:instructure/* ]]; then
    echo "Trusted pull request from $BITRISEIO_PULL_REQUEST_REPOSITORY_URL"
  else
    echo "Untrusted pull request from $BITRISEIO_PULL_REQUEST_REPOSITORY_URL. Aborting"
    exit 1
  fi
fi
