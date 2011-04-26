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

requires 'Specs.SpecHelper'

describe "Milk.Extensions.FunctionExtensions", ->
  describe "#curry()", ->
    it "curries arguments passed in at bind time", ->
      concatenate = (arrays...) -> arrays.inject [], (memo, array) -> memo.add_many array
      one_two_three = concatenate.curry([1], [2], [3])
      expect(one_two_three()).to_equal [1, 2, 3]

    it "passes in regular arguments", ->
      concatenate = (arrays...) -> arrays.inject [], (memo, array) -> memo.add_many array
      one_two_three = concatenate.curry([1], [2], [3])
      expect(one_two_three([4, 5], [6])).to_equal [1, 2, 3, 4, 5, 6]

  describe "#bind_to()", ->
    it "returns a new function which calls the receiver by passing object as the first argument", ->
      plus_one = ((number) -> number + 1)
      five = plus_one.bind_to(4)
      expect(five()).to_be 5

    it "curries arguments passed in at bind time", ->
      concatenate = ((array, arrays...) -> array.concat arrays...)
      one_two_three = concatenate.bind_to([1], [2], [3])
      expect(one_two_three()).to_equal [1, 2, 3]

    it "passes in regular arguments", ->
      concatenate = ((array, arrays...) -> array.concat arrays...)
      one_two_three = concatenate.bind_to([1], [2], [3])
      expect(one_two_three([4, 5], [6])).to_equal [1, 2, 3, 4, 5, 6]

  describe "#methodize()", ->
    it "returns a new function that pushes this as the first argument at call time", ->
      concatenate = (array, arrays...) -> array.concat arrays...
      array = [1, 2, 3]
      array.concatenate = concatenate.methodize()
      expect(array.concatenate [4], [5, 6]).to_equal [1, 2, 3, 4, 5, 6]

  describe "#wrap()", ->
    it "returns a function", ->
      generate_text = -> "I should be wrapped by a div."
      div = generate_text.wrap (func) -> "<div>" + func() + "</div>"
      expect(div()).to_be "<div>I should be wrapped by a div.</div>"

  describe "#compose()", ->

  describe "#clone()", ->
    it "returns the same instance of a function", ->
      func = -> 1 + 1
      expect(func.clone()).to_be func
