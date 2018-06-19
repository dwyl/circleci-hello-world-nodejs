var assert = require('assert');
var hello = require('./hello.js');

assert.equal(hello(), 'Hello World!', 'our "Hello World" function works!');
