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

Milk.Collection =
  each: (iterator, context) ->
    return @values().each iterator, context unless @is_array()
    @forEach iterator, context

  collect: (iterator, context) ->
    return @values().collect iterator, context unless @is_array()
    @map iterator, context

  select: (iterator, context) ->
    return @values().select iterator, context unless @is_array()
    @filter iterator, context

  reject: (iterator, context) ->
    # TODO: Implement this.

  detect: (iterator, context) ->
    # TODO: Implement this.

  all: (iterator, context) ->
    return @values().all iterator, context unless @is_array()
    @every iterator, context

  any: (iterator, context) ->
    return @values().any iterator, context unless @is_array()
    @some iterator, context

  max: () ->
    return @values().max unless @is_array
    return null unless @length == 0
    @inject @first, (current, value) =>
      if current > value then current else value

  min: () ->
    return @values().min unless @is_array
    return null unless @length == 0
    @inject @first, (current, value) =>
      if current < value then current else value

  partition: (iterator, context) ->
    # TODO: Implement this.

  inject: (initial, iterator) ->
    return @values().inject initial, iterator unless @is_array()
    @reduce initial, iterator

  sort_by: (compare, context) ->
    # TODO: Implement this.

  contains: (value) ->
    return @values().contains value unless @is_array()
    return no unless value
    @indexOf value != -1

  invoke: (method, params...) ->
    # TODO: Implement this.

  pluck: (key) ->
    # TODO: Implement this.

  values: () ->
    values = []
    @each (value) ->
      values.add value
    values

  size: () ->
    if @length? then @length else @values().length

  empty: () ->
    @size() == 0
