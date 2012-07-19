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

  class Attributes

    has: (key, options = {}) ->
      initial = options.own 'initial'
      secret = options.own 'private'
      readonly = options.own 'readonly'
      copy = options.own 'copy'
      getter = options.own 'get'
      setter = options.own 'set'

      getter_name = @getter_name_for key
      setter_name = @setter_name_for key
      instance_variable_name = @instance_variable_name_for key

      getter ?= ->
        @[instance_variable_name] = initial unless @has_own instance_variable_name
        @[instance_variable_name]

      setter ?= (value) ->
        value = value.copy() if copy
        @[instance_variable_name] = value
        @

      @prototype[getter_name] = getter
      @prototype[setter_name] = setter

      Object.defineProperty @prototype, getter_name, enumerable: no if secret
      Object.defineProperty @prototype, setter_name, enumerable: no if secret or readonly

  Function.includes Attributes
