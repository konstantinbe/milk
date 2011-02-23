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

this.exports = this unless exports?

Object::mixin = (mixins...) ->
  for mixin in mixins
    for own key, value of mixin
      @[key] = value
  return this

Object::extend = (mixins...) ->
  for mixin in mixins
    for own key, value of mixin
      @[key] = value
  this

Object::include = (mixins...) ->
  @::extend mixins...

namespace = (path, block) ->
  throw "[ERROR] Parameter path of function namespace(path, [block]) is required." unless path? and path.is_string()
  throw "[ERROR] Parameter block of function namespace(path, [block]) must be a function." if block? and not block.is_function()
  throw "[ERROR] Parameter path of function namespace(path, block) is not valid: '#{path}'" unless path.match /^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)*$/
  names = path.split "."
  space = names.inject this, (parent, name) ->
    parent[name] ?= {}
  block.call(space) if block?
  space
