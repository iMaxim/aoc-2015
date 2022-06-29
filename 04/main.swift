import Foundation
import CryptoKit

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath)


// Will be good to parallel this tasks
func partOne() -> Int {
    var key: Int = 0
    var hash = Insecure.MD5.hash(data: "\(input)\(key)".data(using: .utf8)!)

    var isStartedWith5LeadingZeros: Bool {
        hash.map({ String(format: "%02hhx", $0) }).joined().prefix(5) == "00000"
    }

    while !isStartedWith5LeadingZeros {
        key += 1
        hash = Insecure.MD5.hash(data: "\(input)\(key)".data(using: .utf8)!)
        print("1: ", key, hash.description)
    }

    return key
}

func partTwo() -> Int {
    var key: Int = 0
    var hash = Insecure.MD5.hash(data: "\(input)\(key)".data(using: .utf8)!)

    var isStartedWith6LeadingZeros: Bool {
        hash.map({ String(format: "%02hhx", $0) }).joined().prefix(6) == "000000"
    }

    while !isStartedWith6LeadingZeros {
        key += 1
        hash = Insecure.MD5.hash(data: "\(input)\(key)".data(using: .utf8)!)
        print("2: ", key, hash.description)
    }

    return key
}

let answer1 = partOne()
let answer2 = partTwo()

print("\n")
print("The first answer is: \(answer1)")
print("The second answer is: \(answer2)")