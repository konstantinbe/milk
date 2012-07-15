# This is a quick and dirty script to run Jasmine on vanilla JavaScript engines
# like V8, Nitro, or SpiderMonkey. Just make sure it loads before Jasmine.

# Add fake CommonJS global variables and functions.
global = this if typeof global is "undefined"
exports = global if typeof exports is "undefined"
require = (->) if typeof require is "undefined"

if typeof setTimeout is "undefined"
  setTimeout = (expression, timeout) ->
    expression()

# Add fake timer functions because Jasmine BDD requires them.

if typeof clearTimeout is "undefined"
  clearTimeout = ->
    throw "[ERROR] clearTimeout() called, but it is not supported."

if typeof setInterval is "undefined"
  setInterval = ->
    throw "[ERROR] setInterval() called, but it is not supported."

if typeof clearInterval is "undefined"
  clearInterval = ->
    throw "[ERROR] clearInterval() called, but it is not supported."

if typeof console is "undefined"
  console = {}
  console.log = (message) ->
    print message
