# Milk

*A little opinionated utility-belt library for CoffeeScript*

--------------------------------------------------------------------------------

Milk is a little utility-belt library for CoffeeScript mainly inspired by
[underscore.js](http://underscorejs.org) while borrowing ideas from *Cocoa*,
*Rails*, *jQuery*, *Prototype*, and others.

Milk is *opinionated*, alledged "conventions" and "best-practices" may be
violated. In particular, Milk uses underscore notation like *Ruby* and makes
heavy use of monkey patching to extend the core JavaScript types.

Released under the [MIT license](license.txt). Copyright &copy; 2012 [Konstantin Bender](http://github.com/konstantinbe).

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

Alias for `mixin()`.

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

* `initial`: initial value for the property, default: `null`
* `secret`: public or private, defualt: `no`
* `readonly`: read/write or readonly, default: `no`
* `copy`: copy the value rather than referencing it directly, default: `no`
* `freeze`: freeze the value before returning it, default: `no`
* `get`: custom getter function, default: `null` (will be synthesized)
* `set`: custom setter function, default: `null` (will be synthesized)

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

Returns the character code at `index` or null if `index` is out of bounds.

#### `characters()`

Returns an array of characters.

#### `codes()`

Returns an array of codes.

#### `lines()`

Returns an array by splitting the string into lines.

#### `paragraphs()`

Returns an array by splitting the string into paragraphs. A paragraph is a block
of text separated by an empty line.

#### `prepend(strings...)`

Returns a new string by prepending `strings`.

#### `append(strings...)`

Returns a new string by appending `strings`.

#### `index_of(string)`

Returns the index of the first occurence of `string` or `-1` if not found.

#### `last_index_of(string)`

Returns the index of the last occurence of `string` or `-1` if not found.

#### `indexes_of(string)`

Returns the indexes of all occurences of `string`.

#### `begins_with(prefix)`

Returns `yes` if string begings with `prefix`, otherwise returns `no`.

#### `ends_with(suffix)`

Returns `yes` if string ends with `suffix`, otherwise returns `no`.

#### `uppercased()`

Returns a new string with all characters in uppercase.

#### `lowercased()`

Returns a new string with all characters in lowercase.

#### `capitalized()`

Returns a new string with the first character capitalized.

#### `escaped_for_reg_exp()`

Escapes all special characters used by regular expressions.

#### `utf8()`

Returns a UTF-8 version.

#### `sha1()`

Returns the SHA1 hash.

### RegExp Class Reference

The `RegExp` class currently has no extended methods but supports copying and
comparing.

### Array Class Reference

#### `count()`

Returns the number of objects contained in the array.

#### `is_empty()`

Returns `yes` if array is empty (count = 0) otherwise returns `no`.

#### `contains(object)`

Returns `yes` if `object` is in array, otherwise returns `no`.

#### `contains_all(objects)`

Returns `yes` if `self` contains *all* of `objects`, otherwise returns `no`.

#### `contains_any(objects)`

Returns `yes` if `self` contains *any* of `objects`, otherwise returns `no`.

#### `at(index)`

Returns the object at `index`. Returns `null` if `index` is out of bounds.

#### `at_many(indexes)`

Returns an array containing the object for each of the `indexes`. For each of
the index that is out of bounds, the array contains a `null`.

#### `index_of(object)`

Returns the index of the first occurence of `object` if it's in the array,
otherwise returns `-1`.

#### `last_index_of(object)`

Returns the index of the last occurence of `object` if it's in the array,
otherwise returns `-1`.

#### `indexes_of(object)`

Returns an array with indexes for each occurence of `object`.

#### `first(count = null)`

Returns the first object if count of array is >= 1, otherwise returns `null`. If
`count` is passed, returns an array containing the first `count` objects.

#### `second()`

Returns the second object if count of array is >= 2, otherwise returns `null`.

#### `third()`

Returns the third object if count of array is >= 3, otherwise returns `null`.

#### `last(count = null)`

Returns the last object if count of array is >= 1, otherwise returns `null`. If
`count` is passed, returns an array containing the last `count` objects.

#### `rest()`

Returns an array containg all but the first object.

#### `with(object)`

Returns a new array by adding `object` at the end.

#### `with_many(objects)`

Returns a new array by adding many `objects` at the end.

#### `with_at(object, index)`

Returns a new array by inserting `object` at `index`.

#### `with_many_at(objects, index)`

Returns a new array by inserting many `objects` at `index`.

#### `with_before(object, next)`

Returns a new array by inserting `object` before the first occurence of `next`
or at the beginning if `next` is not in array.

#### `with_many_before(objects, next)`

Returns a new array by inserting `objects` before the first occurence of `next`
or at the beginning if `next` is not in array.

#### `with_after(object, previous)`

Returns a new array by inserting `object` after the last occurence of `previous`
or at the end if `previous` is not in array.

#### `with_many_after(objects, previous)`

Returns a new array by inserting `objects` after the last occurence of `previous`
or at the end if `previous` is not in array.

#### `without(object)`

Returns a new array by removing all occurences of `object`. Returns an exact
copy if `object` is not in array.

#### `without_many(objects)`

Returns a new array by removing all occurences of `objects`. Ignores any object
not contained in array.

#### `without_at(index)`

Returns a new array without the object at `index`. Throws an error if index is
out of bounds.

#### `without_many_at(indexes)`

Returns a new array without the objects at `indexes`. Throws an error if one of
the indexes is out of bounds.

#### `compacted()`

Returns a new array by removing all `null`s and `undefined`s.

#### `flattened()`

Returns a new array containing all objects of all sub-arrays as a flat linear
array.

#### `reversed()`

Returns a new array by reversing the order of contained objects.

#### `sorted()`

Returns a new array by sorting all objects.

#### `unique()`

Returns a new array by removing all duplicates.

#### `intersect(objects)`

Returns a new array containing only unique objects that are contained in both,
`self` *and* `objects`.

#### `unite(objects)`

Returns a new array containing unique objects from both, `self` and `objects`.

#### `zip(arrays...)`

Returns a new array containing arrays with each containing the x-th object of
the y-th array. Fill up with `null` for all arrays that are shorter than the
one with the greatest count.

#### `each(block)`

Alias for native `forEach`.

#### `collect(block)`

Alias for native `map`.

#### `select(block)`

Alias for native `filter`.

#### `reject(block)`

The opposite of `select()`. Returns a new array with objects for which
`block(object)` returns falsy.

#### `detect(block)`

Returns the first object for which `block(object)` is truthy or `null` if no
such object can be found.

#### `pluck(key)`

Shortcut for `.collect (object) -> object.value_for key`. Returns an array
containing value for `key` for each object.

#### `partition(block = null)`

Returns an array containing 2 arrays `[selected, rejected]` where:

* array `selected` contains all objects for which `block(object)` is truthy
* array `rejected` contains all objects for which `block(object)` is falsy

If no `block` is passed, `selected` contains all truthy objects, `rejected` all
falsy.

#### `all(block)`

Returns `yes` if `block(object)` is truthy for *all* objects in array.

#### `any(block)`

Returns `yes` if `block(object)` is truthy for *at least one* object in array.

#### `min(compare = null)`

Returns the object that is less or equals any other object using the `compare`
function. Returns `null` if array is empty. Uses `Object.compare()` if no
`compare` function is passed. See also: `max()`, `Object.compare()`.

#### `max(compare = null)`

Returns the object that is greater or equals any other object using the
`compare` function. Returns `null` if array is empty. Uses `Object.compare()`
if no `compare` function is passed. See also: `min()`, `Object.compare()`.

#### `group_by(key_or_block)`

*TODO: describe.*

#### `inject(initial, block)`

*TODO: describe.*

#### `add(object)`

Adds `object` at the end, returns `self`.

#### `add_many(objects)`

Adds `objects` at the end, returns `self`.

#### `remove(object)`

Removes all occurences of `object`, returns `self`.

#### `remove_many(objects)`

Removes all occurences of each of the `objects`, returns `self`.

#### `remove_at(index)`

Removes object at `index` and returns `self`.

#### `remove_many_at(indexes)`

Removes objects at `indexes` and returns `self`.

#### `remove_all()`

Removes all objects and returns `self`.

#### `insert_at(objet, index)`

Inserts `object` at `index` and returns `self`.

#### `insert_many_at(objets, index)`

Inserts `objects` at `index` and returns `self`.

#### `insert_before(object, next)`

Inserts `object` before `next` or at the beginning if `next` is not contained
in array and returns `self`.

#### `insert_many_before(objects, next)`

Inserts `objects` before `next` or at the beginning if `next` is not contained
in array and returns `self`.

#### `insert_after(object, previous)`

Inserts `object` after `previous` or at the end if `previous` is not contained
in array and returns `self`.

#### `insert_many_after(objects, previous)`

Inserts `objects` after `previous` or at the end if `previous` is not contained
in array and returns `self`.

#### `replace_with(object, replacement)`

Replaces all occurences of `object` with `replacement`.

#### `replace_with_many(object, replacements)`

Replaces all occurences of `object` with many `replacements`.

#### `replace_at_with(index, replacement)`

Replaces object at `index` with `replacement`.

#### `replace_at_with_many(index, replacements)`

Replaces object at `index` with many `replacements`.

#### `sort_by(keys)`

Sorts by `keys`.

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
