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

@module 'Milk.Core', ->

  class ArrayExtensions

    # -------------------------------------------------- Native Functions ------

    native_array_for_each = Array::forEach
    native_array_map = Array::map

    native_array_filter = Array::filter
    native_array_reduce = Array::reduce

    native_array_every = Array::every
    native_array_some = Array::some

    native_array_index_of = Array::indexOf
    native_array_last_index_of = Array::lastIndexOf

    # ------------------------------------------------- Private Functions ------

    make_compare_function_for_sorting_by_keys = (keys) ->
      (object1, object2) ->
        result = 0
        for key in keys
          key_parts = key.split /\s+/

          property = key_parts[0]
          value1 = object1.value_for property
          value2 = object2.value_for property

          descending = key_parts[1] and key_parts[1] is "DESC"
          ascending = not descending

          comparison_result = (value1.compare_to value2 if value1 and value1.compare_to)

          inverted_comparison_result = 0
          inverted_comparison_result = -1 if comparison_result > 0
          inverted_comparison_result = 1 if comparison_result < 0

          result = (if ascending then comparison_result else inverted_comparison_result) if result is 0 and comparison_result isnt 0
        result

    # ----------------------------------------------- Working with Arrays ------

    count: ->
      @length

    is_empty: ->
      @count() is 0

    contains: (object) ->
      object in @

    contains_all: (objects) ->
      objects.all (object) => @contains object

    contains_any: (objects) ->
      objects.any (object) => @contains object

    at: (index) ->
      @[index]
 
    at_many: (indexes) ->              
      (@[index] for index in indexes)

    index_of: (object) ->
      native_array_index_of.call this, object

    last_index_of: (object) ->
      native_array_last_index_of.call this, object

    indexes_of: (object) ->
      (index for current, index in this when current is object)

    first: (count) ->
      return @[0] unless count?
      @slice 0, count

    second: ->
      @[1]

    third: ->
      @[2]

    last: (count = null) ->
      return @[@length - 1] unless count?
      return [] if count is 0
      @slice -count

    rest: ->
      @slice 1

    # --------------------------------------------------- Deriving Arrays ------

    with: (object) ->
      @copy().add object

    with_many: (objects) ->
      @copy().add_many objects

    with_at: (object, index) ->
      @copy().insert_at object, index

    with_many_at: (objects, index) ->
      @copy().insert_many_at objects, index

    with_before: (object, before_object) ->
      @copy().insert_before object, before_object

    with_many_before: (objects, before_object) ->
      @copy().insert_many_before objects, before_object

    with_after: (object, after_object) ->
      @copy().insert_after object, after_object

    with_many_after: (objects, after_object) ->
      @copy().insert_many_after objects, after_object

    without: (object) ->
      @copy().remove object

    without_many: (objects) ->
      @copy().remove_many objects

    without_at: (index) ->
      @copy().remove_at index

    without_many_at: (indexes) ->
      @copy().remove_many_at indexes

    compacted: ->
      (object for object in this when object?)

    flattened: ->
      @inject [], (result, object) =>
        objects = if object.is_array() then object.flattened() else [object]
        result.add_many objects

    reversed: ->
      @copy().reverse()

    sorted: ->
      @copy().sort()

    unique: ->
      objects = []
      objects.add object for object in this when not objects.contains object
      objects

    intersect: (objects) ->
      (object for object in @unique() when objects.contains object)

    unite: (objects) ->
      @concat(objects).unique()

    zip: (arrays...) ->
      arrays = [this].with_many arrays
      counts = arrays.collect (array) -> array.count()
      zipped = []
      for index in [0...counts.max()]
        row = arrays.collect (array) -> array[index]
        zipped.add row
      zipped

    # ------------------------------------------------ Enumerating Arrays ------

    each: (block) ->
      native_array_for_each.call this, block

    collect: (block) ->
      native_array_map.call this, block

    select: (block) ->
      native_array_filter.call this, block

    reject: (block) ->
      result = []
      @each (object) ->
        result.push object unless block object
      result

    detect: (block) ->
      # TODO: optimize.
      @select(block).first() or null

    pluck: (key) ->
      @collect (value) ->
        value.value_for key

    partition: (block) ->
      block = ((value) -> value) unless block?
      selected = []
      rejected = []
      for value in this
        if block value then selected.add value else rejected.add value
      [selected, rejected]

    all: (block) ->
      native_array_every.call this, block

    any: (block) ->
      native_array_some.call this, block

    max: (block = Math.identity) ->
      max = null
      @each (object) ->
        max = object unless max? and max.is_greater_than block object
      max

    min: (block = Math.identity) ->
      min = null
      @each (object) ->
        min = object unless min? and min.is_less_than block object
      min

    group_by: (key_or_block) ->
      block = if key_or_block.is_function() then key_or_block else (object) -> object.value_for key_or_block
      partition = {}
      @each (object) ->
        key = block object
        partition[key] = [] unless partition[key]?
        partition[key].add object
      partition

    inject: (initial, block) ->
      native_array_reduce.call this, block, initial

    # --------------------------------------------------- Mutating Arrays ------

    add: (object) ->
      @push object
      @

    add_many: (objects) ->
      @push objects...
      @

    # Removes the first occurence of object.
    remove: (object) ->
      index = @index_of(object)
      @splice index, 1 if 0 <= index < @length
      @

    remove_many: (objects) ->
      for object in objects
        index = @index_of(object)
        @splice index, 1 if 0 <= index < @length
      @

    remove_at: (index) ->
      throw "Array#remove_at() called with invalid index: #{index}, count: #{@length}"  unless 0 <= index < @length
      @splice index, 1
      @

    remove_many_at: (indexes) ->
      for index in indexes.sorted().reversed()
        @remove_at index
      @

    remove_all: () ->
      @pop() while @length > 0
      @

    insert_at: (object, index) ->
      @splice index, 0, object
      @

    insert_many_at: (objects, index) ->
      @splice index, 0, objects...
      @

    insert_before: (object, before_object) ->
      index = @index_of before_object
      index = 0 if index < 0
      @splice index, 0, object
      @

    insert_many_before: (objects, before_object) ->
      index = @index_of before_object
      index = 0 if index < 0
      @splice index, 0, objects...
      @

    insert_after: (object, after_object) ->
      count = @count()
      index = @last_index_of(after_object) + 1
      index = count if index > count
      @splice index, 0, object
      @

    insert_many_after: (objects, after_object) ->
      count = @count()
      index = @last_index_of(after_object) + 1
      index = count if index > count
      @splice index, 0, objects...
      @

    replace_with: (object, replacement) ->
      index = @index_of object
      @splice index, 1, replacement if index >= 0
      @

    replace_with_many: (object, replacements) ->
      index = @index_of object
      @splice index, 1, replacements... if index >= 0
      @

    replace_at_with: (index, replacement) ->
      @splice index, 1, replacement
      @

    replace_at_with_many: (index, replacements) ->
      @splice index, 1, replacements...
      @

    sort_by: (keys) ->
      @sort make_compare_function_for_sorting_by_keys keys if keys.count() > 0

  # ----------------------------------------------------------------------------

  Array.includes ArrayExtensions
