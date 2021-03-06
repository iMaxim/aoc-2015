import Foundation

let manager = FileManager.default
let template = """
import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let samplePath = FileManager.default.currentDirectoryPath + "/sample.txt"
let input = try! String.init(contentsOfFile: inputPath)
let sample = try! String.init(contentsOfFile: samplePath)

func partOne() {

}

func partTwo() {

}

partOne()
partTwo()



// Helpers
"""

let directoryPath = manager.currentDirectoryPath
let contentsOfDirectory = try! manager.contentsOfDirectory(atPath: directoryPath).compactMap { Int($0) }
let newDay = (contentsOfDirectory.max() ?? 0) + 1
let newDayPath = newDay < 10 ? "0\(newDay)/" : "\(newDay)/"

try! manager.createDirectory(atPath: newDayPath, withIntermediateDirectories: false)

let mainFile = newDayPath + "main.swift"
let inputFile = newDayPath + "input.txt"
let sampleFile = newDayPath + "sample.txt"

let data = template.data(using: .utf8)
manager.createFile(atPath: mainFile, contents: data)
manager.createFile(atPath: inputFile, contents: nil)
manager.createFile(atPath: sampleFile, contents: nil)