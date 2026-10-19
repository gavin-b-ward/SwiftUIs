import Cocoa

// structs are a way for us to create our own data types made up of smaller data types
// these structs can also have methods attatched to them
// I find them pretty similiar to go structus

// this is a custom data type that takes the name of the player
// and the number of lives defaulting to 3

// we can see that the struct method has a key word mutating
// this identifies that is updating a struct value
// that value must be var and the struct itself must be a var

// the variable defined with the struct must also be a var to use mutating funcs

struct Player {
    let name: String
    var lives = 3
    
    mutating func loseLife() {
        lives -= 1
    }
    
    mutating func gainLife(amount: Int = 1) {
       lives += amount
    }
    
    func checkForGameOver(){
        if lives <= 0 {
            print("Game Over")
        }
    }
    
    func printInfo() {
        print("\(name) has \(lives) lives")
    }
}

var p1 = Player(name: "Wes")
let p2 = Player(name: "Gavin", lives: 0)

p1.printInfo()

p1.loseLife()

p1.printInfo()

p2.printInfo()

// p2.loseLife() -> this gives error because the struct is a constant

