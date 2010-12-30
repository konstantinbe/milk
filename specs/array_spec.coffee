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

describe 'Array extended by Milk', ->
  it "should return the first element", ->
    expect([1, 2, 3].first()).toBe(1)
    expect([].first()).toBe(undefined)

  it "should return first N elements", ->
    expect([1, 2, 3].first(0)).toEqual([])
    expect([1, 2, 3].first(1)).toEqual([1])
    expect([1, 2, 3].first(2)).toEqual([1, 2])
    expect([1, 2, 3].first(3)).toEqual([1, 2, 3])
    expect([1, 2, 3].first(10)).toEqual([1, 2, 3])

  it "should return rest elements", ->
    expect([1, 2, 3].rest()).toEqual([2, 3])
    expect([1, 2, 3].rest(0)).toEqual([1, 2, 3])
    expect([1, 2, 3].rest(2)).toEqual([3])
    expect([1, 2, 3].rest(3)).toEqual([])
    expect([1, 2, 3].rest(10)).toEqual([])

  it "should return the last element", ->
    expect([1, 2, 3].last()).toBe(3)
    expect([].last()).toBe(undefined)

  it "should return the last N elements", ->
    expect([1, 2, 3].last(0)).toEqual([])
    expect([1, 2, 3].last(1)).toEqual([3])
    expect([1, 2, 3].last(2)).toEqual([2, 3])
    expect([1, 2, 3].last(3)).toEqual([1, 2, 3])
    expect([1, 2, 3].last(10)).toEqual([1, 2, 3])
