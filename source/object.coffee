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

READ = 1
WRITE = 2

ObjectExtensions =
  clone: () ->
    # TODO: Implement this.

  equals: (object) ->
    # TODO: Implement this.

  hash: () ->
    # TODO: Implement this.

  keys: () ->
    # TODO: Implement this.

  values: () ->
    # TODO: Implement this.

  methods: () ->
    # TODO: Implement this.

  mixin: (mixins...) ->
    # TODO: Implement this.

  responds_to: (method) ->
    # TODO: Implement this.

  merge: (object, options = {}) ->
    options['reverse'] ?= no
    # TODO: Implement this.

  has = (name, options = {}) ->
    options['access'] ?= READ | WRITE
    options['default'] ?= null
    options['variable'] ?= '_' + name
    options['get'] ?= 'get_' + name
    options['set'] ?= 'set_' + name

    readable = options['access'] & READ
    writeable = options['access'] & WRITE

    default_getter = -> this[options['variable']] + ' (accessed through getter)'
    default_setter = (value) ->  this[options['variable']] = value + ' (set through setter)'

    custom_getter = this[options['get']]
    custom_setter = this[options['set']]

    getter = custom_getter or default_getter
    setter = custom_setter or default_setter

    config =
      writeable: writeable
      get: getter if readable
      set: setter if writeable
      configurable: no
      enumerable: yes

    using_only_default_accessors = not (custom_getter or custom_setter)
    @prototype[options['variable']] = options['default'] if using_only_default_accessors
    Object.defineProperty @prototype, name, config

  has_one = (name, options = {}) -> null
    # TODO: Implement this.

  has_many = (name, options = {}) -> null
    # TODO: Implement this.

  belongs_to = (name, options = {}) -> null
    # TODO: Implement this.

  has_and_belongs_to_many = (name, options = {}) -> null
    # TODO: Implement this.
