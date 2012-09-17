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
  describe "#class()", ->
    person_class = class Person
    person = new Person()

    it "returns the class object", ->
      expect(person.class()).to_be person_class

  describe "#class_name()", ->
    person_class = class Person
    person = new Person()

    it "returns the name of the instance's class", ->
      expect(person.class_name()).to_be "Person"
      expect(Person.class_name()).to_be "Function"

  describe "#count()", ->
    it "returns the number of own key/value pairs", ->
      expect({}.count()).to_be 0
      expect({key1: 1, key2: 2, key3: 3}.count()).to_be 3

  describe "#is_empty()", ->
    it "returns true if collection is empty", ->
      expect({}.is_empty()).to_be true

    it "returns false if collection has at least one element", ->
      expect({key1: 1}.is_empty()).to_be false
      expect({key1: 1, key2: 2, key3: 3}.is_empty()).to_be false

  describe "#keys()", ->
    it "returns an array of keys", ->
      expect({name: "Peter", age: 45}.keys()).to_equal ['name', 'age']

    it "returns an empty array if the object is empty", ->
      expect({}.keys()).to_equal []

    it "also includes methods", ->
      expect({method: -> console.log "I'm a method." }.keys()).to_equal ['method']

  describe "#values()", ->
    it "returns an array of values", ->
      expect({name: "Peter", age: 45}.values()).to_equal ['Peter', 45]

    it "returns an empty array if the object is empty", ->
      expect({}.values()).to_equal []

    it "also includes methods", ->
      method = -> console.log "I'm a method."
      expect({method: method}.values()).to_equal [method]

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
