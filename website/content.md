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

Returns a copy of the receiver. The default implementation throws an error.
Subclasses implementing this method should also implement `is_copyable()`
and return `yes`.

#### `mixin(object)`

Modifies the receiver by mixing in all own properties of `object` without
overwriting existing ones. Returns the receiver. See also: `merge()`.

#### `merge(object)`

Modifies the receiver by mixing in all own properties of `object` overwriting
existing ones. Returns the receiver. See also: `mixin()`.

#### `with(object)`

Returns a new object with all own properties of the receiver merged with all own
properties of `object` while overwriting existing ones. See also: `merge()`

#### `with_defaults(object)`

*TODO: describe or deprecate.*

#### `freeze()`

Freezes the receiver and returns it. This method has no effect if the receiver
is already frozen. An object can't be modified after it has been frozen.

#### `is_frozen()`

Returns `yes` if receiver is frozen, otherwise returns `no`. See also:
`freeze()`.

#### `seal()`

Seals the receiver and returns it. This method has no effect if the receiver
is already sealed. A sealed object doesn't allow to add or to remove properties,
only existing properties can be modified.

#### `is_sealed()`

Returns `yes` if receiver is sealed, otherwise returns `no`. See also:
`seal()`.

#### `value_for(key, options = {})`

Returns the value for the property identified by `key`. Tries to call the getter
or return the instance variables directly in the following order:

1. Getter method named `{key}`
2. Instance variable named `@{key}`
3. Instance variable named `{key}`

If none of the above exist, returns `undefined`. Bypasses the getter if option
`direct: yes` is passed. See also: `set_value_for()`.

#### `set_value_for(value, key, options = {})`

Sets the `value` for the property identified by `key` and returns the receiver.
Tries to call the setter or set the instance variables directly in the following
order:

1. Setter method named `set_{key}`
2. Instance variable named `@{key}`
3. Instance variable named `{key}`

If none of the above exist, throws an error. Bypasses the setter If option
`direct: yes` is passed. See also: `value_for()`.

#### `getter_name_for()`

*TODO: describe.*

#### `setter_name_for()`

*TODO: describe.*

#### `instance_variable_name_for()`

Comparing:

- `equals()`
- `is_comparable()`
- `compare_to()`
- `is_less_than()`
- `is_less_than_or_equals()`
- `is_greater_than()`
- `is_greater_than_or_equals()`
- `is_between()`

Copying:

- `is_copyable()`
- `copy()`

Mixing & Merging:

- `mixin()`
- `merge()`
- `with()`
- `with_defaults()`

Freezing & Sealing:

- `freeze()`
- `is_frozen()`
- `seal()`
- `is_sealed()`

Key-Value-Coding:

- `value_for()`
- `set_value_for()`
- `getter_name_for()`
- `setter_name_for()`
- `instance_variable_name_for()`

Checking types:

- `is_class()`
- `is_function()`
- `is_boolean()`
- `is_number()`
- `is_date()`
- `is_string()`
- `is_reg_exp()`
- `is_array()`
- `is_dictionary()`
- `is_kind_of()`
- `is_instance_of()`

Messaging:

- `responds_to()`
- `invoke()`

Other:

- `new()`
- `class()`
- `class_name()`
- `keys()`
- `values()`
- `has_own()`
- `own()`
- `to_string()`

### Function Class Reference

*TODO: put detailed descriptions for each method here.*

### Boolean Class Reference

*TODO: put detailed descriptions for each method here.*

### Number Class Reference

*TODO: put detailed descriptions for each method here.*

### Date Class Reference

*TODO: put detailed descriptions for each method here.*

### String Class Reference

- `count()`
- `first()`
- `second()`
- `third()`
- `rest()`
- `last()`
- `code_at()`
- `characters()`
- `codes()`
- `lines()`
- `paragraphs()`
- `prepend()`
- `append()`
- `index_of()`
- `last_index_of()`
- `indexes_of()`
- `begins_with()`
- `ends_with()`
- `increment_suffix_number()`
- `uppercased()`
- `lowercased()`
- `capitalized()`
- `escaped_for_reg_exp()`
- `parse_integer()`
- `utf8()`
- `utf16()`
- `sha1()`

### RegExp Class Reference

*TODO: put detailed descriptions for each method here.*

### Array Class Reference

- `count()`
- `is_empty()`
- `contains()`
- `contains_all()`
- `contains_any()`
- `at()`
- `at_many()`              
- `index_of()`
- `last_index_of()`
- `indexes_of()`

Accessing Parts:

- `first()`
- `second()`
- `third()`
- `last()`
- `rest()`

Deriving Arrays:

- `with()`
- `with_many()`
- `with_at()`
- `with_many_at()`
- `with_before()`
- `with_many_before()`
- `with_after()`
- `with_many_after()`
- `without()`
- `without_many()`
- `without_at()`
- `without_many_at()`
- `compacted()`
- `flattened()`
- `reversed()`
- `sorted()`
- `unique()`
- `intersect()`
- `unite()`
- `zip()`

Iterating Arrays:

- `each()`
- `collect()`
- `select()`
- `reject()`
- `detect()`
- `pluck()`
- `partition()`
- `all()`
- `any()`
- `max()`
- `min()`
- `group_by()`
- `inject()`

Mutating Arrays:

- `add()`
- `add_many()`
- `remove()`
- `remove_many()`
- `remove_at()`
- `remove_many_at()`
- `remove_all()`
- `insert_at()`
- `insert_many_at()`
- `insert_before()`
- `insert_many_before()`
- `insert_after()`
- `insert_many_after()`
- `replace_with()`
- `replace_with_many()`
- `replace_at_with()`
- `replace_at_with_many()`
- `sort_by()`

### Math Class Reference

- `Math.generate_unique_id()`
- `Math.identity()`

--------------------------------------------------------------------------------

## Changelog

### 0.1.0

* Initial release
