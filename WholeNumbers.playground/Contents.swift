import Cocoa

// We can define an integer similar to a string just using numbers
let num = 1

// we can perform integer math operations to make new integers

var num2 = num + 1
var num3 = num2 * 2
var num4 = num3 - 1

// sometimes we need to define a large number
let largeNum = 10000000
// but isnt that hard to tell the value of?

// this defines the same number but we break it apart using _
// swift ignores the _
let largeNumReadable = 10_000_000

// ints have a set of methods too
// here i show isMultiple(of:)
print(largeNumReadable.isMultiple(of: 2))

// how far apart are these two numbers?
print(largeNumReadable.distance(to: 100_000_000))
