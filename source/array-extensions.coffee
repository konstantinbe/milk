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
  # collection methods
  each: (iterator, context) ->
    @forEach iterator, context

  collect: (iterator, context) ->
    @map iterator, context

  select: (iterator, context) ->
    @filter iterator, context

  all: (iterator, context) ->
    @every iterator, context

  any: (iterator, context) ->
    @some iterator, context

  max: ->
    return null if @empty()
    @inject @first, (current, value) =>
      if current > value then current else value

  min: ->
    return null if @empty()
    @inject @first, (current, value) =>
      if current < value then current else value

  inject: (initial, iterator) ->
    @reduce iterator, initial

  contains: (value) ->
    @indexOf(value) != -1

  count: ->
    @length

  # array-only methods
  first: (count) ->
    return @[0] unless count?
    @slice 0, count

  rest: ->
    @slice 1

  last: (count) ->
    return @[@length - 1] unless count?
    return [] if count is 0
    @slice -count

  with: (values...) ->
    @concat values

  with_many: (collections...) ->
    @concat collections...

  without: (values...) ->
    @without_many values

  without_many: (collections...) ->
    @clone().remove_many collections...

  without_at: (indexes...) ->
    # TODO: Implement this.

  compact: ->
    @filter (value) ->
      value?

  flatten: ->
    @inject [], (result, value) =>
      values = if value.is_array() then value.flatten() else [value]
      result.add_many values

  unique: ->
    result = @clone()
    for i in [0..@length]
      for j in [0..@length]
        result.splice(j, 1) if i isnt j and result[j] is result[i]
    result

  intersect: (arrays...) ->
    @unique().select (value) ->
      arrays.all (array) ->
        array.contains value

  unite: (arrays...) ->
    @concat(arrays...).unique()

  zip: (arrays...) ->
    arrays = [this].with_many arrays
    counts = arrays.collect (array) -> array.count()
    zipped = []
    for index in [0...counts.max()]
      row = arrays.collect (array) -> array[index]
      zipped.add row
    zipped

  add: (values...) ->
    @add_many values

  add_many: (collections...) ->
    collections.each (collection) =>
      collection.each (value) =>
        @push value
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

  insert: (value, params = {}) ->
    params['at'] ?= 0
    @splice params['at'], 0, value
    this

  insert_many: (collection, params = {}) ->
    params['at'] ?= 0
    @splice params['at'], 0, collection...
    this

  replace: (value, params = {}) ->
    params['with'] ?= undefined
    params['with_many'] ?= undefined
    replacements = if params['with']? then [params['with']] else params['with_many']
    throw "InvalidArgumentException" unless replacements
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

  index_of: (value) ->
    @indexOf value

  last_index_of: (value) ->
    @lastIndexOf value

  indexes_of: (value) ->
    indexes = []
    @each (current, index) ->
      indexes.add index if value is current
    indexes

  sort_by: (keys...) ->
    @sort (object1, object2) ->
      for key in keys
        return 1 if object1[key] > object2[key]
        return -1 if object1[key] < object2[key]
      0

  clone: ->
    [].concat this

  equals: (object) ->
    return no unless object.is_array()
    return no unless @length == object.length
    return no unless (@all (value, index) -> value == object[index])
    yes

  description: ->
    "[" + @toString() + "]"

  # native array methods:
  # * reverse
  # * join
  # * concat
  # * slice
  # * ...