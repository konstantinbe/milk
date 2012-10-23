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

@module 'Milk', ->

  class StringExtensions

    # -------------------------------------------------- Native Functions ------

    native_char_code_at = String::charCodeAt
    native_index_of = String::indexOf
    native_last_index_of = String::lastIndexOf
    native_to_lower_case = String::toLowerCase
    native_to_upper_case = String::toUpperCase

    # ---------------------------------------------- Working with Strings ------

    count: ->
      @length

    first: (count) ->
      @slice 0, count

    last: (count) ->
      return "" if count is 0
      @slice -count

    code_at: (index) ->
      native_char_code_at.call this, index

    # --------------------------------------------------------------------------

    characters: ->
      @split ""

    codes: ->
      @characters().map (character) -> character.charCodeAt 0

    lines: ->
      @split "\n"

    paragraphs: ->
      @split "\n\n"

    # --------------------------------------------------------------------------

    prepend: (strings...) ->
      "".concat strings..., this

    append: (strings...) ->
      @concat strings...

    index_of: (string, starting_at) ->
      native_index_of.call this, string, starting_at

    last_index_of: (string, starting_at) ->
      native_last_index_of.call this, string, starting_at

    indexes_of: (string) ->
      indexes = []
      index = @index_of string
      while index >= 0
        indexes.add index
        index = @index_of string, index + 1
      indexes

    begins_with: (string) ->
      @index_of(string) is 0

    ends_with: (string) ->
      @index_of(string) is (this.length - string.length)

    # --------------------------------------------------------------------------

    uppercased: ->
      native_to_upper_case.call @

    lowercased: ->
      native_to_lower_case.call @

    capitalized: ->
      return "" if @length is 0
      first = @[0]
      rest = @substr 1
      first.uppercased() + rest.lowercased()

    escaped_for_reg_exp: ->
      @copy().replace /([\\\.\+\*\?\[\^\]\$\(\)\{\}\=\!\<\>\|\:])/g, "\\$1"

    # --------------------------------------------------------------------------

    to_number: ->
      parseFloat @

    # --------------------------------------------------------------------------

    utf8: ->
      unescape encodeURIComponent this

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

      M = Array.new N
      W = Array.new 80

      H0 = 0x67452301
      H1 = 0xefcdab89
      H2 = 0x98badcfe
      H3 = 0x10325476
      H4 = 0xc3d2e1f0

      for i in [0...N]
        M[i] = Array.new 16
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

        a = H0
        b = H1
        c = H2
        d = H3
        e = H4

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

    is_comparable: ->
      yes

    is_copyable: ->
      yes

    compare_to: (object, options = {}) ->
      throw "Can't compare string '#{this}' to #{object}." unless Object.is_string object
      return -1 if this < object
      return +1 if this > object
      0

    copy: ->
      return @ if Object.is_frozen @
      new String @

  String.includes StringExtensions
