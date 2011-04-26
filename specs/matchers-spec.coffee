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

SpecHelper = requires 'Specs.SpecHelper'
Matchers = requires 'Milk.Matchers'

describe "Milk.Matchers", ->
  describe ".to_be()", ->
    it "returns true if subject == value", ->
      expect(Matchers.match 1, to_be: 1).to_be true

    it "returns false if subject != value", ->
      expect(Matchers.match 1, to_be: 2).to_be false

    describe ".to_equal()", ->
      it "returns true if subject equals value", ->
        expect(Matchers.match [1, 2, 3], to_equal: [1, 2, 3]).to_be true

      it "returns false if subject does not equal value", ->
        expect(Matchers.match [1, 2, 3], to_equal: [1, 2]).to_be false
