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
ArrayExtensions = requires 'Milk.Extensions.ArrayExtensions'

describe "Milk.Extensions.ArrayExtensions", ->

  describe "#first()", ->
    it "returns the first element if |count| is not given", ->
      expect([1, 2, 3].first()).to_be 1
      expect([].first()).to_be undefined

    it "returns a new array containing the first N elements if |count| = N is given", ->
      expect([1, 2, 3].first 0).to_equal []
      expect([1, 2, 3].first 1).to_equal [1]
      expect([1, 2, 3].first 2).to_equal [1, 2]
      expect([1, 2, 3].first 3).to_equal [1, 2, 3]
      expect([1, 2, 3].first 10).to_equal [1, 2, 3]

  describe "#second()", ->
    it "returns the second element", ->
      expect([1, 2, 3].second()).to_be 2

  describe "#third()", ->
    it "returns the third element", ->
      expect([1, 2, 3].third()).to_be 3

  describe "#rest()", ->
    it "returns a new array containing all except the first element", ->
      expect([1, 2, 3].rest()).to_equal [2, 3]

  describe "#last()", ->
    it "returns the last element if |count| is not given", ->
      expect([1, 2, 3].last()).to_be 3
      expect([].last()).to_be undefined

    it "returns a new array containing the last N elements if |count| = N is given", ->
      expect([1, 2, 3].last 0).to_equal []
      expect([1, 2, 3].last 1).to_equal [3]
      expect([1, 2, 3].last 2).to_equal [2, 3]
      expect([1, 2, 3].last 3).to_equal [1, 2, 3]
      expect([1, 2, 3].last 10).to_equal [1, 2, 3]

  describe "#compacted()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.compacted()).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "removes all null values", ->
      expect([null, 1, null, 2, null, 3, null].compacted()).to_equal [1, 2, 3]

    it "removes all undefined values", ->
      expect([undefined, 1, undefined, 2, undefined, 3, undefined].compacted()).to_equal [1, 2, 3]

  describe "#flattened()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.flattened()).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "flattens an array", ->
      expect([1, [2], [3, [[[4]]]]].flattened()).to_equal [1, 2, 3, 4]

  describe "#reversed()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.reversed()).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "reverses the order of the values", ->
      array = [1, 2, 3]
      expect(array.reversed()).to_equal [3, 2, 1]

  describe "#with()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.with 4).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "adds one value to the end", ->
      expect([1, 2, 3].with 4).to_equal [1, 2, 3, 4]

    it "adds many values to the end", ->
      expect([1, 2, 3].with 4, 5, 6).to_equal [1, 2, 3, 4, 5, 6]

    it "adds nothing to the end if no value is given", ->
      expect([1, 2, 3].with()).to_equal [1, 2, 3]

  describe "#with_many()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.with_many [4]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "adds all values from one collection to the end", ->
      expect([1, 2, 3].with_many [4, 5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it "adds all values from many collections to the end", ->
      expect([1, 2, 3].with_many [4], [5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it "adds nothing to the end if no collection is given", ->
      expect([1, 2, 3].with_many()).to_equal [1, 2, 3]

  describe "#without()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.without 3).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "removes all occurences of one value", ->
      expect([1, 2, 3, 2].without 2).to_equal [1, 3]

    it "removes all occurences of many values", ->
      expect([1, 2, 3, 2].without 1, 2, 3).to_equal []

    it "removes nothing if the value is not in the array", ->
      expect([1, 2, 3].without 4).to_equal [1, 2, 3]

    it "removes nothing if no value is given", ->
      expect([1, 2, 3].without()).to_equal [1, 2, 3]

  describe "#without_many()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.without_many [3]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "removes all occurences of all values from one collection", ->
      expect([1, 2, 3, 2].without_many [2, 3]).to_equal [1]

    it "removes all occurences of all values from many collections", ->
      expect([1, 2, 3, 3].without_many [2], [3]).to_equal [1]

    it "removes nothing if no value from the collection is not in the array", ->
      expect([1, 2, 3].without_many [4, 5]).to_equal [1, 2, 3]

    it "removes nothing if no collection is given", ->
      expect([1, 2, 3].without_many()).to_equal [1, 2, 3]

  describe "#without_at()", ->
    it "removes value at specified index", ->
      expect([1, 2, 3].remove_at 1).to_equal [1, 3]

    it "removes values at specified indexes", ->
      expect([1, 2, 3, 4, 5].remove_at 1, 2, 3).to_equal [1, 5]

    it "removes values at specified indexes even if indexes are given unsorted", ->
      expect([1, 2, 3, 4, 5].remove_at 2, 1, 3).to_equal [1, 5]

  describe "#unique()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3, 3]
      expect(array.unique()).not.to_be array
      expect(array).to_equal [1, 2, 3, 3]

    it "removes all duplicates in an array", ->
      expect([1, 1, 1, 2, 2, 2, 3, 3, 3].unique()).to_equal [1, 2, 3]

  describe "#intersect()", ->
    it "returns the intersection between the receiver and an array", ->
      expect([0, 1, 2, 3, 4, 5].intersect([1, 2, 3, 6])).to_equal [1, 2, 3]

    it "returns the intersection between the receiver and many arrays", ->
      expect([0, 1, 2, 3, 4, 5].intersect([1, 2, 3, 6], [1, 2, 4], [1])).to_equal [1]

    it "removes duplicates", ->
      expect([1, 2, 2, 3, 3, 3].intersect([1, 2, 3])).to_equal [1, 2, 3]

  describe "#unite()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.unite [4, 5]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "appends one array", ->
      expect([1, 2, 3].unite [4, 5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it "appends multiple arrays", ->
      expect([1, 2, 3].unite [4], [5], [6]).to_equal [1, 2, 3, 4, 5, 6]

    it "removes duplicates after uniting all arrays", ->
      expect([1, 1, 2, 2, 3, 3].unite [4, 4], [5, 5, 6, 6]).to_equal [1, 2, 3, 4, 5, 6]

  describe "#zip()", ->
    it "zips receiver with an array of the same length", ->
      expect([1, 2, 3].zip ['one', 'two', 'three']).to_equal [[1, 'one'], [2, 'two'], [3, 'three']]

    it "zips receiver with many arrays of the same length", ->
      expect([1, 2, 3].zip ['one', 'two', 'three'], ['uno', 'due', 'tres']).to_equal [[1, 'one', 'uno'], [2, 'two', 'due'], [3, 'three', 'tres']]

    it "fills up with undefined if arrays are of different length", ->
      expect([1, 2, 3].zip ['one', 'two'], ['uno']).to_equal [[1, 'one', 'uno'], [2, 'two', undefined], [3, undefined, undefined]]

  describe "#index_of()", ->
    it "returns the index of value", ->
      expect([1, 2, 3].index_of 2).to_be 1

    it "returns the first found index of value if the value is contained more than once in the array", ->
      expect([1, 2, 3, 2].index_of 2).to_be 1

    it "returns -1 if the value is not contained in the array", ->
      expect([1, 2, 3].index_of 4).to_be -1

  describe "#last_index_of()", ->
    it "returns the index of value", ->
      expect([1, 2, 3].last_index_of 2).to_be 1

    it "returns the last found index of value if the value is contained more than once in the array", ->
      expect([1, 2, 3, 2].last_index_of 2).to_be 3

    it "returns -1 if the value is not contained in the array", ->
      expect([1, 2, 3].last_index_of 4).to_be -1

  describe "#indexes_of()", ->
    it "returns all indexes of a value", ->
      expect([1, 2, 3, 2, 4].indexes_of 2).to_equal [1, 3]

    it "returns empty array if the value is not contained in the array", ->
      expect([1, 2, 3].indexes_of 4).to_equal []

  describe "#add()", ->
    it "adds one value to the end", ->
      array = [1, 2, 3]
      array.add 4
      expect(array).to_equal [1, 2, 3, 4]

    it "adds many values to the end", ->
      array = [1, 2, 3]
      array.add 4, 5, 6
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it "adds nothing to the end if no value is given", ->
      array = [1, 2, 3]
      array.add()
      expect(array).to_equal [1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.add 4).to_be array

  describe "#add_many()", ->
    it "adds all values from one collection to the end", ->
      array = [1, 2, 3]
      array.add_many [4, 5, 6]
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it "adds all values from many collections to the end", ->
      array = [1, 2, 3]
      array.add_many [4], [5, 6]
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it "adds nothing to the end if no collection is given", ->
      array = [1, 2, 3]
      array.add_many()
      expect(array).to_equal [1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.add_many [4]).to_be array

  describe "#insert()", ->
    it "inserts the value at a specified index", ->
      array = [1, 2, 4]
      array.insert 3, at: 2
      expect(array).to_equal [1, 2, 3, 4]

    it "inserts the value at the beginning if optional parameter at is not given", ->
      array = [1, 2, 3]
      array.insert 0, 0
      expect(array).to_equal [0, 1, 2, 3]

    it "inserts the value before the first occurence of a specific value", ->
      array = [1, 2, 4, 5, 4, 3, 2, 1]
      array.insert 3, before: 4
      expect(array).to_equal [1, 2, 3, 4, 5, 4, 3, 2, 1]

    it "inserts the value after the last occurence of a specific value", ->
      array = [1, 2, 3, 4, 5, 4, 2, 1]
      array.insert 3, after: 4
      expect(array).to_equal [1, 2, 3, 4, 5, 4, 3, 2, 1]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.insert 4, at: 0).to_be array

  describe "#insert_many()", ->
    it "inserts the collection at a specified index", ->
      array = [1, 2, 5]
      array.insert_many [3, 4], at: 2
      expect(array).to_equal [1, 2, 3, 4, 5]

    it "inserts the collection at the beginning if optional parameter at is not given", ->
      array = [1, 2, 3]
      array.insert_many [0]
      expect(array).to_equal [0, 1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.insert_many [4], at: 0).to_be array

  describe "#remove()", ->
    it "removes all occurences of one value", ->
      array = [1, 2, 3, 2]
      array.remove 2
      expect(array).to_equal [1, 3]

    it "removes all occurences of many values", ->
      array = [1, 2, 3, 2]
      array.remove 1, 2, 3
      expect(array).to_equal []

    it "removes nothing if the value is not in the array", ->
      array = [1, 2, 3]
      array.remove 4
      expect(array).to_equal [1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.remove 3).to_be array

  describe "#remove_many()", ->
    it "removes all occurences of all values from one collection", ->
      array = [1, 2, 3, 2]
      array.remove_many [2, 3]
      expect(array).to_equal [1]

    it "removes all occurences of all values from many collections", ->
      array = [1, 2, 3, 3]
      array.remove_many [2], [3]
      expect(array).to_equal [1]

    it "removes nothing if no value from the collection is not in the array", ->
      array = [1, 2, 3]
      array.remove_many [4, 5]
      expect(array).to_equal [1, 2, 3]

    it "removes nothing if collection is empty", ->
      array = [1, 2, 3]
      array.remove_many([])
      expect(array).to_equal [1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.remove_many [3]).to_be array

  describe "#remove_at()", ->
    it "removes value at specified index", ->
      array = [1, 2, 3]
      array.remove_at 1
      expect(array).to_equal [1, 3]

    it "removes values at specified indexes", ->
      array = [1, 2, 3, 4, 5]
      array.remove_at 1, 2, 3
      expect(array).to_equal [1, 5]

    it "removes values at specified indexes even if indexes are given unsorted", ->
      array = [1, 2, 3, 4, 5]
      array.remove_at 2, 1, 3
      expect(array).to_equal [1, 5]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.remove_at 0).to_be array

  describe "#replace()", ->
    it "replaces value with value", ->
      array = [1, 4, 3]
      array.replace 4, with: 2
      expect(array).to_equal [1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.replace 1, with: 5).to_be array

  describe "#replace_at()", ->
    it "replaces value at index with value", ->
      array = [1, 4, 3]
      array.replace_at 1, with: 2
      expect(array).to_equal [1, 2, 3]

    it "replaces value at index with many values", ->
      array = [1, 4, 4]
      array.replace_at 1, with_many: [2, 3]
      expect(array).to_equal [1, 2, 3, 4]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.replace_at 0, with: 5).to_be array

  describe "#sort_by()", ->
    peter = name: "Peter", age: 23
    maxim = name: "Maxim", age: 40
    jessi = name: "Jessi", age: 54
    kevin = name: "Kevin", age: 33
    inna1 = name: "Inna", age: 36
    inna2 = name: "Inna", age: 33

    people = null

    before_each ->
      people = [peter, maxim, jessi, kevin, inna1, inna2]

    after_each ->
      people = null

    it "sorts by one property name", ->
      people.sort_by 'name'
      expect(people).to_equal [inna1, inna2, jessi, kevin, maxim, peter]

    it "sorts by many property names", ->
      people.sort_by 'name', 'age'
      expect(people).to_equal [inna2, inna1, jessi, kevin, maxim, peter]

    it "returns the receiver", ->
      expect(people.sort_by 'name').to_be people

  describe "#clone()", ->
    it "clones an array", ->
      array = [1, 2, 3]
      clone = array.clone()
      expect(clone).not.to_be array
      expect(clone).to_equal array

  describe "#equals()", ->
    it "returns true for an array with the same values", ->
      expect([1, 2, 3].equals [1, 2, 3]).to_be true

    it "returns false for an array with the same values but in a different order", ->
      expect([1, 2, 3].equals [1, 3, 2]).to_be false

    it "returns false when passing something else than an array (for example an object)", ->
      expect([1, 2, 3].equals {}).to_be false
