import Cocoa

// doubles are decimal numbers
// they are called doubles because they store double the information of old decimal storage systems

// anything number with a . in it get defined as a double which is different than int
let number = 0.1 + 0.2
print(number)

// above shows a good example of why swift does not let integers and doubles mix
// doubles are complex and dont always work exactly how we expect

// doubles have the same operators as ints
var d = 2.0
d += 1.2
d -= 1
d *= 3
d /= 1

var i = 2
// print(i * d) -> this gets an error we need to make them the same data type for it to work
print(i * Int(d))
print(Double(i) * d)

// swift makes you do the above because swift cant guarentee the operation is safe 
