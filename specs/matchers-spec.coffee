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

  describe ".to_exist()", ->
    # TODO: specify.

  describe ".to_be()", ->
    it "returns true if subject == value", ->
      expect(Matchers.match 1, to_be: 1).to_be true

    it "returns false if subject != value", ->
      expect(Matchers.match 1, to_be: 2).to_be false

  describe ".to_a_kind_of()", ->
    # TODO: specify.

  describe ".to_be_an_instance_of()", ->
    # TODO: specify.

  describe ".to_equal()", ->
    it "returns true if subject equals value", ->
      expect(Matchers.match [1, 2, 3], to_equal: [1, 2, 3]).to_be true

    it "returns false if subject does not equal value", ->
      expect(Matchers.match [1, 2, 3], to_equal: [1, 2]).to_be false

  describe ".to_contain()", ->
    it "returns true if subject contains value", ->
      expect(Matchers.match [1, 2, 3], to_contain: 2).to_be true

    it "returns false if subject does not contain the value", ->
      expect(Matchers.match [1, 2, 3], to_contain: 4).to_be false

  describe ".to_contain_all()", ->
    it "returns true if subject contains all values", ->
      expect(Matchers.match [1, 2, 3], to_contain_all: [1, 2]).to_be true

    it "returns true if subject contains all values, even if they are in different order", ->
      expect(Matchers.match [1, 2, 3], to_contain_all: [1, 3, 2]).to_be true

    it "returns false if one of the values is not contained in subject", ->
      expect(Matchers.match [1, 2, 3], to_contain_all: [4]).to_be false

  describe ".to_contain_any()", ->
    it "returns true if subject contains at least one of the values but not the others", ->
      expect(Matchers.match [1, 2, 3], to_contain_any: [1, 4]).to_be true

    it "returns false if not one of the values is contained in subject", ->
      expect(Matchers.match [1, 2, 3], to_contain_any: [4, 5]).to_be false

  describe ".to_have()", ->
    # TODO: specify.

  describe ".to_have_at_least()", ->
    # TODO: specify.

  describe ".to_have_at_most()", ->
    # TODO: specify.

  describe ".to_have_more_than()", ->
    # TODO: specify.

  describe ".to_have_less_than()", ->
    # TODO: specify.

  describe ".to_have_between()", ->
    # TODO: specify.

  describe ".to_have_one()", ->
    # TODO: specify.

  describe ".to_have_many()", ->
    # TODO: specify.

  describe ".to_match()", ->
    # TODO: specify.

  describe ".to_respond_to()", ->
    # TODO: specify.

  describe ".to_throw()", ->
    # TODO: specify.
