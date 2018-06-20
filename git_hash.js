const { exec } = require('child_process');
const { EOL } = require('os');

module.exports = function git_hash (callback) {

  if (process.env.TRAVIS) { // see: https://git.io/vh3M7 (yes, it's lame!)
    return callback(null, process.env.TRAVIS_COMMIT, null);
  }

  if (process.env.GIT_REV) { // see: /home/dokku/<app-name>/ENV
    // console.log('process.env.GIT_REV', process.env.GIT_REV);
    return callback(null, process.env.GIT_REV, null);
  }

  return exec('git rev-parse HEAD', function(e, stdout, stderr) {
    return callback(e, stdout.replace(EOL, ''), stderr);
  });
}
