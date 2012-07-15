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

Match = @import 'Milk.Match'

# ----------------------------------------------------- Aliased Functions ------

spy = spyOn
before = beforeEach
after = afterEach

# ------------------------------------------------------ Aliased Matchers ------

AliasedMatchers =
  to_be: jasmine.Matchers.prototype.toBe
  to_equal: jasmine.Matchers.prototype.toEqual
  to_match: jasmine.Matchers.prototype.toMatch
  to_be_defined: jasmine.Matchers.prototype.toBeDefined
  to_be_undefined: jasmine.Matchers.prototype.toBeUndefined
  to_be_null: jasmine.Matchers.prototype.toBeNull
  to_be_truthy: jasmine.Matchers.prototype.toBeTruthy
  to_be_falsy: jasmine.Matchers.prototype.toBeFalsy
  to_have_been_called: jasmine.Matchers.prototype.toHaveBeenCalled
  to_have_been_called_with: jasmine.Matchers.prototype.toHaveBeenCalledWith
  to_contain: jasmine.Matchers.prototype.toContain
  to_be_less_than: jasmine.Matchers.prototype.toBeLessThan
  to_be_greater_than: jasmine.Matchers.prototype.toBeGreaterThan
  to_throw: jasmine.Matchers.prototype.toThrow

# ----------------------------------------------------- Register Matchers ------

before ->
  @addMatchers AliasedMatchers
  @addMatchers Match.MATCHERS
