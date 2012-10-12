# Milk

*Opinionated utility-belt library for CoffeeScript*

Milk is a little utility-belt library for CoffeeScript mainly inspired by
underscore.js while borrowing ideas from Cocoa, Rails, jQuery, Prototype, and
others.

Milk is *opinionated*, alledged "conventions" and "best-practices" may be
violated. In particular, Milk uses underscore notation like *Ruby* and makes
heavy use of monkey patching to extend the core JavaScript types.

## Getting Started

If you just want to use the library, please consult the official website:
[milkandsugar.org](http://milkandsugar.org).

For developers:

* Fork Milk
* Install [Git](http://git-scm.com)
* Install [CoffeeScript](http://coffeescript.org)
* Install `shell.js`
* Checkout `develop` branch
* Build & run tests: `cake test`

## Conventions

* 2 spaces, no tabs
* Use CamelCase notation for classes and other types:
  `Extensions`, `RegularXmlParser`, `PartiallyFreezeable`
* Use UPPERCASE notation for constants:
  `Comparable.GREATER_THAN`
* Use underscores for everything else in code (methods, variables, ...):
  `index_of`, `instance_variable_name`
* Use dashed notation for directories and files:
  `milk-core.coffee`, `helper-files`
* Use dashed notation for URLs:
  `http://konstantinbender.com/introducing-milk`
* Use dashed notation for XML, HTML and CSS: `person-name`, `table-of-people`,
  `regular-xml-parser`
* No arbitrary abbreviations, such as `src`, `mod`, `obj`, ...
* Source must be "white-space-clean", the *White* command line utility
  will cleanup whitespace for you: [White](http://github.com/konstantinbe/white)

## Inspiration

* [Underscore](http://documentcloud.github.com/underscore)
* [Cocoa](http://developer.apple.com/cocoa)
* [Ruby on Rails](http://rubyonrails.org)
* [Prototype](http://www.prototypejs.org)

## Acknowledgements

Special thanks to [Jeremy Ashkenas](http://github.com/jashkenas) for bringing
[CoffeeScript](http://coffeescript.org) into life.

## License

Released under the MIT license.

Copyright (c) 2012 [Konstantin Bender](http://github.com/konstantinbe).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
