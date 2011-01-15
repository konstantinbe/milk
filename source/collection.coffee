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
  each: (iterator, context) ->
    throw 'AbstractMethodCalledException'

  collect: (iterator, context) ->
    return @map iterator, context if @map?
    @values().collect iterator, context

  select: (iterator, context) ->
    return @filter iterator, context if @filter?
    @values().select iterator, context

  reject: (iterator, context) ->
    # TODO: Implement this.

  detect: (iterator, context) ->
    # TODO: Implement this.

  all: (iterator, context) ->
    return @every iterator, context if @every?

  any: (iterator, context) ->
    @some iterator, context if @some?

  max: () ->
    @inject -Infinity, (current, value) =>
      if current > value then current else value

  min: () ->
    @inject Infinity, (current, value) =>
      if current < value then current else value

  partition: (iterator, context) ->
    # TODO: Implement this.

  inject: (initial, iterator) ->
    return @reduce initial, iterator if @reduce?
    @values().reduce initial, iterator

  sort_by: (compare, context) ->
    # TODO: Implement this.

  contains: (value) ->
    return no unless value
    return yes if @indexOf? and @indexOf value isnt -1
    @any (current_value) ->
      current_value is value

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
    @size() is 0

ROOT = exports ? this
ROOT.Collection = Collection
