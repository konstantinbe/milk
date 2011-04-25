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

Enumerable = requires 'Milk.Mixins.Enumerable'
Comparable = requires 'Milk.Mixins.Comparable'

ObjectExtensions = requires 'Milk.Extensions.ObjectExtensions'
NumberExtensions = requires 'Milk.Extensions.NumberExtensions'
StringExtensions = requires 'Milk.Extensions.StringExtensions'
FunctionExtensions = requires 'Milk.Extensions.FunctionExtensions'
RegExpExtensions = requires 'Milk.Extensions.RegExpExtensions'
ArrayExtensions = requires 'Milk.Extensions.ArrayExtensions'
DateExtensions = requires 'Milk.Extensions.DateExtensions'
MathExtensions = requires 'Milk.Extensions.MathExtensions'

# ------------------------------------------------------------------------------

Object::mixin = (mixins...) ->
  for mixin in mixins
    for own key, value of mixin
      @[key] = value
  return this

Object::extend_by = (mixins...) ->
  @prototype.mixin mixins...

# ------------------------------------------------------------------------------

Object.extend_by ObjectExtensions

Number.extend_by NumberExtensions
Number.extend_by Comparable

String.extend_by Enumerable
String.extend_by StringExtensions
String.extend_by Comparable

Function.extend_by FunctionExtensions
RegExp.extend_by RegExpExtensions

Array.extend_by Enumerable
Array.extend_by ArrayExtensions

Math.mixin MathExtensions
