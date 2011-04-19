/*globals global process put */

// This is a quick and dirty script to run Jasmine on vanilla JavaScript engines
// like V8, Nitro, or SpiderMonkey. Just make sure it loads before Jasmine.

// Add fake CommonJS global variables and functions.
if (typeof global === 'undefined') {
   global = this;
}

if (typeof exports === 'undefined') {
    exports = global;
}

if (typeof require === 'undefined') {
    require = function() {};
}

// Add fake timer functions because Jasmine BDD requires them.
if (typeof setTimeout === 'undefined') {
    setTimeout = function(expression, timeout) { expression(); };
}

if (typeof clearTimeout === 'undefined') {
    clearTimeout = function() { throw "[ERROR] clearTimeout() called, but it is not supported."; };
}

if (typeof setInterval === 'undefined') {
    setInterval = function() { throw "[ERROR] setInterval() called, but it is not supported."; };
}

if (typeof clearInterval === 'undefined') {
    clearInterval = function() { throw "[ERROR] clearInterval() called, but it is not supported."; };
}
