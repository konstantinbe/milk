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

# ------------------------------------------------------------------------------

describe "Number", ->

  describe "#is_nan()", ->
    it "returns true if number is NaN", ->
      expect(Number.NaN.is_nan()).to_be true

    it "returns false if number is infinte", ->
      expect(Number.NEGATIVE_INFINITY.is_nan()).to_be false
      expect(Number.POSITIVE_INFINITY.is_nan()).to_be false

    it "returns false if number is finite", ->
      expect(0.is_nan()).to_be false

  describe "#is_finite()", ->
    it "returns true if number is finite", ->
      expect(0.is_finite()).to_be true

    it "returns false if number is infinite", ->
      expect(Number.NEGATIVE_INFINITY.is_finite()).to_be false
      expect(Number.POSITIVE_INFINITY.is_finite()).to_be false

    it "returns false if number is NaN", ->
      expect(Number.NaN.is_finite()).to_be false

  describe "#is_infinite()", ->
    it "returns true if number is infinite", ->
      expect(Number.NEGATIVE_INFINITY.is_infinite()).to_be true
      expect(Number.POSITIVE_INFINITY.is_infinite()).to_be true

    it "returns false if number is finite", ->
      expect(0.is_infinite()).to_be false

    it "returns false if number is NaN", ->
      expect(Number.NaN.is_infinite()).to_be false
