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

describe "Milk.Collection", ->

  describe "each(iterator, [context])", ->
    it "iterates over all objects in a collection", ->
      squared = []
      [1, 2, 3].each (number) -> squared.add number * number
      expect(squared).to_equal [1, 4, 9]

  describe "collect(iterator, [context])", ->
    it "returns all objects after applying iterator on them", ->
      expect([1, 2, 3].collect (number) -> number * number).to_equal [1, 4, 9]

  describe "select(iterator, [context])", ->
    it "returns all objects for which the iterator returns true", ->
      expect([1, 2, 3, 4, 5].select (number) -> number == 3).to_equal [3]

  describe "reject(iterator, [context])", ->
    it "returns all objects for which the iterator returns false", ->
      expect([1, 2, 3, 4, 5].reject (number) -> number == 3).to_equal [1, 2, 4, 5]

  describe "detect(iterator, [context])", ->
    it "returns the first object for which the iterator returns true", ->
      expect([1, 2, 3, 4, 5].detect (number) -> number == 3).to_be 3

  describe "all(iterator, [context])", ->
    it "returns true if iterator returns true for all objects", ->
      expect([1, 2, 3].all (number) -> true).to_be true

    it "returns false if iterator returns false for at least one object", ->
      expect([1, 2, 3].all (number) -> if number == 3 then false else true).to_be false

  describe "any(iterator, [context])", ->
    it "returns true if iterator returns true for at least one object", ->
      expect([1, 2, 3].any (number) -> if number == 2 then true else false).to_be true

    it "returns false if iterator returns false for all objects", ->
      expect([1, 2, 3].any (number) -> false).to_be false

  describe "max()", ->
    it "returns the max value", ->
      expect([1, 3, 2, 4, 1].max()).to_be 4

    it "returns null if empty", ->
      expect([].max()).to_be null

  describe "min()", ->
    it "returns the min value", ->
      expect([1, 3, 2, -1, 1].min()).to_be -1

    it "returns null if empty", ->
      expect([].min()).to_be null

  describe "partition(iterator, [context])", ->
    it "returns a hash containing a partition where the the results of the iterator are used as keys", ->
      partition = [0, 1, 2, 3, 4, 5].partition (value) -> if value % 2 == 0 then "even" else "odd"
      expect(partition["odd"]).to_equal [1, 3, 5]
      expect(partition["even"]).to_equal [0, 2, 4]

  describe "inject(initial, iterator)", ->
    it "Forwards to native reduce()", ->
      expect(true).to_be true

  describe "sort_by(compare, [context])", ->
    it "TODO: Implement this.", ->
      expect(true).to_be true

  describe "contains(value)", ->
    it "TODO: Implement this.", ->
      expect(true).to_be true

  describe "invoke(method, params...)", ->
    it "collects the results after invoking method on every item", ->
      expect([1, 2, 3].invoke('toFixed')).to_equal ['1', '2', '3']

    it "also forwards arguments", ->
      expect([1, 2, 3].invoke('toFixed', 2)).to_equal ['1.00', '2.00', '3.00']

  describe "pluck(key)", ->
    it "returns an array collecting the values for the given key", ->
      people = [{name: "Peter", age: 59}, {name: "Esther", age: 45}, {name: "Heinerle", age: 4}]
      expect(people.pluck 'name').to_equal ["Peter", "Esther", "Heinerle"]

  describe "values()", ->
    it "returns an array containing the values of a Collection", ->
      expect([1, 2, 3].values()).to_equal [1, 2, 3]

    it "returns an empty array if the collection is empty", ->
      expect([].values()).to_equal []

  describe "size()", ->
    it "TODO: Implement this.", ->
      expect(true).to_be true

  describe "empty()", ->
    it "TODO: Implement this.", ->
      expect(true).to_be true
