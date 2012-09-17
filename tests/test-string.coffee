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

describe "String", ->

  describe "#first()", ->
    it "returns the first character if |count| is not given", ->
      expect("123".first()).to_equal '1'
      expect("".first()).to_be_undefined()

    it "returns a new string containing the first N characters if |count| = N is given", ->
      expect("123".first 0).to_equal ""
      expect("123".first 1).to_equal "1"
      expect("123".first 2).to_equal "12"
      expect("123".first 3).to_equal "123"
      expect("123".first 10).to_equal "123"

  describe "#second()", ->
    it "returns the second character", ->
      expect("123".second()).to_be "2"

  describe "#third()", ->
    it "returns the third character", ->
      expect("123".third()).to_be "3"

  describe "#rest()", ->
    it "returns a new string containing all except the first character", ->
      expect("123".rest()).to_equal "23"

  describe "#last()", ->
    it "returns the last character if |count| is not given", ->
      expect("123".last()).to_be "3"
      expect("".last()).to_be_undefined()

    it "returns a new string containing the last N characters if |count| = N is given", ->
      expect("123".last 0).to_equal ""
      expect("123".last 1).to_equal "3"
      expect("123".last 2).to_equal "23"
      expect("123".last 3).to_equal "123"
      expect("123".last 10).to_equal "123"

  describe "#characters()", ->
    it "returns an array", ->
      expect("".characters()).to_equal []

    it "contaiing individual characters", ->
      expect("Hello World!".characters()).to_equal ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!"]

    it "also works with control characters", ->
      expect("Hello World!\n".characters()).to_equal ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!", "\n"]

  describe "codes()", ->
    it "returns an array", ->
      expect("".codes()).to_equal []

  describe "#is_comparable()", ->
    it "returns true", ->
      value = "string"
      expect(value.is_comparable()).to_be true

  describe "#is_copyable()", ->
    it "returns true", ->
      value = "string"
      expect(value.is_copyable()).to_be true

  describe "#copy()", ->
    it "returns a copy of the receiver", ->
      string = "String"
      expect(string.copy()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.uniqueStringInstance = "Unique String Instance"
      expect(string.copy().unique_string_instance).to_be undefined
