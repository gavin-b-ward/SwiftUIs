import Cocoa

// protocols are the interfaces of swift
// they allow you to define what properties and methods must be implemented to conform with it
// then you can implement structs, classes, or enums that conform to it
// this allows you to use the protocol as a param for functions and pass in any implementation of the protocol
// this is useful when you have different types of data that all need to do the same actions just in different ways

protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)

let car = Car()
commute(distance: 100, using: car)


// another covered topic are opaque return types, this seems like
// you are at the application level returning a protocol while
// at the compiler the actual type is known
// this seems not particularly useful at first glance but is important to know
// for swiftUI. This is what the some keyword means and is essentially saying
// this returns a view, you know what view it is, and we dont want to type everything out so you deal with it


// extensions
// this allows use to add functionality to a type including those given by apple

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// for example to trim whitespace and new lines we would have to type
// "".trimmingCharacters(in: .whitespacesAndNewLines) every time
// but what if we were constantly using this? Thats alot to type every time...

// this is where the extension above becomes useful -> we are defining a new method called trimmed on the String type that will trim white space and new lines

// self refers to the current string in the case above
// as a note only computed properties can and should be added
// this is because imagine if you added a buch of stored properties to an int
// not all ints could be much bigger in size! This would take up more space and slow the app down

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

// above is another use of extensions because it allows use to define a custom init function without removing the default memberwise one
        
        
var lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)
print(lotr)

lotr = Book(title: lotr.title, pageCount: 2000)
print(lotr)

let guests = ["Mario", "Luigi", "Peach"]

extension Array {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

// by putting the extension on the protocol Collection
// we make this apply not only to arrays but to sets and dictionaries as well

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}



var a = [String]()

print(a.count)

// protocol extensions are useful because we can either extend functionality to all
// implementation of the protocol or in our own apps add a default behavior to all protocol
// implementations that can be overriddent by the implementations when needed.

protocol Building {
    var room: Int { get }
    var cost: Int { get set }
    var agent: String { get set }
    
    func summary()
}

struct House: Building {
    var room: Int
    var cost: Int
    var agent: String
    
    func summary(){
        print("This a beautiful house costing \(cost) with \(room)(s) rooms sold by \(agent)")
    }
    
}

struct Office: Building {
    var room: Int
    var cost: Int
    var agent: String
    
    func summary(){
        print("This a large office building costing \(cost) with \(room)(s) rooms sold by \(agent)")
    }
}

func printListings(buildings: [Building]){
    for b in buildings{
        b.summary()
    }
}

var h1 = House(room: 6, cost: 400_000, agent: "Mackenzie")
var h2 = House(room: 20, cost: 2_400_000, agent: "Mackenzie")
var o1 = Office(room: 200, cost: 30_000_000, agent: "Taylor")

printListings(buildings: [h1, h2, o1])


