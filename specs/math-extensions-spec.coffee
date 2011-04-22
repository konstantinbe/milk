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

requires 'Specs.Helper'

describe "Milk.MathExtensions", ->
  describe ".generate_unique_id()", ->
    it "generates an RFC4122 version 4 ID", ->
      expect(Math.generate_unique_id()).to_match /^.+$/

    it "contains 36 characters", ->
      expect(Math.generate_unique_id().length).to_be 36

    it "is divided by dashes at indexes 8, 13, 18, and 23", ->
      expect(Math.generate_unique_id()).to_match "^........-....-....-....-............$"

    it "has a 4 at index 14", ->
      expect(Math.generate_unique_id()).to_match "^........-....-4...-....-............$"

    it "has only HEX numbers besides the dashes", ->
      unique_id = Math.generate_unique_id().replace /-/g, ""
      expect(unique_id).to_match /^(\d|A|B|C|D|E|F)+$/
