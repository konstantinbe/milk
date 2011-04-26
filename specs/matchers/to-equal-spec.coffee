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

Helper = requires 'Specs.Helper'
ToEqual = requires 'Milk.Matchers.ToEqual'

describe "Milk.Matchers.ToEqual", ->
  to_equal = null
  before_each -> to_equal = ToEqual.new [1, 2, 3]

  describe "#matches()", ->
    it "returns true if actual equals expected", ->
      expect(to_equal.matches [1, 2, 3]).to_equal true

    it "returns false if actual doesn't equal expected", ->
      expect(to_equal.matches [1, 2]).to_equal false

  describe "#failure_message_for_to()", ->
    it "returns 'expected <actual> to equal <expected>'", ->
      expect(to_equal.failure_message_for_to [1, 2]).to_equal "expected [1, 2] to equal [1, 2, 3]"

  describe "#description()", ->
    it "returns a message of the form 'equal <expected>'", ->
      expect(to_equal.description()).to_equal "equal [1, 2, 3]"
