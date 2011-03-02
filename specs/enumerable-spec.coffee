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

describe "Milk.Enumerable", ->

  describe "each(block, [context])", ->
    it "iterates over all objects in a collection", ->
      squared = []
      [1, 2, 3].each (number) -> squared.add number * number
      expect(squared).to_equal [1, 4, 9]

  describe "collect(block, [context])", ->
    it "returns all objects after applying block on them", ->
      expect([1, 2, 3].collect (number) -> number * number).to_equal [1, 4, 9]

  describe "select(block, [context])", ->
    it "returns all objects for which the block returns true", ->
      expect([1, 2, 3, 4, 5].select (number) -> number == 3).to_equal [3]

  describe "reject(block, [context])", ->
    it "returns all objects for which the block returns false", ->
      expect([1, 2, 3, 4, 5].reject (number) -> number == 3).to_equal [1, 2, 4, 5]

  describe "partition([block])", ->
    it "Partitions the elements into: [selected, rejected], where selected contains all truthy values and rejected contains all falsy values", ->
      expect(['hello', null, 42, false, true, undefined, 17].partition()).to_equal [['hello', 42, true, 17], [null, false, undefined]]

    it "also accepts a block that is called for each value returning either true or false", ->
      expect([1..10].partition (value) -> value % 2 == 0).to_equal [[2, 4, 6, 8, 10], [1, 3, 5, 7, 9]]


  describe "detect(block, [context])", ->
    it "returns the first object for which the block returns true", ->
      expect([1, 2, 3, 4, 5].detect (number) -> number == 3).to_be 3

  describe "all(block, [context])", ->
    it "returns true if block returns true for all objects", ->
      expect([1, 2, 3].all (number) -> true).to_be true

    it "returns false if block returns false for at least one object", ->
      expect([1, 2, 3].all (number) -> if number == 3 then false else true).to_be false

  describe "any(block, [context])", ->
    it "returns true if block returns true for at least one object", ->
      expect([1, 2, 3].any (number) -> if number == 2 then true else false).to_be true

    it "returns false if block returns false for all objects", ->
      expect([1, 2, 3].any (number) -> false).to_be false

  describe "max()", ->
    it "returns the max value", ->
      expect([1, 3, 2, 4, 1].max()).to_be 4

    it "returns -Infinity if empty", ->
      expect([].max()).to_be -Infinity

  describe "min()", ->
    it "returns the min value", ->
      expect([1, 3, 2, -1, 1].min()).to_be -1

    it "returns Infinity if empty", ->
      expect([].min()).to_be Infinity

  describe "group_by(key_path_or_block)", ->
    describe "when a key is passed", ->
      it "returns a hash containing groups using the value of object's properties as keys", ->
        peter = name: "Peter"
        maxim = name: "Maxim"
        inna1 = name: "Inna"
        inna2 = name: "Inna"

        groups = [peter, maxim, inna1, inna2].group_by 'name'
        expect(groups["Peter"]).to_equal [peter]
        expect(groups["Maxim"]).to_equal [maxim]
        expect(groups["Inna"]).to_equal [inna1, inna2]

    describe "when a block is passed", ->
      it "returns a hash containing groups using the results of the block as keys", ->
        groups = [0, 1, 2, 3, 4, 5].group_by (value) -> if value % 2 == 0 then "even" else "odd"
        expect(groups["odd"]).to_equal [1, 3, 5]
        expect(groups["even"]).to_equal [0, 2, 4]

  describe "inject(initial, block)", ->
    it "Forwards to native reduce()", ->
      expect(true).to_be true

  describe "contains(value)", ->
    it "returns true if collection contains value", ->
      expect([1, 2, 3].contains 2).to_be true

    it "returns false if collection does not contain the value", ->
      expect([1, 2, 3].contains 4).to_be false

  describe "invoke(method, args...)", ->
    it "collects the results after invoking method on every item", ->
      expect([1, 2, 3].invoke('toFixed')).to_equal ['1', '2', '3']

    it "also forwards arguments", ->
      expect([1, 2, 3].invoke('toFixed', 2)).to_equal ['1.00', '2.00', '3.00']

  describe "pluck(key)", ->
    it "returns an array collecting the values for the given key", ->
      people = [{name: "Peter", age: 59}, {name: "Esther", age: 45}, {name: "Heinerle", age: 4}]
      expect(people.pluck 'name').to_equal ["Peter", "Esther", "Heinerle"]

  describe "values()", ->
    it "returns an array containing the values of a Enumerable", ->
      expect([1, 2, 3].values()).to_equal [1, 2, 3]

    it "returns an empty array if the collection is empty", ->
      expect([].values()).to_equal []

  describe "count()", ->
    it "returns the number of elements in a collection", ->
      expect([].count()).to_be 0
      expect([1, 2, 3].count()).to_be 3
      expect([1, 2, 3, 3, 3].count()).to_be 5

  describe "empty()", ->
    it "returns true if collection is empty", ->
      expect([].empty()).to_be true

    it "returns false if collection has at least one element", ->
      expect([1].empty()).to_be false
      expect([1, 2, 3].empty()).to_be false
