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

  describe ".to_be_a_kind_of()", ->
    class Vehicle
      type: ""

    class Car extends Vehicle
      drive: -> "Bruuuum..."

    car = Car.new()

    it "returns true of subject is an instance of class", ->
      expect(Matchers.match car, to_be_a_kind_of: Car).to_be true

    it "returns true of subject is an instance of subclass of class", ->
      expect(Matchers.match car, to_be_a_kind_of: Vehicle).to_be true

    it "returns true for Object", ->
      expect(Matchers.match car, to_be_a_kind_of: Object).to_be true

    it "returns false if subject is an instance of a different class which is not a subclass of class", ->
      expect(Matchers.match car, to_be_a_kind_of: Array).to_be false

  describe ".to_be_an_instance_of()", ->
    context "when object is an instance of a built in class", ->
      it "returns true if subject is an instance of class", ->
        expect(Matchers.match [1, 2, 3], to_be_an_instance_of: Array).to_be true

      it "returns false if subject is not an instance of class", ->
        expect(Matchers.match [1, 2, 3], to_be_an_instance_of: Object).to_be false

    context "when object is an instance of a custom class", ->
      class Vehicle
        type: ""

      class Car extends Vehicle
        drive: -> "Bruuuum..."

      car = Car.new()

      it "returns true if subject is an instance of class", ->
        expect(Matchers.match car, to_be_an_instance_of: Car).to_be true

      it "returns false if subject is not an instance of class", ->
        expect(Matchers.match car, to_be_an_instance_of: Vehicle).to_be false

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

  describe ".to_have_exactly()", ->
    it "returns true if subject has exactly N values", ->
      expect(Matchers.match [1, 2, 3], to_have_exactly: 3).to_be true

    it "returns false if subject has not exactly N values", ->
      expect(Matchers.match [1, 2, 3], to_have_exactly: 4).to_be false

  describe ".to_have_at_least()", ->
    it "returns true if subject has exactly N values", ->
      expect(Matchers.match [1, 2, 3], to_have_at_least: 3).to_be true

    it "returns false if subject has less than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_at_least: 2).to_be true

    it "returns true if subject has more than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_at_least: 4).to_be false

  describe ".to_have_at_most()", ->
    it "returns true if subject has exactly N values", ->
      expect(Matchers.match [1, 2, 3], to_have_at_most: 3).to_be true

    it "returns true if subject has more than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_at_most: 4).to_be true

    it "returns false if subject has less than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_at_most: 2).to_be false

  describe ".to_have_more_than()", ->
    it "returns true if subject has more than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_more_than: 2).to_be true

    it "returns false if subject has exactly N values", ->
      expect(Matchers.match [1, 2, 3], to_have_more_than: 3).to_be false

    it "returns false if subject has less than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_more_than: 4).to_be false

  describe ".to_have_less_than()", ->
    it "returns true if subject has less than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_less_than: 4).to_be true

    it "returns false if subject has exactly N values", ->
      expect(Matchers.match [1, 2, 3], to_have_less_than: 3).to_be false

    it "returns false if subject has more than N values", ->
      expect(Matchers.match [1, 2, 3], to_have_less_than: 2).to_be false

  describe ".to_have_between()", ->
    # TODO: specify.

  describe ".to_have()", ->
    # TODO: specify.

  describe ".to_have_one()", ->
    # TODO: specify.

  describe ".to_have_many()", ->
    # TODO: specify.

  describe ".to_match()", ->
    it "returns true of subject matches reg exp", ->
      expect(Matchers.match "Hello World!", to_match: /ello/).to_be true

    it "returns false of subject doesn't match reg exp", ->
      expect(Matchers.match "Hello World!", to_match: /elo/).to_be false

  describe ".to_respond_to()", ->
    car = drive: -> "Bruuuum..."
    it "returns true if subject repsonds to the method", ->
      expect(Matchers.match car, to_respond_to: 'drive').to_be true

    it "returns false if subject does not repsond to the method", ->
      expect(Matchers.match car, to_respond_to: 'fly').to_be false

  describe ".to_throw()", ->
    it "returns true if subject is a block and throws when executing it", ->
      expect(Matchers.match (-> throw "Exception to test to_throw() matcher"), to_throw: null).to_be true

    it "returns false if subject is a block but doesn't throw when executing it", ->
      expect(Matchers.match (-> "no exception here, just a string"), to_throw: null).to_be false
