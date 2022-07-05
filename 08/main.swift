import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let samplePath = FileManager.default.currentDirectoryPath + "/sample.txt"
let input = try! String.init(contentsOfFile: inputPath).components(separatedBy: .newlines)
let sample = try! String.init(contentsOfFile: samplePath).components(separatedBy: .newlines)

func partOne() {
    var numberOfStringLiterals = 0
    var numberOfCharactersInMemory = 0
    for line in input {
        numberOfStringLiterals += line.count
        numberOfCharactersInMemory += parseString(line)
    }

    print(numberOfStringLiterals - numberOfCharactersInMemory)
}

func partTwo() {
    var charsInNewString = 0
    var charsInOriginalString = 0
    for line in input {
        charsInNewString += line.debugDescription.count
        charsInOriginalString += line.count
    }

    print(charsInNewString - charsInOriginalString)
}

partOne()
partTwo()



// Helpers
func parseString(_ input: String) -> Int {
    var cleanedEdgeQuotes = String(input.dropFirst().dropLast(1))
    replaceASCIIHexCode(&cleanedEdgeQuotes)
    removeEscapedCharacters(&cleanedEdgeQuotes)
    return cleanedEdgeQuotes.count
}

func removeEscapedCharacters(_ input: inout String) {
    input = input.replacingOccurrences(of: Literals.quoteLiteral, with: Literals.singleQuote)
                 .replacingOccurrences(of: Literals.backslashLiteral, with: Literals.backslash)
}

func replaceASCIIHexCode(_ input: inout String) {
    while let hexLiteral = input.range(of: Literals.hex) {

        let scalarLowerBound = input.index(hexLiteral.lowerBound, offsetBy: 2)
        let scalarUpperBound = input.index(hexLiteral.upperBound, offsetBy: 1)
        let sliceEndIndex = input.index(hexLiteral.upperBound, offsetBy: 1)

        let nonScalarHexStartIndex = input.index(hexLiteral.lowerBound, offsetBy: 1)
        let nonScalarHexEndIndex = input.index(hexLiteral.upperBound, offsetBy: -1)

        let scalarPositionRange = hexLiteral.lowerBound...sliceEndIndex
        let noScalarHexPositionRange = nonScalarHexStartIndex...nonScalarHexEndIndex

        let hex = String(input[scalarLowerBound...scalarUpperBound])
        if let scalar = convertToScalar(hex) {
            input = input.replacingCharacters(in: scalarPositionRange, with: "\(scalar)")
        } else {
            input = input.replacingCharacters(in: noScalarHexPositionRange, with: "S")
        }
    }
}

func convertToScalar(_ hexSubstring: String) -> UnicodeScalar? {
    if let hex = Int(hexSubstring, radix: 16), let scalar = UnicodeScalar(hex) {
        return scalar
    } else {
        return nil
    }
}

enum Literals {
static let quoteLiteral = """
\\\"
"""
static let singleQuote = """
"
"""
static let backslashLiteral = """
\\\\
"""
static let backslash = """
\\
"""
static let hex = #"\x"#
}