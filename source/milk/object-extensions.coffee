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

native_seal = Object.seal
native_freeze = Object.freeze
native_is_sealed = Object.isSealed
native_is_frozen = Object.isFrozen

ObjectExtensions =
  keys: ->
    Object.keys this

  values: ->
    values = []
    for own key, value of this
       values.add value
    values

  properties: ->
    @keys().inject [], (properties, key) =>
      if this[key].is_function() then properties else properties.add key

  methods: ->
    @keys().inject [], (methods, key) =>
      if this[key].is_function() then methods.add key else methods

  responds_to: (method) ->
    @[method]? and @[method].is_function()

  send: (method, parameters...) ->
    @[method](parameters...)

  merge: (objects...) ->
    for object in objects
      for own key, value of object
        @[key] = value
    this

  freeze: ->
    if native_freeze? then native_freeze(this) else @is_frozen = -> yes
    this

  seal: ->
    if native_seal? native_seal(this) else @is_sealed = -> yes
    this

  is_frozen: ->
    if native_is_frozen? then native_is_frozen(this) else no

  is_sealed: ->
    if native_is_sealed? then native_is_sealed(this) else no

  is_array: ->
    Array.isArray this

  is_function: ->
    @constructor? and @call? and @apply?

  is_string: ->
    this == '' or (@charCodeAt? and @substr?)

  is_number: ->
    this == 0 or (@toExponential? and @toFixed?)

  is_boolean: ->
    this instanceof Boolean

  is_date: ->
    @getTimezoneOffset? and @setUTCFullYear?

  is_reg_exp: (value) ->
    @test? and @exec? and (@ignoreCase? or @ignoreCase == no)

  # ----------------------------------------------------------------------------

  clone: ->
    clone = {}
    for own key, value of this
      clone[key] = value
    clone

  equals: (object) ->
    this == object

  description: ->
    if @toString? then @toString() else "Object"

  # ------------------------------- defining properties and relationships ------

  has: (name, options = {}) ->
    options['access'] ?= 'readwrite'
    options['default'] ?= null
    options['type'] ?= 'Object'
    options['variable'] ?= '_' + name
    options['getter'] ?= 'get_' + name
    options['setter'] ?= 'set_' + name

    readable = options['access'].begins_with 'read'
    writeable = options['access'].ends_with 'write'

    getter_ = options['getter']
    setter = options['setter']
    variable = options['variable']

    getter_function = ->
      @will_access_value_for name
      value = if @[getter] then @[getter]() else @[variable]
      @did_access_value_for name
      value

    setter_function = (value) ->
      @will_change_value_for name
      if @[setter] then @[setter](value) else @[variable] = value
      @did_change_value_for name
      @

    config =
      writeable: writeable
      getter: getter_function if readable
      setter: setter_function if writeable
      configurable: no
      enumerable: yes

    @prototype[options['variable']] = options['default']
    Object.defineProperty @prototype, name, config
    @

  has_one: (name, options = {}) ->
    # TODO: implement.

  has_many: (name, options = {}) ->
    # TODO: implement.

  belongs_to: (name, options = {}) ->
    # TODO: implement.

  has_and_belongs_to_many: (name, options = {}) ->
    # TODO: Implement this.

  # -------------------------------------------- key-value-coding methods ------

  value_for: (key) ->
    getter = 'get_' + key
    @will_access_value_for key
    value = if @responds_to getter then @send getter else @[key]
    @did_access_value_for key
    value

  set_value: (value, options = {}) ->
    key = options['for']
    setter = 'set_' + key
    @will_change_value_for key
    if @responds_to setter then @send setter, value else @[key] = value
    @did_change_value_for key
    @

  # ------------------------ key-value coding change notification methods ------

  will_access_value_for: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  did_access_value_for: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  will_change_value_for: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  did_change_value_for: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  will_insert_values_into: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  did_insert_values_into: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  will_remove_values_from: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  did_remove_values_from: (key, options = {}) ->
    @ # do nothing for now, will be used later for key-value observing.

  # ----------------------- generic to-many relationship accessor methods ------

  add_value: (value, options = {}) ->
    @add_many_values [value], options

  add_many_values: (values, options = {}) ->
    key = options['to']
    array = @[key]
    index = array.length
    array.add_many values
    @

  remove_value: (value, options = {}) ->
    @remove_many_values [value], options

  remove_many_values: (values, options = {}) ->
    key = options['from']
    @[key].remove_many values
    @

  insert_value: (value, options = {}) ->
    @insert_many_values [value], options

  insert_many_values: (values, options = {}) ->
    key = options['into']
    index = options['at']
    @[key].insert_many values, at: index
    @

  remove_value_at: (index, options = {}) ->
    @remove_many_values_at [index], options

  remove_many_values_at: (indexes, options = {}) ->
    key = options['from']
    @[key].remove_at indexes...
    @
