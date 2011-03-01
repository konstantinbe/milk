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

exports.StringExtensions =
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
    # TODO: implement.

  singularized: ->
    # TODO: implement.

  clone: ->
    new String(this)
