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
    @forEach iterator, context

  collect: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @map iterator, context

  select: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @filter iterator, context

  reject: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  detect: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  all: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @every iterator, context

  any: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    @some iterator, context

  max: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  min: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  sort_by: (context, iterator) ->
    [iterator, context] = [context, undefined] unless iterator?
    # TODO: Implement this.

  # returns all values as an array
  values: ->
    values = []
    @each (value) ->
      values.push value
    values

  contains: (value) ->
    return no unless value
    return yes if @indexOf? and @indexOf(value) isnt -1
    @any (current_value) ->
      current_value is value

  invoke: (method) ->
    # TODO: Implement this.

  pluck: (key) ->
    # TODO: Implement this.

  size: () ->
    @values.length
