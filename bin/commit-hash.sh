#!/bin/bash
if [ "$TRAVIS" == "true" ]; then
    latestPRCommit=(${TRAVIS_COMMIT_RANGE//\.\.\./ })
    TRAVIS_HASH=${latestPRCommit[1]}
    echo $TRAVIS_HASH
else
    echo $(git rev-parse --verify HEAD);
fi
