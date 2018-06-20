#!/bin/bash
CWD="$PWD/bin"
echo "CWD $CWD"
BRANCH=$(sh $CWD/branch.sh)
echo "BRANCH => $BRANCH"
echo "DOKKU_APP => $DOKKU_APP"
DOKKU_APP="$DOKKU_APP-$(sh $CWD/app-name.sh)"
echo "DOKKU_APP => $DOKKU_APP"

# these could all be environment variables:
USER="root"
SSH="ssh $USER@$SERVER_IP_ADDRESS"
URL="$SERVER_IP_ADDRESS:$DOKKU_APP"
echo "URL => $URL"

# create the dokku App
CREATE="dokku apps:create $DOKKU_APP"
echo "CREATE => $CREATE"
$SSH $CREATE

# set git remote for the "review" dokku app:
REMOTE="dokku dokku@$URL"
echo "REMOTE => $REMOTE"
if [ "$TRAVIS" == "true" ]; then
    $(git remote add $REMOTE)
    # Travis does a "shallow" git clone so we need to "unshallow" it:
    $(git fetch --unshallow) # see: https://github.com/dwyl/learn-devops/issues/33
    $(git config --global push.default simple)
else
    $(git remote set-url $REMOTE)
fi
if [ "$TRAVIS" == "false" ]; then
    $(git remote add $REMOTE)
fi
echo "$(git remote -v)"

# Temporarily Stop Nginx to avoid the git push / build failing:
KILL_NGINX="pkill nginx"
echo "KILL_NGINX => $KILL_NGINX"
SYSTEMCTL_START_NGINX="systemctl start nginx"
echo "SYSTEMCTL_START_NGINX => $SYSTEMCTL_START_NGINX"
$SSH $KILL_NGINX
$SSH $SYSTEMCTL_START_NGINX

# Push *ONLY* the latest commit to dokku (minimalist)
COMMIT_HASH=$(sh $CWD/commit-hash.sh)
echo "COMMIT_HASH => $COMMIT_HASH"
PUSH="git push dokku $COMMIT_HASH:refs/heads/master" # this should work *everywhere*
echo "PUSH => $PUSH"
$($PUSH)

# Apply the Letsencrypt Wildcard SSL/TLS Certificate to the app
CERTS="sudo dokku certs:add $DOKKU_APP < /etc/letsencrypt/live/ademo.app/certs.tar"
$SSH $CERTS

# Reload (restart) nginx so the new app is served:
RELOAD="systemctl stop nginx && nginx -t && nginx"
$SSH $RELOAD

# $(sh $CWD/docker-exited.sh)
