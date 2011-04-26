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
#
# Methods singularized(), pluralized(), escaped(), and normalized() are based
# on code from SproutCore: http://github/sproutcore/sproutcore
#
# Method sha1() is based on code from ttp://www.webtoolkit.info/ and the SHA-1
# implementation in JavaScript by Chris Veness, http://www.movable-type.co.uk/
#
# Methods utf8() and utf16() are using the brilliant URL encoding/decoding trick
# described here:
# http://ecmanaut.blogspot.com/2006/07/encoding-decoding-utf8-in-javascript.html

PLURAL = [
  [/(quiz)$/i,               "$1zes"  ]
  [/^(ox)$/i,                "$1en"   ]
  [/([m|l])ouse$/i,          "$1ice"  ]
  [/(matr|vert|ind)ix|ex$/i, "$1ices" ]
  [/(x|ch|ss|sh)$/i,         "$1es"   ]
  [/([^aeiouy]|qu)y$/i,      "$1ies"  ]
  [/(hive)$/i,               "$1s"    ]
  [/(?:([^f])fe|([lr])f)$/i, "$1$2ves"]
  [/sis$/i,                  "ses"    ]
  [/([ti])um$/i,             "$1a"    ]
  [/(buffal|tomat)o$/i,      "$1oes"  ]
  [/(bu)s$/i,                "$1ses"  ]
  [/(alias|status)$/i,       "$1es"   ]
  [/(octop|vir)us$/i,        "$1i"    ]
  [/(ax|test)is$/i,          "$1es"   ]
  [/s$/i,                    "s"      ]
  [/$/,                      "s"      ]
]

SINGULAR = [
  [/(quiz)zes$/i,                                                    "$1"     ]
  [/(matr)ices$/i,                                                   "$1ix"   ]
  [/(vert|ind)ices$/i,                                               "$1ex"   ]
  [/^(ox)en/i,                                                       "$1"     ]
  [/(alias|status)es$/i,                                             "$1"     ]
  [/(octop|vir)i$/i,                                                 "$1us"   ]
  [/(cris|ax|test)es$/i,                                             "$1is"   ]
  [/(shoe)s$/i,                                                      "$1"     ]
  [/(o)es$/i,                                                        "$1"     ]
  [/(bus)es$/i,                                                      "$1"     ]
  [/([m|l])ice$/i,                                                   "$1ouse" ]
  [/(x|ch|ss|sh)es$/i,                                               "$1"     ]
  [/(m)ovies$/i,                                                     "$1ovie" ]
  [/(s)eries$/i,                                                     "$1eries"]
  [/([^aeiouy]|qu)ies$/i,                                            "$1y"    ]
  [/([lr])ves$/i,                                                    "$1f"    ]
  [/(tive)s$/i,                                                      "$1"     ]
  [/(hive)s$/i,                                                      "$1"     ]
  [/([^f])ves$/i,                                                    "$1fe"   ]
  [/(^analy)ses$/i,                                                  "$1sis"  ]
  [/((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$/i, "$1$2sis"]
  [/([ti])a$/i,                                                      "$1um"   ]
  [/(n)ews$/i,                                                       "$1ews"  ]
  [/s$/i,                                                            ""       ]
]

IRREGULAR = [
  ['move',   'moves'   ]
  ['sex',    'sexes'   ]
  ['child',  'children']
  ['man',    'men'     ]
  ['person', 'people'  ]
]

UNCOUNTABLE = [
  "milk"
  "sheep"
  "fish"
  "series"
  "species"
  "money"
  "rice"
  "information"
  "info"
  "equipment"
  "data"
]

split_into_prefix_word_and_suffix = (string) ->
  [whole, prefix, word, suffix] = string.match /^(.*\s)?(\w*)(\W*)$/
  prefix ?= ""
  suffix ?= ""
  [prefix, word, suffix]

is_uncountable = (word) ->
  UNCOUNTABLE.contains word.lowercased()

pluralize_irregular = (word, capitalize) ->
  lowercased_word = word.lowercased()
  entry = IRREGULAR.detect ([singular, plural]) -> singular is lowercased_word
  if entry then entry.second() else null

pluralize_regular = (word, capitalize) ->
  for [pattern, replacement] in PLURAL
    return word.replace(pattern, replacement) if word.search(pattern) >= 0
  null

singularize_irregular = (word) ->
  lowercased_word = word.lowercased()
  entry = IRREGULAR.detect ([singular, plural]) -> plural is lowercased_word
  if entry then entry.first() else null

singularize_regular = (word) ->
  for [pattern, replacement] in SINGULAR
    return word.replace(pattern, replacement) if word.search(pattern) >= 0
  null

StringExtensions =
  first: (count) ->
    return @[0] unless count?
    @slice 0, count

  second: ->
    @[1]

  third: ->
    @[2]

  rest: ->
    @slice 1

  last: (count) ->
    return @[@length - 1] unless count?
    return "" if count is 0
    @slice -count

  # ----------------------------------------------------------------------------

  characters: ->
    @split ""

  codes: ->
    @characters().map (character) -> character.charCodeAt 0

  words: ->
    cleaned = @clone().replace("'", "").replace(/[\W|_]+/g, " ").replace(/([a-z]|\d)([A-Z])/g, "$1 $2").replace(/([A-Z]|\d)([a-z])/g, " $1$2")
    trimmed = cleaned.trim()
    words = trimmed.split " "
    words.select (word) -> word.length > 0

  lines: ->
    @split "\n"

  paragraphs: ->
    @split "\n\n"

  # ----------------------------------------------------------------------------

  prepend: (strings...) ->
    "".concat strings..., this

  append: (strings...) ->
    @concat strings...

  index_of: (string) ->
    @indexOf string

  last_index_of: (string) ->
    @lastIndexOf string

  indexes_of: (string) ->
    indexes = []
    index = @indexOf string
    while index >= 0
      indexes.add index
      index = @indexOf string, index + 1
    indexes

  begins_with: (string) ->
    @index_of(string) == 0

  ends_with: (string) ->
    @index_of(string) == this.length - string.length

  # ----------------------------------------------------------------------------

  uppercased: ->
    @toUpperCase()

  lowercased: ->
    @toLowerCase()

  capitalized: ->
    return "" if @length == 0
    first = @[0]
    rest = @substr 1
    first.uppercased() + rest.lowercased()

  underscorized: ->
    @lowercased().words().join "_"

  dasherized: ->
    @lowercased().words().join "-"

  camelized: ->
    capitalized_words = @lowercased().words().collect (word) -> word.capitalized()
    capitalized_words.join ""

  titleized: ->
    String::insignificant_words ?= {a: yes, an: yes, the: yes, at: yes, by: yes, for: yes, in: yes, of: yes, off: yes, on: yes, out: yes, to: yes, up: yes, and: yes, as: yes, but: yes, if: yes, or: yes, nor: yes, is: yes}
    titleized_words = @lowercased().words().collect (word) ->
      is_insignificant = String::insignificant_words[word]?
      if is_insignificant then word else word.capitalized()
    titleized_words.join " "

  humanized: ->
    return "" if @length == 0
    words = @lowercased().words()
    words[0] = words[0].capitalized()
    words.join " "

  pluralized: ->
    [prefix, word, suffix] = split_into_prefix_word_and_suffix this
    lowercased_word = word.lowercased()
    pluralized_word = null
    pluralized_word ?= lowercased_word if is_uncountable lowercased_word
    pluralized_word ?= irregular if irregular = pluralize_irregular lowercased_word
    pluralized_word ?= regular if regular = pluralize_regular lowercased_word
    pluralized_word ?= lowercased_word
    prefix + word.first() + pluralized_word.rest() + suffix

  singularized: ->
    [prefix, word, suffix] = split_into_prefix_word_and_suffix this
    lowercased_word = word.lowercased()
    singularized_word = null
    singularized_word ?= lowercased_word if is_uncountable lowercased_word
    singularized_word ?= irregular if irregular = singularize_irregular lowercased_word
    singularized_word ?= regular if regular = singularize_regular lowercased_word
    singularized_word ?= lowercased_word
    prefix + word.first() + singularized_word.rest() + suffix

  escaped: (options = {}) ->
    options['for'] ?= 'reg_exp'
    if options['for'] is 'reg_exp'
      return @clone().replace /([\\\.\+\*\?\[\^\]\$\(\)\{\}\=\!\<\>\|\:])/g, "\\$1"
    this

  clone: ->
    new String(this)

  description: ->
    "'" + this + "'"

  utf8: ->
    unescape encodeURIComponent this

  utf16: ->
    decodeURIComponent escape this

  sha1: ->
    rotate_left = (n, s) -> (n << s) | (n >>> (32 - s))

    f = (s, x, y, z) ->
      switch s
        when 0 then (x & y) ^ (~x & z)
        when 1 then x ^ y ^ z
        when 2 then (x & y) ^ (x & z) ^ (y & z)
        when 3 then x ^ y ^ z

    to_hex = (number) ->
      [7..0].inject "", (string, i) ->
        intermediate = (number >>> (i * 4)) & 0x0f
        string += intermediate.toString 16

    string = this.utf8()
    string += String.fromCharCode 0x80

    K = [0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6]
    l = string.length / 4 + 2
    N = Math.ceil l / 16

    M = new Array(N)
    W = new Array(80)

    H0 = 0x67452301
    H1 = 0xefcdab89
    H2 = 0x98badcfe
    H3 = 0x10325476
    H4 = 0xc3d2e1f0

    for i in [0...N]
      M[i] = new Array(16)
      for j in [0...16]
        M[i][j] = (string.charCodeAt(i * 64 + j * 4) << 24) |
                  (string.charCodeAt(i * 64 + j * 4 + 1) << 16) |
                  (string.charCodeAt(i * 64 + j * 4 + 2) << 8) |
                  (string.charCodeAt(i * 64 + j * 4 + 3))

    M[N - 1][14] = (string.length - 1) * 8 / Math.pow 2, 32
    M[N - 1][14] = Math.floor M[N - 1][14]
    M[N - 1][15] = ((string.length - 1) * 8) & 0xffffffff

    for i in [0...N]
      W[t] = M[i][t] for t in [0...16]
      W[t] = rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1) for t in [16...80]

      a = H0;
      b = H1;
      c = H2;
      d = H3;
      e = H4;

      for t in [0...80]
        s = Math.floor t / 20
        T = (rotate_left(a, 5) + f(s, b, c, d) + e + K[s] + W[t]) & 0xffffffff
        e = d
        d = c
        c = rotate_left b, 30
        b = a
        a = T

      H0 = (H0 + a) & 0xffffffff
      H1 = (H1 + b) & 0xffffffff
      H2 = (H2 + c) & 0xffffffff
      H3 = (H3 + d) & 0xffffffff
      H4 = (H4 + e) & 0xffffffff

    to_hex(H0) + to_hex(H1) + to_hex(H2) + to_hex(H3) + to_hex(H4)
