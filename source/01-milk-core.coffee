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

# ------------------------------------------------------------------------------

global = exports ? this

class Module

  @walk: (path, options = {}) ->
    options['create_if_not_exists'] ?= no
    options['secret'] ?= no
    object = global
    for section in path.split "."
      parent = object
      object = object[section]
      object ?= object['$' + section] if options['secret']
      object ?= parent[section] = new Module() if options['create_if_not_exists']
      throw "Can't walk module path '#{path}', #{section} doesn't exist" unless object?
    object

  export: (object, options = {}) ->
    options['as'] ?= null
    options['secret'] ?= no
    name = options['as'] ? object['name']
    throw "Can't export #{object}, couldn't determine name" unless name?
    throw "Can't export #{object} as '#{name}', name already taken" if @[name]?
    name = '$' + name if options['secret']
    @[name] = object

Object::module = (path, block) ->
  module = Module.walk path, create_if_not_exists: yes
  block?.call module
  module

Object::import = (path, options = {}) ->
  options['secret'] ?= no
  Module.walk path, options

Object::includes = (mixins...) ->
  for mixin in mixins
    @[key] = value for own key, value of mixin
    @prototype[key] = value for own key, value of mixin.prototype

# ------------------------------------------------------------------------------

@module 'Milk', ->

  class Comparing

    is_less_than: (value, options = {}) ->
      @compare_to(value, options = {}) is -1

    is_less_than_or_equal_to: (value, options = {}) ->
      result = @compare_to value, options
      result is 0 or result is -1

    is_greater_than: (value, options = {}) ->
      @compare_to(value, options = {}) is 1

    is_greater_than_or_equal_to: (value, options = {}) ->
      result = @compare_to value, options
      result is 0 or result is 1

    is_between: (bounds, options = {}) ->
      [lower, upper] = bounds
      excluding_bounds = options['excluding_bounds'] or no
      excluding_lower = options['excluding_lower'] or no
      excluding_upper = options['excluding_upper'] or no

      include_lower = not (excluding_bounds or excluding_lower)
      include_upper = not (excluding_bounds or excluding_upper)

      compared_to_lower = @compare_to lower, options
      compared_to_upper = @compare_to upper, options

      meets_lower = compared_to_lower is +1 or include_lower and compared_to_lower is 0
      meets_upper = compared_to_upper is -1 or include_upper and compared_to_upper is 0
      meets_lower and meets_upper

    is_comparable: ->
      no

    compare_to: (object, options = {}) ->
      throw "#Can't compare #{this} to #{object}, object is not comparable"

    equals: (object, options = {}) ->
      return this is object unless @is_comparable()
      @compare_to(object, options = {}) is 0

  # ----------------------------------------------------------------------------

  class Copying

    is_copyable: ->
      return yes if @class() is Object
      no

    copy: ->
      throw "#{@class_name()} doesn't support copying" unless @class() is Object
      copy = {}
      for own key, value of @
        copy[key] = value
      copy

  # ----------------------------------------------------------------------------

  class MixingAndMerging

    mixin: (objects...) ->
      for object in objects
        for own key, value of object when not @has_own key
          @[key] = value
      @

    merge: (objects...) ->
      for object in objects
        for own key, value of object
          @[key] = value
      @

    with_defaults: (defaults) ->
      dictionary = @copy()
      dictionary[key] = value for own key, value of defaults when not @has_own key
      dictionary

  # ----------------------------------------------------------------------------

  class FreezingAndSealing

    native_seal = Object.seal
    native_freeze = Object.freeze

    native_is_sealed = Object.isSealed
    native_is_frozen = Object.isFrozen

    freeze: ->
      native_freeze? @
      @

    seal: ->
      native_seal? @
      @

    is_frozen: ->
      native_is_frozen? @

    is_sealed: ->
      native_is_sealed? @

  # ----------------------------------------------------------------------------

  class KeyValueCoding

    value_for: (key, options = {}) ->
      direct = options.own 'direct'

      unless direct
        getter_name = @getter_name_for key
        getter_function = this[getter_name]
        return getter_function.call @ if getter_function?.is_function()

      instance_variable_name = @instance_variable_name_for key
      return this[instance_variable_name] if this[instance_variable_name] isnt undefined

      this[key]

    set_value_for: (value, key, options = {}) ->
      direct = options['direct'] or no

      unless direct
        setter_name = @setter_name_for key
        setter_function = this[setter_name]
        return setter_function.call(this, value, options = {}) if setter_function?.is_function()

      instance_variable_name = @instance_variable_name_for key
      if this[instance_variable_name] isnt undefined
        this[instance_variable_name] = value
        return @

      if this[key] isnt undefined
        this[key] = value
        return @

      throw "Can't set value for key '" + key + "', property unknown"
      @

    getter_name_for: (key) ->
      key

    setter_name_for: (key) ->
      example_key = "full_name"
      is_camel_cased = example_key[4] isnt '_'
      return "set_" + key unless is_camel_cased
      "set" + key[0].uppercased() + key.slice 1

    instance_variable_name_for: (key) ->
      "@" + key

  # ----------------------------------------------------------------------------

  class TypeChecking

    native_is_array = Array.isArray

    is_class: ->
      Boolean (typeof @) is 'function' and @name.match /^[A-Z]/

    is_array: ->
      native_is_array @

    is_dictionary: ->
      @constructor? and @constructor.name is 'Object'

    is_function: ->
      @constructor? and @call? and @apply?

    is_string: ->
      @ is "" or (@charCodeAt? and @substr?)

    is_number: ->
      @ is 0 or (@toExponential? and @toFixed?)

    is_boolean: ->
      @ instanceof Boolean

    is_date: ->
      @getTimezoneOffset? and @setUTCFullYear?

    is_reg_exp: (value) ->
      @test? and @exec? and (@ignoreCase? or @ignoreCase == no)

    is_kind_of: (klass) ->
      @ instanceof klass

    is_instance_of: (klass) ->
      @class() is klass

  # ----------------------------------------------------------------------------

  class Messaging

    responds_to: (method) ->
      method? and @[method]? and @[method].is_function()

    invoke: (method, args...) ->
      @[method](args...)

  # ----------------------------------------------------------------------------

  class DefiningAttributes

    has: (key, options = {}) ->
      initial = options.own 'initial'
      secret = options.own 'private'
      readonly = options.own 'readonly'
      copy = options.own 'copy'
      getter = options.own 'get'
      setter = options.own 'set'

      @[@instance_variable_name_for key + '_meta'] ?= {}.mixin options

      getter_name = @getter_name_for key
      setter_name = @setter_name_for key
      instance_variable_name = @instance_variable_name_for key

      getter ?= ->
        @[instance_variable_name] = initial unless @has_own instance_variable_name
        @[instance_variable_name]

      setter ?= (value) ->
        value = value.copy() if copy
        @[instance_variable_name] = value
        @

      @prototype[getter_name] = getter
      @prototype[setter_name] = setter

      Object.defineProperty @prototype, getter_name, enumerable: no if secret
      Object.defineProperty @prototype, setter_name, enumerable: no if secret or readonly

    meta_for: (key) ->
       @[@instance_variable_name_for key + '_meta']

  # ----------------------------------------------------------------------------

  class ObjectExtensions

    native_has_own_property = Object::hasOwnProperty
    native_to_string = Object::toString

    class: ->
      return @constructor

    class_name: ->
      return @class().name

    keys: ->
      Object.keys @

    values: ->
      (value for own key, value of @)

    has_own: (key) ->
      native_has_own_property.call this, key

    own: (key) ->
      if @has_own key then @[key] else undefined

    toString: ->
      return @to_string() if @to_string?
      native_to_string.call @

    to_string: ->
      native_to_string.call @

  # ----------------------------------------------------------------------------

  class BooleanExtensions

    is_comparable: ->
      yes

    is_copyable: ->
      yes

    compare_to: (object, options = {}) ->
      throw "Can't compare boolean to #{object}." unless object?.is_boolean()
      return -1 if not @ and object
      return +1 if @ and not object
      0

    copy: ->
      return @ if @is_frozen()
      @ is true

  # ----------------------------------------------------------------------------

  class NumberExtensions

    is_comparable: ->
      yes

    is_copyable: ->
      yes

    compare_to: (object, options = {}) ->
      return -1 if this < object
      return +1 if this > object
      0

    copy: ->
      return @ if @is_frozen()
      new Number @

  # ----------------------------------------------------------------------------

  class RegExpExtensions

    is_comparable: ->
      yes

    is_copyable: ->
      yes

    compare_to: (object, options = {}) ->
      throw "Can't regexp to #{object}." unless object?.is_reg_exp()
      return -1 if this < object
      return +1 if this > object
      0

    copy: ->
      return @ if @is_frozen()
      new RegExp @

  # ----------------------------------------------------------------------------

  class DateExtensions

    is_comparable: ->
      yes

    is_copyable: ->
      yes

    compare_to: (object, options = {}) ->
      throw "Can't compare date to #{object}." unless object?.is_date()
      return -1 if this < object
      return +1 if this > object
      0

    copy: ->
      return @ if @is_frozen()
      new Date @

  # ----------------------------------------------------------------------------

  class FunctionExtensions

    is_comparable: ->
      no

    is_copyable: ->
      no

    new: (args...) ->
      new this args...

  # ----------------------------------------------------------------------------

  class ArrayExtensions

    is_comparable: ->
      no

    is_copyable: ->
      yes

    equals: (object) ->
      return no unless object.is_array()
      return no unless @length == object.length
      return no unless (@all (value, index) -> value is object[index] or value?.equals object[index])
      yes

    copy: ->
      return @ if @is_frozen()
      [].concat this

    to_string: ->
      strings = @collect (object) -> if object? then object.to_string() else object
      "[" + strings.join(", ") + "]"

  # ----------------------------------------------------------------------------

  class StringExtensions

    is_comparable: ->
      yes

    is_copyable: ->
      yes

    compare_to: (object, options = {}) ->
      return -1 if this < object
      return +1 if this > object
      0

    copy: ->
      return @ if @is_frozen()
      new String @

  # ----------------------------------------------------------------------------

  class MathExtensions

    @generate_unique_id: ->
      unique_id = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (character) ->
        random = Math.random() * 16 | 0
        number = if character == 'x' then random else (random & 0x3 | 0x8)
        number.toString 16
      unique_id

    @identity = (object) -> object

  # ----------------------------------------------------------------------------

  Object.includes Comparing
  Object.includes Copying

  Object.includes MixingAndMerging
  Object.includes FreezingAndSealing

  Object.includes KeyValueCoding
  Object.includes TypeChecking
  Object.includes Messaging

  Function.includes DefiningAttributes

  Object.includes ObjectExtensions
  Function.includes FunctionExtensions

  Array.includes ArrayExtensions
  String.includes StringExtensions
  RegExp.includes RegExpExtensions

  Date.includes DateExtensions
  Number.includes NumberExtensions
  Boolean.includes BooleanExtensions

  Math.includes MathExtensions

  # ----------------------------------------------------------------------------

  for key of Object.prototype
    Object.defineProperty Object.prototype, key, enumerable: no

  for key of Array.prototype
    Object.defineProperty Array.prototype, key, enumerable: no

  # ----------------------------------------------------------------------------

  @export Module
