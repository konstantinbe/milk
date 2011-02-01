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
    return @values().each iterator, context

  collect: (iterator, context) ->
    return @values().collect iterator, context

  select: (iterator, context) ->
    return @values().select iterator, context

  reject: (iterator, context) ->
    @inject [], (values, value) ->
      unless iterator value then values.add value else values

  detect: (iterator, context) ->
    for own value in @values()
      return value if iterator value
    false

  all: (iterator, context) ->
    return @values().all iterator, context

  any: (iterator, context) ->
    return @values().any iterator, context

  max: () ->
    @values().max()

  min: () ->
    @values().min()

  partition: (iterator) ->
    @inject {}, (partition, value) ->
      key = iterator value
      partition[key] = [] unless partition[key]
      partition[key].add value
      partition

  inject: (initial, iterator) ->
    @values().inject initial, iterator

  contains: (value) ->
    @values().contains value

  invoke: (method, args...) ->
    @collect (value) ->
      value[method].apply(value, args)

  pluck: (key) ->
    @collect (value) ->
      value[key]

  values: () ->
    values = []
    @each (value) ->
      values.add value
    values

  count: () ->
    @values().length

  empty: () ->
    @count() == 0
