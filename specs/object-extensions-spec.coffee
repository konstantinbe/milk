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
  xdescribe "get(key)", ->
    it "returns value for key", ->
      expect({name: "Peter"}.get 'name').toBe "Peter"

    it "throws if no value for key exists", ->
      expect(-> {name: "Peter"}.get 'city').toThrow()

  xdescribe "set(key, value)", ->
    it "sets value for key", ->
      person = name: "Peter"
      person.set 'name', "Peter Pan"
      expect(person.name).toBe "Peter Pan"

    it "throws if no parameters are passed", ->
      person = name: "Peter", age: 45
      expect(-> person.set()).toThrow()

    it "throws if the properties does not exist", ->
      person = name: "Peter", age: 45
      expect(-> person.set 'city', "Burmingham").toThrow()

    it "sets nothing if the property does not exist", ->
      person = name: "Peter", age: 45
      expect(-> person.set 'city', "Burmingham").toThrow()
      expect(person.name).toBe "Peter"
      expect(person.age).toBe 45

    it "returns the receiver", ->
      person = name: "Peter", age: 45
      expect(person.set 'name', "Peter Pan").toBe person

  describe "keys()", ->
    it "returns an array of keys", ->
      expect({name: "Peter", age: 45}.keys()).toEqual ['name', 'age']

    it "returns an empty array if the object is empty", ->
      expect({}.keys()).toEqual []

    it "also includes methods", ->
      expect({method: -> console.log "I'm a method." }.keys()).toEqual ['method']

  describe "values()", ->
    it "returns an array of values", ->
      expect({name: "Peter", age: 45}.values()).toEqual ['Peter', 45]

    it "returns an empty array if the object is empty", ->
      expect({}.values()).toEqual []

    it "also includes methods", ->
      method = -> console.log "I'm a method."
      expect({method: method}.values()).toEqual [method]

  describe "properties()", ->
    it "returns an array of property names", ->
      expect({name: "Peter", age: 45}.properties()).toEqual ['name', 'age']

    it "does not include methods", ->
      expect({name: "Peter", age: 45, cry: -> "AAAAA!"}.properties()).toEqual ['name', 'age']

    it "returns an empty array if the object is empty", ->
      expect({}.keys()).toEqual []

  describe "responds_to(method)", ->
    it "returns yes if object responds to a method", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to 'method').toBe yes

    it "returns no if object does not respond to a method (i.e. method does not exist)", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to 'not_existing_method').toBe no

    it "returns no if method is null", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to null).toBe no

    it "returns no if no arguments are passed", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to()).toBe no

  describe "seal()", ->
    it "seals the receiver", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(person.is_sealed()).toBe true

  describe "freeze()", ->
    it "freezes the receiver", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(person.is_frozen()).toBe true

  describe "is_sealed()", ->
    it "returns no if receiver is not sealed", ->
      person = name: "Peter", age: 45
      expect(person.is_sealed()).toBe false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(person.is_sealed()).toBe true

  describe "is_frozen()", ->
    it "returns no if receiver is not frozen", ->
      person = name: "Peter", age: 45
      expect(person.is_frozen()).toBe false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(person.is_frozen()).toBe true

  describe "is_function(value)", ->
    it "returns yes if receiver is a function", ->
      expect((->).is_function()).toBe true

  describe "is_string(value)", ->
    it "returns yes if receiver is a string", ->
      expect("".is_string()).toBe true

  describe "is_boolean(value)", ->
    it "returns yes if receiver is a boolean", ->
      expect(yes.is_boolean()).toBe true

  describe "is_number(value)", ->
    it "returns yes if receiver is a number", ->
      expect(1.is_number()).toBe true

  describe "is_array(value)", ->
    it "returns yes if receiver is an array", ->
      expect([].is_array()).toBe true

  describe "is_date(value)", ->
    it "returns yes if receiver is a date", ->
      expect((new Date()).is_date()).toBe true

  describe "is_reg_exp(value)", ->
    it "returns yes if receiver is a regular expression", ->
      expect(//.is_reg_exp()).toBe true

  describe "clone(options = {})", ->
    it "returns a new object", ->
      expect({}.clone()).toBe_an_object()

    it "has all keys and values of the receiver", ->
      person = name: "Peter", age: 45
      clone = person.clone()
      expect(clone.keys()).toEqual ['name', 'age']
      expect(clone.values()).toEqual ["Peter", 45]

    it "makes a shallow copy, i.e. does not copy objects recursively, just references them", ->
      address = street: "Rhode-Island-Alley", city: "Karlsruhe"
      person = name: "Peter", age: 45, address: address
      clone = person.clone()
      expect(clone.address).toBe address

  describe "equals(object)", ->
    it "returns yes if object is the same", ->
      person = name: "Peter"
      expect(person.equals person).toBe true

    it "returns no if object is not the same", ->
      person = name: "Peter"
      expect(person.equals name: "Peter").toBe false

  describe "key-value coding accessor methods", ->
    describe "value_for(key, options = {})", ->
      it "returns the value for the given key of an object", ->
        expect({name: "Rick"}.value_for 'name').toBe "Rick"

      it "calls the corresponding getter method if available", ->
        person = get_name: -> "Rick"
        expect(person.value_for 'name').toBe "Rick"

      it "calls will_access_value_for() before accessing the value", ->
        person =
          name: null
          get_name: -> @['name']
          will_access_value_for: (key) -> @['name'] = "Rick"
        expect(person.value_for 'name').toBe "Rick"

      it "calls did_access_value_for() after accessing the value", ->
        person = name: "Rick"
        spyOn person, 'did_access_value_for'
        expect(person.value_for 'name').toBe "Rick"
        expect(person.did_access_value_for).toHaveBeenCalled()

    describe "set_value(value, options = {})", ->
      it "sets the value for the given key of an object", ->
        person = name: 'Unknown'
        person.set_value "Rick", for: 'name'
        expect(person.name).toBe "Rick"

      it "calls the corresponding setter method if available", ->
        person = set_name: (value) -> @['name'] = "Rick"
        person.set_value "Rick", for: 'name'
        expect(person.name).toBe "Rick"

      it "calls will_change_value_for() before changing the value", ->
        person =
          name: null
          set_name: (value) -> # do nothing
          will_change_value_for: (key) -> @['name'] = "Rick"
        person.set_value "Rick", for: 'name'
        expect(person.name).toBe "Rick"

      it "calls did_change_value_for() after changing the value", ->
        person = name: null
        spyOn person, 'did_change_value_for'
        person.set_value 'Rick', for: 'name'
        expect(person.did_change_value_for).toHaveBeenCalled()

  describe "key-value coding change notification methods", ->
    describe "will_access_value_for(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.will_access_value_for 'test').toBe object

    describe "did_access_value_for(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.did_access_value_for 'test').toBe object

    describe "will_change_value_for(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.will_change_value_for 'test').toBe object

    describe "did_change_value_for(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.did_change_value_for 'test').toBe object

    describe "will_insert_values_into(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.will_insert_values []).toBe object

    describe "did_insert_values_into(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.did_insert_values []).toBe object

    describe "will_remove_values_from(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.will_remove_values []).toBe object

    describe "did_remove_values_from(key, options = {})", ->
      it "returns itself", ->
        object = {}
        expect(object.did_remove_values []).toBe object

  describe "has(name, options = {})", ->
    # TODO: describe.

  describe "generic to-many relationship accessor methods", ->
    company = null
    beforeEach -> company = employees: ["Ashton", "Bud"]

    describe "add_many_values(values, options = {})", ->
      it "adds many values to the end of a to-many relationship", ->
        company.add_many_values ["Cyndia", "Didi"], to: 'employees'
        expect(company.employees).toEqual ["Ashton", "Bud", "Cyndia", "Didi"]

      it "forwards to insert_many_values() method", ->
        spyOn(company, 'insert_many_values')
        people = ["Cyndia", "Didi"]
        company.add_many_values people, to: 'employees'
        expect(company.insert_many_values).toHaveBeenCalledWith people, into: 'employees', at: 2

      it "returns the receiver", ->
        expect(company.add_many_values ["Cyndia", "Didi"], to: 'employees').toBe company

    describe "remove_many_values(values, options = {})", ->
      it "removes many values from a to-many relationship", ->
        company.remove_many_values ["Ashton", "Bud"], from: 'employees'
        expect(company.employees).toEqual []

      it "forwards to remove_many_values_at() method", ->
        spyOn(company, 'remove_many_values_at')
        people = ["Ashton", "Bud"]
        company.remove_many_values people, from: 'employees'
        expect(company.remove_many_values_at).toHaveBeenCalledWith [0, 1], from: 'employees', passed_through_values: people

      it "returns the receiver", ->
        expect(company.remove_many_values ["Bud"], from: 'employees').toBe company

    describe "insert_many_values(values, options = {})", ->
      it "inserts many values into a to-many relationship at a specified index", ->
        company.insert_many_values ["Cyndia", "Didi"], into: 'employees', at: 2
        expect(company.employees).toEqual ["Ashton", "Bud", "Cyndia", "Didi"]

      it "returns the receiver", ->
        expect(company.insert_many_values ["Cyndia", "Didi"], into: 'employees', at: 2).toBe company

      it "calls will_insert_values() before inserting the values", ->
        spyOn(company, 'will_insert_values')
        people = ["Cyndia", "Didi"]
        company.insert_many_values people, into: 'employees', at: 2
        expect(company.will_insert_values).toHaveBeenCalledWith people, into: 'employees', at: 2

      it "calls did_insert_values() after inserting the values", ->
        spyOn(company, 'did_insert_values')
        people = ["Cyndia", "Didi"]
        company.insert_many_values people, into: 'employees', at: 2
        expect(company.did_insert_values).toHaveBeenCalledWith people, into: 'employees', at: 2

    describe "remove_many_values_at(indexes, options = {})", ->
      it "removes many values at specified indexes from a to-many relationship", ->
        company.remove_many_values_at [0, 1], from: 'employees'
        expect(company.employees).toEqual []

      it "returns the receiver", ->
        expect(company.remove_many_values_at [0, 1], from: 'employees').toBe company

      it "calls will_remove_values() before removing the values", ->
        spyOn(company, 'will_remove_values')
        company.remove_many_values_at [0, 1], from: 'employees'
        expect(company.will_remove_values).toHaveBeenCalledWith ["Ashton", "Bud"], from: 'employees', at: [0, 1]

      it "calls did_remove_values() after removing the values", ->
        # TODO: specify.
