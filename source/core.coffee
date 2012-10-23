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

# ------------------------------------------------------------------------------

@module 'Milk', ->

  class Keywords

    native_is_array = Array.isArray
    native_has_own_property = Object::hasOwnProperty
    native_get_prototype_of = Object.getPrototypeOf
    native_keys = Object.keys

    option: (object, key, fallback) ->
      if object? and native_has_own_property.call(object, key) then object[key] else fallback

    class_of: (object) ->
      object?.constructor ? null

    class_name_of: (object) ->
      object?.constructor?.name ? null

    keys_of: (object) ->
      native_keys object

    values_of: (object) ->
      (object[key] for key in native_keys object)

    prototype_of: (object) ->
      native_get_prototype_of object

    copy_of: (object) ->
      return null unless object?
      native_get_prototype_of(object)['copy'].call object

# ------------------------------------------------------------------------------

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

  class FreezingAndSealing

    native_is_sealed = Object.isSealed
    native_is_frozen = Object.isFrozen

    @is_frozen: (object) ->
      native_is_frozen object

    @is_sealed: (object) ->
      native_is_sealed object

  # ----------------------------------------------------------------------------

  class KeyValueCoding

    value_for: (key, options = {}) ->
      direct = options.own 'direct'

      unless direct
        getter_name = @getter_name_for key
        getter_function = @[getter_name]
        return getter_function.call @ if Object.is_function getter_function

      instance_variable_name = '@' + key
      return @[instance_variable_name] if @[instance_variable_name] isnt undefined

      @[key]

    set_value_for: (value, key, options = {}) ->
      direct = options['direct'] or no

      unless direct
        setter_name = @setter_name_for key
        setter_function = @[setter_name]
        return setter_function.call(@, value, options = {}) if Object.is_function setter_function

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

    @is_null: (object) ->
      object is null

    @is_class: (object) ->
      Boolean (typeof object) is 'function' and object.name.match /^[A-Z]/

    @is_function: (object) ->
      object?.constructor? and object.call? and object.apply?

    @is_boolean: (object) ->
      object is yes or object is no

    @is_number: (object) ->
      object is 0 or (object?.toExponential? and object.toFixed?)

    @is_date: (object) ->
      object? and object.getTimezoneOffset? and object.setUTCFullYear?

    @is_string: (object) ->
      object is "" or (object?.charCodeAt? and object.substr?)

    @is_reg_exp: (object) ->
      object? and object.test? and object.exec? and (object.ignoreCase? or object.ignoreCase == no)

    @is_array: (object) ->
      native_is_array object

    @is_dictionary: (object) ->
      object?.constructor?.name is 'Object'

    @is_kind_of: (object, klass) ->
      object instanceof klass

    @is_instance_of: (object, klass) ->
      @class_of(object) is klass

  # ----------------------------------------------------------------------------

  class Messaging

    responds_to: (command) ->
      command? and @[command]? and Object.is_function @[command]

    invoke: (command, args = []) ->
      @[command](args...)

  # ----------------------------------------------------------------------------

  Object.includes Keywords
  Object.includes Comparing
  Object.includes FreezingAndSealing
  Object.includes KeyValueCoding
  Object.includes TypeChecking
  Object.includes Messaging

  @export Module
