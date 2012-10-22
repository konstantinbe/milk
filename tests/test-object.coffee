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

describe "Object", ->

  describe "#has_own()", ->
    it "returns true if object has own property", ->
      class Person
      person = new Person()
      person['age'] = 1
      expect(person.has_own 'age').to_be true

    it "returns false if property is not own but somewhere in the prototype chain", ->
      class Person
      Person::age = "1"
      person = new Person()
      expect(person.has_own 'age').to_be false

  describe "#own()", ->
    it "returns the value if object has own property", ->
      class Person
      person = new Person()
      person['age'] = 1
      expect(person.own 'age').to_equal 1

    it "returns undefined if property is not own but somewhere in the prototype chain", ->
      class Person
      Person::age = "1"
      person = new Person()
      expect(person.own 'age').to_be undefined

  describe "#toString()", ->
    it "invokes to_string() if defined", ->
      class Person
        to_string: ->
          "test"
      person = new Person()
      expect(person.toString()).to_equal "test"

  describe "#to_string()", ->
    # without spec, subclassees implement this
