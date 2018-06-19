var assert = require('assert');
var hello = require('./hello.js');

assert.strictEqual(hello(), 'Hello World!', 'our "Hello World" function works');
