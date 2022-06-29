import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath).components(separatedBy: "\n")

let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
let forbidden: Set<String> = ["ab", "cd", "pq", "xy"]

func partOne() {
    var goodLines = 0
    for line in input {
        if goodLineChecker(line) { goodLines += 1 }
    }

    print(goodLines)
}

func partTwo() {
    var goodLines = 0
    for line in input {
        if updatedGoodLineChecker(line) { goodLines += 1 }
    }

    print(goodLines)
}

partOne()
partTwo()



// Helpers
func goodLineChecker(_ input: String) -> Bool {
    var vowelsCount = 0
    var isContainsForbiddenSymbols = false
    var isHaveDoubleSymbols = false

    let _ = input.reduce("") { partialResult, letter in
        if vowels.contains(letter) { vowelsCount += 1 }
        if forbidden.contains(partialResult + String(letter)) { isContainsForbiddenSymbols = true }
        if partialResult == String(letter) { isHaveDoubleSymbols = true }

        return String(letter)
    }
    
    return vowelsCount >= 3 && !isContainsForbiddenSymbols && isHaveDoubleSymbols
}

func updatedGoodLineChecker(_ input: String) -> Bool {
    checkForDoubles(input) && checkForSymmetric(input)
}

func checkForDoubles(_ input: String) -> Bool {
    let lastCharIndex = input.endIndex
    var isContainsDoubles = false

    for (index, _) in input.enumerated() {
        if index == 0 || index > input.count - 3 { continue }

        let pairRange = input.index(input.startIndex, offsetBy: index - 1)..<input.index(input.startIndex, offsetBy: index + 1)
        let pairSubstring = input[pairRange]
        let testableRange = input.index(input.startIndex, offsetBy: index + 1)..<lastCharIndex
        let testableSubstring = input[testableRange]

        if testableSubstring.contains(pairSubstring) { isContainsDoubles = true; break }
    }

    return isContainsDoubles
}

func checkForSymmetric(_ input: String) -> Bool {
    var isSymmetric = false

    for (index, _) in input.enumerated() {
        if index == 0 || index == 1 { continue }

        let pairRange = input.index(input.startIndex, offsetBy: index - 2)..<input.index(input.startIndex, offsetBy: index + 1)
        let pairSubstring = input[pairRange]

        if pairSubstring.first == pairSubstring.last { isSymmetric = true; break }
    }

    return isSymmetric
}