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

Milk =
  # collections
  each: (collection, iterator, context) -> collection
  map: (collection, iterator, context) -> collection
  reduce: (collection, iterator, value, context) -> value
  detect: (collection, iterator, context) -> null
  select: (collection, iterator, context) -> collection
  reject: (collection, iterator, context) -> collection
  all: (collection, iterator, context) -> no
  any: (collection, iterator, context) -> no
  contains: (collection, values) -> no
  invoke: (collection, method, context) -> null
  pluck: (collection, property) -> null
  max: (collection, iterator, context) -> null
  min: (collection, iterator, context) -> null
  sort_by: (collection, iterator, context) -> collection
  size: (collection) -> 0

  # arrays
  first: (array, count) -> array
  rest: (array, index) -> array
  last: (array, count) -> array
  compact: (array) -> array
  flatten: (array) -> array
  without: (array) -> array
  unique: (array, is_sorted) -> array
  intersect: (array) -> array
  zip: (array) -> array
  index_of: (array, value) -> 0
  last_index_of: (array, value) -> 0
  range: (start, stop, step) -> []
  reverse: (array) -> array

  # functions
  bind: -> null
  bind_all: -> null
  memoize: -> this
  delay: (func, wait) -> null
  defer: (func, wait) -> null
  thottle: (func, wait) -> null
  debounce: (func, wait) -> null
  wrap: (func, wrapper) -> null
  compose: (functions...) -> null
  methodize: -> this
  curry: -> this

  # objects
  keys: (object) -> []
  values: (object) -> []
  methods: (object) -> []
  extend: (destination, sources...) -> destination
  clone: (object) -> object
  tap: (object, interceptor) -> object
  is_equal_to: (object, other) -> no
  inspect: (object) -> ""
  to_string: (object) -> ""
  is_empty: (object) -> no
  is_element: (object) -> no
  is_array: (object) -> no
  is_arguments: (object) -> no
  is_function: (object) -> no
  is_string: (object) -> no
  is_number: (object) -> no
  is_boolean: (object) -> no
  is_date: (object) -> no
  is_regexp: (object) -> no
  is_nan: (object) -> no
  is_null: (object) -> no

  # strings
  words: (string) -> [string]
  trim: (string) -> string
  begins_with: (string, prefix) -> no
  ends_with: (string, prefix) -> no
  truncate: (string, suffix) -> string + suffix
  underscorize: (string) -> string
  capitalize: (string) -> string
  humanize: (string) -> string
  titleize: (string) -> string
  camelize: (string) -> string
  dasherize: (string) -> string

  # numbers
  times: (count, iterator) -> null

  # utility
  identity: (value) -> value
  unique_id: (prefix) -> '0000'
  is_undefined: (variable) -> variable is undefined

  # chaining
  chain: -> null
  value: -> this
