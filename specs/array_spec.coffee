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

describe 'Array, extended by Milk', ->

  describe 'first([count])', ->

    it "returns the first element if |count| is not given", ->
      expect([1, 2, 3].first()).to_be 1
      expect([].first()).to_be undefined

    it "returns a new array containing the first N elements if |count| = N is given", ->
      expect([1, 2, 3].first 0).to_equal []
      expect([1, 2, 3].first 1).to_equal [1]
      expect([1, 2, 3].first 2).to_equal [1, 2]
      expect([1, 2, 3].first 3).to_equal [1, 2, 3]
      expect([1, 2, 3].first 10).to_equal [1, 2, 3]

  describe 'rest(index = 1)', ->

    it "returns a new array containing all but the first element if |index| is not given", ->
      expect([1, 2, 3].rest()).to_equal [2, 3]

    it "returns a new array containing all elements starting at the specified |index|", ->
      expect([1, 2, 3].rest 0).to_equal [1, 2, 3]
      expect([1, 2, 3].rest 2).to_equal [3]
      expect([1, 2, 3].rest 3).to_equal []
      expect([1, 2, 3].rest 10).to_equal []

  describe 'last([count])', ->

    it "returns the last element if |count| is not given", ->
      expect([1, 2, 3].last()).to_be 3
      expect([].last()).to_be undefined

    it "returns a new array containing the last N elements if |count| = N is given", ->
      expect([1, 2, 3].last 0).to_equal []
      expect([1, 2, 3].last 1).to_equal [3]
      expect([1, 2, 3].last 2).to_equal [2, 3]
      expect([1, 2, 3].last 3).to_equal [1, 2, 3]
      expect([1, 2, 3].last 10).to_equal [1, 2, 3]

  describe 'compact()', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.compact()).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'removes all null values', ->
      expect([null, 1, null, 2, null, 3, null].compact()).to_equal [1, 2, 3]

    it 'removes all undefined values', ->
      expect([undefined, 1, undefined, 2, undefined, 3, undefined].compact()).to_equal [1, 2, 3]

  describe 'flatten()', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.flatten()).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'flattens an array', ->
      expect([1, [2], [3, [[[4]]]]].flatten()).to_equal [1, 2, 3, 4]

  describe 'with(values...)', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.with 4).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'adds one value to the end', ->
      expect([1, 2, 3].with 4).to_equal [1, 2, 3, 4]

    it 'adds many values to the end', ->
      expect([1, 2, 3].with 4, 5, 6).to_equal [1, 2, 3, 4, 5, 6]

    it 'adds nothing to the end if no value is given', ->
      expect([1, 2, 3].with()).to_equal [1, 2, 3]

  describe 'with_many(collections...)', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.with_many [4]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'adds all values from one collection to the end', ->
      expect([1, 2, 3].with_many [4, 5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it 'adds all values from many collections to the end', ->
      expect([1, 2, 3].with_many [4], [5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it 'adds nothing to the end if no collection is given', ->
      expect([1, 2, 3].with_many()).to_equal [1, 2, 3]

  describe 'without(values...)', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.without 3).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'removes all occurences of one value', ->
      expect([1, 2, 3, 2].without 2).to_equal [1, 3]

    it 'removes all occurences of many values', ->
      expect([1, 2, 3, 2].without 1, 2, 3).to_equal []

    it 'removes nothing if the value is not in the array', ->
      expect([1, 2, 3].without 4).to_equal [1, 2, 3]

    it 'removes nothing if no value is given', ->
      expect([1, 2, 3].without()).to_equal [1, 2, 3]

  describe 'without_many(collections...)', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.without_many [3]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'removes all occurences of all values from one collection', ->
      expect([1, 2, 3, 2].without_many [2, 3]).to_equal [1]

    it 'removes all occurences of all values from many collections', ->
      expect([1, 2, 3, 3].without_many [2], [3]).to_equal [1]

    it 'removes nothing if no value from the collection is not in the array', ->
      expect([1, 2, 3].without_many [4, 5]).to_equal [1, 2, 3]

    it 'removes nothing if no collection is given', ->
      expect([1, 2, 3].without_many()).to_equal [1, 2, 3]

  describe 'unique()', ->
    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3, 3]
      expect(array.unique()).not.to_be array
      expect(array).to_equal [1, 2, 3, 3]

    it 'removes all duplicates in an array', ->
      expect([1, 1, 1, 2, 2, 2, 3, 3, 3].unique()).to_equal [1, 2, 3]

  xdescribe 'intersect(arrays...)'

  describe 'unite(arrays...)', ->

    it 'returns a new array without modifying the receiver', ->
      array = [1, 2, 3]
      expect(array.unite [4, 5]).not.to_be array
      expect(array).to_equal [1, 2, 3]

    it 'appends one array', ->
      expect([1, 2, 3].unite [4, 5, 6]).to_equal [1, 2, 3, 4, 5, 6]

    it 'appends multiple arrays', ->
      expect([1, 2, 3].unite [4], [5], [6]).to_equal [1, 2, 3, 4, 5, 6]

    it 'removes duplicates after uniting all arrays', ->
      expect([1, 1, 2, 2, 3, 3].unite [4, 4], [5, 5, 6, 6]).to_equal [1, 2, 3, 4, 5, 6]

  xdescribe 'zip(arrays...)'

  describe 'index_of(value)', ->

    it 'returns the index of value', ->
      expect([1, 2, 3].index_of 2).to_be 1

    it 'returns the first found index of value if the value is contained more than once in the array', ->
      expect([1, 2, 3, 2].index_of 2).to_be 1

    it 'returns -1 if the value is not contained in the array', ->
      expect([1, 2, 3].index_of 4).to_be -1

  describe 'last_index_of(value)', ->
    it 'returns the index of value', ->
      expect([1, 2, 3].last_index_of 2).to_be 1

    it 'returns the last found index of value if the value is contained more than once in the array', ->
      expect([1, 2, 3, 2].last_index_of 2).to_be 3

    it 'returns -1 if the value is not contained in the array', ->
      expect([1, 2, 3].last_index_of 4).to_be -1

  describe 'add(values...)', ->
    it 'adds one value to the end', ->
      array = [1, 2, 3]
      array.add 4
      expect(array).to_equal [1, 2, 3, 4]

    it 'adds many values to the end', ->
      array = [1, 2, 3]
      array.add 4, 5, 6
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it 'adds nothing to the end if no value is given', ->
      array = [1, 2, 3]
      array.add()
      expect(array).to_equal [1, 2, 3]

  describe 'add_many(collections...)', ->
    it 'adds all values from one collection to the end', ->
      array = [1, 2, 3]
      array.add_many [4, 5, 6]
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it 'adds all values from many collections to the end', ->
      array = [1, 2, 3]
      array.add_many [4], [5, 6]
      expect(array).to_equal [1, 2, 3, 4, 5, 6]

    it 'adds nothing to the end if no collection is given', ->
      array = [1, 2, 3]
      array.add_many()
      expect(array).to_equal [1, 2, 3]

  xdescribe 'insert_at(index, values...)'
  xdescribe 'insert_many_at(index, collections...)'

  xdescribe 'remove(values...)'
  xdescribe 'remove_many(collections...)'
  xdescribe 'remove_at(index)'

  xdescribe 'replace(value, replacement)'
  xdescribe 'replace_many(values, replacements)'
  xdescribe 'replace_at(index, replacements...)'

  xdescribe 'clone()'
  xdescribe 'equals(array)'
