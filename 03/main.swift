import Foundation

let inputPath = FileManager.default.currentDirectoryPath + "/input.txt"
let input = try! String.init(contentsOfFile: inputPath).map { String($0) }

func partOne() {
    var santaVisits: Set<Coordinate> = [Coordinate(x: 0, y: 0)]

    let _ = input.reduce(Coordinate(x: 0, y: 0)) { partialResult, direction in
        var newCoords = Coordinate(x: 0, y: 0)

        if let direction = Direction(rawValue: String(direction)) {
            switch direction {
            case .up: newCoords = Coordinate(x: partialResult.x, y: partialResult.y + 1)
            case .down: newCoords = Coordinate(x: partialResult.x, y: partialResult.y - 1)
            case .left: newCoords = Coordinate(x: partialResult.x - 1, y: partialResult.y)
            case .right: newCoords = Coordinate(x: partialResult.x + 1, y: partialResult.y)
            }
        }

        santaVisits.insert(newCoords)
        return newCoords
    }

    print(santaVisits.count)
}

func partTwo() {
    var visitedHouses: Set<Position> = [Position(x: 0, y: 0)]
    var santaMovements: [String] = []
    var robotMovements: [String] = []

    for (index, movement) in input.enumerated() {
        index % 2 == 0 ? santaMovements.append(movement) : robotMovements.append(movement)
    }

    func traverse(_ movements: [String]) {
        var currentPosition = Position(x: 0, y: 0)
        for direction in movements {
            let dir = Direction(rawValue: direction)!
            switch dir {
                case .up: currentPosition.y += 1
                case .down: currentPosition.y -= 1
                case .left: currentPosition.x -= 1
                case .right: currentPosition.x += 1
            }

            visitedHouses.insert(currentPosition)
        }
    }

    traverse(santaMovements)
    traverse(robotMovements)

    print(visitedHouses.count)
}




partOne()
partTwo()

// Helpers
struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

struct Position: Hashable {
    var x: Int
    var y: Int
}

enum Direction: String {
    case up = "^"
    case down = "v"
    case left = "<"
    case right = ">"
}