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

describe 'Milk.Collection', ->

  describe 'each(iterator, context)', ->
    it 'Forwards to native forEach()', ->
      expect(true).to_be true

  describe 'collect(iterator, context)', ->
    it 'Forwards to native map()', ->
      expect(true).to_be true

  describe 'select(iterator, context)', ->
    it 'Forwards to native filter()', ->
      expect(true).to_be true

  describe 'reject(iterator, context)', ->
    it 'TODO: Describe this.', ->
      expect(true).to_be true

  describe 'detect(iterator, context)', ->
    it 'TODO: Describe this.', ->
      expect(true).to_be true

  describe 'all(iterator, context)', ->
    it 'Forwards to native every()', ->
      expect(true).to_be true

  describe 'any(iterator, context)', ->
    it 'Forwards to native some()', ->
      expect(true).to_be true

  describe 'max()', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'min()', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'partition(iterator, context)', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'inject(initial, iterator)', ->
    it 'Forwards to native reduce()', ->
      expect(true).to_be true

  describe 'sort_by(compare, context)', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'contains(value)', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'invoke(method, params...)', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'pluck(key)', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'values()', ->
    it 'returns an array containing the values of a Collection', ->
      expect([1, 2, 3].values()).to_equal [1, 2, 3]

    it 'returns an empty array if the collection is empty', ->
      expect([].values()).to_equal []

  describe 'size()', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true

  describe 'empty()', ->
    it 'TODO: Implement this.', ->
      expect(true).to_be true
