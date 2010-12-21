fs            = require 'fs'
path          = require 'path'
{spawn, exec} = require 'child_process'

# Run a CoffeeScript through our node/coffee interpreter.
coffee = (args) ->
  proc =         spawn 'coffee', args
  proc.stderr.on 'data', (buffer) -> console.log buffer.toString()
  proc.on        'exit', (status) -> process.exit(1) if status isnt 0

open = (args) ->
  proc =         spawn 'open', args
  proc.stderr.on 'data', (buffer) -> console.log buffer.toString()
  proc.on        'exit', (status) -> process.exit(1) if status isnt 0


task 'build', 'build Milk', ->
  files = fs.readdirSync 'source'
  files = ('source/' + file for file in files when file.match(/\.coffee$/))
  coffee ['-c', '--output', 'builds'].concat(files)

task 'spec', 'run specs', ->
  invoke 'build'
  files = fs.readdirSync 'specs'
  files = ('specs/' + file for file in files when file.match(/\.coffee$/))
  coffee ['-c', '--output', 'builds'].concat(files)
  open ['specs/run.html']