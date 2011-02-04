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
    it "splits a string into words", ->
      expect("HTML5 is great".words()).to_equal ["HTML5", "is", "great"]

    it "removes all non-word characters", ->
      expect("HTML5 is great! <> : {} [] | + =".words()).to_equal ["HTML5", "is", "great"]

    it "also removes underscores", ->
      expect("HTML5_is_great".words()).to_equal ["HTML5", "is", "great"]

    it "doesn't include empty strings", ->
      expect("".words()).to_equal []

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

  describe "index_of(string)", ->
    it "returns the index of the first occurence of string", ->
      expect("Hello World!".index_of "l").to_be 2

  describe "last_index_of(string)", ->
    it "returns the index for the last occurence of string", ->
      expect("Hello World!".last_index_of "l").to_be 9

  describe "indexes_of(string)", ->
    it "returns an array of indexes for all occurences of the string", ->
      expect("Hello World!".indexes_of "l").to_equal [2, 3, 9]

  describe "uppercase()", ->
    it "returns an uppercase copy of the string", ->
      expect("Hello World!".uppercase()).to_be "HELLO WORLD!"

  describe "lowercase()", ->
    it "returns a lowercase copy of the string", ->
      expect("Hello World!".lowercase()).to_be "hello world!"

  describe "capitalize()", ->
    it "returns a copy of the string with the first letter uppercase and all other letters lowercase", ->
      expect("hello World!".capitalize()).to_be "Hello world!"

  describe "underscorize()", ->
    it "splits into words and concatenates with underscores while lowercasing everything", ->
      expect("Hello World!".underscorize()).to_be "hello_world"

  describe "dasherize()", ->
    it "splits into words and concatenates with dashes while lowercasing everything", ->
      expect("Hello World!".dasherize()).to_be "hello-world"

  describe "camelize()", ->
    it "splits into words and concatenates with by capitalizing every word", ->
      expect("hello World!".camelize()).to_be "HelloWorld"

  describe "titleize()", ->
    # TODO: specify.

  describe "humanize()", ->
    # TODO: specify.

  describe "pluralize()", ->
    # TODO: specify.

  describe "clone()", ->
    it "returns a clone of the receiver", ->
      string = "String"
      expect(string.clone()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.unique_string_instance = "Unique String Instance"
      expect(string.clone().unique_string_instance).to_be undefined
