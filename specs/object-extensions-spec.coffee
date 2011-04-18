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

describe "Milk.ObjectExtensions", ->
  xdescribe "#get()", ->
    it "returns value for key", ->
      expect({name: "Peter"}.get 'name').to_be "Peter"

    it "throws if no value for key exists", ->
      expect(-> {name: "Peter"}.get 'city').to_throw()

  xdescribe "#set()", ->
    it "sets value for key", ->
      person = name: "Peter"
      person.set 'name', "Peter Pan"
      expect(person.name).to_be "Peter Pan"

    it "throws if no parameters are passed", ->
      person = name: "Peter", age: 45
      expect(-> person.set()).to_throw()

    it "throws if the properties does not exist", ->
      person = name: "Peter", age: 45
      expect(-> person.set 'city', "Burmingham").to_throw()

    it "sets nothing if the property does not exist", ->
      person = name: "Peter", age: 45
      expect(-> person.set 'city', "Burmingham").to_throw()
      expect(person.name).to_be "Peter"
      expect(person.age).to_be 45

    it "returns the receiver", ->
      person = name: "Peter", age: 45
      expect(person.set 'name', "Peter Pan").to_be person

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

  describe "#properties()", ->
    it "returns an array of property names", ->
      expect({name: "Peter", age: 45}.properties()).to_equal ['name', 'age']

    it "does not include methods", ->
      expect({name: "Peter", age: 45, cry: -> "AAAAA!"}.properties()).to_equal ['name', 'age']

    it "returns an empty array if the object is empty", ->
      expect({}.keys()).to_equal []

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

  describe "#is_sealed()", ->
    it "returns no if receiver is not sealed", ->
      person = name: "Peter", age: 45
      expect(person.is_sealed()).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(person.is_sealed()).to_be true

  describe "#is_frozen()", ->
    it "returns no if receiver is not frozen", ->
      person = name: "Peter", age: 45
      expect(person.is_frozen()).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(person.is_frozen()).to_be true

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
      expect((new Date()).is_date()).to_be true

  describe "#is_reg_exp()", ->
    it "returns yes if receiver is a regular expression", ->
      expect(//.is_reg_exp()).to_be true

  describe "#clone()", ->
    it "returns a new object", ->
      expect({}.clone()).to_be_an_object()

    it "has all keys and values of the receiver", ->
      person = name: "Peter", age: 45
      clone = person.clone()
      expect(clone.keys()).to_equal ['name', 'age']
      expect(clone.values()).to_equal ["Peter", 45]

    it "doesn't copy objects recursively, just references them", ->
      address = street: "Rhode-Island-Alley", city: "Karlsruhe"
      person = name: "Peter", age: 45, address: address
      clone = person.clone()
      expect(clone.address).to_be address

  describe "#equals()", ->
    it "returns yes if object is the same", ->
      person = name: "Peter"
      expect(person.equals person).to_be true

    it "returns no if object is not the same", ->
      person = name: "Peter"
      expect(person.equals name: "Peter").to_be false

  describe "property and relationship definition methods", ->
    describe "#has()", ->
      # TODO: specify.

    describe "#has_one()", ->
      # TODO: specify.

    describe "#belongs_to()", ->
      # TODO: specify.

    describe "#has_many()", ->
      # TODO: specify.

    describe "#has_and_belongs_to_many()", ->
      # TODO: specify.

  describe "key-value coding accessor methods", ->
    describe "#value_for()", ->
      it "returns the value for the given key of an object", ->
        expect({name: "Rick"}.value_for 'name').to_be "Rick"

      it "calls the corresponding getter method if available", ->
        person = get_name: -> "Rick"
        expect(person.value_for 'name').to_be "Rick"

      it "calls will_access_value_for() before accessing the value", ->
        person =
          name: null
          get_name: -> @['name']
          will_access_value_for: (key) -> @['name'] = "Rick"
        expect(person.value_for 'name').to_be "Rick"

      it "calls did_access_value_for() after accessing the value", ->
        person = name: "Rick"
        spy_on person, 'did_access_value_for'
        expect(person.value_for 'name').to_be "Rick"
        expect(person.did_access_value_for).to_have_been_called()

    describe "#set_value()", ->
      it "sets the value for the given key of an object", ->
        person = name: 'Unknown'
        person.set_value "Rick", for: 'name'
        expect(person.name).to_be "Rick"

      it "calls the corresponding setter method if available", ->
        person = set_name: (value) -> @['name'] = "Rick"
        person.set_value "Rick", for: 'name'
        expect(person.name).to_be "Rick"

      it "calls will_change_value_for() before changing the value", ->
        person =
          name: null
          set_name: (value) -> # do nothing
          will_change_value_for: (key) -> @['name'] = "Rick"
        person.set_value "Rick", for: 'name'
        expect(person.name).to_be "Rick"

      it "calls did_change_value_for() after changing the value", ->
        person = name: null
        spy_on person, 'did_change_value_for'
        person.set_value 'Rick', for: 'name'
        expect(person.did_change_value_for).to_have_been_called()

  describe "key-value coding change notification methods", ->
    describe "#will_access_value_for()", ->
      it "returns itself", ->
        object = {}
        expect(object.will_access_value_for 'test').to_be object

    describe "#did_access_value_for()", ->
      it "returns itself", ->
        object = {}
        expect(object.did_access_value_for 'test').to_be object

    describe "#will_change_value_for()", ->
      it "returns itself", ->
        object = {}
        expect(object.will_change_value_for 'test').to_be object

    describe "#did_change_value_for()", ->
      it "returns itself", ->
        object = {}
        expect(object.did_change_value_for 'test').to_be object

    describe "#will_insert_many_values_into()", ->
      it "returns itself", ->
        object = {}
        expect(object.will_insert_many_values []).to_be object

    describe "#did_insert_many_values_into()", ->
      it "returns itself", ->
        object = {}
        expect(object.did_insert_many_values []).to_be object

    describe "#will_remove_many_values_from()", ->
      it "returns itself", ->
        object = {}
        expect(object.will_remove_many_values []).to_be object

    describe "#did_remove_many_values_from()", ->
      it "returns itself", ->
        object = {}
        expect(object.did_remove_many_values []).to_be object

  describe "generic to-many relationship accessor methods", ->
    company = null
    beforeEach -> company = employees: ["Ashton", "Bud"]

    describe "#add_many_values()", ->
      it "adds many values to the end of a to-many relationship", ->
        company.add_many_values ["Cyndia", "Didi"], to: 'employees'
        expect(company.employees).to_equal ["Ashton", "Bud", "Cyndia", "Didi"]

      it "forwards to insert_many_values() method", ->
        spy_on(company, 'insert_many_values')
        people = ["Cyndia", "Didi"]
        company.add_many_values people, to: 'employees'
        expect(company.insert_many_values).to_have_been_called_with people, into: 'employees', at: 2

      it "returns the receiver", ->
        expect(company.add_many_values ["Cyndia", "Didi"], to: 'employees').to_be company

    describe "#remove_many_values()", ->
      it "removes many values from a to-many relationship", ->
        company.remove_many_values ["Ashton", "Bud"], from: 'employees'
        expect(company.employees).to_equal []

      it "forwards to remove_many_values_at() method", ->
        spy_on(company, 'remove_many_values_at')
        people = ["Ashton", "Bud"]
        company.remove_many_values people, from: 'employees'
        expect(company.remove_many_values_at).to_have_been_called_with [0, 1], from: 'employees', passed_through_values: people

      it "returns the receiver", ->
        expect(company.remove_many_values ["Bud"], from: 'employees').to_be company

    describe "#insert_many_values()", ->
      it "inserts many values into a to-many relationship at a specified index", ->
        company.insert_many_values ["Cyndia", "Didi"], into: 'employees', at: 2
        expect(company.employees).to_equal ["Ashton", "Bud", "Cyndia", "Didi"]

      it "returns the receiver", ->
        expect(company.insert_many_values ["Cyndia", "Didi"], into: 'employees', at: 2).to_be company

      it "calls #will_insert_many_values() before inserting the values", ->
        spy_on(company, 'will_insert_many_values')
        people = ["Cyndia", "Didi"]
        company.insert_many_values people, into: 'employees', at: 2
        expect(company.will_insert_many_values).to_have_been_called_with people, into: 'employees', at: 2

      it "calls #did_insert_many_values() after inserting the values", ->
        spy_on(company, 'did_insert_many_values')
        people = ["Cyndia", "Didi"]
        company.insert_many_values people, into: 'employees', at: 2
        expect(company.did_insert_many_values).to_have_been_called_with people, into: 'employees', at: 2

    describe "#remove_many_values_at()", ->
      it "removes many values at specified indexes from a to-many relationship", ->
        company.remove_many_values_at [0, 1], from: 'employees'
        expect(company.employees).to_equal []

      it "returns the receiver", ->
        expect(company.remove_many_values_at [0, 1], from: 'employees').to_be company

      it "calls #will_remove_many_values() before removing the values", ->
        spy_on(company, 'will_remove_many_values')
        company.remove_many_values_at [0, 1], from: 'employees'
        expect(company.will_remove_many_values).to_have_been_called_with ["Ashton", "Bud"], from: 'employees', at: [0, 1]

      it "calls #did_remove_many_values() after removing the values", ->
        spy_on(company, 'did_remove_many_values')
        company.remove_many_values_at [0, 1], from: 'employees'
        expect(company.did_remove_many_values).to_have_been_called_with ["Ashton", "Bud"], from: 'employees', at: [0, 1]
