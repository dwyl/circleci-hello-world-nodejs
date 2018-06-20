const assert = require('assert');
const hello = require('./hello.js');

assert.strictEqual(hello(), 'Hello World!', 'our "Hello World" function works');
