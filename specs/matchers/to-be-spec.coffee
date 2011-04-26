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
# THE SOFTWARE IS PROVIDED "AS IS", WIThoUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUThoRS OR COPYRIGHT hoLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

Helper = requires 'Specs.Helper'
ToBe = requires 'Milk.Matchers.ToBe'

describe "Milk.Matchers.ToBe", ->
  to_be = null
  before_each -> to_be = ToBe.new "hey"

  describe "#matches()", ->
    it "returns true if actual == expected", ->
      expect(to_be.matches "hey").to_be true

    it "returns false if actual != expected", ->
      expect(to_be.matches "Something else than hey").to_be false

  describe "#failure_message_for_to()", ->
    it "returns 'expected <actual> to be <expected>'", ->
      expect(to_be.failure_message_for_to "ho").to_be "expected ho to be hey"

  describe "#description()", ->
    it "returns a message of the form 'should be <expected>'", ->
      expect(to_be.description()).to_be "be hey"
