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

describe "Function", ->

  describe "#new()", ->
    it "instantiates an object with that constructor", ->
      class Person
      person = Person.new()
      expect(person).to_be_instance_of Person

    it "passes arguments to the constructor", ->
      class Person
        constructor: (one, two, three) ->
          @one = one
          @two = two
          @three = three

      person = Person.new 1, 2, 3
      expect(person['one']).to_be 1
      expect(person['two']).to_be 2
      expect(person['three']).to_be 3

  describe "#has()", ->

    describe "when no options are passed", ->
      person = null
      instance_variable_name = null
      class Person
        @has 'name'

      before ->
        person = new Person()
        instance_variable_name = '@name'
        person[instance_variable_name] = "Peter"

      it "defines a getter method returning the value of the instance variable", ->
        expect(person).to_respond_to 'name'
        expect(person.name()).to_be "Peter"

      it "defines a setter method updating the instance variable", ->
        expect(person).to_respond_to 'set_name'
        person.set_name 'Anna'
        expect(person[instance_variable_name]).to_be "Anna"

      it "sets the initial value to be null", ->
        person = new Person()
        expect(person.name()).to_be null

    describe "when option 'initial: value' is passed", ->
      class Person
        @has 'name', initial: "New"

      it "sets the initial value", ->
        person = new Person()
        expect(person.name()).to_be "New"

    describe "when option 'secret: yes' is passed", ->
      class Person
        @has 'age', secret: yes

      it "makes the getter and setter non-enumerable", ->
        person = new Person()
        keys = (key for key of person)
        expect(keys).not.to_contain 'age'
        expect(keys).not.to_contain 'set_age'

    describe "when option 'readonly: yes' is passed", ->
      class Person
        @has 'age', readonly: yes
