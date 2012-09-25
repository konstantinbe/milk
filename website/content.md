# Milk

*A little opinionated utility-belt library for CoffeeScript*

--------------------------------------------------------------------------------

Milk is a little utility-belt library for CoffeeScript mainly inspired by
[underscore.js](http://underscorejs.org) while borrowing ideas from *Cocoa*,
*Rails*, *jQuery*, *Prototype*, and
others.

Milk is *opinionated*, alledged "conventions" and "best-practices" may be
violated. In particular, Milk uses underscore notation like *Ruby* and makes
heavy use of monkey patching to extend the core JavaScript types.

--------------------------------------------------------------------------------

## Overview

*TODO: give an overview here.*

## Tutorial

*TODO: write a little tutorial here.*

### Working with Objects

Comparing:

- [`equals()`](#)
- [`is_comparable()`](#)
- [`compare_to()`](#)
- [`is_less_than()`](#)
- [`is_less_than_or_equals()`](#)
- [`is_greater_than()`](#)
- [`is_greater_than_or_equals()`](#)
- [`is_between()`](#)

Copying:

- [`is_copyable()`](#)
- [`copy()`](#)

Mixing & Merging:

- [`mixin()`](#)
- [`merge()`](#)
- [`with()`](#)
- [`with_defaults()`](#)

Freezing & Sealing:

- [`is_frozen()`](#)
- [`freeze()`](#)
- [`is_sealed()`](#)
- [`seal()`](#)

Key-Value-Coding:

- [`value_for()`](#)
- [`set_value_for()`](#)
- [`getter_name_for()`](#)
- [`setter_name_for()`](#)
- [`instance_variable_name_for()`](#)

Checking types:

- [`is_class()`](#)
- [`is_function()`](#)
- [`is_boolean()`](#)
- [`is_number()`](#)
- [`is_date()`](#)
- [`is_string()`](#)
- [`is_reg_exp()`](#)
- [`is_array()`](#)
- [`is_dictionary()`](#)
- [`is_kind_of()`](#)
- [`is_instance_of()`](#)

Messaging:

- [`responds_to()`](#)
- [`invoke()`](#)

Other:

- [`new()`](#)
- [`class()`](#)
- [`class_name()`](#)
- [`keys()`](#)
- [`values()`](#)
- [`has_own()`](#)
- [`own()`](#)
- [`to_string()`](#)

### Working with Strings

- [`count()`](#)
- [`first()`](#)
- [`second()`](#)
- [`third()`](#)
- [`rest()`](#)
- [`last()`](#)
- [`code_at()`](#)
- [`characters()`](#)
- [`codes()`](#)
- [`lines()`](#)
- [`paragraphs()`](#)
- [`prepend()`](#)
- [`append()`](#)
- [`index_of()`](#)
- [`last_index_of()`](#)
- [`indexes_of()`](#)
- [`begins_with()`](#)
- [`ends_with()`](#)
- [`increment_suffix_number()`](#)
- [`uppercased()`](#)
- [`lowercased()`](#)
- [`capitalized()`](#)
- [`escaped_for_reg_exp()`](#)
- [`parse_integer()`](#)
- [`utf8()`](#)
- [`utf16()`](#)
- [`sha1()`](#)

### Working with Arrays

- [`count()`](#)
- [`is_empty()`](#)
- [`contains()`](#)
- [`contains_all()`](#)
- [`contains_any()`](#)
- [`at()`](#)
- [`at_many()`](#)              
- [`index_of()`](#)
- [`last_index_of()`](#)
- [`indexes_of()`](#)

Accessing Parts:

- [`first()`](#)
- [`second()`](#)
- [`third()`](#)
- [`last()`](#)
- [`rest()`](#)

Deriving Arrays:

- [`with()`](#)
- [`with_many()`](#)
- [`with_at()`](#)
- [`with_many_at()`](#)
- [`with_before()`](#)
- [`with_many_before()`](#)
- [`with_after()`](#)
- [`with_many_after()`](#)
- [`without()`](#)
- [`without_many()`](#)
- [`without_at()`](#)
- [`without_many_at()`](#)
- [`compacted()`](#)
- [`flattened()`](#)
- [`reversed()`](#)
- [`sorted()`](#)
- [`unique()`](#)
- [`intersect()`](#)
- [`unite()`](#)
- [`zip()`](#)

Iterating Arrays:

- [`each()`](#)
- [`collect()`](#)
- [`select()`](#)
- [`reject()`](#)
- [`detect()`](#)
- [`pluck()`](#)
- [`partition()`](#)
- [`all()`](#)
- [`any()`](#)
- [`max()`](#)
- [`min()`](#)
- [`group_by()`](#)
- [`inject()`](#)

Mutating Arrays:

- [`add()`](#)
- [`add_many()`](#)
- [`remove()`](#)
- [`remove_many()`](#)
- [`remove_at()`](#)
- [`remove_many_at()`](#)
- [`remove_all()`](#)
- [`insert_at()`](#)
- [`insert_many_at()`](#)
- [`insert_before()`](#)
- [`insert_many_before()`](#)
- [`insert_after()`](#)
- [`insert_many_after()`](#)
- [`replace_with()`](#)
- [`replace_with_many()`](#)
- [`replace_at_with()`](#)
- [`replace_at_with_many()`](#)
- [`sort_by()`](#)

### Defining Attributes

    TODO: document.

### Organizing Code

    TODO: document.

### Miscellaneous

Math extensions:

- [`Math.generate_unique_id()`](#)
- [`Math.identity()`](#)

--------------------------------------------------------------------------------

## Reference

*TODO: put detailed descriptions for each method here.*

--------------------------------------------------------------------------------

## Changelog

### 0.1.0

* Initial release
