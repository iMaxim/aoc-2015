import Foundation

let samplePath = FileManager.default.currentDirectoryPath + "/sample.txt"
let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let sample: String = try! String(contentsOfFile: samplePath)
let input = try! String.init(contentsOfFile: inputPath)
var floor = 0
var index = 0

for char in input {
    index += 1
    switch char {
    case "(": floor += 1
    case ")": floor -= 1
    default: break
    }
    if floor == -1 { print("Santa enters basement at \(index) step") }
}

print(floor)