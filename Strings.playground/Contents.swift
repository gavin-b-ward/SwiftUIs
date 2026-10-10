import Cocoa

// strings are a collection of characters that make up some line of text
// greetings below is an examples
var greeting = "Hello, playground"


// if we want to get the word count of a string we can do

print(greeting.count) // 17

var stationID = "n00456"

// strings have methods
// you can lower case, upper case, or make a title
stationID = stationID.uppercased()

// we can also check prefix or suffix
//but be careful it is case sensitive
if stationID.hasPrefix( "n" ) {
        print("Has prefix n")
}

// this one prints because the case is correct
if stationID.hasPrefix( "N" ) {
   print("Has prefix N 😃")
}

// you can also do multi line strings
let multiLine = """
This is a 
multi-line
string
in
SWIFT
"""

print(multiLine)
