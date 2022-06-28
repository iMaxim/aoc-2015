import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath)

var wrappingPaperArea = 0
var ribbonLength = 0
let separatedExpressions = input.components(separatedBy: .newlines)
let partedExpressions = separatedExpressions.map { $0.components(separatedBy: "x") }
let data = partedExpressions.map { $0.compactMap { Int($0) } }

for expression in data {
    let sorted = expression.sorted()
    let smallestPerimeter = 2 * sorted[0] + 2 * sorted[1]
    let cubic = sorted[0] * sorted[1] * sorted[2]
    let firstSideArea = sorted[0] * sorted[1]
    let secondSideArea = sorted[1] * sorted[2]
    let thirdSideArea = sorted[0] * sorted[2]

    ribbonLength += smallestPerimeter + cubic
    wrappingPaperArea += 2 * (firstSideArea + secondSideArea + thirdSideArea) + firstSideArea
}

print("Ribbon length \(ribbonLength)")
print("Wrapping paper \(wrappingPaperArea)")