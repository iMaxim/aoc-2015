import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath)
var floor = 0
var index = 0
var firstStepIntoBasement = 0

for char in input {
    index += 1
    switch char {
    case "(": floor += 1
    case ")": floor -= 1
    default: fatalError("Invalid character")
    }
    if floor == -1 && firstStepIntoBasement == 0 {
        firstStepIntoBasement = index
        print("Santa enters basement at \(index) step")
    }
}

print(floor)
