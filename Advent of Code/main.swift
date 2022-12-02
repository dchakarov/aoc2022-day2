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
    
    var totalScore = 0
    lines.forEach { line in
        let hands = parseLine(line)
        let roundScore = playRound(opponent: hands.opponent, me: hands.me)
        totalScore += roundScore
    }
    print(totalScore)
    
    totalScore = 0
    lines.forEach { line in
        let (opponent, outcome) = parseLine2(line)
        let roundScore = playRound(opponentHand: opponent, desiredOutcome: outcome)
        totalScore += roundScore
    }
    print(totalScore)
}

func parseLine(_ line: String) -> (opponent: Hand, me: Hand) {
    let result = line.components(separatedBy: .whitespaces)
    return (Hand(rawValue: result[0])!, Hand(rawValue: result[1])!)
}

func parseLine2(_ line: String) -> (opponent: OpponentHand, outcome: Outcome) {
    let result = line.components(separatedBy: .whitespaces)
    return (OpponentHand(rawValue: result[0])!, Outcome(rawValue: result[1])!)
}

enum Hand: String {
    case A
    case B
    case C
    case X
    case Y
    case Z
}

enum OpponentHand: String {
    case rock = "A"
    case paper = "B"
    case scissors = "C"
}

enum Outcome: String {
    case lose = "X"
    case draw = "Y"
    case win = "Z"
}

func playRound(opponentHand: OpponentHand, desiredOutcome: Outcome) -> Int {
    var playerHand: OpponentHand
    
    switch desiredOutcome {
    case .draw:
        playerHand = opponentHand
    case .win:
        switch opponentHand {
        case .rock: playerHand = .paper
        case .paper: playerHand = .scissors
        case .scissors: playerHand = .rock
        }
    case .lose:
        switch opponentHand {
        case .rock: playerHand = .scissors
        case .paper: playerHand = .rock
        case .scissors: playerHand = .paper
        }
    }
    
    return calcPoints(hand: playerHand, outcome: desiredOutcome)
}

func calcPoints(hand: OpponentHand, outcome: Outcome) -> Int {
    var points = 0
    switch hand {
    case .rock: points += 1
    case .paper: points += 2
    case .scissors: points += 3
    }
    
    switch outcome {
    case .win:
        points += 6
    case .draw:
        points += 3
    case .lose:
        ()
    }
    
    return points
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
