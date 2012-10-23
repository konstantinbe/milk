#
# Copyright (c) 2012 Konstantin Bender.
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

@module 'Milk', ->

  class ObjectExtensions

    native_has_own_property = Object::hasOwnProperty
    native_to_string = Object::toString

    has_own: (key) ->
      native_has_own_property.call this, key

    own: (key) ->
      if @has_own key then @[key] else undefined

    is_copyable: ->
      return yes if @class_of @ is Object
      no

    copy: ->
      throw "#{@class_name_of @} doesn't support copying" unless @class_of @ is Object
      copy = {}
      for own key, value of @
        copy[key] = value
      copy

    toString: ->
      return @to_string() if @responds_to 'to_string'
      native_to_string.call @

    to_string: ->
      native_to_string.call @

  Object.includes ObjectExtensions
