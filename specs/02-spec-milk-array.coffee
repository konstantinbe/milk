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

describe "Array", ->

  describe "#each()", ->
    it "iterates over all objects in a collection", ->
      squared = []
      [1, 2, 3].each (number) -> squared.add number * number
      expect(squared).to_equal [1, 4, 9]

  describe "#collect()", ->
    it "returns all objects after applying block on them", ->
      expect([1, 2, 3].collect (number) -> number * number).to_equal [1, 4, 9]

  describe "#select()", ->
    it "returns all objects for which the block returns true", ->
      expect([1, 2, 3, 4, 5].select (number) -> number == 3).to_equal [3]

  describe "#reject()", ->
    it "returns all objects for which the block returns false", ->
      expect([1, 2, 3, 4, 5].reject (number) -> number == 3).to_equal [1, 2, 4, 5]

  describe "#partition()", ->
    it "partitions the elements into: [selected, rejected], where selected contains all truthy values and rejected contains all falsy values", ->
      expect(['hello', null, 42, false, true, undefined, 17].partition()).to_equal [['hello', 42, true, 17], [null, false, undefined]]

    it "also accepts a block that is called for each value returning either true or false", ->
      expect([1..10].partition (value) -> value % 2 == 0).to_equal [[2, 4, 6, 8, 10], [1, 3, 5, 7, 9]]

  describe "#detect()", ->
    it "returns the first object for which the block returns true", ->
      expect([1, 2, 3, 4, 5].detect (number) -> number == 3).to_be 3

  describe "#all()", ->
    it "returns true if block returns true for all objects", ->
      expect([1, 2, 3].all (number) -> true).to_be true

    it "returns false if block returns false for at least one object", ->
      expect([1, 2, 3].all (number) -> if number == 3 then false else true).to_be false

  describe "#any()", ->
    it "returns true if block returns true for at least one object", ->
      expect([1, 2, 3].any (number) -> if number == 2 then true else false).to_be true

    it "returns false if block returns false for all objects", ->
      expect([1, 2, 3].any (number) -> false).to_be false

  describe "#max()", ->
    it "returns the max value", ->
      expect([1, 3, 2, 4, 1].max()).to_be 4

    it "returns null if empty", ->
      expect([].max()).to_be null

  describe "#min()", ->
    it "returns the min value", ->
      expect([1, 3, 2, -1, 1].min()).to_be -1

    it "returns null if empty", ->
      expect([].min()).to_be null

  xdescribe "#group_by()", ->
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

    describe "#inject()", ->
      # TODO: specify.

    describe "#contains()", ->
      it "returns true if collection contains value", ->
        expect([1, 2, 3].contains 2).to_be true

      it "returns false if collection does not contain the value", ->
        expect([1, 2, 3].contains 4).to_be false

    describe "#pluck()", ->
      it "returns an array collecting the values for the given key", ->
        people = [{name: "_peter", age: 59}, {name: "_esther", age: 45}, {name: "_heinerle", age: 4}]
        expect(people.pluck 'name').to_equal ["_peter", "_esther", "_heinerle"]

    describe "#count()", ->
      it "returns the number of elements in a collection", ->
        expect([].count()).to_be 0
        expect([1, 2, 3].count()).to_be 3
        expect([1, 2, 3, 3, 3].count()).to_be 5

    describe "#is_empty()", ->
      it "returns true if collection is empty", ->
        expect([].is_empty()).to_be true

      it "returns false if collection has at least one element", ->
        expect([1].is_empty()).to_be false
        expect([1, 2, 3].is_empty()).to_be false

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

    it "removes all null objects", ->
      expect([null, 1, null, 2, null, 3, null].compacted()).to_equal [1, 2, 3]

    it "removes all undefined objects", ->
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

    it "reverses the order of the objects", ->
      array = [1, 2, 3]
      expect(array.reversed()).to_equal [3, 2, 1]

  describe "#with()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.with 4).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "adds one object to the end", ->
      expect([1, 2, 3].with 4).to_equal [1, 2, 3, 4]

  describe "#with_many()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.with_many [4]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "appends all objects", ->
      expect([1, 2, 3].with_many [4, 5, 6]).to_equal [1, 2, 3, 4, 5, 6]

  describe "#without()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.without 3).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "removes first occurences of one object", ->
      expect([1, 2, 3, 2].without 2).to_equal [1, 3, 2]

    it "removes nothing if object is not in array", ->
      expect([1, 2, 3].without 4).to_equal [1, 2, 3]

  describe "#without_many()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.without_many [3]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "removes first occurences of passed in objects", ->
      expect([1, 2, 3, 2].without_many [2, 3]).to_equal [1, 2]

    it "doesn't remove an object if it is not in the array", ->
      expect([1, 2, 3].without_many [4, 5]).to_equal [1, 2, 3]

  describe "#without_at()", ->
    it "removes object at specified index", ->
      expect([1, 2, 3].remove_at 1).to_equal [1, 3]

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

    it "removes duplicates", ->
      expect([1, 2, 2, 3, 3, 3].intersect([1, 2, 3])).to_equal [1, 2, 3]

  describe "#unite()", ->
    it "returns a new array without modifying the receiver", ->
      array = [1, 2, 3]
      expect(array.unite [4, 5]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it "appends one array", ->
      expect([1, 2, 3].unite [4, 5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it "removes duplicates after uniting all arrays", ->
      expect([1, 1, 2, 2, 3, 3].unite [4, 4, 5, 5, 6, 6]).to_equal [1, 2, 3, 4, 5, 6]

  describe "#zip()", ->
    it "zips receiver with an array of the same length", ->
      expect([1, 2, 3].zip ['one', 'two', 'three']).to_equal [[1, 'one'], [2, 'two'], [3, 'three']]

    it "zips receiver with many arrays of the same length", ->
      expect([1, 2, 3].zip ['one', 'two', 'three'], ['uno', 'due', 'tres']).to_equal [[1, 'one', 'uno'], [2, 'two', 'due'], [3, 'three', 'tres']]

    it "fills up with undefined if arrays are of different length", ->
      expect([1, 2, 3].zip ['one', 'two'], ['uno']).to_equal [[1, 'one', 'uno'], [2, 'two', undefined], [3, undefined, undefined]]

  describe "#index_of()", ->
    it "returns the index of object", ->
      expect([1, 2, 3].index_of 2).to_be 1

    it "returns the first found index of object if the object is contained more than once in the array", ->
      expect([1, 2, 3, 2].index_of 2).to_be 1

    it "returns -1 if the object is not contained in the array", ->
      expect([1, 2, 3].index_of 4).to_be -1

  describe "#last_index_of()", ->
    it "returns the index of object", ->
      expect([1, 2, 3].last_index_of 2).to_be 1

    it "returns the last found index of object if the object is contained more than once in the array", ->
      expect([1, 2, 3, 2].last_index_of 2).to_be 3

    it "returns -1 if the object is not contained in the array", ->
      expect([1, 2, 3].last_index_of 4).to_be -1

  describe "#indexes_of()", ->
    it "returns all indexes of a object", ->
      expect([1, 2, 3, 2, 4].indexes_of 2).to_equal [1, 3]

    it "returns empty array if the object is not contained in the array", ->
      expect([1, 2, 3].indexes_of 4).to_equal []

  describe "#add()", ->
    it "appends one object", ->
      array = [1, 2, 3]
      array.add 4
      expect(array).to_equal [1, 2, 3, 4]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.add 4).to_be array

  describe "#add_many()", ->
    it "appends many objects", ->
      array = [1, 2, 3]
      array.add_many [4, 5, 6]
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.add_many [4]).to_be array

  describe "#insert_at()", ->
    it "inserts the object at a specified index", ->
      array = [1, 2, 4]
      array.insert_at 3, 2
      expect(array).to_equal [1, 2, 3, 4]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.insert_at 4, 0).to_be array

  describe "#insert_many_at()", ->
    it "inserts the objects at a specified index", ->
      array = [1, 2, 5]
      array.insert_many_at [3, 4], 2
      expect(array).to_equal [1, 2, 3, 4, 5]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.insert_many_at [4], 0).to_be array

  describe "#insert_before()", ->
    it "inserts the object before the first occurence of a specific object", ->
      array = [1, 2, 4, 5, 4, 3, 2, 1]
      array.insert_before 3, 4
      expect(array).to_equal [1, 2, 3, 4, 5, 4, 3, 2, 1]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.insert_before 0, 1).to_be array

  describe "#insert_many_before()", ->
    it "inserts objects before the first occurence of a specific object", ->
      array = [1, 4, 5, 4, 3, 2, 1]
      array.insert_many_before [2, 3], 4
      expect(array).to_equal [1, 2, 3, 4, 5, 4, 3, 2, 1]

    it "returns the receiver", ->
      array = [1, 4, 5, 4, 3, 2, 1]
      expect(array.insert_many_before [2, 3], 4).to_be array

  describe "#insert_after()", ->
    it "inserts the object after the last occurence of a specific object", ->
      array = [1, 2, 3, 4, 5, 4, 3, 2]
      array.insert_after 1, 2
      expect(array).to_equal [1, 2, 3, 4, 5, 4, 3, 2, 1]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.insert_after [4], 3).to_be array

  describe "#insert_many_after()", ->
    it "inserts the objects before the first occurence of a specific object", ->
      array = [1, 2, 3, 4, 5, 4, 3]
      array.insert_many_after [2, 1], 3
      expect(array).to_equal [1, 2, 3, 4, 5, 4, 3, 2, 1]

    it "returns the receiver", ->
      array = [1, 2, 3, 4, 5, 4, 3]
      expect(array.insert_many_after [2, 1], 3).to_be array

  describe "#remove()", ->
    it "removes first occurence of one object", ->
      array = [1, 2, 3, 2]
      array.remove 2
      expect(array).to_equal [1, 3, 2]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.remove 3).to_be array

  describe "#remove_many()", ->
    it "removes first occurences of objects", ->
      array = [1, 2, 3, 2]
      array.remove_many [2, 3, 2]
      expect(array).to_equal [1]

    it "removes nothing if no object from the collection is not in the array", ->
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
    it "removes object at specified index", ->
      array = [1, 2, 3]
      array.remove_at 1
      expect(array).to_equal [1, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.remove_at 0).to_be array

  describe "#replace_with()", ->
    it "replaces first occurence of object with replacement", ->
      array = [1, 4, 3, 4]
      array.replace_with 4, 2
      expect(array).to_equal [1, 2, 3, 4]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.replace_with 1, 5).to_be array

  describe "#replace_with_many()", ->
    it "replaces first occurence of object with many objects", ->
      array = [1, 4, 3, 4]
      array.replace_with_many 4, [2, 2]
      expect(array).to_equal [1, 2, 2, 3, 4]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.replace_with_many 1, [5, 6]).to_be array

  describe "#replace_at_with()", ->
    it "replaces object at index with object", ->
      array = [1, 4, 3]
      array.replace_at_with 1, 2
      expect(array).to_equal [1, 2, 3]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.replace_at_with 0, 5).to_be array

  describe "#replace_at_with_many()", ->
    it "replaces object at index with many objects", ->
      array = [1, 4, 4]
      array.replace_at_with_many 1, [2, 3]
      expect(array).to_equal [1, 2, 3, 4]

    it "returns the receiver", ->
      array = [1, 2, 3]
      expect(array.replace_at_with 0, 5).to_be array


  describe "#sort_by()", ->
    peter = name: "_peter", age: 23
    maxim = name: "_maxim", age: 40
    jessi = name: "_jessi", age: 54
    kevin = name: "_kevin", age: 33
    inna1 = name: "_inna", age: 36
    inna2 = name: "_inna", age: 33

    people = null

    before ->
      people = [peter, maxim, jessi, kevin, inna1, inna2]

    after ->
      people = null

    it "sorts by one property name", ->
      people.sort_by ['name']
      expect(people).to_equal [inna1, inna2, jessi, kevin, maxim, peter]

    it "sorts by many property names", ->
      people.sort_by ['name', 'age']
      expect(people).to_equal [inna2, inna1, jessi, kevin, maxim, peter]

    it "returns the receiver", ->
      expect(people.sort_by ['name']).to_be people
