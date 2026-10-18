import Cocoa

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

for line in luckyNumbers.filter { $0 % 2 != 0 ? true: false }.sorted { $0 < $1 }.map { "\($0) is a lucky number"}{
    print(line)
}


