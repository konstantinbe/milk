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

Milk.StringExtensions =
  characters: ->
    @split ""

  codes: ->
    @characters().map (character) -> character.charCodeAt 0

  words: ->
    cleaned = @clone().replace("'", "").replace(/[\W|_]+/g, " ")
    trimmed = cleaned.trim()
    words = trimmed.split " "
    words.select (word) -> word.length > 0

  lines: ->
    # TODO: Implement this.

  paragraphs: ->
    # TODO: Implement this.

  part: (params = {}) ->
    # TODO: Implement this.

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

  uppercase: ->
    @toUpperCase()

  lowercase: ->
    @toLowerCase()

  capitalize: ->
    return "" if @length == 0
    first = @[0]
    rest = @substr 1
    first.uppercase() + rest.lowercase()

  underscorize: ->
    @lowercase().words().join_by "_"

  dasherize: ->
    @lowercase().words().join_by "-"

  camelize: ->
    capitalized_words = @lowercase().words().collect (word) -> word.capitalize()
    capitalized_words.join ""

  titleize: ->
    insignificant_words = ["a", "an", "the", "at", "by", "for", "in", "of", "off", "on", "out", "to", "up", "and", "as", "but", "if", "or", "nor", "is"]
    is_insignificant = (word) -> insignificant_words.contains word
    titleized_words = @lowercase().words().collect (word) ->
      if is_insignificant word then word else word.capitalize()
    titleized_words.join_by " "

  humanize: ->
    # TODO: Implement this.

  pluralize: ->
    # TODO: Implement this.

  clone: ->
    return new String(this)
