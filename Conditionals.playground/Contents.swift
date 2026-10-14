import Cocoa

// swift uses regular if; else if; else statements

var A: [Int] = []

if A.isEmpty {
    print("A is empty")
} else if A.count == 1 {
    print("A has 1 item")
} else {
    print("A has many elements")
}

A.append(1)

if A.isEmpty {
    print("A is empty")
} else if A.count == 1 {
    print("A has 1 item")
} else {
    print("A has many elements")
}

A.append(10)

if A.isEmpty {
    print("A is empty")
} else if A.count == 1 {
    print("A has 1 item")
} else {
    print("A has many elements")
}


enum Season {
    case summer, autumn, winter, spring
}

var currSeason = Season.autumn

if currSeason == .autumn || currSeason == .spring {
    print("The weather is nice")
} else if currSeason == .summer {
   print("It's too damn hot")
} else {
    print("It's too cold")
}

// we could also use an switch

switch currSeason {
case .autumn:
    print("It's nice out")
case .winter:
    print("Bundle up, it's getting chilly!")
case .spring:
    print("The flowers are in bloom")
case .summer:
    print("I'm sweating, its HOT")
}

// ternary condition

var message: String = currSeason == .autumn ? "It's autumn" : "Not autumn"


var Time: Int = 12

var greeting = Time > 12 ? "Good Afternoon": "Good Morning"
