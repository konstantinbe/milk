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


describe "Milk.Comparable", ->
  describe "properties", ->
    describe "is_comparable", ->
      it "returns yes if object mixes Comparable in", ->
        expect(Milk.Comparable).to_be_defined()
        expect(5.is_comparable).to_be true

  describe "methods", ->
    describe "is_less_than(value)", ->
      it "returns true if receiver is less than value", ->
        expect(3.is_less_than 5).to_be true

      it "returns false if they are equal", ->
        expect(5.is_less_than 5).to_be false

      it "returns false if receiver is greater than value", ->
        expect(5.is_less_than 3).to_be false

    describe "is_less_than_or_equal_to(value)", ->
      it "returns true if receiver is less than or equal to value", ->
        expect(3.is_less_than_or_equal_to 5).to_be true

      it "returns true if they are equal", ->
        expect(5.is_less_than_or_equal_to 5).to_be true

      it "returns false if receiver is greater than or equal to value", ->
        expect(5.is_less_than_or_equal_to 3).to_be false

    describe "is_greater_than(value)", ->
      it "returns true if receiver is greater than value", ->
        expect(5.is_greater_than 3).to_be true

      it "returns false if they are equal", ->
        expect(5.is_greater_than 5).to_be false

      it "returns false if receiver is greater than value", ->
        expect(3.is_greater_than 5).to_be false

    describe "is_greater_than_or_equal_to(value)", ->
      it "returns true if receiver is greater than or equal to value", ->
        expect(5.is_greater_than_or_equal_to 3).to_be true

      it "returns true if they are equal", ->
        expect(5.is_greater_than_or_equal_to 5).to_be true

      it "returns false if receiver is greater than or equal to value", ->
        expect(3.is_greater_than_or_equal_to 5).to_be false

    describe "is_between(lower, upper, [options = {}])", ->
      describe "without options", ->
        it "returns true if receiver is between lower and upper bound", ->
          expect(5.is_between 4, 6).to_be true

        it "returns true if receiver equals lower bound", ->
          expect(5.is_between 5, 6).to_be true

        it "returns true if receiver equals upper bound", ->
          expect(5.is_between 4, 5).to_be true

        it "returns true if receiver == upper == lower", ->
          expect(5.is_between 5, 5).to_be true

      describe "when options exclude_bounds is set to yes", ->
        it "returns true if receiver is between lower and upper bound", ->
          expect(5.is_between 4, 6, exclude_bounds: yes).to_be true

        it "returns false if receiver equals lower bound", ->
          expect(5.is_between 5, 6, exclude_bounds: yes).to_be false

        it "returns false if receiver equals upper bound", ->
          expect(5.is_between 4, 5, exclude_bounds: yes).to_be false

        it "returns false if receiver == upper == lower", ->
          expect(5.is_between 5, 5, exclude_bounds: yes).to_be false

    describe "equals(value)", ->
      it "returns true if receiver equals value", ->
        expect(5.equals 5).to_be true

      it "returns false otherwise", ->
        expect(5.equals 6).to_be false
