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

exports.Comparable =
  is_comparable: yes

  is_less_than: (value) ->
    @compare_to(value) == -1

  is_less_than_or_equal_to: (value) ->
    result = @compare_to value
    result == 0 or result == -1

  is_greater_than: (value) ->
    @compare_to(value) == 1

  is_greater_than_or_equal_to: (value) ->
    result = @compare_to value
    result == 0 or result == 1

  is_between: (lower, upper, options = {}) ->
    include_lower_bound = not (options['exclude_bounds'] or options['exclude_lower_bound'])
    include_upper_bound = not (options['exclude_bounds'] or options['exclude_upper_bound'])
    compared_to_lower = @compare_to lower
    compared_to_upper = @compare_to upper
    meets_lower_bound = compared_to_lower == +1 or include_lower_bound and compared_to_lower == 0
    meets_upper_bound = compared_to_upper == -1 or include_upper_bound and compared_to_upper == 0
    meets_lower_bound and meets_upper_bound

  equals: (value) ->
    @compare_to(value) == 0

  compare_to: (value) ->
    return -1 if this < value
    return +1 if this > value
    0
