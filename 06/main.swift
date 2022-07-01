import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let samplePath = FileManager.default.currentDirectoryPath + "/sample.txt"
var input = try! String.init(contentsOfFile: inputPath).components(separatedBy: "\n")
var sample = try! String.init(contentsOfFile: samplePath)

let commandQueue: [Command] = input.map { convertCommandString($0) }

func partOne() {
    var grid: [[Bool]] = createGrid(rows: 1000, columns: 1000, filler: false)
    var lightsOn = 0

    let _ = commandQueue.map { executeCommand($0, atGrid: &grid) }
    let _ = grid.map { row in row.map { if $0 == true { lightsOn += 1 } }}
    print("Lights lit: \(lightsOn)")
}

func partTwo() {
    var grid: [[UInt8]] = createGrid(rows: 1000, columns: 1000, filler: UInt8.min)
    var sumBrightness = 0

    let _ = commandQueue.map { executeCommand($0, atGrid: &grid) }
    let _ = grid.map { row in row.map { sumBrightness += Int($0) } }
    print("Total brightness: \(sumBrightness)")
}

partOne()
partTwo()



// Helpers
func createGrid<T>(rows: Int, columns: Int, filler: T) -> [[T]] {
    (1...rows).map { _ in (1...columns).map { _ in filler } }
}

func executeCommand(_ command: Command, atGrid grid: inout [[Bool]]) {
    for row in command.startCell.x...command.finishCell.x {
        for column in command.startCell.y...command.finishCell.y {
            switch command.signal {
                case .on: grid[row][column] = true
                case .off: grid[row][column] = false
                case .toggle: grid[row][column].toggle()
            }
        }
    }
}

func executeCommand(_ command: Command, atGrid grid: inout [[UInt8]]) {
    for row in command.startCell.x...command.finishCell.x {
        for column in command.startCell.y...command.finishCell.y {
            switch command.signal {
                case .on: grid[row][column] += 1
                case .off: 
                    if grid[row][column] == 0 { continue } else { grid[row][column] -= UInt8(1) }
                case .toggle: grid[row][column] += 2
            }
        }
    }
}

func convertCommandString(_ commandString: String) -> Command {
    let command = commandString.components(separatedBy: " ").filter { $0 != "turn" }.filter { $0 != "through" }
    return Command(command)
}

struct LightCellPosition {
    let x: Int
    let y: Int
}

extension LightCellPosition {
    init(_ input: String) {
        let coordinates = input.components(separatedBy: ",")
        self.x = Int(coordinates[0])!
        self.y = Int(coordinates[1])!
    }
}

struct Command {
    let signal: Signal
    let startCell: LightCellPosition
    let finishCell: LightCellPosition

    enum Signal: String {
        case on = "on"
        case off = "off"
        case toggle = "toggle"
    }
}

extension Command {
    init(_ input: [String]) {
        self.signal = Signal(rawValue: input[0])!
        self.startCell = LightCellPosition(input[1])
        self.finishCell = LightCellPosition(input[2])
    }
}