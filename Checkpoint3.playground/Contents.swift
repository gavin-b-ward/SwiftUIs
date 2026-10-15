import Cocoa


func Fizzbuzz(in range: ClosedRange<Int>) -> (res: [String], count: Int){
    var val: String = ""
    var res: [String] = []
    for i in range{
        if i.isMultiple(of: 3) && i.isMultiple(of: 5){
            val = "FizzBuzz"
        } else if i.isMultiple(of: 3) {
            val = "Fizz"
        } else if i.isMultiple(of: 5) {
            val = "Buzz"
        } else {
            val = String(i)
        }
        res.append(val)
    }
        
    return (res, res.count)
    
    
}

func Pythagoras(a: Double, b: Double) -> Double {
    sqrt(a*a + b*b)
}

var (res, count) = Fizzbuzz(in: 1...10)
print(res)
print(count)


print(Pythagoras(a: 3, b: 4))
