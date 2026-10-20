import Cocoa

class Animal {
    let legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}
class Dog: Animal {
    func speak(){
        print("bark bark bark")
    }
}
class Cat: Animal {
    var isTame: Bool
    init(isTame: Bool, legs: Int){
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak(){
        print("meow meow meow")
    }
}

class Corgi: Dog {
    override func speak() {
       print("Bark Bark, but corgi")
    }
}
class Poodle: Dog {
    override func speak() {
        print("How are you doing today my good sir... I mean bark..")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meowth dats right!")
    }
}
class Lion: Cat {
    override func speak() {
        print("The king of the jungle needs help with his romance")
    }
}

var a = Animal(legs: 4)
// a.speak() -> does not exist yet

var d = Dog(legs: 4)
d.speak()

var c = Cat(isTame: true, legs: 3)
c.speak()

var corg = Corgi(legs: 4)
corg.speak()

var persian = Persian(isTame: false, legs: 2)
persian.speak()

var lion = Lion(isTame: true, legs: 4)
lion.speak()
