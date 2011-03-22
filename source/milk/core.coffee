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

require 'Milk.Foundation.Enumerable'
require 'Milk.Foundation.Comparable'

require 'Milk.Extensions.ObjectExtensions'
require 'Milk.Extensions.NumberExtensions'
require 'Milk.Extensions.StringExtensions'
require 'Milk.Extensions.FunctionExtensions'
require 'Milk.Extensions.RegExpExtensions'
require 'Milk.Extensions.ArrayExtensions'
require 'Milk.Extensions.DateExtensions'

Object::mixin = (mixins...) ->
  for mixin in mixins
    for own key, value of mixin
      @[key] = value
  return this

Object::extend_by = (mixins...) ->
  @prototype.mixin mixins...

Object.extend_by Milk.Extensions.ObjectExtensions

Number.extend_by Milk.Extensions.NumberExtensions
Number.extend_by Milk.Foundation.Comparable

String.extend_by Milk.Foundation.Enumerable
String.extend_by Milk.Extensions.StringExtensions
String.extend_by Milk.Foundation.Comparable

Function.extend_by Milk.Extensions.FunctionExtensions
RegExp.extend_by Milk.Extensions.RegExpExtensions

Array.extend_by Milk.Foundation.Enumerable
Array.extend_by Milk.Extensions.ArrayExtensions
