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

describe "Modules", ->
  it "allow organizing code into modules", ->

    @module 'Test.Tick.Tack', ->
      @MAX_NUMBER_OF_VEHICLES = 5
      class Vehicle
      class SecretVehicle
      @export Vehicle
      @export SecretVehicle, secret: yes

    @module 'Test.Click.Clack', ->
      TestTickTack = @import 'Test.Tick.Tack'
      Vehicle = @import 'Test.Tick.Tack.Vehicle'
      class Car extends Vehicle
      vehicle = new Vehicle()
      car = new Car()

      expect(TestTickTack.MAX_NUMBER_OF_VEHICLES).to_be 5
      expect(@class_name_of vehicle).to_be 'Vehicle'
      expect(@class_name_of car).to_be 'Car'

    expect(-> @import 'Test.Tick.Tack.SecretVehicle').to_throw()
    expect(-> @import 'Test.Tick.Tack.SecretVehicle', secret: yes).to_exist()


describe "Keywords", ->

  describe "#class_of()", ->
    person_class = class Person
    person = new Person()

    it "returns the class object", ->
      expect(@class_of person).to_be person_class

  describe "#class_name_of()", ->
    person_class = class Person
    person = new Person()

    it "returns the name of the instance's class", ->
      expect(@class_name_of person).to_be "Person"
      expect(@class_name_of Person).to_be "Function"

  describe "#keys_of()", ->
    it "returns an array of keys", ->
      expect(@keys_of name: "Peter", age: 45).to_equal ['name', 'age']

    it "returns an empty array if the object is empty", ->
      expect(@keys_of {}).to_equal []

    it "also includes methods", ->
      expect(@keys_of method: -> console.log "I'm a method.").to_equal ['method']

  describe "#values_of()", ->
    it "returns an array of values", ->
      expect(@values_of name: "Peter", age: 45).to_equal ['Peter', 45]

    it "returns an empty array if the object is empty", ->
      expect(@values_of {}).to_equal []

    it "also includes methods", ->
      method = -> console.log "I'm a method."
      expect(@values_of method: method).to_equal [method]
# ------------------------------------------------------------------------------

describe "Comparing", ->

  describe "#equals()", ->
    it "returns yes if object is the same", ->
      person = name: "Peter"
      expect(person.equals person).to_be true

    it "returns no if object is null or undefined", ->
      person = name: "Peter"
      expect(person.equals null).to_be false
      expect(person.equals()).to_be false

    it "returns no if object is not the same", ->
      person = name: "Peter"
      expect(person.equals name: "Peter").to_be false

  describe "#compare_to()", ->
    examples = [
      {type: "booleans", left: no, right: yes, result: -1}
      {type: "booleans", left: yes, right: yes, result: 0}
      {type: "booleans", left: yes, right: no, result: +1}
      {type: "numbers", left: 1, right: 2, result: -1}
      {type: "numbers", left: 2, right: 2, result: 0}
      {type: "numbers", left: 3, right: 2, result: +1}
      {type: "strings", left: "a", right: "b", result: -1}
      {type: "strings", left: "b", right: "b", result: 0}
      {type: "strings", left: "c", right: "b", result: +1}
      {type: "dates", left: no, right: yes, result: -1}
      {type: "dates", left: yes, right: yes, result: 0}
      {type: "dates", left: yes, right: no, result: +1}
      {type: "regular expressions", left: /a/, right: /b/, result: -1}
      {type: "regular expressions", left: /b/, right: /b/, result: 0}
      {type: "regular expressions", left: /c/, right: /b/, result: +1}
    ]

    examples_with_different_types = [
      {left: no, right: 5}
      {left: 5, right: no}
      {left: "string", right: 3}
      {left: "string", right: /regexp/}
    ]

    do ->
      for example in examples
        it "returns #{example['result']} when comparing #{example['left']} with #{example['right']} of type #{example['type']}", ->
          expect(example['left'].compare_to example['right']).to_equal example['result']

    do ->
      for example in examples_with_different_types
        it "throws when comparing #{example['left']} with #{example['right']} of of different types", ->
          expect(-> example['left'].compare_to example['right']).to_throw()

  describe "#is_comparable()", ->
    it "returns true for numbers", ->
      number = 5
      expect(number.is_comparable()).to_be true

    it "returns true for strings", ->
      string = "Test"
      expect(string.is_comparable()).to_be true

    it "returns false for arrays", ->
      array = []
      expect(array.is_comparable()).to_be false

  describe "#is_less_than()", ->
    it "returns true if receiver is less than value", ->
      expect(3.is_less_than 5).to_be true

    it "returns false if they are equal", ->
      expect(5.is_less_than 5).to_be false

    it "returns false if receiver is greater than value", ->
      expect(5.is_less_than 3).to_be false

  describe "#is_less_than_or_equals()", ->
    it "returns true if receiver is less than or equal to value", ->
      expect(3.is_less_than_or_equals 5).to_be true

    it "returns true if they are equal", ->
      expect(5.is_less_than_or_equals 5).to_be true

    it "returns false if receiver is greater than or equal to value", ->
      expect(5.is_less_than_or_equals 3).to_be false

  describe "#is_greater_than()", ->
    it "returns true if receiver is greater than value", ->
      expect(5.is_greater_than 3).to_be true

    it "returns false if they are equal", ->
      expect(5.is_greater_than 5).to_be false

    it "returns false if receiver is greater than value", ->
      expect(3.is_greater_than 5).to_be false

  describe "#is_greater_than_or_equals()", ->
    it "returns true if receiver is greater than or equal to value", ->
      expect(5.is_greater_than_or_equals 3).to_be true

    it "returns true if they are equal", ->
      expect(5.is_greater_than_or_equals 5).to_be true

    it "returns false if receiver is greater than or equal to value", ->
      expect(3.is_greater_than_or_equals 5).to_be false

  describe "#is_between()", ->
    describe "without options", ->
      it "returns true if receiver is between lower and upper bound", ->
        expect(5.is_between [4, 6]).to_be true

      it "returns true if receiver equals lower bound", ->
        expect(5.is_between [5, 6]).to_be true

      it "returns true if receiver equals upper bound", ->
        expect(5.is_between [4, 5]).to_be true

      it "returns true if receiver == upper == lower", ->
        expect(5.is_between [5, 5]).to_be true

    describe "when given option excluding_bounds:yes", ->
      it "returns true if receiver is between lower and upper bound", ->
        expect(5.is_between [4, 6], excluding_bounds: yes).to_be true

      it "returns false if receiver equals lower bound", ->
        expect(5.is_between [5, 6], excluding_bounds: yes).to_be false

      it "returns false if receiver equals upper bound", ->
        expect(5.is_between [4, 5], excluding_bounds: yes).to_be false

      it "returns false if receiver == upper == lower", ->
        expect(5.is_between [5, 5], excluding_bounds: yes).to_be false

    describe "when given option excluding_lower:yes", ->
      it "returns true if receiver is between lower and upper bound", ->
        expect(5.is_between [4, 6], excluding_lower: yes).to_be true

      it "returns false if receiver equals lower bound", ->
        expect(5.is_between [5, 6], excluding_lower: yes).to_be false

      it "returns true if receiver equals upper bound", ->
        expect(5.is_between [4, 5], excluding_lower: yes).to_be true

      it "returns false if receiver == upper == lower", ->
        expect(5.is_between [5, 5], excluding_lower: yes).to_be false

    describe "when given option excluding_upper:yes", ->
      it "returns true if receiver is between lower and upper bound", ->
        expect(5.is_between [4, 6], excluding_upper: yes).to_be true

      it "returns true if receiver equals lower bound", ->
        expect(5.is_between [5, 6], excluding_upper: yes).to_be true

      it "returns false if receiver equals upper bound", ->
        expect(5.is_between [4, 5], excluding_upper: yes).to_be false

      it "returns false if receiver == upper == lower", ->
        expect(5.is_between [5, 5], excluding_upper: yes).to_be false

# ------------------------------------------------------------------------------

describe "Freezing & Sealing", ->

  describe "Object.is_frozen()", ->
    it "returns no if receiver is not frozen", ->
      person = name: "Peter", age: 45
      expect(Object.is_frozen person).to_be false

    it "returns yes if receiver is frozen", ->
      person = name: "Peter", age: 45
      Object.freeze person
      expect(Object.is_frozen person).to_be true

  describe "Object.is_sealed()", ->
    it "returns no if receiver is not sealed", ->
      person = name: "Peter", age: 45
      expect(Object.is_sealed person).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      Object.seal person
      expect(Object.is_sealed person).to_be true

# ------------------------------------------------------------------------------

describe "Key-Value Coding", ->

  describe "#value_for()", ->
    it "returns the value by calling the getter if it is a function", ->
      object = key: (-> "getter"), '@key': "variable"
      expect(object.value_for 'key').to_be "getter"

    it "returns the value of the private instance variable if there is no getter", ->
      expect({'@key': "variable", key: "property"}.value_for 'key').to_be "variable"

    it "returns the value of the private instance variable if there a getter, but option 'direct: yes' was passed", ->
      object = key: (-> "getter"), '@key': "variable"
      expect(object.value_for 'key', direct: yes).to_be "variable"

    it "returns the value of the property if there is no getter and no instance variable", ->
      expect({key: "property"}.value_for 'key').to_be "property"

  describe "#set_value_for()", ->
    it "calls the setter if setter is available", ->
      object = set_key: ((key) -> @['@key'] = key), '@key': "variable"
      object.set_value_for "Test", 'key'
      expect(object['@key']).to_be "Test"

    it "sets the private instance variable if no setter is available", ->
      object = '@key': "variable", key: "property"
      object.set_value_for "Test", 'key'
      expect(object['@key']).to_be "Test"

    it "sets the private instance variable if setter is available but option 'direct: yes' was passed", ->
      object = set_key: ((key) -> @['@key'] = "setter"), '@key': "variable"
      object.set_value_for "Test", 'key', direct: yes
      expect(object['@key']).to_be "Test"

    it "sets the property if no instaince variable is available", ->
      object = key: "property"
      object.set_value_for "Test", 'key'
      expect(object['key']).to_be "Test"

  describe "#getter_name_for()", ->
    it "returns the key itself", ->
      expect({}.getter_name_for 'some_nice_key').to_equal 'some_nice_key'

  describe "#setter_name_for()", ->
    it "returns the key prefixed with 'get'", ->
      expect({}.setter_name_for 'some_nice_key').to_equal 'set_some_nice_key'

# ------------------------------------------------------------------------------

describe "Type-Checking", ->

  describe "Object.is_class()", ->
    it "returns true for a class", ->
      class Vehicle
      expect(Object.is_class Vehicle).to_be true

    it "returns true for a subclass", ->
      class Vehicle
      class Car extends Vehicle
      expect(Object.is_class Car).to_be true

    it "returns true for Object", ->
      expect(Object.is_class Object).to_be true

    it "returns true for Date", ->
      expect(Object.is_class Date).to_be true

    it "returns true for Array", ->
      expect(Object.is_class Array).to_be true

    it "returns true for Function", ->
      expect(Object.is_class Array).to_be true

    it "returns false for a hash", ->
      expect(Object.is_class {}).to_be false

    it "returns false for an array", ->
      expect(Object.is_class []).to_be false

    it "returns false for an instance of a class", ->
      class Vehicle
      vehicle = new Vehicle()
      expect(Object.is_class vehicle).to_be false

    it "returns false for an instance of a subclass", ->
      class Vehicle
      class Car
      car = new Car()
      expect(Object.is_class car).to_be false

    it "returns false for a function", ->
      expect(Object.is_class ->).to_be false

  describe "Object.is_function()", ->
    it "returns yes if receiver is a function", ->
      expect(Object.is_function ->).to_be true

  describe "Object.is_boolean()", ->
    it "returns yes if receiver is a boolean", ->
      expect(Object.is_boolean yes).to_be true

  describe "Object.is_number()", ->
    it "returns yes if receiver is a number", ->
      expect(Object.is_number 1).to_be true

  describe "Object.is_date()", ->
    it "returns yes if receiver is a date", ->
      expect(Object.is_date new Date()).to_be true

  describe "Object.is_string()", ->
    it "returns yes if receiver is a string", ->
      expect(Object.is_string "").to_be true

  describe "Object.is_reg_exp()", ->
    it "returns yes if receiver is a regular expression", ->
      expect(Object.is_reg_exp //).to_be true

  describe "Object.is_array()", ->
    it "returns yes if receiver is an array", ->
      expect(Object.is_array []).to_be true

  describe "Object.is_dictionary()", ->
    it "returns yes if receiver is a simple JSON hash", ->
      expect(Object.is_dictionary {}).to_be true

  describe "Object.is_kind_of()", ->
    class Vehicle
      type: ""

    class Car extends Vehicle
      drive: -> "Bruuuum..."

    car = new Car()

    it "returns true of an object is an instance of class", ->
      expect(Object.is_kind_of car, Car).to_be true

    it "returns true of an object is an instance of subclass of class", ->
      expect(Object.is_kind_of car, Vehicle).to_be true

    it "returns true for Object", ->
      expect(Object.is_kind_of car, Object).to_be true

    it "returns false if an object is an instance of a different class which is not a subclass of class", ->
      expect(Object.is_kind_of car, Array).to_be false

  describe "Object.is_instance_of()", ->
    class Vehicle
      type: ""

    class Car extends Vehicle
      drive: -> "Bruuuum..."

    car = new Car()

    it "returns true of an object is an instance of class", ->
      expect(Object.is_instance_of car, Car).to_be true

    it "returns false of an object is an instance of subclass of class", ->
      expect(Object.is_instance_of car, Vehicle).to_be false

    it "returns false for Object", ->
      expect(Object.is_instance_of car, Object).to_be false

    it "returns false if an object is an instance of a different class which is not a subclass of class", ->
      expect(Object.is_instance_of car, Array).to_be false

# ------------------------------------------------------------------------------

describe "Messaging", ->

  describe "#responds_to()", ->
    it "returns yes if object responds to a method", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to 'method').to_be yes

    it "returns no if object does not respond to a method", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to 'not_existing_method').to_be no

    it "returns no if method is null", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to null).to_be no

    it "returns no if no arguments are passed", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to()).to_be no

  describe "#invoke()", ->
    it "invokes a method", ->
      object = method: -> # do nothing
      spy_on(object, 'method').and_call_through()
      object.invoke 'method'
      expect(object.method).to_have_been_called()

    it "passes an array of parameters", ->
      args = [1, 2, 3]
      object = method: (arg1, arg2, arg3) -> args = [arg1, arg2, arg3]
      spy_on(object, 'method').and_call_through()
      object.invoke 'method', [5, 6, 7]
      expect(args.sort()).to_equal [5, 6, 7]
