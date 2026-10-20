import Cocoa

class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I am a developer who works \(hours) a day")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()

// How do we initialize a subclass that inherits from another class?

// we use the super.init() to call the parents init function and pass in the needed values


class Monster {
    var hp: Int
    var def: Int
    var spd: Int
    var att: Int
    var spAtt: Int
    var name: String
    
    init(hp: Int, def: Int, spd: Int, att: Int, spAtt: Int, name: String) {
        self.hp = hp
        self.def = def
        self.spd = spd
        self.att = att
        self.spAtt = spAtt
        self.name = name
    }
}

class ArcherSkeleton: Monster {
    var rangeTiles: Int
    
    init(rangeTiles: Int, hp: Int, def: Int, spd: Int, att: Int, spAtt: Int) {
        self.rangeTiles = rangeTiles
        super.init(hp: hp, def: def, spd: spd, att: att, spAtt: spAtt, name: "Skeleton Archer")
    }
    
    deinit {
        print("Skeleton Instance Destroyed!")
    }
}

var skeleton1 = ArcherSkeleton(rangeTiles: 3, hp: 10, def: 10, spd: 10, att: 10, spAtt: 10)
var skeleton2 = skeleton1

// one main feature of classes which distriguish them from structs is the fact
// that they copy data when we assign another variable to their value
// this is valuable because it allows us to share data between instances
// but as you can see below if we are not careful it can have unintended effects.

skeleton2.name = "Jeff"
print(skeleton1.name)
print(skeleton2.name)

// another difference between classes and structs is the existance of a deinitializer (destructor)
// this is something that runs when the last instance of class copy is destroyed
// this normally happens when it is no longer within the scope it was defined

for _ in 1...3 {
    var s = ArcherSkeleton(rangeTiles: 3, hp: 10, def: 10, spd: 10, att: 10, spAtt: 10)
}

// since the instance is created and repeatedly falling out of scope we see the deinitializer running 3 times.
