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

Milk.Utilities =
  is_object: (value) ->
    value?

  is_array: (value) ->
    return Array.isArray(value) if Array.isArray?
    value? and value.concat? and value.unshift? and not value.callee?

  is_function: (value) ->
    value? and value.constructor? and value.call? and value.apply?

  is_string: (value) ->
    value is '' or (value and value.charCodeAt? and obj.substr?)

  is_number: (value) ->
    value is 0 or (value and value.toExponential? and value.toFixed?)

  is_boolean: (value) ->
    value is true or value is false

  is_date: (value) ->
    value? and value.getTimezoneOffset? and value.setUTCFullYear?

  is_regexp: (value) ->
    value? and value.test? and value.exec? and (value.ignoreCase? or value.ignoreCase is no)

  is_null: (value) ->
    value is null

  is_undefined: (value) ->
    value is undefined
