#
# Copyright (c) 2010 Konstantin Bender.
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


# global constants
ROOT = exports ? this
ROOT.READ = 1
ROOT.WRITE = 2


# defines a property on an object/class
Object::has = (name, options = {}) ->
  options['access'] ?= READ | WRITE
  options['default'] ?= null
  options['variable'] ?= '_' + name
  options['get'] ?= 'get_' + name
  options['set'] ?= 'set_' + name

  readable = options['access'] & READ
  writeable = options['access'] & WRITE

  getter = this[options['get']] or -> this[options['variable']] + ' (accessed through getter)'
  setter = this[options['set']] or (value) ->  this[options['variable']] = value + ' (set through setter)'

  config = {}
  config['writeable'] = writeable
  config['get'] = getter if readable
  config['set'] = setter if writeable
  config['configurable'] = no
  config['enumerable'] = yes

  using_default_getter_or_setter = this[options['get']]? or this[options['set']]?
  @prototype[options['variable']] = options['default'] if using_default_getter_or_setter
  Object.defineProperty @prototype, name, config


# TODO: Implement these.
Object::has_one = (name, options) -> null
Object::has_many = (name, options) -> null
Object::belongs_to = (name, options) -> null
Object::has_and_belongs_to_many = (name, options) -> null


# define the class
# class Book
#   @has 'uniqueID', access: READ, default: '010101010101'
#   @has 'changed', access: WRITE
#   @has 'title', default: 'New Book' # read and write by default
#   @has 'author', default: 'Unknown'
#   @has 'isbn'


# run some tests
# book = new Book()
# console.log 'Default book title: ' + book.title
#
# book.title = 'CoffeeScript Cookbook'
# console.log 'Title of book is: ' + book.title
#
# book.uniqueID = "Test"
# console.log book.uniqueID
