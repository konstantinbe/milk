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

describe "Object (modules)", ->
  it "allows organizing your code into modules", ->

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
      expect(vehicle.class_name()).to_be 'Vehicle'
      expect(car.class_name()).to_be 'Car'

    expect(-> @import 'Test.Tick.Tack.SecretVehicle').to_throw()
    expect(-> @import 'Test.Tick.Tack.SecretVehicle', secret: yes).to_exist()

# ------------------------------------------------------------------------------

describe "Object (comparing)", ->

  describe "#is_less_than()", ->
    it "returns true if receiver is less than value", ->
      expect(3.is_less_than 5).to_be true

    it "returns false if they are equal", ->
      expect(5.is_less_than 5).to_be false

    it "returns false if receiver is greater than value", ->
      expect(5.is_less_than 3).to_be false

  describe "#is_less_than_or_equal_to()", ->
    it "returns true if receiver is less than or equal to value", ->
      expect(3.is_less_than_or_equal_to 5).to_be true

    it "returns true if they are equal", ->
      expect(5.is_less_than_or_equal_to 5).to_be true

    it "returns false if receiver is greater than or equal to value", ->
      expect(5.is_less_than_or_equal_to 3).to_be false

  describe "#is_greater_than()", ->
    it "returns true if receiver is greater than value", ->
      expect(5.is_greater_than 3).to_be true

    it "returns false if they are equal", ->
      expect(5.is_greater_than 5).to_be false

    it "returns false if receiver is greater than value", ->
      expect(3.is_greater_than 5).to_be false

  describe "#is_greater_than_or_equal_to()", ->
    it "returns true if receiver is greater than or equal to value", ->
      expect(5.is_greater_than_or_equal_to 3).to_be true

    it "returns true if they are equal", ->
      expect(5.is_greater_than_or_equal_to 5).to_be true

    it "returns false if receiver is greater than or equal to value", ->
      expect(3.is_greater_than_or_equal_to 5).to_be false

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

  describe "#equals()", ->
    it "returns yes if object is the same", ->
      person = name: "Peter"
      expect(person.equals person).to_be true

    it "returns no if object is not the same", ->
      person = name: "Peter"
      expect(person.equals name: "Peter").to_be false

# ------------------------------------------------------------------------------

describe "Object (copying)", ->

  describe "#is_copyable()", ->
    copyable_objects = [
      yes
      1
      "String"
      /RegExp/
      {a_dictianary_object_should_be_copyable: yes}
      new Date
    ]

    for object in copyable_objects
      it "returns true for #{object}", ->
        expect(object.is_copyable()).to_be true

  describe "#copy()", ->
    it "returns a new object", ->
      expect({}.copy()).to_be_defined()

    it "has all keys and values of the receiver", ->
      person = name: "Peter", age: 45
      copy = person.copy()
      expect(copy.keys()).to_equal ['name', 'age']
      expect(copy.values()).to_equal ["Peter", 45]

    it "doesn't copy objects recursively, just references them", ->
      address = street: "Rhode-Island-Alley", city: "Karlsruhe"
      person = name: "Peter", age: 45, address: address
      copy = person.copy()
      expect(copy.address).to_be address

# ------------------------------------------------------------------------------

describe "Object (mixing & merging)", ->

  describe "#mixin()", ->
    it "mixes dictionaries without overwriting existing ones", ->
      left = key1: 1, key2: 2
      right = key2: 4, key3: 3
      left.mixin right
      expect(left.keys().sort()).to_equal ['key1', 'key2', 'key3']
      expect(left.values().sort()).to_equal [1, 2, 3]

  describe "#merge()", ->
    it "merges dictionaries while overwriting existing ones", ->
      left = key1: 1, key2: 4
      right = key2: 2, key3: 3
      left.merge right
      expect(left.keys().sort()).to_equal ['key1', 'key2', 'key3']
      expect(left.values().sort()).to_equal [1, 2, 3]

  describe "#with()", ->
    it "returnes a copy with merged dictionary", ->
      left = key1: 1, key2: 4
      right = key2: 2, key3: 3
      left_with_right = left.with right
      expect(left.keys().sort()).to_equal ['key1', 'key2']
      expect(left_with_right.keys().sort()).to_equal ['key1', 'key2', 'key3']
      expect(left_with_right.values().sort()).to_equal [1, 2, 3]

  describe "#with_defaults()", ->
    it "returns a copy with mixed in defaults", ->
      options = key1: 1, key2: 2
      defaults = key2: 4, key3: 3
      options_with_defaults = options.with_defaults defaults
      expect(options_with_defaults.keys().sort()).to_equal ['key1', 'key2', 'key3']
      expect(options_with_defaults.values().sort()).to_equal [1, 2, 3]
      expect(options.keys().sort()).to_equal ['key1', 'key2']

# ------------------------------------------------------------------------------

describe "Object (freezing & sealing)", ->

  describe "#seal()", ->
    it "seals the receiver", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(person.is_sealed()).to_be true

  describe "#freeze()", ->
    it "freezes the receiver", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(person.is_frozen()).to_be true

  describe "#isSealed()", ->
    it "returns no if receiver is not sealed", ->
      person = name: "Peter", age: 45
      expect(person.is_sealed()).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(person.is_sealed()).to_be true

  describe "#isFrozen()", ->
    it "returns no if receiver is not frozen", ->
      person = name: "Peter", age: 45
      expect(person.is_frozen()).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(person.is_frozen()).to_be true

# ------------------------------------------------------------------------------

describe "Object (key-value coding)", ->

  describe "#value_for()", ->
    # TODO: specify.

  describe "#set_value_for()", ->
    # TODO: specify.

  describe "#getter_name_for()", ->
    # TODO: specify.

  describe "#setter_name_for()", ->
    # TODO: specify.

  describe "#instance_variable_name_for()", ->
    # TODO: specify.

# ------------------------------------------------------------------------------

describe "Object (type checking)", ->

  describe "#is_class()", ->
    it "returns true for a class", ->
      class Vehicle
      expect(Vehicle.is_class()).to_be true

    it "returns true for a subclass", ->
      class Vehicle
      class Car extends Vehicle
      expect(Car.is_class()).to_be true

    it "returns true for Object", ->
      expect(Object.is_class()).to_be true

    it "returns true for Date", ->
      expect(Date.is_class()).to_be true

    it "returns true for Array", ->
      expect(Array.is_class()).to_be true

    it "returns true for Function", ->
      expect(Array.is_class()).to_be true

    it "returns false for a hash", ->
      expect({}.is_class()).to_be false

    it "returns false for an array", ->
      expect([].is_class()).to_be false

    it "returns false for an instance of a class", ->
      class Vehicle
      vehicle = new Vehicle()
      expect(vehicle.is_class()).to_be false

    it "returns false for an instance of a subclass", ->
      class Vehicle
      class Car
      car = new Car()
      expect(car.is_class()).to_be false

    it "returns false for a function", ->
      expect((->).is_class()).to_be false

  describe "#is_function()", ->
    it "returns yes if receiver is a function", ->
      expect((->).is_function()).to_be true

  describe "#is_string()", ->
    it "returns yes if receiver is a string", ->
      expect("".is_string()).to_be true

  describe "#is_boolean()", ->
    it "returns yes if receiver is a boolean", ->
      expect(yes.is_boolean()).to_be true

  describe "#is_number()", ->
    it "returns yes if receiver is a number", ->
      expect(1.is_number()).to_be true

  describe "#is_array()", ->
    it "returns yes if receiver is an array", ->
      expect([].is_array()).to_be true

  describe "#is_date()", ->
    it "returns yes if receiver is a date", ->
      expect(new Date().is_date()).to_be true

  describe "#is_reg_exp()", ->
    it "returns yes if receiver is a regular expression", ->
      expect(//.is_reg_exp()).to_be true

  describe "#is_kind_of()", ->
    class Vehicle
      type: ""

    class Car extends Vehicle
      drive: -> "Bruuuum..."

    car = new Car()

    it "returns true of an object is an instance of class", ->
      expect(car.is_kind_of Car).to_be true

    it "returns true of an object is an instance of subclass of class", ->
      expect(car.is_kind_of Vehicle).to_be true

    it "returns true for Object", ->
      expect(car.is_kind_of Object).to_be true

    it "returns false if an object is an instance of a different class which is not a subclass of class", ->
      expect(car.is_kind_of Array).to_be false

  describe "#is_instance_of()", ->
    class Vehicle
      type: ""

    class Car extends Vehicle
      drive: -> "Bruuuum..."

    car = new Car()

    it "returns true of an object is an instance of class", ->
      expect(car.is_instance_of Car).to_be true

    it "returns false of an object is an instance of subclass of class", ->
      expect(car.is_instance_of Vehicle).to_be false

    it "returns false for Object", ->
      expect(car.is_instance_of Object).to_be false

    it "returns false if an object is an instance of a different class which is not a subclass of class", ->
      expect(car.is_instance_of Array).to_be false

# ------------------------------------------------------------------------------

describe "Object (messaging)", ->

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
    # TODO: specify

# ------------------------------------------------------------------------------

describe "Object (core extensions)", ->
  describe "#class()", ->
    person_class = class Person
    person = new Person()

    it "returns the class object", ->
      expect(person.class()).to_be person_class

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

# ------------------------------------------------------------------------------

describe "Array (core extensions)", ->
  describe "#copy()", ->
    it "copys an array", ->
      array = [1, 2, 3]
      copy = array.copy()
      expect(copy).not.to_be array
      expect(copy).to_equal array

  describe "#equals()", ->
    it "returns true for an array with the same objects", ->
      expect([1, 2, 3].equals [1, 2, 3]).to_be true

    it "returns false for an array with the same objects but in a different order", ->
      expect([1, 2, 3].equals [1, 3, 2]).to_be false

    it "returns false when passing something else than an array (for example an object)", ->
      expect([1, 2, 3].equals {}).to_be false

# ------------------------------------------------------------------------------

describe "String (core extensions)", ->
  describe "#copy()", ->
    it "returns a copy of the receiver", ->
      string = "String"
      expect(string.copy()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.uniqueStringInstance = "Unique String Instance"
      expect(string.copy().unique_string_instance).to_be undefined

# ------------------------------------------------------------------------------

describe "Number (core extensions)", ->
  describe "#copy()", ->
    it "returns a copy of the receiver", ->
      five = 5
      expect(five.copy()).to_equal 5

    it "which is not the same instance", ->
      five = 5
      five.unique_five_instance = "_unique _five _instance"
      expect(five.copy().unique_five_instance).to_be undefined

# ------------------------------------------------------------------------------

describe "Date (core extensions)", ->
  describe "#copy()", ->
    it "returns a copy of the receiver", ->
      five = 5
      expect(five.copy()).to_equal 5

    it "which is not the same instance", ->
      five = 5
      five.unique_five_instance = "_unique _five _instance"
      expect(five.copy().unique_five_instance).to_be undefined

# ------------------------------------------------------------------------------

describe "RegExp (core extensions)", ->
  describe "#copy()", ->
    it "returns a copy of the receiver", ->
      reg_exp = /.*/
      expect(reg_exp.copy().to_string()).to_equal /.*/.to_string()

# ------------------------------------------------------------------------------

describe "Math (core extensions)", ->
  describe ".generate_unique_id()", ->
    it "generates an RFC4122 version 4 ID", ->
      expect(Math.generate_unique_id()).to_match /^.+$/

    it "contains 36 characters", ->
      expect(Math.generate_unique_id().length).to_be 36

    it "is divided by dashes at indexes 8, 13, 18, and 23", ->
      expect(Math.generate_unique_id()).to_match "^........-....-....-....-............$"

    it "has a 4 at index 14", ->
      expect(Math.generate_unique_id()).to_match "^........-....-4...-....-............$"

    it "has only HEX numbers besides the dashes", ->
      unique_id = Math.generate_unique_id().replace /-/g, ""
      expect(unique_id).to_match /^(\d|a|b|c|d|e|f)+$/
