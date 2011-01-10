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

ArrayExtensions =
  first: (count) ->
    return this[0] unless count?
    @slice 0, count

  rest: (index = 1) ->
    @slice index

  last: (count) ->
    last_index = @length - 1
    return this[last_index] unless count?
    return [] if count is 0
    @slice -count

  compact: () ->
    this.filter (value) ->
      value?

  flatten: () ->
    # TODO: Implement this.

  without: (values...) ->
    # TODO: Implement this.

  without_many: (collections...) ->
    # TODO: Implement this.

  unique: (sorted = no) ->
    # TODO: Implement this.

  intersect: (arrays...) ->
    # TODO: Implement this.

  append: (arrays...) ->
    # TODO: Implement this

  zip: (arrays...) ->
    # TODO: Implement this.

  index_of: (value) ->
    # TODO: Implement this.

  last_index_of: (value) ->
    # TODO: Implement this.

  add: (values...) ->
    # TODO: Implement this.

  add_many: (collections...) ->
    # TODO: Implement this.

  insert_at: (index, values...) ->
    # TODO: Implement this.

  insert_many_at: (index, collections...) ->
    # TODO: Implement this.

  remove: (values...) ->
    # TODO: Implement this.

  remove_at: (indexes...) ->
    # TODO: Implement this.

  remove_many: (collections...) ->
    # TODO: Implement this.

  replace: (value, replacement) ->
    # TODO: Implement this.

  replace_at: (index, replacement) ->
    # TODO: Implement this.

  replace_many: (values, replacements) ->
    # TODO: Implement this.

  # native array methods:
  # * reserve
  # * join
  # * concat
  # * slice
  # * ...

Array::mixin Collection
Array::mixin ArrayExtensions
