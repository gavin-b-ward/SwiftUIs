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


// structs also have a few interesting properties
// first we can create computed values which are values that get dynamically
// updated each time they are used... it is essentially a function that is tied to a value

struct Enemy {
    var name: String
    var health: Int
    
    var isDead: Bool {
        health <= 0
    }
}

var e = Enemy(name: "Slime", health: 10)

print(e.isDead)

e.health = 0

print(e.isDead)

// we can see the isDead property above, this will get dynamically computed with each call
// of the Enemy.isDead property

// there are also property observers willSet and didSet that run a block of code whenever a struct value
// is changing. Will set runs the block before the value changes, and did set runs the block after.

struct Player2 {
    var name: String
    var lives: Int {
        willSet {
            print("About to set lives to \(newValue)")
        }
        didSet {
            print("Lives changed from \(oldValue) to \(lives)")
        }
    }
}

var p3 = Player2(name: "Wes", lives: 3)
p3.lives = 2

// finally we can create structs with custom initializers

struct Skeleton{
    var dmg = 5
    var hp = 5
    var speed = 3
    var level = 1
    
    init(level: Int = 1) {
        self.dmg = level * self.dmg
        self.hp = level * self.hp
        self.speed = level * self.speed
        self.level = level
    }
}

var s = Skeleton()
print(s)


var skeletonElite = Skeleton(level: 10)
print(skeletonElite)

// we can see above the default values are applied to all of the values so we do not have to pass them into the struct
// only the level is in our initializer so that is the only value we can pass and all others are updated based on that.

