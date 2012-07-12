# Milk

Milk is a CoffeeScript library inspired by Cocoa, Rails, Prototype and others.

Milk is *opinionated*. *Beauty* and *Clarity* has top priority, therefore
alledged "conventions" and "best-practices" may be violated.

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
  `http://konstantinbender.com/introducing-the-milk-framework`
* Use dashed notation for XML, HTML and CSS: `person-name`, `table-of-people`,
  `regular-xml-parser`
* No arbitrary abbreviations, such as `src`, `mod`, `obj`, ...
* Source must be "white-space-clean", the *White* command line utility
  will cleanup whitespace for you: [White](https://github.com/konstantinbender/white)

## Inspiration

* [Cocoa](http://developer.apple.com/cocoa/)
* [Prototype](http://www.prototypejs.org/)
* [Ruby on Rails](http://rubyonrails.org/)
* [Underscore](http://documentcloud.github.com/underscore/)
* [Backbone](http://documentcloud.github.com/backbone/)
* [Doodle](http://www.rubyinside.com/doodle-a-new-way-to-build-and-define-ruby-classes-795.html)

## Acknowledgements

Special thanks to [Jeremy Ashkenas](https://github.com/jashkenas) for bringing
[CoffeeScript](http://coffeescript.org) into life.

## License

Released under the MIT license.

Copyright (c) 2010 [Konstantin Bender](https://github.com/konstantinbender).

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
