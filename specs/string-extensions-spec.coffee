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

describe "Milk.StringExtensions", ->
  describe "first([count])", ->
    it "returns the first character if |count| is not given", ->
      expect("123".first()).toBe '1'
      expect("".first()).toBe undefined

    it "returns a new string containing the first N characters if |count| = N is given", ->
      expect("123".first 0).toEqual ""
      expect("123".first 1).toEqual "1"
      expect("123".first 2).toEqual "12"
      expect("123".first 3).toEqual "123"
      expect("123".first 10).toEqual "123"

    describe "second()", ->
      it "returns the second character", ->
        expect("123".second()).toBe "2"

    describe "third()", ->
      it "returns the third character", ->
        expect("123".third()).toBe "3"

    describe "rest()", ->
      it "returns a new string containing all except the first character", ->
        expect("123".rest()).toEqual "23"

    describe "last([count])", ->
      it "returns the last character if |count| is not given", ->
        expect("123".last()).toBe "3"
        expect("".last()).toBe undefined

      it "returns a new string containing the last N characters if |count| = N is given", ->
        expect("123".last 0).toEqual ""
        expect("123".last 1).toEqual "3"
        expect("123".last 2).toEqual "23"
        expect("123".last 3).toEqual "123"
        expect("123".last 10).toEqual "123"

    describe "characters()", ->
      it "returns an array", ->
        expect("".characters()).toEqual []

      it "contaiing individual characters", ->
        expect("Hello World!".characters()).toEqual ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!"]

      it "also works with control characters", ->
        expect("Hello World!\n".characters()).toEqual ["H", "e", "l", "l", "o", " ", "W", "o", "r", "l", "d", "!", "\n"]

    describe "codes", ->
      it "returns an array", ->
        expect("".codes()).toEqual []

      it "containing the char codes for individual characters", ->
        expect("Hello World!".codes()).toEqual [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]

      it "also works with control characters", ->
        expect("Hello World!\n".codes()).toEqual [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33, 10]

    describe "words()", ->
      it "splits a string into words", ->
        expect("HTML5 is great".words()).toEqual ["HTML5", "is", "great"]

      it "removes all non-word characters", ->
        expect("HTML5 is great! <> : {} [] | + =".words()).toEqual ["HTML5", "is", "great"]

      it "doesn't split at apostrophes", ->
        expect("Konstantin's MacBook Pro".words()).toEqual ["Konstantins", "Mac", "Book", "Pro"]

      it "also removes underscores", ->
        expect("HTML5_is_great".words()).toEqual ["HTML5", "is", "great"]

      it "doesn't include empty strings", ->
        expect("".words()).toEqual []

      it "works with came cased strings", ->
        expect("HelloWorld!".words()).toEqual ["Hello", "World"]
        expect("helloWorld!".words()).toEqual ["hello", "World"]

      it "preserves acronyms", ->
        expect("HTML".words()).toEqual ["HTML"]
        expect("HTML5 is great!".words()).toEqual ["HTML5", "is", "great"]
        expect("HTML5_is_great!".words()).toEqual ["HTML5", "is", "great"]
        expect("HTML5-is-great!".words()).toEqual ["HTML5", "is", "great"]

      it "preserves acronyms in camel cased strings", ->
        expect("RegularHTMLReader".words()).toEqual ["Regular", "HTML", "Reader"]
        expect("RegularHTML5Reader".words()).toEqual ["Regular", "HTML5", "Reader"]

    describe "lines()", ->
      it "returns an array of strings by splitting the receiver at \\n", ->
        expect("Hello\nWorld!".lines()).toEqual ["Hello", "World!"]

      it "returns empty strings for empty lines", ->
        expect("Hello\n\nWorld!".lines()).toEqual ["Hello", "", "World!"]

      it "returns an array with one empty string if the string is empty", ->
        expect("".lines()).toEqual [""]

    describe "paragraphs()", ->
      it "returns an array of strings by splitting the receiver at double new lines \\n\\n", ->
        expect("Hello\n\nWorld!".paragraphs()).toEqual ["Hello", "World!"]

    describe "prepend(strings...)", ->
      it "prepends one string", ->
        expect("World!".prepend "Hello ").toBe "Hello World!"

      it "appends many strings", ->
        expect("!".prepend "Hello", " ", "World").toBe "Hello World!"

    describe "append(strings...)", ->
      it "appends one string", ->
        expect("Hello ".append "World!").toBe "Hello World!"

      it "appends many strings", ->
        expect("Hello".append " ", "World", "!").toBe "Hello World!"

    describe "index_of(string)", ->
      it "returns the index of the first occurence of string", ->
        expect("Hello World!".index_of "l").toBe 2

    describe "last_index_of(string)", ->
      it "returns the index for the last occurence of string", ->
        expect("Hello World!".last_index_of "l").toBe 9

    describe "indexes_of(string)", ->
      it "returns an array of indexes for all occurences of the string", ->
        expect("Hello World!".indexes_of "l").toEqual [2, 3, 9]

    describe "begins_with(string)", ->
      it "returns yes if receiver begins with string", ->
        expect("Hello World!".begins_with "Hello").toBe true

      it "returns no otherwise", ->
        expect("Hello World!".begins_with "Hellow").toBe false

    describe "ends_with(string)", ->
      it "returns yes if receiver ends with string", ->
        expect("Hello World!".ends_with "World!").toBe true

      it "returns no otherwise", ->
        expect("Hello World!".ends_with "World").toBe false

    describe "uppercased()", ->
      it "returns an uppercased copy of the string", ->
        expect("Hello World!".uppercased()).toBe "HELLO WORLD!"

    describe "lowercased()", ->
      it "returns a lowercased copy of the string", ->
        expect("Hello World!".lowercased()).toBe "hello world!"

    describe "capitalized()", ->
      it "returns a copy of the string with the first letter uppercased and all other letters lowercased", ->
        expect("hello World!".capitalized()).toBe "Hello world!"

    describe "underscorized()", ->
      it "splits into words and concatenates with underscores while lowercasing everything", ->
        expect("Hello World!".underscorized()).toBe "hello_world"

    describe "dasherized()", ->
      it "splits into words and concatenates with dashes while lowercasing everything", ->
        expect("Hello World!".dasherized()).toBe "hello-world"

    describe "camelized()", ->
      it "splits into words and concatenates with by capitalizing every word", ->
        expect("hello World!".camelized()).toBe "HelloWorld"

    describe "titleized()", ->
      it "extracts words and capitalizes every word unless it's insignificant", ->
        expect("Konstantin's macbook pro is Awesome.".titleized()).toBe "Konstantins Macbook Pro is Awesome"

    describe "humanized()", ->
      it "extracts words, makes them all lowercased except the first word", ->
        expect("Konstantin's-macbook_pro$is#Awesome.".humanized()).toBe "Konstantins macbook pro is awesome"

    describe "escaped()", ->
      expect('\.+*?[^]$(){}=!<>|:'.escaped for: 'reg_exp').toBe '\\.\\+\\*\\?\\[\\^\\]\\$\\(\\)\\{\\}\\=\\!\\<\\>\\|\\:'

    describe "pluralized()", ->
      it "standard pluralization", ->
        expect('Goat'.pluralized()).toBe 'Goats'

      it "standard pluralization of a multi-word string", ->
        expect('There are many goat'.pluralized()).toBe 'There are many goats'

      it "non-standard pluralization", ->
        expect('Bunny'.pluralized()).toBe 'Bunnies'

      it "non-standard pluralization of a multi-word string", ->
        expect('I like bunny'.pluralized()).toBe 'I like bunnies'

      it "irregular pluralization", ->
        expect('child'.pluralized()).toBe 'children'

      it "irregular pluralization of a multi-word string", ->
        expect('I have three child'.pluralized()).toBe 'I have three children'

      it "uncountable pluralization", ->
        expect('sheep'.pluralized()).toBe 'sheep'

      it "uncountable pluralization of a multi-word string", ->
        expect('Please hold this sheep'.pluralized()).toBe 'Please hold this sheep'

    describe "singularized()", ->
      it "standard singularization", ->
        expect('Vegetables'.singularized()).toBe 'Vegetable'

      it "standard singularization of a multi-word string", ->
        expect('Broccoli is a vegetables'.singularized()).toBe 'Broccoli is a vegetable'

      it "non-standard singularization", ->
        expect('Properties'.singularized()).toBe 'Property'

      it "non-standard singularization of a multi-word string", ->
        expect('Buy a properties'.singularized()).toBe 'Buy a property'

      it "irregular singularization", ->
        expect('people'.singularized()).toBe 'person'

      it "irregular singularization of a multi-word string", ->
        expect('The Village People'.singularized()).toBe 'The Village Person'

      it "uncountable singularization", ->
        expect('money'.singularized()).toBe 'money'

      it "uncountable singularization of a multi-word string", ->
        expect('Gotta git da money'.singularized()).toBe 'Gotta git da money'

    describe "normalized()", ->
      it "removes diactrics, i.e. converts characters with diactrics to normal characters", ->
        string = "ÀÁÂÃÄÅĀĂĄǍǞǠǺȀȂȦḀẠẢẤẦẨẪẬẮẰẲẴẶÅḂḄḆÇĆĈĊČḈĎḊḌḎḐḒÈÉÊËĒĔĖĘĚȄȆȨḔḖḘḚḜẸẺẼẾỀỂỄỆḞĜĞĠĢǦǴḠĤȞḢḤḦḨḪÌÍÎÏĨĪĬĮİǏȈȊḬḮỈỊĴĶǨḰḲḴĹĻĽḶḸḺḼḾṀṂÑŃŅŇǸṄṆṈṊÒÓÔÕÖŌŎŐƠǑǪǬȌȎȪȬȮȰṌṎṐṒỌỎỐỒỔỖỘỚỜỞỠỢṔṖŔŖŘȐȒṘṚṜṞŚŜŞŠȘṠṢṤṦṨŢŤȚṪṬṮṰÙÚÛÜŨŪŬŮŰŲƯǓǕǗǙǛȔȖṲṴṶṸṺỤỦỨỪỬỮỰṼṾŴẀẂẄẆẈẊẌÝŶŸȲẎỲỴỶỸŹŻŽẐẒẔ`àáâãäåāăąǎǟǡǻȁȃȧḁạảấầẩẫậắằẳẵặḃḅḇçćĉċčḉďḋḍḏḑḓèéêëēĕėęěȅȇȩḕḗḙḛḝẹẻẽếềểễệḟĝğġģǧǵḡĥȟḣḥḧḩḫẖìíîïĩīĭįǐȉȋḭḯỉịĵǰķǩḱḳḵĺļľḷḹḻḽḿṁṃñńņňǹṅṇṉṋòóôõöōŏőơǒǫǭȍȏȫȭȯȱṍṏṑṓọỏốồổỗộớờởỡợṕṗŕŗřȑȓṙṛṝṟśŝşšșṡṣṥṧṩţťțṫṭṯṱẗùúûüũūŭůűųưǔǖǘǚǜȕȗṳṵṷṹṻụủứừửữựṽṿŵẁẃẅẇẉẘẋẍýÿŷȳẏẙỳỵỷỹźżžẑẓẕ"
        normalized = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBCCCCCCDDDDDDEEEEEEEEEEEEEEEEEEEEEEEEEFGGGGGGGHHHHHHHIIIIIIIIIIIIIIIIJKKKKKLLLLLLLMMMNNNNNNNNNOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOPPRRRRRRRRRSSSSSSSSSSTTTTTTTUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUVVWWWWWWXXYYYYYYYYYZZZZZZ`aaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbccccccddddddeeeeeeeeeeeeeeeeeeeeeeeeefggggggghhhhhhhhiiiiiiiiiiiiiiijjkkkkklllllllmmmnnnnnnnnnoooooooooooooooooooooooooooooooooopprrrrrrrrrssssssssssttttttttuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuvvwwwwwwwxxyyyyyyyyyyzzzzzz"
        expect(string.normalized()).toBe normalized

    describe "sha1()", ->
      it "generates a string", ->
        expect("1".sha1()).toBeDefined()

      it "has 40 characters", ->
        expect("1".sha1().length).toBe 40

      it "is HEX, i.e. contains only digits and letters A - F", ->
        expect("1".sha1()).toMatch /[0-9a-fA-F]+/

      it "generates correct digests for some example strings", ->
          expect("The quick brown fox jumps over the lazy dog".sha1()).toBe "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12"

    describe "clone()", ->
      it "returns a clone of the receiver", ->
        string = "String"
        expect(string.clone()).toEqual "String"

      it "which is not the same instance", ->
        string = "String"
        string.unique_string_instance = "Unique String Instance"
        expect(string.clone().unique_string_instance).toBe undefined
