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

  values: ->
    @characters()

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
    [whole, prefix, word, suffix] = @match /^(.*\s)?(\w*)(\W*)$/
    prefix ?= ""
    suffix ?= ""

    return whole if UNCOUNTABLE.contains word

    entry = IRREGULAR.detect ([singular, plural]) -> singular is word
    return prefix + entry.second() + suffix if entry

    for [pattern, replacement] in PLURAL
      return prefix + word.replace(pattern, replacement) + suffix if word.search(pattern) >= 0
    false

    whole # return the whole string if can't pluralize

  singularized: ->
    # var idx, len,
    #     compare = this.split(/\s/).pop(), //check only the last word of a string
    #     restOfString = this.replace(compare,''),
    #     isCapitalized = compare.charAt(0).match(/[A-Z]/) ? true : false;
    #
    # compare = compare.toLowerCase();
    # for (idx=0, len=SC.INFLECTION_CONSTANTS.UNCOUNTABLE.length; idx < len; idx++) {
    #     var uncountable = SC.INFLECTION_CONSTANTS.UNCOUNTABLE[idx];
    #     if (compare == uncountable) {
    #         return this.toString();
    #     }
    # }
    # for (idx=0, len=SC.INFLECTION_CONSTANTS.IRREGULAR.length; idx < len; idx++) {
    #     var singular = SC.INFLECTION_CONSTANTS.IRREGULAR[idx][0],
    #         plural   = SC.INFLECTION_CONSTANTS.IRREGULAR[idx][1];
    #     if ((compare == singular) || (compare == plural)) {
    #         if(isCapitalized) singular = singular.capitalize();
    #         return restOfString + singular;
    #     }
    # }
    # for (idx=0, len=SC.INFLECTION_CONSTANTS.SINGULAR.length; idx < len; idx++) {
    #     var regex          = SC.INFLECTION_CONSTANTS.SINGULAR[idx][0],
    #         replace_string = SC.INFLECTION_CONSTANTS.SINGULAR[idx][1];
    #     if (regex.test(compare)) {
    #         return this.replace(regex, replace_string);
    #     }
    # }

  escaped: (options = {}) ->
    options['for'] ?= 'reg_exp'
    if options['for'] is 'reg_exp'
      return @clone().replace /([\\\.\+\*\?\[\^\]\$\(\)\{\}\=\!\<\>\|\:])/g, "\\$1"
    this

  normalized: ->
    diactrict_mapping_table = @normalized.diactrict_mapping_table ?=
      'À':'A', 'Á':'A', 'Â':'A', 'Ã':'A', 'Ä':'A', 'Å':'A', 'Ā':'A', 'Ă':'A',
      'Ą':'A', 'Ǎ':'A', 'Ǟ':'A', 'Ǡ':'A', 'Ǻ':'A', 'Ȁ':'A', 'Ȃ':'A', 'Ȧ':'A',
      'Ḁ':'A', 'Ạ':'A', 'Ả':'A', 'Ấ':'A', 'Ầ':'A', 'Ẩ':'A', 'Ẫ':'A', 'Ậ':'A',
      'Ắ':'A', 'Ằ':'A', 'Ẳ':'A', 'Ẵ':'A', 'Ặ':'A', 'Å':'A', 'Ḃ':'B', 'Ḅ':'B',
      'Ḇ':'B', 'Ç':'C', 'Ć':'C', 'Ĉ':'C', 'Ċ':'C', 'Č':'C', 'Ḉ':'C', 'Ď':'D',
      'Ḋ':'D', 'Ḍ':'D', 'Ḏ':'D', 'Ḑ':'D', 'Ḓ':'D', 'È':'E', 'É':'E', 'Ê':'E',
      'Ë':'E', 'Ē':'E', 'Ĕ':'E', 'Ė':'E', 'Ę':'E', 'Ě':'E', 'Ȅ':'E', 'Ȇ':'E',
      'Ȩ':'E', 'Ḕ':'E', 'Ḗ':'E', 'Ḙ':'E', 'Ḛ':'E', 'Ḝ':'E', 'Ẹ':'E', 'Ẻ':'E',
      'Ẽ':'E', 'Ế':'E', 'Ề':'E', 'Ể':'E', 'Ễ':'E', 'Ệ':'E', 'Ḟ':'F', 'Ĝ':'G',
      'Ğ':'G', 'Ġ':'G', 'Ģ':'G', 'Ǧ':'G', 'Ǵ':'G', 'Ḡ':'G', 'Ĥ':'H', 'Ȟ':'H',
      'Ḣ':'H', 'Ḥ':'H', 'Ḧ':'H', 'Ḩ':'H', 'Ḫ':'H', 'Ì':'I', 'Í':'I', 'Î':'I',
      'Ï':'I', 'Ĩ':'I', 'Ī':'I', 'Ĭ':'I', 'Į':'I', 'İ':'I', 'Ǐ':'I', 'Ȉ':'I',
      'Ȋ':'I', 'Ḭ':'I', 'Ḯ':'I', 'Ỉ':'I', 'Ị':'I', 'Ĵ':'J', 'Ķ':'K', 'Ǩ':'K',
      'Ḱ':'K', 'Ḳ':'K', 'Ḵ':'K', 'Ĺ':'L', 'Ļ':'L', 'Ľ':'L', 'Ḷ':'L', 'Ḹ':'L',
      'Ḻ':'L', 'Ḽ':'L', 'Ḿ':'M', 'Ṁ':'M', 'Ṃ':'M', 'Ñ':'N', 'Ń':'N', 'Ņ':'N',
      'Ň':'N', 'Ǹ':'N', 'Ṅ':'N', 'Ṇ':'N', 'Ṉ':'N', 'Ṋ':'N', 'Ò':'O', 'Ó':'O',
      'Ô':'O', 'Õ':'O', 'Ö':'O', 'Ō':'O', 'Ŏ':'O', 'Ő':'O', 'Ơ':'O', 'Ǒ':'O',
      'Ǫ':'O', 'Ǭ':'O', 'Ȍ':'O', 'Ȏ':'O', 'Ȫ':'O', 'Ȭ':'O', 'Ȯ':'O', 'Ȱ':'O',
      'Ṍ':'O', 'Ṏ':'O', 'Ṑ':'O', 'Ṓ':'O', 'Ọ':'O', 'Ỏ':'O', 'Ố':'O', 'Ồ':'O',
      'Ổ':'O', 'Ỗ':'O', 'Ộ':'O', 'Ớ':'O', 'Ờ':'O', 'Ở':'O', 'Ỡ':'O', 'Ợ':'O',
      'Ṕ':'P', 'Ṗ':'P', 'Ŕ':'R', 'Ŗ':'R', 'Ř':'R', 'Ȑ':'R', 'Ȓ':'R', 'Ṙ':'R',
      'Ṛ':'R', 'Ṝ':'R', 'Ṟ':'R', 'Ś':'S', 'Ŝ':'S', 'Ş':'S', 'Š':'S', 'Ș':'S',
      'Ṡ':'S', 'Ṣ':'S', 'Ṥ':'S', 'Ṧ':'S', 'Ṩ':'S', 'Ţ':'T', 'Ť':'T', 'Ț':'T',
      'Ṫ':'T', 'Ṭ':'T', 'Ṯ':'T', 'Ṱ':'T', 'Ù':'U', 'Ú':'U', 'Û':'U', 'Ü':'U',
      'Ũ':'U', 'Ū':'U', 'Ŭ':'U', 'Ů':'U', 'Ű':'U', 'Ų':'U', 'Ư':'U', 'Ǔ':'U',
      'Ǖ':'U', 'Ǘ':'U', 'Ǚ':'U', 'Ǜ':'U', 'Ȕ':'U', 'Ȗ':'U', 'Ṳ':'U', 'Ṵ':'U',
      'Ṷ':'U', 'Ṹ':'U', 'Ṻ':'U', 'Ụ':'U', 'Ủ':'U', 'Ứ':'U', 'Ừ':'U', 'Ử':'U',
      'Ữ':'U', 'Ự':'U', 'Ṽ':'V', 'Ṿ':'V', 'Ŵ':'W', 'Ẁ':'W', 'Ẃ':'W', 'Ẅ':'W',
      'Ẇ':'W', 'Ẉ':'W', 'Ẋ':'X', 'Ẍ':'X', 'Ý':'Y', 'Ŷ':'Y', 'Ÿ':'Y', 'Ȳ':'Y',
      'Ẏ':'Y', 'Ỳ':'Y', 'Ỵ':'Y', 'Ỷ':'Y', 'Ỹ':'Y', 'Ź':'Z', 'Ż':'Z', 'Ž':'Z',
      'Ẑ':'Z', 'Ẓ':'Z', 'Ẕ':'Z',
      '`': '`',
      'à':'a', 'á':'a', 'â':'a', 'ã':'a', 'ä':'a', 'å':'a', 'ā':'a', 'ă':'a',
      'ą':'a', 'ǎ':'a', 'ǟ':'a', 'ǡ':'a', 'ǻ':'a', 'ȁ':'a', 'ȃ':'a', 'ȧ':'a',
      'ḁ':'a', 'ạ':'a', 'ả':'a', 'ấ':'a', 'ầ':'a', 'ẩ':'a', 'ẫ':'a', 'ậ':'a',
      'ắ':'a', 'ằ':'a', 'ẳ':'a', 'ẵ':'a', 'ặ':'a', 'ḃ':'b', 'ḅ':'b', 'ḇ':'b',
      'ç':'c', 'ć':'c', 'ĉ':'c', 'ċ':'c', 'č':'c', 'ḉ':'c', 'ď':'d', 'ḋ':'d',
      'ḍ':'d', 'ḏ':'d', 'ḑ':'d', 'ḓ':'d', 'è':'e', 'é':'e', 'ê':'e', 'ë':'e',
      'ē':'e', 'ĕ':'e', 'ė':'e', 'ę':'e', 'ě':'e', 'ȅ':'e', 'ȇ':'e', 'ȩ':'e',
      'ḕ':'e', 'ḗ':'e', 'ḙ':'e', 'ḛ':'e', 'ḝ':'e', 'ẹ':'e', 'ẻ':'e', 'ẽ':'e',
      'ế':'e', 'ề':'e', 'ể':'e', 'ễ':'e', 'ệ':'e', 'ḟ':'f', 'ĝ':'g', 'ğ':'g',
      'ġ':'g', 'ģ':'g', 'ǧ':'g', 'ǵ':'g', 'ḡ':'g', 'ĥ':'h', 'ȟ':'h', 'ḣ':'h',
      'ḥ':'h', 'ḧ':'h', 'ḩ':'h', 'ḫ':'h', 'ẖ':'h', 'ì':'i', 'í':'i', 'î':'i',
      'ï':'i', 'ĩ':'i', 'ī':'i', 'ĭ':'i', 'į':'i', 'ǐ':'i', 'ȉ':'i', 'ȋ':'i',
      'ḭ':'i', 'ḯ':'i', 'ỉ':'i', 'ị':'i', 'ĵ':'j', 'ǰ':'j', 'ķ':'k', 'ǩ':'k',
      'ḱ':'k', 'ḳ':'k', 'ḵ':'k', 'ĺ':'l', 'ļ':'l', 'ľ':'l', 'ḷ':'l', 'ḹ':'l',
      'ḻ':'l', 'ḽ':'l', 'ḿ':'m', 'ṁ':'m', 'ṃ':'m', 'ñ':'n', 'ń':'n', 'ņ':'n',
      'ň':'n', 'ǹ':'n', 'ṅ':'n', 'ṇ':'n', 'ṉ':'n', 'ṋ':'n', 'ò':'o', 'ó':'o',
      'ô':'o', 'õ':'o', 'ö':'o', 'ō':'o', 'ŏ':'o', 'ő':'o', 'ơ':'o', 'ǒ':'o',
      'ǫ':'o', 'ǭ':'o', 'ȍ':'o', 'ȏ':'o', 'ȫ':'o', 'ȭ':'o', 'ȯ':'o', 'ȱ':'o',
      'ṍ':'o', 'ṏ':'o', 'ṑ':'o', 'ṓ':'o', 'ọ':'o', 'ỏ':'o', 'ố':'o', 'ồ':'o',
      'ổ':'o', 'ỗ':'o', 'ộ':'o', 'ớ':'o', 'ờ':'o', 'ở':'o', 'ỡ':'o', 'ợ':'o',
      'ṕ':'p', 'ṗ':'p', 'ŕ':'r', 'ŗ':'r', 'ř':'r', 'ȑ':'r', 'ȓ':'r', 'ṙ':'r',
      'ṛ':'r', 'ṝ':'r', 'ṟ':'r', 'ś':'s', 'ŝ':'s', 'ş':'s', 'š':'s', 'ș':'s',
      'ṡ':'s', 'ṣ':'s', 'ṥ':'s', 'ṧ':'s', 'ṩ':'s', 'ţ':'t', 'ť':'t', 'ț':'t',
      'ṫ':'t', 'ṭ':'t', 'ṯ':'t', 'ṱ':'t', 'ẗ':'t', 'ù':'u', 'ú':'u', 'û':'u',
      'ü':'u', 'ũ':'u', 'ū':'u', 'ŭ':'u', 'ů':'u', 'ű':'u', 'ų':'u', 'ư':'u',
      'ǔ':'u', 'ǖ':'u', 'ǘ':'u', 'ǚ':'u', 'ǜ':'u', 'ȕ':'u', 'ȗ':'u', 'ṳ':'u',
      'ṵ':'u', 'ṷ':'u', 'ṹ':'u', 'ṻ':'u', 'ụ':'u', 'ủ':'u', 'ứ':'u', 'ừ':'u',
      'ử':'u', 'ữ':'u', 'ự':'u', 'ṽ':'v', 'ṿ':'v', 'ŵ':'w', 'ẁ':'w', 'ẃ':'w',
      'ẅ':'w', 'ẇ':'w', 'ẉ':'w', 'ẘ':'w', 'ẋ':'x', 'ẍ':'x', 'ý':'y', 'ÿ':'y',
      'ŷ':'y', 'ȳ':'y', 'ẏ':'y', 'ẙ':'y', 'ỳ':'y', 'ỵ':'y', 'ỷ':'y', 'ỹ':'y',
      'ź':'z', 'ż':'z', 'ž':'z', 'ẑ':'z', 'ẓ':'z', 'ẕ':'z'

    @characters().inject "", (normalized, character) ->
      normalized_character = diactrict_mapping_table[character]
      normalized += normalized_character or character

  clone: ->
    new String(this)
