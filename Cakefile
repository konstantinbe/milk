#!/usr/bin/env node
#
# Copyright (c) 2010 Konstantin Bender.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

fs = require 'fs'
shell = require 'shelljs'
marked = require 'marked'

# ------------------------------------------------------------- Constants ------

BOLD = "\x1B[0;1m"
BLACK = "\x1B[0;30m"
RED = "\x1B[0;31m"
GREEN = "\x1B[0;32m"
YELLOW = "\x1B[0;33m"
BLUE = "\x1B[0;34m"
MAGENTA = "\x1B[0;35m"
CYAN = "\x1B[0;36m"
WHITE = "\x1B[0;37m"

BLACK_BRIGHT = "\x1B[1;30m"
RED_BRIGHT = "\x1B[1;31m"
GREEN_BRIGHT = "\x1B[1;32m"
YELLOW_BRIGHT = "\x1B[1;33m"
BLUE_BRIGHT = "\x1B[1;34m"
MAGENTA_BRIGHT = "\x1B[1;35m"
CYAN_BRIGHT = "\x1B[1;36m"
WHITE_BRIGHT = "\x1B[1;37m"

RESET = "\x1B[0m"

OK = GREEN + "OK" + RESET
FAILED = RED + "FAILED" + RESET

# --------------------------------------------------------------- Engines ------

engines = {}
engines['node'] = title: "NodeJS", command: "node"
engines['v8'] = title: "V8", command: "v8"
engines['nitro'] = title: "Nitro", command: "jsc"
engines['spider'] = title: "SpiderMonkey", command: "js"
engines['phantom'] = title: "PhantomJS", command: "phantomjs"
default_engine = engines['node']

# -------------------------------------------------------------- Browsers ------

browsers = {}
browsers['safari'] = name: "Safari"
browsers['firefox'] = name: "Firefox"
browsers['chrome'] = name: "Google Chrome"
browsers['webkit'] = name: "WebKit"
default_browser = browsers['safari']

# ----------------------------------------------------------------Browser ------

option '-e', "--engine [NAME]", "use one of the engines: #{Object.keys(engines).join(', ')}"
option '-b', "--browser [NAME]", "use one of the browsers: #{Object.keys(browsers).join(', ')}"
option '-h', "--version [NAME]", "release version, required for task 'release'"
option '-d', "--dry", "only prepare release, don't publish"

# ------------------------------------------------------------------ Milk ------

SOURCE = [
  "core"
  "object"
  "function"
  "boolean"
  "number"
  "date"
  "string"
  "reg-exp"
  "array"
  "math"
  "milk"
].map (pattern) -> "source/#{pattern}.coffee"

TESTS = [
  "test"
  "test-core"
  "test-object"
  "test-function"
  "test-boolean"
  "test-number"
  "test-date"
  "test-string"
  "test-reg-exp"
  "test-array"
  "test-math"
  "test-milk"
].map (pattern) -> "tests/#{pattern}.coffee"

task 'check', "check what engines are installed", (options) ->
  for id, engine of engines
     put "Checking whether #{WHITE + engine['title'] + RESET} is installed ... "
     installed = run "which #{engine['command']}", silent: yes, survive: yes
     puts if installed then GREEN + "YES" + RESET else RED + "NO" + RESET

task 'build', "build Milk", (options) ->
  invoke 'prepare'

  put "Building Milk library ... "
  run "cat #{SOURCE.join ' '} > build/milk.coffee"
  run "coffee --output build/ --compile --bare build/milk.coffee"
  puts OK

  put "Building Milk tests ... "
  run "cat #{TESTS.join ' '} > build/milk-tests.coffee"
  run "coffee --output build/ --compile --bare build/milk-tests.coffee"
  run "coffee --output build/ --compile --bare support/driver.coffee support/spec-runner.coffee"
  run "cat build/driver.js externals/jasmine/jasmine.js build/milk.js build/milk-tests.js build/spec-runner.js > build/test-milk.js"
  puts OK

task 'test', "build & run Milk tests", (options) ->
  invoke 'build'
  invoke 'run'

task 'play', "build & run Milk in browser", (options) ->
  invoke 'build'

  put "Generating play.html ... "
  html = """
    <!DOCTYPE html>
    <html>
        <head>
            <title>Milk Playground</title>
            <script type='text/javascript' src='milk.js'></script>
        </head>
        <body>
            <div id='content'>
            </div>
        </body>
    </html>
  """
  write_to_file html, "build/play.html"
  puts OK

  browser = browsers[options['browser']] or default_browser
  put "Opening play.html in #{WHITE + browser['name'] + RESET} ... "
  run "open build/play.html -a #{browser['name']}"
  puts OK

task 'run', "run Milk tests\n", (options) ->
  engine = engines[options['engine']] or default_engine
  puts "Running Milk tests on #{WHITE + engine['title'] + RESET} ..."
  if options['engine']?
    run "cd build; #{engine['command']} test-milk.js"
  else
    require 'build/test-milk.js'

task 'test:all', "build & run all tests on all engines", (options) ->
  invoke 'build'
  invoke 'run:all'

task 'run:all', "run all tests on all engines\n", (options) ->
  invoke 'check'
  for own id, engine of engines
    if which engine.command
      puts "==================================================\n"
      run "cake --engine #{id} run"

task 'camel', "build camel case version & run tests", (options) ->
  invoke 'clean'
  invoke 'build'

  coffee_file_names = [
    'milk'
    'milk-tests'
  ]

  put "Converting to CamelCase ... "
  for name in coffee_file_names
    underscorized = read_from_file "build/#{name}.coffee"
    camel_cased = underscorized.replace /_([a-z])/g, (match) -> match[1].toUpperCase()
    finalized = camel_cased.replace /([a-z])_/g, (match) -> match[1]
    write_to_file finalized, "build/#{name}.coffee"
  puts OK

  put "Compiling ... "
  for name in coffee_file_names
   run "coffee --output build/ --compile --bare build/#{name}.coffee"
  puts OK

  invoke 'run'

task 'website', "build website\n", (options) ->
  invoke 'prepare'

  put "Building website ... "
  run "mkdir -p build/website"
  run "rm -rf build/website/*"
  run "cp website/* build/website/"
  index_html = read_from_file "website/index.html"
  content_md = read_from_file "website/content.md"
  index_html = index_html.replace "<!-- content.md -->", marked content_md
  write_to_file index_html, "build/website/index.html"
  puts OK

task 'release', "release a version of Milk (website, NPM)\n", (options) ->
  invoke 'build'
  invoke 'website'

  version = options['version']
  dry = options['dry']
  check version?, "Can't release, --version required"

  put "Preparing release ... "
  run "rm -rf build/release"
  run "mkdir -p build/release"
  puts OK

  put "Preparing node module ... "
  run "mkdir -p build/release/node"
  run "cp build/milk.js build/release/node/milk-node.js"
  run "sed 's/x\.x\.x/#{version}/' support/package.json > build/release/node/package.json"
  puts OK

  put "Preparing website ... "
  run "mkdir -p build/release/website"
  run "git clone -q .git build/release/website"
  run "cd build/release/website; git checkout origin/gh-pages -b gh-pages; git clean -fd"
  run "rm -rf build/release/website/*"
  run "cp build/website/* build/release/website/; rm -rf build/release/website/*.md"
  run "sed 's/x\.x\.x/#{version}/' build/milk.coffee > build/release/website/milk-#{version}.coffee"
  run "sed 's/x\.x\.x/#{version}/' build/milk.js > build/release/website/milk-#{version}.js"
  run "sed 's/x\.x\.x/#{version}/g' build/website/index.html > build/release/website/index.html"
  puts OK

  if dry
    puts "Dry run, won't publish"
    process.exit 0

  put "Publishing website ... "
  # run "cd build/release/website/; git add *; git commit -a -m 'Publish website (#{version})'; git push origin gh-pages:gh-pages"
  # run "git push origin gh-pages:gh-pages"
  puts OK

  put "Publishing NPM package ... "
  # run "cd build/release/node/; node publish"
  puts OK

# --------------------------------------------------------------- Default ------

task 'prepare', "create the build directory", (options) ->
  put "Preparing ... "
  run "mkdir -p build"
  puts OK

task 'clean', "delete the build directory\n", (options) ->
  put "Cleaning ... "
  run "rm -rf build"
  puts OK

# ------------------------------------------------------------- Functions ------

run = (command, options = {}) ->
  parts = command.split " > "
  command = parts[0]
  redirect = parts[1]

  options['silent'] = yes if redirect?
  result = shell.exec command, options

  code = result['code']
  output = result['output']

  if code > 0
    put output unless options['silent']
    puts FAILED unless options['silent']
    process.exit code unless options['survive']

  output.to redirect if output? and redirect?
  output

check = (condition, message) ->
  unless condition
    puts "#{message} #{FAILED}"
    process.exit 1

put = (message) ->
  process.stdout.write message

puts = (message) ->
  put message + "\n"

read_from_file = (path) ->
  data = fs.readFileSync path
  if not data?
    console.log "Error reading from file: #{path}"
    process.exit error
  data.toString()

write_to_file = (string, path) ->
  error = fs.writeFileSync path, string
  if error > 0
    console.log "Error writing to file: #{path}"
    process.exit error

file_exists = (path) ->
  pwd = run "pwd", silent: yes
  tested_path = run "test -e #{path} && cd #{path}; pwd", silent: yes
  return yes if path is pwd
  return yes if tested_path.length > 0 and tested_path isnt pwd
  no
