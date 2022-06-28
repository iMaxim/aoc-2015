import Foundation

let template = """
import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath)
"""

let directoryPath = FileManager.default.currentDirectoryPath
let mainFile = directoryPath + "/main.swift"
let inputFile = directoryPath + "/input.txt"

let data = template.data(using: .utf8)
FileManager.default.createFile(atPath: mainFile, contents: data)
FileManager.default.createFile(atPath: inputFile, contents: nil)