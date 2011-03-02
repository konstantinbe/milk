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

exports.Enumerable =
  is_enumerable: yes

  each: (block, context) ->
    return @values().each block, context

  collect: (block, context) ->
    return @values().collect block, context

  select: (block, context) ->
    return @values().select block, context

  reject: (block, context) ->
    @inject [], (values, value) ->
      unless block value then values.add value else values

  partition: (block) ->
    block = ((value) -> value) unless block?
    selected = []
    rejected = []
    @each (value) ->
      if block value then selected.add value else rejected.add value
    [selected, rejected]

  detect: (block, context) ->
    for value in @values()
      return value if block value
    false

  all: (block, context) ->
    return @values().all block, context

  any: (block, context) ->
    return @values().any block, context

  max: ->
    @values().max()

  min: ->
    @values().min()

  group_by: (key_path_or_block) ->
    block = if key_path_or_block.is_function() then key_path_or_block else (value) -> value.get key_path_or_block
    @inject {}, (partition, value) ->
      key = block value
      partition[key] = [] unless partition[key]
      partition[key].add value
      partition


  inject: (initial, block) ->
    @values().inject initial, block

  contains: (value) ->
    @values().contains value

  invoke: (method, args...) ->
    @collect (value) ->
      value[method].apply value, args

  pluck: (key) ->
    @collect (value) ->
      value[key]

  values: ->
    values = []
    @each (value) ->
      values.add value
    values

  count: ->
    @values().length

  empty: ->
    @count() == 0
