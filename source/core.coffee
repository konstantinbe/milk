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

  option = (object, key, fallback) ->
    if object? and Object::hasOwnProperty.call object, key then object[key] else fallback

  @walk: (path, options = {}) ->
    create_if_not_exists = option options, 'create_if_not_exists', no
    secret = option options, 'secret', no
    object = global
    for section in path.split "."
      parent = object
      object = object[section]
      object ?= object['$' + section] if secret
      object ?= parent[section] = new Module() if create_if_not_exists
      throw "Can't walk module path '#{path}', #{section} doesn't exist" unless object?
    object

  export: (object, options = {}) ->
    as = option options, 'as', null
    secret = option options, 'secret', no
    name = as ? object['name']
    throw "Can't export #{object}, couldn't determine name" unless name?
    throw "Can't export #{object} as '#{name}', name already taken" if @[name]?
    name = '$' + name if secret
    @[name] = object

# ------------------------------------------------------------------------------

Object::module = (path, block) ->
  module = Module.walk path, create_if_not_exists: yes
  block?.call module
  module

Object::import = (path, options = {}) ->
  secret = @option options, 'secret', no
  Module.walk path, options

Object::includes = (mixins...) ->
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
    native_to_string = Object::toString

    option: (object, key, fallback) ->
      if object? and native_has_own_property.call object, key then object[key] else fallback

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
      return undefined if object is undefined
      return null if object is null

      if Object.is_dictionary object
        copy = {}
        for own key, value of @
          copy[key] = value
        return copy

      throw "Object doesn't support copying" unless Object.responds_to object, 'copy'
      native_get_prototype_of(object)['copy'].call object

    frozen_copy_of: (object) ->
      return object if Object.is_frozen object
      return @copy_of object

    description_of: (object) ->
      return "undefined" if object is undefined
      return "null" if object is null
      return "{" + @keys_of(object).join(", ") + "}" if Object.is_dictionary object
      return object.to_string() if Object.responds_to object, 'to_string'
      native_to_string.call object

    are_equal: (left, right) ->
      throw "Can't compare objects, left is undefined" if left is undefined
      throw "Can't compare objects, right is undefined" if right is undefined
      return yes if left is null and right is null
      return no if left is null or right is null
      left_is_dictionary = Object.is_dictionary left
      right_is_dictionary = Object.is_dictionary right
      return no if left_is_dictionary and not right_is_dictionary
      return no if not left_is_dictionary and right_is_dictionary
      if left_is_dictionary and right_is_dictionary
        for key in @keys_of(left).concat @keys_of(right)
          return no unless left.has_own(key) and right.has_own(key)
          return no unless @are_equal left.own[key], right.own[key]
        return yes
      return left.equals right if Object.responds_to left, 'equals'
      return right.equals left if Object.responds_to right, 'equals'
      return left.compare_to(right) is 0 if Object.responds_to left, 'compare_to'
      return right.compare_to(left) is 0 if Object.responds_to right, 'compare_to'
      throw "Can't compare objects, neither left nor right implement equals() or compare_to()"

    compare: (left, right) ->
      throw "Can't compare objects, left is undefined" if left is undefined
      throw "Can't compare objects, right is undefined" if right is undefined
      throw "Can't compare objects, left is null" if left is null
      throw "Can't compare objects, right is null" if right is null
      throw "Can't compare objects, left is a dictionary" if Object.is_dictionary left
      throw "Can't compare objects, right is a dictionary" if Object.is_dictionary right
      throw "Can't compare, objects don't support comparing" unless Object.responds_to left, 'compare_to'
      left.compare_to right

    has_own: (object, key) ->
      native_has_own_property.call object, key

    own: (object, key) ->
      if native_has_own_property.call object, key then object[key] else undefined

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

    @getter_name_for = (key) ->
      key

    @setter_name_for = (key) ->
      example_key = "full_name"
      is_camel_cased = example_key[4] isnt '_'
      return "set_" + key unless is_camel_cased
      "set" + key[0].uppercased() + key.slice 1

    value_for: (key, options = {}) ->
      direct = @option options, 'direct', no

      unless direct
        getter_name = Object.getter_name_for key
        getter_function = @[getter_name]
        return getter_function.call @ if Object.is_function getter_function

      instance_variable_name = '@' + key
      return @[instance_variable_name] if @[instance_variable_name] isnt undefined

      @[key]

    set_value_for: (value, key, options = {}) ->
      direct = @option options, 'direct', no

      unless direct
        setter_name = Object.setter_name_for key
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

    @responds_to: (object, command) ->
      command? and object[command]? and Object.is_function object[command]

  # ----------------------------------------------------------------------------

  Object.includes Keywords
  Object.includes FreezingAndSealing
  Object.includes KeyValueCoding
  Object.includes TypeChecking
  Object.includes Messaging

  @export Module
