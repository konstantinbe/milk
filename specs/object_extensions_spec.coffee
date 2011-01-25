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

  describe "is_regexp(value)", ->
    it "returns yes if receiver is a regular expression", ->
      expect(//.is_regexp()).to_be true
