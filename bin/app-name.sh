#!/bin/bash
# This Bash Script has/does One Job: Return the Git Branch Name minus the Issue Number of the Active Branch.
CWD="$PWD/bin"
B=$(sh $CWD/branch.sh)
# echo "B => $B"
# echo "IFS => $IFS"
# remove any # (hash symbol) from branch name.
IFS=# read BRANCH ISSUE <<< "$B";
# echo "issue >> $ISSUE";
# echo "name >> $BRANCH";
echo $BRANCH
