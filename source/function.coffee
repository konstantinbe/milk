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

  class FunctionExtensions

    new: (args...) ->
      new this args...

    has: (key, options = {}) ->
      initial = @option options, 'initial', null
      secret = @option options, 'secret', no
      readonly = @option options, 'readonly', no
      copy = @option options, 'copy', no
      freeze = @option options, 'creeze', no
      getter = @option options, 'get', null
      setter = @option options, 'set', null

      getter_name = Object.getter_name_for key
      setter_name = Object.setter_name_for key
      instance_variable_name = '@' + key

      getter ?= ->
        value = @[instance_variable_name] ? initial
        Object.freeze value if freeze and value?
        value

      setter ?= (value) ->
        value = @copy_of value if copy
        @[instance_variable_name] = value
        @

      @prototype[getter_name] = getter
      @prototype[setter_name] = setter

      Object.defineProperty @prototype, getter_name, enumerable: no if secret
      Object.defineProperty @prototype, setter_name, enumerable: no if secret or readonly

  Function.includes FunctionExtensions
