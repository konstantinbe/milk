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

Collection =
  each: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    return @forEach iterator, context if @forEach?
    # TODO: Implement fallback.

  collect: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    return @map iterator, context if @map?
    # TODO: Implement fallback.

  select: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    return @filter iterator, context if @filter
    # TODO: Implement fallback.

  reject: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  detect: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  all: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    return @every iterator, context if @every
    # TODO: Implement fallback.

  any: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    return @some iterator, context if @some
    # TODO: Implement fallback.

  max: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  min: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  reduce: (initial, iterator) ->
    reduced_value = initial
    index = 0
    @each (value) ->
      reduced_value = iterator(reduced_value, value, index)
      index += 1
    reduced_value

  sort_by: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  contains: (value) ->
    return no unless value
    return yes if @indexOf? and @indexOf(value) isnt -1
    @any (current_value) ->
      current_value is value

  invoke: (method, method_arguments...) ->
    # TODO: Implement this.

  pluck: (key) ->
    # TODO: Implement this.

  # TODO: Make this a property.
  values: () ->
    values = []
    @each (value) ->
      values.push value
    values

  # TODO: Make this a property.
  size: () ->
    return @length if @length?
    @values.length

  empty: () ->
    @size() is 0
