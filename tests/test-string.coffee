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
    it "returns a new string containing the first N characters", ->
      expect("123".first 0).to_equal ""
      expect("123".first 1).to_equal "1"
      expect("123".first 2).to_equal "12"
      expect("123".first 3).to_equal "123"
      expect("123".first 10).to_equal "123"

  describe "#last()", ->
    it "returns a new string containing the last N characters", ->
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

  describe "#copy()", ->
    it "returns a copy of the receiver", ->
      string = "String"
      expect(string.copy()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.uniqueStringInstance = "Unique String Instance"
      expect(string.copy().unique_string_instance).to_be undefined
