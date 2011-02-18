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

    it "containing the char codes for individual characters", ->
      expect("Hello World!".codes()).to_equal [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]

    it "also works with control characters", ->
      expect("Hello World!\n".codes()).to_equal [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33, 10]

  describe "words()", ->
    it "splits a string into words", ->
      expect("HTML5 is great".words()).to_equal ["HTML5", "is", "great"]

    it "removes all non-word characters", ->
      expect("HTML5 is great! <> : {} [] | + =".words()).to_equal ["HTML5", "is", "great"]

    it "doesn't split at apostrophes", ->
      expect("Konstantin's MacBook Pro".words()).to_equal ["Konstantins", "Mac", "Book", "Pro"]

    it "also removes underscores", ->
      expect("HTML5_is_great".words()).to_equal ["HTML5", "is", "great"]

    it "doesn't include empty strings", ->
      expect("".words()).to_equal []

    it "works with came cased strings", ->
      expect("HelloWorld!".words()).to_equal ["Hello", "World"]
      expect("helloWorld!".words()).to_equal ["hello", "World"]

    it "preserves acronyms", ->
      expect("HTML".words()).to_equal ["HTML"]
      expect("HTML5 is great!".words()).to_equal ["HTML5", "is", "great"]
      expect("HTML5_is_great!".words()).to_equal ["HTML5", "is", "great"]
      expect("HTML5-is-great!".words()).to_equal ["HTML5", "is", "great"]

    it "preserves acronyms in camel cased strings", ->
      expect("RegularHTMLReader".words()).to_equal ["Regular", "HTML", "Reader"]
      expect("RegularHTML5Reader".words()).to_equal ["Regular", "HTML5", "Reader"]

  describe "lines()", ->
    it "returns an array of strings by splitting the receiver at \\n", ->
      expect("Hello\nWorld!".lines()).to_equal ["Hello", "World!"]

    it "returns empty strings for empty lines", ->
      expect("Hello\n\nWorld!".lines()).to_equal ["Hello", "", "World!"]

    it "returns an array with one empty string if the string is empty", ->
      expect("".lines()).to_equal [""]

  describe "paragraphs()", ->
    it "returns an array of strings by splitting the receiver at double new lines \\n\\n", ->
      expect("Hello\n\nWorld!".paragraphs()).to_equal ["Hello", "World!"]

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

  describe "begins_with(string)", ->
    it "returns yes if receiver begins with string", ->
      expect("Hello World!".begins_with "Hello").to_be true

    it "returns no otherwise", ->
      expect("Hello World!".begins_with "Hellow").to_be false

  describe "ends_with(string)", ->
    it "returns yes if receiver ends with string", ->
      expect("Hello World!".ends_with "World!").to_be true

    it "returns no otherwise", ->
      expect("Hello World!".ends_with "World").to_be false

  describe "uppercase()", ->
    it "returns an uppercase copy of the string", ->
      expect("Hello World!".uppercase()).to_be "HELLO WORLD!"

  describe "lowercase()", ->
    it "returns a lowercase copy of the string", ->
      expect("Hello World!".lowercase()).to_be "hello world!"

  describe "capitalized()", ->
    it "returns a copy of the string with the first letter uppercase and all other letters lowercase", ->
      expect("hello World!".capitalized()).to_be "Hello world!"

  describe "underscorized()", ->
    it "splits into words and concatenates with underscores while lowercasing everything", ->
      expect("Hello World!".underscorized()).to_be "hello_world"

  describe "dasherized()", ->
    it "splits into words and concatenates with dashes while lowercasing everything", ->
      expect("Hello World!".dasherized()).to_be "hello-world"

  describe "camelized()", ->
    it "splits into words and concatenates with by capitalizing every word", ->
      expect("hello World!".camelized()).to_be "HelloWorld"

  describe "titleized()", ->
    it "extracts words and capitalizes every word unless it's insignificant", ->
      expect("Konstantin's macbook pro is Awesome.".titleized()).to_be "Konstantins Macbook Pro is Awesome"

  describe "humanized()", ->
    it "extracts words, makes them all lowercase except the first word", ->
      expect("Konstantin's-macbook_pro$is#Awesome.".humanized()).to_be "Konstantins macbook pro is awesome"

  describe "plural()", ->

  describe "singular()", ->

  describe "clone()", ->
    it "returns a clone of the receiver", ->
      string = "String"
      expect(string.clone()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.unique_string_instance = "Unique String Instance"
      expect(string.clone().unique_string_instance).to_be undefined
