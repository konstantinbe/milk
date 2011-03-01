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

native_seal = Object.seal
native_freeze = Object.freeze
native_is_sealed = Object.isSealed
native_is_frozen = Object.isFrozen

exports.ObjectExtensions =
  get: (key) ->
    value = @[key]
    throw "[ERROR] Property '#{key}' not found." if value == undefined
    @[key]

  set: (key, value) ->
    throw "[ERROR] Property '#{key}' not found." if @[key] == undefined
    @[key] = value
    this

  keys: ->
    Object.keys this

  values: ->
    values = []
    for own key, value of this
       values.add value
    values

  properties: ->
    # TODO: implement.

  methods: ->
    # TODO: implement.

  responds_to: (method) ->
    @[method]? and @[method].is_function()

  merge: (objects...) ->
    for object in objects
      for own key, value of object
        @[key] = value
    this

  freeze: ->
    if native_freeze? then native_freeze(this) else @is_frozen = -> yes
    this

  seal: ->
    if native_seal? native_seal(this) else @is_sealed = -> yes
    this

  is_frozen: ->
    if native_is_frozen? then native_is_frozen(this) else no

  is_sealed: ->
    if native_is_sealed? then native_is_sealed(this) else no

  is_array: ->
    Array.isArray this

  is_function: ->
    @constructor? and @call? and @apply?

  is_string: ->
    this == '' or (@charCodeAt? and @substr?)

  is_number: ->
    this == 0 or (@toExponential? and @toFixed?)

  is_boolean: ->
    this instanceof Boolean

  is_date: ->
    @getTimezoneOffset? and @setUTCFullYear?

  is_reg_exp: (value) ->
    @test? and @exec? and (@ignoreCase? or @ignoreCase == no)

  clone: ->
    clone = {}
    for own key, value of this
      clone[key] = value
    clone

  equals: (object) ->
    this == object

  description: ->
    if @toString? then @toString() else "Object"
