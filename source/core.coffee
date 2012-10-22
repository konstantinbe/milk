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

global = exports ? this

# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------

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

# TODO: delete either includes or supports.
Object::supports = (mixins...) ->
  for mixin in mixins
    @[key] = value for own key, value of mixin
    @prototype[key] = value for own key, value of mixin.prototype

Object::option = (object, key, fallback) ->
  if object? and Object::hasOwnProperty.call(object, key) then object[key] else fallback

Object::class_of = (object) ->
  object?.constructor ? null

Object::class_name_of = (object) ->
  object?.constructor?.name ? null

# ------------------------------------------------------------------------------

@module 'Milk', ->

  class Comparing

    equals: (object, options = {}) ->
      return no unless object?
      return @ is object unless @is_comparable()
      @compare_to(object, options) is 0

    is_comparable: ->
      no

    compare_to: (object, options = {}) ->
      throw "#Can't compare #{this} to #{object}, object is not comparable"

    is_less_than: (value, options = {}) ->
      @compare_to(value, options = {}) is -1

    is_less_than_or_equals: (value, options = {}) ->
      result = @compare_to value, options
      result is 0 or result is -1

    is_greater_than: (value, options = {}) ->
      @compare_to(value, options = {}) is 1

    is_greater_than_or_equals: (value, options = {}) ->
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

  # ----------------------------------------------------------------------------

  class Copying

    is_copyable: ->
      return yes if @class_of @ is Object
      no

    copy: ->
      throw "#{@class_name_of @} doesn't support copying" unless @class_of @ is Object
      copy = {}
      for own key, value of @
        copy[key] = value
      copy

  # ----------------------------------------------------------------------------

  class FreezingAndSealing

    native_seal = Object.seal
    native_freeze = Object.freeze

    native_is_sealed = Object.isSealed
    native_is_frozen = Object.isFrozen

    freeze: ->
      native_freeze? @
      @

    is_frozen: ->
      native_is_frozen? @

    seal: ->
      native_seal? @
      @

    is_sealed: ->
      native_is_sealed? @

  # ----------------------------------------------------------------------------

  class KeyValueCoding

    value_for: (key, options = {}) ->
      direct = options.own 'direct'

      unless direct
        getter_name = @getter_name_for key
        getter_function = @[getter_name]
        return getter_function.call @ if getter_function?.is_function()

      instance_variable_name = '@' + key
      return @[instance_variable_name] if @[instance_variable_name] isnt undefined

      @[key]

    set_value_for: (value, key, options = {}) ->
      direct = options['direct'] or no

      unless direct
        setter_name = @setter_name_for key
        setter_function = @[setter_name]
        return setter_function.call(@, value, options = {}) if setter_function?.is_function()

      instance_variable_name = '@' + key
      if @[instance_variable_name] isnt undefined
        @[instance_variable_name] = value
        return @

      if @[key] isnt undefined
        @[key] = value
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

  # ----------------------------------------------------------------------------

  class TypeChecking

    native_is_array = Array.isArray

    is_class: ->
      Boolean (typeof @) is 'function' and @name.match /^[A-Z]/

    is_function: ->
      @constructor? and @call? and @apply?

    is_boolean: ->
      @ instanceof Boolean

    is_number: ->
      @ is 0 or (@toExponential? and @toFixed?)

    is_date: ->
      @getTimezoneOffset? and @setUTCFullYear?

    is_string: ->
      @ is "" or (@charCodeAt? and @substr?)

    is_reg_exp: (value) ->
      @test? and @exec? and (@ignoreCase? or @ignoreCase == no)

    is_array: ->
      native_is_array @

    is_dictionary: ->
      @constructor?.name is 'Object'

    is_kind_of: (klass) ->
      @ instanceof klass

    is_instance_of: (klass) ->
      @class_of(@) is klass

  # ----------------------------------------------------------------------------

  class Messaging

    responds_to: (command) ->
      command? and @[command]? and @[command].is_function()

    invoke: (command, args = []) ->
      @[command](args...)

  # ----------------------------------------------------------------------------

  Object.includes Comparing
  Object.includes Copying

  Object.includes FreezingAndSealing

  Object.includes KeyValueCoding
  Object.includes TypeChecking
  Object.includes Messaging

  @export Module
