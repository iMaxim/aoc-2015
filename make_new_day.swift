import Foundation

let manager = FileManager.default
let template = """
import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath)

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
let latestDay = contentsOfDirectory.max() ?? 0
let newDayPath = latestDay < 10 ? "0\(latestDay + 1)/" : "\(latestDay + 1)/"

try! manager.createDirectory(atPath: newDayPath, withIntermediateDirectories: false)

let mainFile = newDayPath + "main.swift"
let inputFile = newDayPath + "input.txt"

let data = template.data(using: .utf8)
manager.createFile(atPath: mainFile, contents: data)
manager.createFile(atPath: inputFile, contents: nil)