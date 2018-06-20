#!/bin/bash
# This Bash Script has/does One Job: Return the GitHub Issue Number of the Active Branch.
# [ $TRAVIS_PULL_REQUEST_BRANCH ] && B=$TRAVIS_PULL_REQUEST_BRANCH || B=$(git rev-parse --abbrev-ref HEAD)
CWD="$PWD/bin"
B=$(sh $CWD/branch.sh)
# echo "B $B"
# echo "IFS $IFS"
IFS=# read BRANCH ISSUE <<< "$B";
# echo "issue >> $ISSUE";
# echo "name >> $BRANCH";
ISSUE=$(($ISSUE + 0)) # typecast to int
if [ $B == "master" ]; then
  echo "hello-world-node"
elif [ $ISSUE > 0 ]; then
  echo $ISSUE
fi
