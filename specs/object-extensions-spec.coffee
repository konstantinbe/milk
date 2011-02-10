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
  describe "get(key)", ->
    it "returns value for key", ->
      expect({name: "Peter"}.get 'name').to_be "Peter"

    it "throws if no value for key exists", ->
      expect(-> {name: "Peter"}.get 'city').to_throw()

  describe "set(key, value)", ->
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

  describe "keys()", ->
    it "returns an array of keys", ->
      expect({name: "Peter", age: 45}.keys()).to_equal ['name', 'age']

    it "returns an empty array if the object is empty", ->
      expect({}.keys()).to_equal []

    it "also includes methods", ->
      expect({method: -> console.log "I'm a method." }.keys()).to_equal ['method']

  describe "values()", ->
    it "returns an array of values", ->
      expect({name: "Peter", age: 45}.values()).to_equal ['Peter', 45]

    it "returns an empty array if the object is empty", ->
      expect({}.values()).to_equal []

    it "also includes methods", ->
      method = -> console.log "I'm a method."
      expect({method: method}.values()).to_equal [method]

  describe "responds_to(method)", ->
    it "returns yes if object responds to a method", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to 'method').to_be yes

    it "returns no if object does not respond to a method (i.e. method does not exist)", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to 'not_existing_method').to_be no

    it "returns no if method is null", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to null).to_be no

    it "returns no if no arguments are passed", ->
      method = -> console.log "I'm a method."
      expect({method: method}.responds_to()).to_be no

  describe "seal()", ->
    it "seals the receiver", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(Object.isSealed(person)).to_be true

  describe "freeze()", ->
    it "freezes the receiver", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(Object.isFrozen(person)).to_be true

  describe "is_sealed()", ->
    it "returns no if receiver is not sealed", ->
      person = name: "Peter", age: 45
      expect(person.is_sealed()).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.seal()
      expect(person.is_sealed()).to_be true

  describe "is_frozen()", ->
    it "returns no if receiver is not frozen", ->
      person = name: "Peter", age: 45
      expect(person.is_frozen()).to_be false

    it "returns yes if receiver is sealed", ->
      person = name: "Peter", age: 45
      person.freeze()
      expect(person.is_frozen()).to_be true

  describe "is_function(value)", ->
    it "returns yes if receiver is a function", ->
      expect((->).is_function()).to_be true

  describe "is_string(value)", ->
    it "returns yes if receiver is a string", ->
      expect("".is_string()).to_be true

  describe "is_boolean(value)", ->
    it "returns yes if receiver is a boolean", ->
      expect(yes.is_boolean()).to_be true

  describe "is_number(value)", ->
    it "returns yes if receiver is a number", ->
      expect(1.is_number()).to_be true

  describe "is_array(value)", ->
    it "returns yes if receiver is an array", ->
      expect([].is_array()).to_be true

  describe "is_date(value)", ->
    it "returns yes if receiver is a date", ->
      expect((new Date()).is_date()).to_be true

  describe "is_reg_exp(value)", ->
    it "returns yes if receiver is a regular expression", ->
      expect(//.is_reg_exp()).to_be true

  describe "clone(options = {})", ->
    it "returns a new object", ->
      expect({}.clone()).to_be_an_object()

    it "has all keys and values of the receiver", ->
      person = name: "Peter", age: 45
      clone = person.clone()
      expect(clone.keys()).to_equal ['name', 'age']
      expect(clone.values()).to_equal ["Peter", 45]

    it "makes a shallow copy, i.e. does not copy objects recursively, just references them", ->
      address = street: "Rhode-Island-Alley", city: "Karlsruhe"
      person = name: "Peter", age: 45, address: address
      clone = person.clone()
      expect(clone.address).to_be address

  describe "equals(object)", ->
    it "returns yes if object is the same", ->
      person = name: "Peter"
      expect(person.equals person).to_be true

    it "returns no if object is not the same", ->
      person = name: "Peter"
      expect(person.equals name: "Peter").to_be false
