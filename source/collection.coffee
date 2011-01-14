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
    @forEach iterator, context if @forEach?

  collect: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @map iterator, context if @map?

  select: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @filter iterator, context if @filter

  reject: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  detect: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  all: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @every iterator, context if @every

  any: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @some iterator, context if @some

  max: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  min: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  partition: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  inject: (initial, iterator) ->
    return @reduce initial, iterator if @reduce?
    result = initial
    @each (value) ->
      result = iterator(result, value)
    result

  sort_by: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  contains: (value) ->
    return no unless value
    return yes if @indexOf? and @indexOf(value) isnt -1
    @any (current_value) ->
      current_value is value

  invoke: (method, params...) ->
    # TODO: Implement this.

  pluck: (key) ->
    # TODO: Implement this.

  # TODO: Make this a property.
  values: () ->
    @each (value) ->
      values.push value
    return values

  # TODO: Make this a property.
  size: () ->
    if @length? then @length else @values.length

  empty: () ->
    @size() is 0

ROOT = exports ? this
ROOT.Collection = Collection
