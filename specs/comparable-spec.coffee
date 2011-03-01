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
  class Person
    @mixin Milk.Comparable
    name: ''
    constructor: (@name) ->
    compare_to: (value) ->
      return +1 if @name > value
      return -1 if @name < value
      return 0

  person = null

  create_person = -> person = new Person("Peter")
  destroy_person = -> person = null

  describe "properties", ->
    describe "is_comparable", ->
      before_each create_person
      after_each destroy_person

      it "returns yes if object mixes Comparable in", ->
        expect(person).to_be_defined()
        expect(Milk.Comparable).to_be_defined()
        expect(person.is_comparable).to_be true

  describe "methods", ->
    describe "is_less_than(value)", ->
      # TODO: specify.

    describe "is_less_than_or_equal_to(value)", ->
      # TODO: specify.

    describe "is_greater_than(value)", ->
      # TODO: specify.

    describe "is_greater_than_or_equal_to(value)", ->
      # TODO: specify.

    describe "is_between(lower, upper, [options = {}])", ->
      # TODO: specify.

    describe "equals(value)", ->
      # TODO: specify.
