//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    // Sample algorithm
    var totalScore = 0
    lines.forEach { line in
        let hands = parseLine(line)
        let roundScore = playRound(opponent: hands.opponent, me: hands.me)
        print(roundScore)
        totalScore += roundScore
    }
    print(totalScore)
}

func parseLine(_ line: String) -> (opponent: Hand, me: Hand) {
    let result = line.components(separatedBy: .whitespaces)
    return (Hand(rawValue: result[0])!, Hand(rawValue: result[1])!)
}

enum Hand: String {
    case A
    case B
    case C
    case X
    case Y
    case Z
}

func playRound(opponent: Hand, me: Hand) -> Int {
    var score = 0
    switch me {
    case .X: score += 1
    case .Y: score += 2
    case .Z: score += 3
    default: ()
    }
    
    // draw
    if (opponent == .A && me == .X) ||
        (opponent == .B && me == .Y) ||
        (opponent == .C && me == .Z) {
        score += 3
    }
    
    // win
    if (opponent == .A && me == .Y) ||
        (opponent == .B && me == .Z) ||
        (opponent == .C && me == .X) {
        score += 6
    }
    
    return score
}

main()
