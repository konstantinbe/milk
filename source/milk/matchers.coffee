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

class Matchers
  @match: (subject, options = {}) ->
    matcher_name = options.keys().detect (key) -> key.begins_with "to_"
    matcher_parameter = options[matcher_name]
    matcher = @[matcher_name]
    matcher.call {subject: subject}, matcher_parameter, options

  @to_exist: ->
    @subject?

  @to_be: (value) ->
    @subject == value

  @to_be_a_kind_of: (klass) ->
    # TODO: implement.

  @to_be_an_instance_of: (klass) ->
    @subject instanceof klass

  @to_equal: (object) ->
    @subject.equals object

  @to_contain: (value) ->
    @subject.contains value

  @to_contain_all: (values) ->
    values.all (value) => @subject.contains value

  @to_contain_any: (values) ->
    values.any (value) => @subject.contains value

  @to_have_exactly: (count, options = {}) ->
    @subject.count() == count

  @to_have_at_least: (count) ->
    @subject.count() >= count

  @to_have_at_most: (count) ->
    @subject.count() <= count

  @to_have_more_than: (count) ->
    @subject.count() > count

  @to_have_less_than: (count) ->
    @subject.count() < count

  @to_have_between: (bounds, options = {}) ->
    [lower, upper] = bounds.sort()
    count = @subject.count()
    return lower < count <= upper if options['excluding_lower']
    return lower <= count < upper if options['excluding_upper']
    return lower < count < upper if options['excluding_bounds']
    lower <= count <= upper

  @to_have: (key, options = {}) ->
    # TODO: implement.

  @to_have_one: (key, options = {}) ->
    # TODO: implement.

  @to_have_many: (key, options = {}) ->
    # TODO: implement.

  @to_match: (reg_exp) ->
    Boolean @subject.match reg_exp

  @to_respond_to: (method) ->
    @subject.responds_to method

  @to_throw: (exception) ->
    catched_exception = null
    try
      @subject()
    catch thrown_exception
      catched_exception = thrown_exception
    if exception then catched_exception == exception else catched_exception?
