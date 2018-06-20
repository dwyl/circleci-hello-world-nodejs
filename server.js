/** a super-basic static page web server with no dependencies **/
const http = require('http'); // basic http server (don't need anything fancy!)
const fs = require('fs');     // to read index.html and favicon.ico files
// read files synchronously once when app starts (no "perf" impact):
const index = fs.readFileSync(__dirname + '/index.html', 'utf8');
const favicon = fs.readFileSync(__dirname + '/favicon.ico');
// display the Git revision hash in browser so we know which version of app.
const get_hash = require('./git_hash.js');
const hello = require('./hello.js'); // the most basic "function" ever!

get_hash(function(e, GIT_COMMIT_HASH, stder) {
  !e ? console.log('GIT_COMMIT_HASH:', GIT_COMMIT_HASH) : console.log(e);
  http.createServer(function (req, res) {
    console.log("URL:", req.url);
    if (req.url.indexOf('favicon') > -1) { // serve favicon! (◔_◔)
      res.writeHead(200, {'Content-Type': 'image/x-icon'});
      res.end(favicon);
    }
    else {
      res.writeHead(200, {'Content-Type': 'text/html'});
      res.end(index // rudimentary "view" variable rendering
        .replace(/{GIT_COMMIT_HASH}/g, GIT_COMMIT_HASH)
        .replace(/{hello}/g, hello())
      );
    }
  }).listen(process.env.PORT || 5000);
});
console.log('Listening on: http://localhost:' + (process.env.PORT || 5000));
