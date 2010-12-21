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
    @forEach iterator, context

  collect: (iterator, context) ->
    @map iterator, context

  select: (predicate, context) ->
    @filter predicate, context

  reject: (predicate, context) ->
    # TODO: Implement this.

  detect: (predicate, context) ->
    # TODO: Implement this.

  all: (predicate, context) ->
    @every predicate, context

  any: (predicate, context) ->
    @some predicate, context

  contains: (value) ->
    return no unless value
    return yes if @indexOf and @indexOf value isnt -1
    return @any (current_value) ->
      current_value is value

  invoke: (method) ->
    # TODO: Implement this.

  pluck: (key) ->
    # TODO: Implement this.

  max: (iterator, context) ->
    # TODO: Implement this.

  min: (iterator, context) ->
    # TODO: Implement this.
