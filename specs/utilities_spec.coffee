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

describe 'Utilities', ->
  it "should check if a value is undefined", ->
    expect(Utilities.is_undefined undefined).toBe(true)

  it "should check if a value is null", ->
    expect(Utilities.is_null null).toBe(true)

  it "should check if a value is an object", ->
    expect(Utilities.is_object {}).toBe(true)

  it "should check if a value is a function", ->
    expect(Utilities.is_function () -> this).toBe(true)

  it "should check if a value is a string", ->
    expect(Utilities.is_string "").toBe(true)

  it "should check if a value is boolean", ->
    expect(Utilities.is_boolean yes).toBe(true)

  it "should check if a value is a number", ->
    expect(Utilities.is_number 1).toBe(true)

  it "should check if a value is an array", ->
    expect(Utilities.is_array []).toBe(true)

  it "should check if a value is a date", ->
    expect(Utilities.is_date new Date()).toBe(true)

  it "should check if a value is a regular expression", ->
    expect(Utilities.is_regexp //).toBe(true)

  it "should mixin objects into an object", ->
    expect(Utilities.mixin({}, {title: "test" })).toEqual({ title: "test" })
