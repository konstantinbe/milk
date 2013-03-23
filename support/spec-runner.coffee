# Quick and dirty reporter to run jasmine specs on NodeJS, PhantomJS and vanilla
# JavaScript engines like V8 or SpiderMonkey.

verbose = false
numberOfColumns = 50
colorOutputSupported = true

isNode = typeof process isnt "undefined"
isPhantom = typeof phantom isnt "undefined"
isBrowser = not isPhantom and typeof document isnt "undefined" and document.body and document.body.innerHTML
isEngine = not isPhantom and typeof print isnt "undefined"

put = -> # Do nothing.

puts = -> # Do nothing.

exit = -> # Do nothing.

buffer = ""
bufferedPut = (string) ->
  buffer += string
  lines = buffer.split("\n")
  i = 0

  while i < lines.length - 1
    puts lines[i]
    i++
  buffer = lines[lines.length - 1]

if isNode
  put = (string) -> process.stdout.write string
  puts = (string) -> put string + "\n"
  exit = (code) -> process.exit code

if isPhantom
  put = (string) -> bufferedPut string
  puts = (string) -> console.log string
  exit = (code) -> phantom.exit code

if isBrowser
  put = (string) ->
    string = string.replace(/\n/g, "<br />")
    string = string.replace(/\[31m/g, "<span style='color:#ff6c60'>")
    string = string.replace(/\[32m/g, "<span style='color:#a8ff60'>")
    string = string.replace(/\[33m/g, "<span style='color:#ffffb6'>")
    string = string.replace(/\[34m/g, "<span style='color:#96cbfe'>")
    string = string.replace(/\[1m/g, "<span style='color:white; font-weight:bold'>")
    string = string.replace(/\[0m/, "</span>")
    document.body.innerHTML += string

  puts = (string) -> put string + "\n"

if isEngine
  put = (string) -> bufferedPut string
  puts = (string) -> print string
  exit = (code) -> quit code

stylize = (string, style) ->
  return string  unless colorOutputSupported
  styleCodeBegin = "\u001b["
  styleCodeEnd = "\u001b[0m"
  styleCode = "0m"
  switch style
    when "red"
      styleCode = "31m"
    when "green"
      styleCode = "32m"
    when "yellow"
      styleCode = "33m"
    when "blue"
      styleCode = "34m"
    when "bold"
      styleCode = "1m"
    else
  styleCodeBegin + styleCode + string + styleCodeEnd

suitesFor = (spec) ->
  suites = []
  suite = spec.suite
  while suite
    suites.push suite
    suite = suite.parentSuite
  suites.reverse()

failureMessageFor = (spec) ->
  message = "\n    "
  suitesFor(spec).forEach (suite) ->
    message += suite.description + " "

  message += spec.description
  spec.results().getItems().forEach (result) ->
    message += "\n        - " + result.message  unless result.passed()

  message

printFailureMessageFor = (spec) ->
  put failureMessageFor(spec) + "\n"

jasmine.CommandLineReporter = ->
  @numberOfExamples = 0
  @numberOfFailedExamples = 0

jasmine.CommandLineReporter::reportRunnerStarting = (runner) ->
  @startedAt = new Date()
  put "\n"

jasmine.CommandLineReporter::reportRunnerResults = (runner) ->
  finishedAt = new Date()
  durationInSeconds = (finishedAt - @startedAt) / 1000.0
  results = runner.results()
  put "\n"  unless verbose
  if results.failedCount > 0
    put stylize("\nFAILURES:", "bold") + "\n"
    runner.specs().forEach (spec) ->
      printFailureMessageFor spec  unless spec.results().passed()
  color = (if results.failedCount > 0 then "red" else "green")
  examples = (if @numberOfExamples is 1 then "example" else "examples")
  failures = (if @numberOfFailedExamples is 1 then "failure" else "failures")
  put "\nFinished in " + durationInSeconds + " seconds\n"
  put @numberOfExamples + " " + examples + ", " + stylize(@numberOfFailedExamples + " " + failures + "\n", color) + "\n"
  code = 0
  code = 1 if results.failedCount > 0
  exit code

jasmine.CommandLineReporter::reportSuiteResults = (suite) ->

jasmine.CommandLineReporter::reportSpecStarting = (spec) ->

counter = 0
jasmine.CommandLineReporter::reportSpecResults = (spec) ->
  @numberOfExamples++
  @numberOfFailedExamples++  unless spec.results().passed()
  indentation = ""
  suitesFor(spec).forEach (suite) ->
    unless suite.printed
      put "\n" + indentation + suite.description + "\n"  if verbose
      suite.printed = true
    indentation += "    "

  passed = spec.results().passed()
  if verbose
    unless spec.printed
      put indentation + "- " + spec.description + (if passed then "" else stylize(" FAILED", "red")) + "\n"
      spec.printed = true
  else
    put (if passed then "." else stylize("F", "red"))
    counter = (if counter >= numberOfColumns - 1 then 0 else counter + 1)
    put "\n"  if counter is 0

jasmine.getEnv().addReporter new jasmine.CommandLineReporter()
jasmine.getEnv().execute()
