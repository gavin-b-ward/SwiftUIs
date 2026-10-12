import Cocoa

// String interpolation is the act of combining multiple strings
// we can do this through the + operator through something called operator overloading
// this is what lets it do different things for different types of data
// string1 + string2 will concat string2 to the end of string1

var string1 = "Hello, "
var string2 = "World!"
var string3 = string1 + string2
print(string3)

// this works but only for 2 strings
// int + string does not work
// and for many chained together + it becomes slow
// since swift creates a new string for each +

// to solve this there is string interpolation

var string4 = "Hello, \(string2)"
print(string4)

// this also lets us add other data types

var name = "Gavin"
var age = 21
var greeting = "Hello, \(name), you are \(age) years old"
print(greeting)

