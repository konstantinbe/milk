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

Milk.ObjectExtensions =
  get: (key) ->
    value = this[key]
    throw "[ERROR] Property '#{key}' not found." if value == undefined
    this[key]

  set: (hash) ->
    for own key of hash
      throw "[ERROR] Property '#{key}' not found." if this[key] == undefined
    for own key, value of hash
      this[key] = value
    this

  keys: () ->
    Object.keys this

  values: () ->
    values = []
    for own key, value of this
       values.add value
    values

  responds_to: (method) ->
    this[method]? and this[method].is_function()

  merge: (objects...) ->
    for object in objects
      for own key, value of object
        this[key] = value
    this

  freeze: () ->
    Object.freeze(this)

  seal: () ->
    Object.seal(this)

  is_frozen: () ->
    Object.isFrozen(this)

  is_sealed: () ->
    Object.isSealed(this)

  is_array: () ->
    Array.isArray this

  is_function: () ->
    @constructor? and @call? and @apply?

  is_string: () ->
    this == '' or (@charCodeAt? and @substr?)

  is_number: () ->
    this == 0 or (@toExponential? and @toFixed?)

  is_boolean: () ->
    this instanceof Boolean

  is_date: () ->
    @getTimezoneOffset? and @setUTCFullYear?

  is_regexp: (value) ->
    @test? and @exec? and (@ignoreCase? or @ignoreCase == no)

  hash: () ->
    # TODO: Implement this.

  clone: () ->
    {}.set this

  equals: (object) ->
    # TODO: Implement this.

  description: () ->
    # TODO: Implement this.
