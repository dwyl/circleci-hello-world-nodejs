#!/bin/bash
# purge all docker containers which have status=exited
USER="root"
SSH="ssh -i ./deploy_key $USER@$SERVER_IP_ADDRESS"
echo $SSH
CMD="docker ps -aq -f status=exited"
echo $CMD
LIST=$($SSH $CMD)
echo $LIST
DELETE="docker rm $LIST"
echo $DELETE
$SSH $DELETE
