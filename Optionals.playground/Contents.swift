import Cocoa

func getMeaningOfLife() -> Int? {
    42
}

func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

// How do we use guard instead?

func printMeaningOfLifeGuard(){
    let name = getMeaningOfLife()
    guard let name else {
        return
    }
    
    print(name)
}

printMeaningOfLife()
printMeaningOfLifeGuard()

// if let unwraps and makes it available in the {}
// guard let unwraps and if fails runs the else block
// after the else block if it does not exit then name is scoped
// and unwrapped

// we use guard let for early returns kind of like go nil / err checks

let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "Captain Died"
print(new)

// above shows one more method
// this is a way of providing a value to set the variable to if it is nil
// you can think of this like providing a default and it works for all optionals
// this is best used when you want a real value no matter what and dont need to do
// some error handling in the case of nil

struct Book {
    let title: String
    let author: String?
}

var a = ["A", "B"]

var book: Book? = nil
var author = book?.author?.capitalized ?? "Unknown"
print(author)
book = Book(title: "The Stanger", author: "albert camus")
author = book?.author?.capitalized ?? "Unknown"
print(author)


func returnRandomNum(nums: [Int]?) -> Int {
    nums?.randomElement() ?? Int.random(in: 1...100)
}

print(returnRandomNum(nums: nil))
print(returnRandomNum(nums: nil))
print(returnRandomNum(nums: [101, 200, 333, 1000]))
print(returnRandomNum(nums: [101, 200, 333, 1000]))
print(returnRandomNum(nums: [101, 200, 333, 1000]))

