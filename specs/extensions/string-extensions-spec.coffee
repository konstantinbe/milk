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
        expect("1".sha1().length).toBe(40)

      it "is HEX, i.e. contains only digits and letters A - F", ->
        expect("1".sha1()).toMatch(/[0-9a-fA-F]+/)

      it "returns the same result as the original JavaScript implementation by http://www.webtoolkit.info/", ->
        ["1", "Konstantin", "CoffeeScript is awesome!", "Less is more."].each (string) ->
          expect(string.sha1()).toBe(original_sha1_implementation(string))

    describe "clone()", ->
      it "returns a clone of the receiver", ->
        string = "String"
        expect(string.clone()).toEqual "String"

      it "which is not the same instance", ->
        string = "String"
        string.unique_string_instance = "Unique String Instance"
        expect(string.clone().unique_string_instance).toBe undefined

original_sha1_implementation = `function SHA1(msg) {
    /**
    *
    *  Secure Hash Algorithm (SHA1)
    *  http://www.webtoolkit.info/
    *
    **/

    function rotate_left(n, s) {
        var t4 = (n << s) | (n >>> (32 - s));
        return t4;
    };

    function lsb_hex(val) {
        var str = "";
        var i;
        var vh;
        var vl;

        for (i = 0; i <= 6; i += 2) {
            vh = (val >>> (i * 4 + 4)) & 0x0f;
            vl = (val >>> (i * 4)) & 0x0f;
            str += vh.toString(16) + vl.toString(16);
        }
        return str;
    };

    function cvt_hex(val) {
        var str = "";
        var i;
        var v;

        for (i = 7; i >= 0; i--) {
            v = (val >>> (i * 4)) & 0x0f;
            str += v.toString(16);
        }
        return str;
    };


    function Utf8Encode(string) {
        string = string.replace(/\r\n/g, "\n");
        var utftext = "";

        for (var n = 0; n < string.length; n++) {

            var c = string.charCodeAt(n);

            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if ((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }

        return utftext;
    };

    var blockstart;
    var i,
    j;
    var W = new Array(80);
    var H0 = 0x67452301;
    var H1 = 0xEFCDAB89;
    var H2 = 0x98BADCFE;
    var H3 = 0x10325476;
    var H4 = 0xC3D2E1F0;
    var A,
    B,
    C,
    D,
    E;
    var temp;

    msg = Utf8Encode(msg);

    var msg_len = msg.length;

    var word_array = new Array();
    for (i = 0; i < msg_len - 3; i += 4) {
        j = msg.charCodeAt(i) << 24 | msg.charCodeAt(i + 1) << 16 |
        msg.charCodeAt(i + 2) << 8 | msg.charCodeAt(i + 3);
        word_array.push(j);
    }

    switch (msg_len % 4) {
    case 0:
        i = 0x080000000;
        break;
    case 1:
        i = msg.charCodeAt(msg_len - 1) << 24 | 0x0800000;
        break;

    case 2:
        i = msg.charCodeAt(msg_len - 2) << 24 | msg.charCodeAt(msg_len - 1) << 16 | 0x08000;
        break;

    case 3:
        i = msg.charCodeAt(msg_len - 3) << 24 | msg.charCodeAt(msg_len - 2) << 16 | msg.charCodeAt(msg_len - 1) << 8 | 0x80;
        break;
    }

    word_array.push(i);

    while ((word_array.length % 16) != 14) word_array.push(0);

    word_array.push(msg_len >>> 29);
    word_array.push((msg_len << 3) & 0x0ffffffff);


    for (blockstart = 0; blockstart < word_array.length; blockstart += 16) {

        for (i = 0; i < 16; i++) W[i] = word_array[blockstart + i];
        for (i = 16; i <= 79; i++) W[i] = rotate_left(W[i - 3] ^ W[i - 8] ^ W[i - 14] ^ W[i - 16], 1);

        A = H0;
        B = H1;
        C = H2;
        D = H3;
        E = H4;

        for (i = 0; i <= 19; i++) {
            temp = (rotate_left(A, 5) + ((B & C) | (~B & D)) + E + W[i] + 0x5A827999) & 0x0ffffffff;
            E = D;
            D = C;
            C = rotate_left(B, 30);
            B = A;
            A = temp;
        }

        for (i = 20; i <= 39; i++) {
            temp = (rotate_left(A, 5) + (B ^ C ^ D) + E + W[i] + 0x6ED9EBA1) & 0x0ffffffff;
            E = D;
            D = C;
            C = rotate_left(B, 30);
            B = A;
            A = temp;
        }

        for (i = 40; i <= 59; i++) {
            temp = (rotate_left(A, 5) + ((B & C) | (B & D) | (C & D)) + E + W[i] + 0x8F1BBCDC) & 0x0ffffffff;
            E = D;
            D = C;
            C = rotate_left(B, 30);
            B = A;
            A = temp;
        }

        for (i = 60; i <= 79; i++) {
            temp = (rotate_left(A, 5) + (B ^ C ^ D) + E + W[i] + 0xCA62C1D6) & 0x0ffffffff;
            E = D;
            D = C;
            C = rotate_left(B, 30);
            B = A;
            A = temp;
        }

        H0 = (H0 + A) & 0x0ffffffff;
        H1 = (H1 + B) & 0x0ffffffff;
        H2 = (H2 + C) & 0x0ffffffff;
        H3 = (H3 + D) & 0x0ffffffff;
        H4 = (H4 + E) & 0x0ffffffff;

    }

    var temp = cvt_hex(H0) + cvt_hex(H1) + cvt_hex(H2) + cvt_hex(H3) + cvt_hex(H4);

    return temp.toLowerCase();
}`
