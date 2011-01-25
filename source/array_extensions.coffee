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

Milk.ArrayExtensions =
  each: (iterator, context) ->
    @forEach iterator, context

  first: (count) ->
    return this[0] unless count?
    @slice 0, count

  rest: () ->
    @slice 1

  last: (count) ->
    last_index = @length - 1
    return this[last_index] unless count?
    return [] if count is 0
    @slice -count

  compact: () ->
    @filter (value) ->
      value?

  flatten: () ->
    @inject [], (result, value) =>
      if value.is_array() then result.add_many value.flatten() else result.add value

  with: (values...) ->
    @with_many values

  with_many: (collections...) ->
    @clone().add_many collections...

  without: (values...) ->
    @without_many values

  without_many: (collections...) ->
    @clone().remove_many collections...

  unique: () ->
    result = @clone()
    for i in [0..@length]
      for j in [0..@length]
        result.splice(j, 1) if i isnt j and result[j] is result[i]
    result

  intersect: (arrays...) ->
    # TODO: Implement this.

  unite: (arrays...) ->
    @concat(arrays...).unique()

  zip: (arrays...) ->
    # TODO: Implement this.

  index_of: (value) ->
    @indexOf value

  last_index_of: (value) ->
    @lastIndexOf value

  indexes_of: (value) ->
    indexes = []
    @each (current, index) ->
      indexes.add index if value is current
    indexes

  add: (values...) ->
    @add_many values

  add_many: (collections...) ->
    collections.each (collection) =>
      collection.each (value) =>
        @push value
    this

  insert: (value, params = {}) ->
    params['at'] ?= 0
    throw 'InvalidParameterException' if value == undefined
    @splice params['at'], 0, value
    this

  insert_many: (collection, params = {}) ->
    params['at'] ?= 0
    throw 'InvalidParameterException' if collection == undefined
    @splice params['at'], 0, collection...
    this

  remove: (values...) ->
    @remove_many values

  remove_many: (collections...) ->
    collections.each (collection) =>
      collection.each (value) =>
        index = @index_of value
        while index >= 0
          @splice index, 1
          index = @index_of value
    this

  remove_at: (indexes...) ->
    indexes.sort()
    offset = 0
    indexes.each (index) =>
      @splice(index - offset, 1)
      offset += 1
    this

  replace: (value, params = {}) ->
    params['with'] ?= undefined
    params['with_many'] ?= undefined
    replacements = if params['with']? then [params['with']] else params['with_many']
    throw 'InvalidParameterException' unless replacements
    indexes = @indexes_of value
    indexes.each (index) =>
      @replace_at index, with_many: replacements
    this

  replace_at: (index, params = {}) ->
    params['with'] ?= undefined
    params['with_many'] ?= undefined
    replacements = if params['with']? then [params['with']] else params['with_many']
    @splice index, 1, replacements...
    this

  clone: () ->
    [].add_many this

  equals: (object) ->
    return no unless is_array = object.is_array()
    return no unless has_same_length = @length is object.length
    return no unless has_same_values = (@all (value, index) -> value is object[index])
    yes

  # native array methods:
  # * reserve
  # * join
  # * concat
  # * slice
  # * ...
