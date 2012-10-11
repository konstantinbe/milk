# Milk

*A little opinionated utility-belt library for CoffeeScript*

--------------------------------------------------------------------------------

Milk is a little utility-belt library for CoffeeScript mainly inspired by
[underscore.js](http://underscorejs.org) while borrowing ideas from *Cocoa*,
*Rails*, *jQuery*, *Prototype*, and others.

Milk is *opinionated*, alledged "conventions" and "best-practices" may be
violated. In particular, Milk uses underscore notation like *Ruby* and makes
heavy use of monkey patching to extend the core JavaScript types.

--------------------------------------------------------------------------------

## Overview

*TODO: give an overview here.*

--------------------------------------------------------------------------------

## Tutorial

*TODO: write a little tutorial here.*

--------------------------------------------------------------------------------

## Reference

### Object Class Reference

#### `equals(object)`

Returns `yes` if receiver equals `object`, otherwise returns `no`.

#### `is_comparable()`

Returns `yes` if receiver is comparable, otherwise returns `no`. The default
implementation returns `no`, subclasses returning `yes` must implement the
`compare_to()` method.

#### `compare_to(object)`

Returns:

* `-1` if receiver is less than `object`
* `+1` if receiver is greater than `object`
* ` 0` if receiver equals `object`

The default implementation throws an error. Subclasses implementing this method
should also implement `is_comparable()` and return `yes`. This is a low-level
method called by all high-level comparison methods:

- `is_less_than()`
- `is_less_than_or_equals()`
- `is_greater_than()`
- `is_greater_than_or_equals()`
- `is_between()`

#### `is_less_than(object)`

Returns `yes` if receiver is less than `object`, otherwise returns `no`. This is
a high-level method and should not be overriden. To support or customize
comparison, objects must override the `compare_to()` method instead.

#### `is_less_than_or_equals(object)`

Returns `yes` if receiver is less than or equals `object`, otherwise returns
`no`. This is a high-level method and should not be overriden. To support or
customize comparison, objects must override the `compare_to()` method
instead.

#### `is_greater_than(object)`

Returns `yes` if receiver is greater than `object`, otherwise returns `no`. This
is a high-level method and should not be overriden. To support or customize
comparison, objects must override the `compare_to()` method instead.

#### `is_greater_than_or_equals(object)`

Returns `yes` if receiver is greater than or equals `object`, otherwise returns
`no`. This is a high-level method and should not be overriden. To support or
customize comparison, objects must override the `compare_to()` method
instead.

#### `is_between(bounds, options = {})`

Returns `yes` if receiver is within `bounds` (array with two elements `[lower,
upper]`), otherwise returns `no`. By default, bounds are inclusive. To exclude
both bounds, or lower/upper bound individually, pass in any of the following
options:

* `excluding_bounds: yes`
* `excluding_lower: yes`
* `excluding_upper: yes`

This is a high-level method and should not be overriden. To support or customize
comparison, objects must override the `compare_to()` method instead.

#### `is_copyable()`

Returns `yes` if receiver supports copying, otherwise returns `no`. The default
implementation returns `no`. subclasses returning `yes` must implement the
`copy()` method.

#### `copy()`

Returns a copy of `self`. The default implementation throws an error.
Subclasses implementing this method should also implement `is_copyable()`
and return `yes`.

#### `mixin(object)`

Mutates `self` by mixing in all own properties of `object` without
overwriting existing ones. Returns `self`. See also: `merge()`.

#### `merge(object)`

Mutates `self` by mixing in all own properties of `object` overwriting
existing ones. Returns `self`. See also: `mixin()`.

#### `with(object)`

Returns a new object with all own properties of `self` merged with all own
properties of `object` while overwriting existing ones. See also: `merge()`

#### `with_defaults(object)`

*TODO: describe or deprecate.*

#### `freeze()`

Freezes and returns `self`. This method has no effect if `self`
is already frozen. An object can't be modified after it has been frozen.

#### `is_frozen()`

Returns `yes` if receiver is frozen, otherwise returns `no`. See also:
`freeze()`.

#### `seal()`

Seals and returns `self`. This method has no effect if `self`
is already sealed. A sealed object doesn't allow to add or to remove properties,
only existing properties can be modified.

#### `is_sealed()`

Returns `yes` if receiver is sealed, otherwise returns `no`. See also:
`seal()`.

#### `value_for(key, options = {})`

Returns the value for the property identified by `key`. Tries to call the getter
or return the instance variables directly in the following order:

1. Getter method named `<key>`
2. Instance variable named `@<key>`
3. Instance variable named `<key>`

If none of the above exist, returns `undefined`. Bypasses the getter if option
`direct: yes` is passed. See also: `set_value_for()`.

#### `set_value_for(value, key, options = {})`

Sets the `value` for the property identified by `key` and returns `self`.
Tries to call the setter or set the instance variables directly in the following
order:

1. Setter method named `set_<key>`
2. Instance variable named `@<key>`
3. Instance variable named `<key>`

If none of the above exist, throws an error. Bypasses the setter If option
`direct: yes` is passed. See also: `value_for()`.

#### `getter_name_for(key)`

Returns the getter name for a specific `key`. Currently, the getter name is
simply the key itself (this might change in the future).

#### `setter_name_for(key)`

Returns the setter name for a specific `key`. Currently, the setter name is of
the form `set_<key>` (this might change in the future).

#### `instance_variable_name_for(key)`

Returns the instance variable name for a specific `key`. Currently, the instance
variable name is of the form `@<key>` (this might change in the future).

#### `is_class()`

Returns `yes` if `self` is a class, otherwise returns `no`.

#### `is_function()`

Returns `yes` if `self` is a function, otherwise returns `no`.

#### `is_boolean()`

Returns `yes` if `self` is a boolean, otherwise returns `no`.

#### `is_number()`

Returns `yes` if `self` is a number, otherwise returns `no`.

#### `is_date()`

Returns `yes` if `self` is a date, otherwise returns `no`.

#### `is_string()`

Returns `yes` if `self` is a string, otherwise returns `no`.

#### `is_reg_exp()`

Returns `yes` if `self` is a regular expression, otherwise returns `no`.

#### `is_array()`

Returns `yes` if `self` is an array, otherwise returns `no`.

#### `is_dictionary()`

Returns `yes` if `self` is a dictionary, otherwise returns `no`. A dictionary is
a plain JavaScript object without a superclass.

#### `is_kind_of(class)`

Returns `yes` if `self` is an instance of `class` or any of its superclasses,
otherwise returns `no`. See also: `is_instance_of()`.

#### `is_instance_of(class)`

Returns `yes` if `self` is an instance of `class`, otherwise returns `no`. See
also: `is_kind_of()`.

#### `responds_to(command)`

Returns `yes` if `self` responds to `command` (i.e. has a method with that
name), otherwise returns `no`.

#### `invoke(command, args = [])`

Invokes the method named `command`, passes the `args` array as arguments and
returns the result. Throws an error if `self` doesn't respond to `command`.

### Function Class Reference

#### `new(args...)`

Creates a new instance of a class by passing `args` to the constructor.

#### `has(key, options = {})`

Defines a property for the class. By default synthesizes a getter and a setter
method of the form `<key>()` and `set_<key>()`, and initializes an instance
variable named `@<key>` with `null`. The property can be customized by passing
the following options:

* `initial`: initial value for the property, default: `null`.
* `secret`: public or private, defualt: `no`.
* `readonly`: read/write or readonly, default: `no`.
* `copy`: copy the value rather than referencing it directly, default: `no`.
* `freeze`: freeze the value before returning it, default: `no`.
* `get`: custom getter function, default: `null` (will be synthesized).
* `set`: custom setter function, default: `null` (will be synthesized).

See also: `value_for()`, `set_value_for()`.

### Boolean Class Reference

The `Boolean` class currently has no extended methods but supports copying and
comparing.

### Number Class Reference

The `Number` class supports copying and comparing.

#### `is_nan()`

Returns `yes` if number is `NaN` (not a number), otherwise returns `no`.

#### `is_finite()`

Returns `yes` if number is finite, otherwise returns `no`.

#### `is_infinite()`

Returns `yes` if number is infinite, otherwise returns `no`.

### Date Class Reference

The `Date` class currently has no extended methods but supports copying and
comparing.

### String Class Reference

#### `count()`

Returns number of characters contained in `self`.

#### `first(count)`

Returns a string containing the first character if string is not empty.
Otherwise returns `null`. If the optional parameter `count` is passed, returns
a prefix with up to `count` characters.

#### `last(count)`

Returns a string containing the last character if string is not empty.
Otherwise returns `null`. If the optional parameter `count` is passed, returns
a prefix with up to `count` characters.

#### `code_at(index)`

*TODO: describe.*

#### `characters()`

*TODO: describe.*

#### `codes()`

*TODO: describe.*

#### `lines()`

*TODO: describe.*

#### `paragraphs()`

*TODO: describe.*

#### `prepend(string)`

*TODO: describe.*

#### `append(string)`

*TODO: describe.*

#### `index_of(string)`

*TODO: describe.*

#### `last_index_of(string)`

*TODO: describe.*

#### `indexes_of(string)`

*TODO: describe.*

#### `begins_with(string)`

*TODO: describe.*

#### `ends_with(string)`

*TODO: describe.*

#### `increment_suffix_number()`

*TODO: describe.*

#### `uppercased()`

*TODO: describe.*

#### `lowercased()`

*TODO: describe.*

#### `capitalized()`

*TODO: describe.*

#### `escaped_for_reg_exp()`

*TODO: describe.*

#### `parse_integer(integer)`

*TODO: describe.*

#### `utf8()`

*TODO: describe.*

#### `sha1()`

### RegExp Class Reference

The `RegExp` class currently has no extended methods but supports copying and
comparing.

### Array Class Reference

#### `count()`

*TODO: describe.*

#### `is_empty()`

*TODO: describe.*

#### `contains()`

*TODO: describe.*

#### `contains_all()`

*TODO: describe.*

#### `contains_any()`

*TODO: describe.*

#### `at()`

*TODO: describe.*

#### `at_many()`              

*TODO: describe.*

#### `index_of()`

*TODO: describe.*

#### `last_index_of()`

*TODO: describe.*

#### `indexes_of()`

*TODO: describe.*

#### `first()`

*TODO: describe.*

#### `second()`

*TODO: describe.*

#### `third()`

*TODO: describe.*

#### `last()`

*TODO: describe.*

#### `rest()`

*TODO: describe.*

#### `with()`

*TODO: describe.*

#### `with_many()`

*TODO: describe.*

#### `with_at()`

*TODO: describe.*

#### `with_many_at()`

*TODO: describe.*

#### `with_before()`

*TODO: describe.*

#### `with_many_before()`

*TODO: describe.*

#### `with_after()`

*TODO: describe.*

#### `with_many_after()`

*TODO: describe.*

#### `without()`

*TODO: describe.*

#### `without_many()`

*TODO: describe.*

#### `without_at()`

*TODO: describe.*

#### `without_many_at()`

*TODO: describe.*

#### `compacted()`

*TODO: describe.*

#### `flattened()`

*TODO: describe.*

#### `reversed()`

*TODO: describe.*

#### `sorted()`

*TODO: describe.*

#### `unique()`

*TODO: describe.*

#### `intersect()`

*TODO: describe.*

#### `unite()`

*TODO: describe.*

#### `zip()`

*TODO: describe.*

#### `each()`

*TODO: describe.*

#### `collect()`

*TODO: describe.*

#### `select()`

*TODO: describe.*

#### `reject()`

*TODO: describe.*

#### `detect()`

*TODO: describe.*

#### `pluck()`

*TODO: describe.*

#### `partition()`

*TODO: describe.*

#### `all()`

*TODO: describe.*

#### `any()`

*TODO: describe.*

#### `max()`

*TODO: describe.*

#### `min()`

*TODO: describe.*

#### `group_by()`

*TODO: describe.*

#### `inject()`

*TODO: describe.*

#### `add()`

*TODO: describe.*

#### `add_many()`

*TODO: describe.*

#### `remove()`

*TODO: describe.*

#### `remove_many()`

*TODO: describe.*

#### `remove_at()`

*TODO: describe.*

#### `remove_many_at()`

*TODO: describe.*

#### `remove_all()`

*TODO: describe.*

#### `insert_at()`

*TODO: describe.*

#### `insert_many_at()`

*TODO: describe.*

#### `insert_before()`

*TODO: describe.*

#### `insert_many_before()`

*TODO: describe.*

#### `insert_after()`

*TODO: describe.*

#### `insert_many_after()`

*TODO: describe.*

#### `replace_with()`

*TODO: describe.*

#### `replace_with_many()`

*TODO: describe.*

#### `replace_at_with()`

*TODO: describe.*

#### `replace_at_with_many()`

*TODO: describe.*

#### `sort_by()`

### Math Class Reference

#### `Math.generate_unique_id()`

Generates and returns a random string which can be used as a (globally) unique
ID.

#### `Math.identity()`

Returns the identity function. An identity function takes a parameter and simply
returns it as is without doing anything.

--------------------------------------------------------------------------------

## Changelog

### 0.1.0

* Initial release
