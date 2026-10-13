import Cocoa

// First is the array
// It is a way to store ordered information
// Swift arrays can only hold one type
// There are 4 ways to init an array

var strArr = Array<String>()
var strArr2 = [String]()
var strArr3: [String] = []
var strArr4 = ["Hello"]

// we add data with the append method

strArr.append("Hello")
strArr.append("World")

print(strArr[0])
// count is the len property

strArr.count
strArr.isEmpty

// there are othr methods of course such as .sorted() .contains() .reveresed()


print(strArr.reversed())

// the next type is dictionaries which store key value pairs
// most importantly when you read a value from a dict in
// swift it returns an optional.
// this is good because it wont crash from an invalid index but does mean you need ot handle the optional

var me = [String: String]()

me["name"] = "Gavin"
me["age"] = "21"
me["school"] = "Alabama"
me["from"] = "Georgia"


print("Hello my name is \(me["name"]), I am \(me["age"]) years old, I am from \(me["from"]) and I go to \(me["school"])")

// well that printed ugly, what do i do to get rid of all those optionals
print("Hello my name is \(me["name"]!), I am \(me["age"]!) years old, I am from \(me["from"]!) and I go to \(me["school"]!)")

// this just says we know for sure the value exists, more optional handling will be covered later.

// you can also set a default

print(me["color", default: "Unkown"]) // this defaults when no amtching key is found

// sets -> these are the third data type and they
// are like arrays but dont allow duplicates and are unordered

// why would we want that? well sometimes we want to make sure their are no duplicates
// and since it is unordered swift can optimize the storage allowing for super fast retreival.

var actors = Set(["Tom Cruise", "Tom Cruise", "Robert Patinson", "The Rock"])

print(actors) // sometimes prints in a different order and does not repeat tom cruise

print(actors.contains("Tom Cruise"))
print(actors.count)

// The last data type is enums
// enums allow use to have basically our own boolean lists
// you can only choose from the allowed values which is good when you have a fixed set of values available
// like if you wanted to keep track of the day of the week

// you could do

var day: String = "Monday"
day = "Tuesday " // oh weve already made a type the code is on fire its all over

enum Day {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

// or
/*
 enum Day {
    case monday,
    case tuesday,
 ...
*/

// now we can only choose from the Day enum values no room for error.
var weekday = Day.monday
weekday = .tuesday
print(weekday)




