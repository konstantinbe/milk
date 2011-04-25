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

requires 'Specs.Helper'

describe "Milk.Matchers.ToBe", ->
  describe "#matches()", ->
    context "when created only with expected, no options", ->
      to_be = null
      before_each -> to_be = Milk.Matchers.ToBe.new "Hello World!"

      it "returns true if actual == expected", ->
        expect(to_be.matches "Hello World!").to_be true

      it "returns false if actual != expected", ->
        expect(to_be.matches "Something else than Hello World!").to_be false

    context "when created with a target option 'of'", ->
      person = null
      to_be = null

      before_each ->
        person = name: "Peter", age: 5
        to_be = Milk.Matchers.ToBe.new 'name', of: person

      it "returns true if actual == <property of target>", ->
        expect(to_be.matches "Peter").to_be true

      it "returns false if actual != <property of target>", ->
        expect(to_be.matches "Anna").to_be false
