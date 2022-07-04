import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let samplePath = FileManager.default.currentDirectoryPath + "/sample.txt"
let input = try! String.init(contentsOfFile: inputPath).components(separatedBy: "\n")
let sample = try! String.init(contentsOfFile: samplePath).components(separatedBy: "\n")

var gates: [String:UInt16] = [:]
var operations: [String:Array<String>] = [:]

func partOne() {
    parseInput(input)
    let result = calculate(name: "a")
    print(result)
}

func partTwo() {
    let val = gates["a"]
    gates.removeAll()
    gates["b"] = val
    let result = calculate(name: "a")
    print(result)
}

partOne()
partTwo()



// Helpers
func process(operation: String, parts: [String]) -> UInt16 {
    switch operation {
    case "AND": return calculate(name: parts[0]) & calculate(name: parts[2])
    case "OR": return calculate(name: parts[0]) | calculate(name: parts[2])
    case "NOT": return ~calculate(name: parts[1])
    case "RSHIFT": return calculate(name: parts[0]) >> calculate(name: parts[2])
    case "LSHIFT": return calculate(name: parts[0]) << calculate(name: parts[2])
    default: fatalError("ERROR: Unknown operation")
    }
}

func calculate(name: String) -> UInt16 {
    if let number = UInt16(name) { return number }
    if !gates.keys.contains(name) {
        guard let ops = operations[name] else { fatalError("Could't find operation \(name)") }
        gates[name] = ops.count < 2 ? 
            calculate(name: ops[0]) : 
            process(operation: ops[ops.count - 2], parts: ops)
    }
    return gates[name]!
}

func parseInput(_ input: [String]) {
    let _ = input.map { command in
        let parts = command.components(separatedBy: "->")
        operations[parts[1].trimmingCharacters(in: .whitespaces)] = 
            parts[0].trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
    }
}