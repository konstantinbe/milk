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

describe "Milk.NumberExtensions", ->
  describe "characters()", ->
    it "returns an array", ->
      expect("".characters()).to_equal []

    it "contaiing individual characters", ->
      expect("Hello World!".characters()).to_equal ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!"]

    it "also works with control characters", ->
      expect("Hello World!\n".characters()).to_equal ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!", "\n"]

  describe "codes", ->
    it "returns an array", ->
      expect("".codes()).to_equal []

    it "contaiing the char codes for individual characters", ->
      expect("Hello World!".codes()).to_equal [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]

    it "also works with control characters", ->
      expect("Hello World!\n".codes()).to_equal [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33, 10]

  describe "words()", ->
    # TODO: specify.

  describe "prepend(strings...)", ->
    it "prepends one string", ->
      expect("World!".prepend "Hello ").to_be "Hello World!"

    it "appends many strings", ->
      expect("!".prepend "Hello", " ", "World").to_be "Hello World!"

  describe "append(strings...)", ->
    it "appends one string", ->
      expect("Hello ".append "World!").to_be "Hello World!"

    it "appends many strings", ->
      expect("Hello".append " ", "World", "!").to_be "Hello World!"

  describe "titleize()", ->
    # TODO: specify.

  describe "humanize()", ->
    # TODO: specify.

  describe "camelize()", ->
    # TODO: specify.

  describe "underscorize()", ->
    # TODO: specify.

  describe "pluralize()", ->
    # TODO: specify.

  describe "dasherize()", ->
    # TODO: specify.

  describe "clone()", ->
    it "returns a clone of the receiver", ->
      string = "String"
      expect(string.clone()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.unique_string_instance = "Unique String Instance"
      expect(string.clone().unique_string_instance).to_be undefined
