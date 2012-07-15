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

@module 'Milk.Match', ->

  # ----------------------------------------------------------------------------

  matchers =

    to_exist: ->
      @actual?

    to_be: (value) ->
      @actual is value

    to_be_a_dictionary: ->
      @actual? and @actual instanceof Object

    to_be_a_kind_of: (klass) ->
      @actual.is_kind_of klass

    to_be_an_instance_of: (klass) ->
      @actual.is_instance_of klass

    to_equal: (object) ->
      @actual.equals object

    to_contain: (value) ->
      @actual.contains value

    to_contain_all: (values) ->
      values.all (value) => @actual.contains value

    to_contain_any: (values) ->
      values.any (value) => @actual.contains value

    to_have_exactly: (count, options = {}) ->
      @actual.count() == count

    to_have_at_least: (count) ->
      @actual.count() >= count

    to_have_at_most: (count) ->
      @actual.count() <= count

    to_have_more_than: (count) ->
      @actual.count() > count

    to_have_less_than: (count) ->
      @actual.count() < count

    to_have_between: (bounds, options = {}) ->
      [lower, upper] = bounds.sort()
      count = @actual.count()
      return lower < count <= upper if options.own 'excluding_lower'
      return lower <= count < upper if options.own 'excluding_upper'
      return lower < count < upper if options.own 'excluding_bounds'
      lower <= count <= upper

    to_have: (key, options = {}) ->
      # TODO: implement.

    to_have_one: (key, options = {}) ->
      # TODO: implement.

    to_have_many: (key, options = {}) ->
      # TODO: implement.

    to_belong_to: (key, options = {}) ->
      # TODO: implement.

    to_match: (reg_exp) ->
      Boolean @actual.match reg_exp

    to_respond_to: (method) ->
      @actual.responds_to method

    to_throw: (exception) ->
      catched_exception = null
      try
        @actual()
      catch thrown_exception
        catched_exception = thrown_exception
      if exception then catched_exception == exception else catched_exception?

  # ----------------------------------------------------------------------------

  expect = (actual, options = {}) ->
    key = options.keys().detect (key) -> key.match /^(not_)?to/
    value = options[key]
    delete options[key]

    unary = key.match /^(not_)?to$/

    matcher_name_possibly_negated = key
    matcher_name_possibly_negated += "_" + value if unary

    negated = matcher_name_possibly_negated.begins_with 'not'

    matcher_name = matcher_name_possibly_negated.replace /^not_/, ""
    matcher = @[matcher_name]
    argument = if unary then undefined else value

    result = matcher.call {actual}, argument, options
    if negated then not result else result

  # ----------------------------------------------------------------------------

  @export matchers, as: 'MATCHERS'
  @export expect, as: 'expect'
