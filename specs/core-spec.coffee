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

describe "Milk.Core", ->
  describe "namespace(path, block)", ->
    it "creates a namespace object in the global name space if it doesn't exist", ->
      namespace 'NewNameSpace'
      expect(NewNameSpace).to_be_defined()

    it "returns the namespace object", ->
      space = namespace 'NewNameSpaceToBeReturned'
      expect(space).to_be NewNameSpaceToBeReturned

    it "does not create a namespace object if it already exists", ->
      existing_name_space = namespace 'ExistingNameSpace'
      space = namespace 'ExistingNameSpace', -> @VERSION = "0.1"
      expect(space).to_be_defined()
      expect(space).to_be existing_name_space

    it "adds objects defined in block to the namespace object", ->
      space = namespace 'NameSpaceContainingVersion', -> @VERSION = "0.1"
      expect(NameSpaceContainingVersion.VERSION).to_be "0.1"

    it "creates all namespace objects along the path", ->
      namespace 'One.Two.Three'
      expect(One.Two.Three).to_be_defined()

    it "returns the last name space in path", ->
      space = namespace 'Four.Five.Seven'
      expect(Four.Five.Seven).to_be space

    it "adds objects defined in block to the last namespace object", ->
      space = namespace 'Eight.Nine.Ten', -> @VERSION = "0.1"
      expect(Eight.Nine.Ten.VERSION).to_be "0.1"

    it "throws if no path is given", ->
      expect(-> namespace()).to_throw()

    it "throws if path is not a string", ->
      expect(-> namespace 5).to_throw()

    it "throws if block is given but not a function", ->
      expect(-> namespace 'Hello.World', '').to_throw()

    ['', '1', '.', 'Milk.', 'Milk.2', 'Milk;Core', 'Milk,Core', 'Milk-Core'].each (invalid_path) ->
      it "throws if path is invalid, example: '#{invalid_path}'", ->
        expect(-> namespace invalid_path, -> 1).to_throw()
