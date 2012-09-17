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

# ------------------------------------------------------------------------------

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

    it "containing the char codes for individual characters", ->
      expect("Hello World!".codes()).to_equal [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]

    it "also works with control characters", ->
      expect("Hello World!\n".codes()).to_equal [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33, 10]

  describe "#lines()", ->
    it "returns an array of strings by splitting the receiver at \\n", ->
      expect("Hello\nWorld!".lines()).to_equal ["Hello", "World!"]

    it "returns empty strings for empty lines", ->
      expect("Hello\n\nWorld!".lines()).to_equal ["Hello", "", "World!"]

    it "returns an array with one empty string if the string is empty", ->
      expect("".lines()).to_equal [""]

  describe "#paragraphs()", ->
    it "returns an array of strings by splitting the receiver at double new lines \\n\\n", ->
      expect("Hello\n\nWorld!".paragraphs()).to_equal ["Hello", "World!"]

  describe "#prepend()", ->
    it "prepends one string", ->
      expect("World!".prepend "Hello ").to_be "Hello World!"

    it "prepends many strings", ->
      expect("!".prepend "Hello", " ", "World").to_be "Hello World!"

  describe "#append()", ->
    it "appends one string", ->
      expect("Hello ".append "World!").to_be "Hello World!"

    it "appends many strings", ->
      expect("Hello".append " ", "World", "!").to_be "Hello World!"

  describe "#index_of()", ->
    it "returns the index of the first occurence of a string", ->
      expect("Hello World!".index_of "l").to_be 2

  describe "#last_index_of()", ->
    it "returns the index for the last occurence of a string", ->
      expect("Hello World!".last_index_of "l").to_be 9

  describe "#indexes_of()", ->
    it "returns an array of indexes for all occurences of the string", ->
      expect("Hello World!".indexes_of "l").to_equal [2, 3, 9]

  describe "#begins_with()", ->
    it "returns yes if receiver begins with a string", ->
      expect("Hello World!".begins_with "Hello").to_be true

    it "returns no otherwise", ->
      expect("Hello World!".begins_with "Hellow").to_be false

  describe "#ends_with()", ->
    it "returns yes if receiver ends with a string", ->
      expect("Hello World!".ends_with "World!").to_be true

    it "returns no otherwise", ->
      expect("Hello World!".ends_with "World").to_be false

  describe "#uppercased()", ->
    it "returns an uppercased copy of the string", ->
      expect("Hello World!".uppercased()).to_be "HELLO WORLD!"

  describe "#lowercased()", ->
    it "returns a lowercased copy of the string", ->
      expect("Hello World!".lowercased()).to_be "hello world!"

  describe "#capitalized()", ->
    it "returns a copy of the string with the first letter uppercased and all other letters lowercased", ->
      expect("hello World!".capitalized()).to_be "Hello world!"

  describe "#escaped_for_reg_exp()", ->
    it "escapes all 'control' characters", ->
      expect('\.+*?[^]$(){}=!<>|:'.escaped_for_reg_exp()).to_be '\\.\\+\\*\\?\\[\\^\\]\\$\\(\\)\\{\\}\\=\\!\\<\\>\\|\\:'

  describe "#sha1()", ->
    it "generates a string", ->
      expect("1".sha1()).toBeDefined()

    it "has 40 characters", ->
      expect("1".sha1().length).toBe 40

    it "is HEX, i.e. contains only digits and letters A - F", ->
      expect("1".sha1()).toMatch /[0-9a-fA-F]+/

    it "generates correct digests for some example strings", ->
        expect("The quick brown fox jumps over the lazy dog".sha1()).toBe "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12"
