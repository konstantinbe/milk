Milk
----

Milk is a CoffeeScript library inspired by Rails, Cocoa, Prototype and others.

Milk is *opinionated*. *Beaty* and *Clarity* has #1 priority, therefore common
"conventions" and "best-practices" may be violated.


Conventions
-----------

* 2 spaces, no tabs
* Use CamelCase notation for namespaces, classes, and mixins:
  `Core.Extensions`, `RegularXmlParser`, `PartiallyFreezeable`
* Use UPPERCASE notation for constants:
  `Comparable.GREATER_THAN`
* Use dashed notation for directories, files, and URLs: `milk/core-extensions`, `date-extensions.coffee`, `http://konstantinbender.com/blog/introducing-the-milk-framework`
* Use dashed notation for XML, HTML and CSS: `person-name`, `table-of-people`, `regular-xml-parser`
* Use underscore notation for everything else (variables, functions, properties,
  methods, JSON, ...):
  `number_of_items`, `compute_number_of_items()`
* No arbitrary abbreviations, such as `src`, `mod`, `obj`, ...


Getting Started
---------------

* TODO: document.


Roadmap
-------

* Milk 0.1 **Utility Belt** -- *Covers most of the functionalty provided by underscore.js.*
* ...


Considered Features
-------------------

* Underscore.js style extensions to native objects (Milk 0.1 Utility Belt)
* Useful stuff from Rails' Active Support

* Key-value coding
* Key-value observing
* Cocoa style bindings
* Cocoa style key/value validations
* Cocoa style collection operators: http://bit.ly/f8I9Tl

* Rails style Active Model
* Rails style validations

* Cocoa style notifications
* Cocoa style events

* Automatic caching of computed properties

* Browser-only additions
* Server-only additions


Inspiration
-----------

* [Cocoa](http://developer.apple.com/cocoa/)
* [Prototype](http://www.prototypejs.org/)
* [Ruby on Rails](http://rubyonrails.org/)
* [Underscore](http://documentcloud.github.com/underscore/)
* [Backbone](http://documentcloud.github.com/backbone/)
* [Doodle](http://www.rubyinside.com/doodle-a-new-way-to-build-and-define-ruby-classes-795.html)
* [SproutCore](http://documentcloud.github.com/sproutcore/sproutcore/)


Acknowledgements
----------------

Special thanks to [Jeremy Ashkenas](https://github.com/jashkenas) for bringing
[CoffeeScript](http://jashkenas.github.com/coffee-script/) into life.


Changelog
---------

### 0.1.00 - Underway

* [In Progress] Implemented extensions for native JavaScript classes/objects
  covering most of the underscore.js functionality.
* Added inflection support for strings.


### 0.0.01

* First release.


License
-------

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
