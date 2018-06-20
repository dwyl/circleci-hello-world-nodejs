#!/bin/bash
# This Bash Script has/does One Job: Return the name of the active Git branch.
# echo "BRANCH $(git rev-parse --abbrev-ref HEAD)"
[ $TRAVIS_PULL_REQUEST_BRANCH ] && B=$TRAVIS_PULL_REQUEST_BRANCH || B=$(git rev-parse --abbrev-ref HEAD)
echo $B