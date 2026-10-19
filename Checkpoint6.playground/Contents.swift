import Cocoa

struct Car {
    let model: String
    let numSeats: Int
    private var currGear: Int = 1
    
    init(model: String, numSeats: Int){
        self.model = model
        self.numSeats = numSeats
    }
    
    mutating func increaseGear(){
        if currGear < 6{
            currGear += 1
        } else {
            print("Max Gear, Cannot go up more!")
        }
    }
    
    mutating func decreaseGear(){
        if currGear > 1 {
           currGear -= 1
        } else {
            print("Min Gear, Cannot go down more!")
        }
    }
}
