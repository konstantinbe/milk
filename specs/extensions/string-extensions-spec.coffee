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
describe "first([count])", ->
  it "returns the first character if |count| is not given", ->
    expect("123".first()).to_be '1'
    expect("".first()).to_be undefined

  it "returns a new string containing the first N characters if |count| = N is given", ->
    expect("123".first 0).to_equal ""
    expect("123".first 1).to_equal "1"
    expect("123".first 2).to_equal "12"
    expect("123".first 3).to_equal "123"
    expect("123".first 10).to_equal "123"

  describe "second()", ->
    it "returns the second character", ->
      expect("123".second()).to_be "2"

  describe "third()", ->
    it "returns the third character", ->
      expect("123".third()).to_be "3"

  describe "rest()", ->
    it "returns a new string containing all except the first character", ->
      expect("123".rest()).to_equal "23"

  describe "last([count])", ->
    it "returns the last character if |count| is not given", ->
      expect("123".last()).to_be "3"
      expect("".last()).to_be undefined

    it "returns a new string containing the last N characters if |count| = N is given", ->
      expect("123".last 0).to_equal ""
      expect("123".last 1).to_equal "3"
      expect("123".last 2).to_equal "23"
      expect("123".last 3).to_equal "123"
      expect("123".last 10).to_equal "123"

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

  describe "uppercased()", ->
    it "returns an uppercased copy of the string", ->
      expect("Hello World!".uppercased()).to_be "HELLO WORLD!"

  describe "lowercased()", ->
    it "returns a lowercased copy of the string", ->
      expect("Hello World!".lowercased()).to_be "hello world!"

  describe "capitalized()", ->
    it "returns a copy of the string with the first letter uppercased and all other letters lowercased", ->
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
    it "extracts words, makes them all lowercased except the first word", ->
      expect("Konstantin's-macbook_pro$is#Awesome.".humanized()).to_be "Konstantins macbook pro is awesome"

  describe "escaped()", ->
    expect('\.+*?[^]$(){}=!<>|:'.escaped for: 'reg_exp').to_be '\\.\\+\\*\\?\\[\\^\\]\\$\\(\\)\\{\\}\\=\\!\\<\\>\\|\\:'

  describe "pluralized()", ->
    it "standard pluralization", ->
      expect('Goat'.pluralized()).to_be 'Goats'

    it "standard pluralization of a multi-word string", ->
      expect('There are many goat'.pluralized()).to_be 'There are many goats'

    it "non-standard pluralization", ->
      expect('Bunny'.pluralized()).to_be 'Bunnies'

    it "non-standard pluralization of a multi-word string", ->
      expect('I like bunny'.pluralized()).to_be 'I like bunnies'

    it "irregular pluralization", ->
      expect('child'.pluralized()).to_be 'children'

    it "irregular pluralization of a multi-word string", ->
      expect('I have three child'.pluralized()).to_be 'I have three children'

    it "uncountable pluralization", ->
      expect('sheep'.pluralized()).to_be 'sheep'

    it "uncountable pluralization of a multi-word string", ->
      expect('Please hold this sheep'.pluralized()).to_be 'Please hold this sheep'

  describe "singularized()", ->
    it "standard singularization", ->
      expect('Vegetables'.singularized()).to_be 'Vegetable'

    it "standard singularization of a multi-word string", ->
      expect('Broccoli is a vegetables'.singularized()).to_be 'Broccoli is a vegetable'

    it "non-standard singularization", ->
      expect('Properties'.singularized()).to_be 'Property'

    it "non-standard singularization of a multi-word string", ->
      expect('Buy a properties'.singularized()).to_be 'Buy a property'

    it "irregular singularization", ->
      expect('people'.singularized()).to_be 'person'

    it "irregular singularization of a multi-word string", ->
      expect('The Village People'.singularized()).to_be 'The Village Person'

    it "uncountable singularization", ->
      expect('money'.singularized()).to_be 'money'

    it "uncountable singularization of a multi-word string", ->
      expect('Gotta git da money'.singularized()).to_be 'Gotta git da money'

  describe "normalized()", ->
    it "removes diactrics, i.e. converts characters with diactrics to normal characters", ->
      string = "ÀÁÂÃÄÅĀĂĄǍǞǠǺȀȂȦḀẠẢẤẦẨẪẬẮẰẲẴẶÅḂḄḆÇĆĈĊČḈĎḊḌḎḐḒÈÉÊËĒĔĖĘĚȄȆȨḔḖḘḚḜẸẺẼẾỀỂỄỆḞĜĞĠĢǦǴḠĤȞḢḤḦḨḪÌÍÎÏĨĪĬĮİǏȈȊḬḮỈỊĴĶǨḰḲḴĹĻĽḶḸḺḼḾṀṂÑŃŅŇǸṄṆṈṊÒÓÔÕÖŌŎŐƠǑǪǬȌȎȪȬȮȰṌṎṐṒỌỎỐỒỔỖỘỚỜỞỠỢṔṖŔŖŘȐȒṘṚṜṞŚŜŞŠȘṠṢṤṦṨŢŤȚṪṬṮṰÙÚÛÜŨŪŬŮŰŲƯǓǕǗǙǛȔȖṲṴṶṸṺỤỦỨỪỬỮỰṼṾŴẀẂẄẆẈẊẌÝŶŸȲẎỲỴỶỸŹŻŽẐẒẔ`àáâãäåāăąǎǟǡǻȁȃȧḁạảấầẩẫậắằẳẵặḃḅḇçćĉċčḉďḋḍḏḑḓèéêëēĕėęěȅȇȩḕḗḙḛḝẹẻẽếềểễệḟĝğġģǧǵḡĥȟḣḥḧḩḫẖìíîïĩīĭįǐȉȋḭḯỉịĵǰķǩḱḳḵĺļľḷḹḻḽḿṁṃñńņňǹṅṇṉṋòóôõöōŏőơǒǫǭȍȏȫȭȯȱṍṏṑṓọỏốồổỗộớờởỡợṕṗŕŗřȑȓṙṛṝṟśŝşšșṡṣṥṧṩţťțṫṭṯṱẗùúûüũūŭůűųưǔǖǘǚǜȕȗṳṵṷṹṻụủứừửữựṽṿŵẁẃẅẇẉẘẋẍýÿŷȳẏẙỳỵỷỹźżžẑẓẕ"
      normalized = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBCCCCCCDDDDDDEEEEEEEEEEEEEEEEEEEEEEEEEFGGGGGGGHHHHHHHIIIIIIIIIIIIIIIIJKKKKKLLLLLLLMMMNNNNNNNNNOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOPPRRRRRRRRRSSSSSSSSSSTTTTTTTUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUVVWWWWWWXXYYYYYYYYYZZZZZZ`aaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbccccccddddddeeeeeeeeeeeeeeeeeeeeeeeeefggggggghhhhhhhhiiiiiiiiiiiiiiijjkkkkklllllllmmmnnnnnnnnnoooooooooooooooooooooooooooooooooopprrrrrrrrrssssssssssttttttttuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuvvwwwwwwwxxyyyyyyyyyyzzzzzz"
      expect(string.normalized()).to_be normalized

  describe "clone()", ->
    it "returns a clone of the receiver", ->
      string = "String"
      expect(string.clone()).to_equal "String"

    it "which is not the same instance", ->
      string = "String"
      string.unique_string_instance = "Unique String Instance"
      expect(string.clone().unique_string_instance).to_be undefined