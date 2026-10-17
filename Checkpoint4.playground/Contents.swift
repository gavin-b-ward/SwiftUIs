import Cocoa

enum MathError: Error {
    case OutOfRangeErr, ErrNotFound
}

func intSqrRoot(_ x: Int) throws -> Int {
    if x < 1 || x > 10000 {
        throw MathError.OutOfRangeErr
    }
    
    for i in 1...100 {
        if i * i == x {
            return i
        }
    }
    
    throw MathError.ErrNotFound
}

var val = 100
do {
    var sqr = try intSqrRoot(val)
    print(sqr)
    
    val = 10000
    sqr = try intSqrRoot(val)
    print(sqr)

    val = 16
    sqr = try intSqrRoot(val)
    print(sqr)
} catch MathError.ErrNotFound {
   print("Int sqr root of \(val) not found")
}
