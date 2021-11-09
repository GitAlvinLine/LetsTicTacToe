//
//  GamePlayViewModel.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import SwiftUI

final class GamePlayViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    @Published var difficultyLevel: LevelDifficulty?
    
    private let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    func processPlayerMove(for position: Int) {
        if isSpaceOccuppied(in: moves, forIndex: position) {return}
        moves[position] = Move(player: .human, boardIndex: position)
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameBoardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
        }
    }
    
    func playerSelectsDifficulty(_ level: LevelDifficulty) {
        switch level {
        case .easy:
            difficultyLevel = .easy
        case .medium:
            difficultyLevel = .medium
        case .hard:
            difficultyLevel = .hard
        }
    }
    
    
    func isSpaceOccuppied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func computerCanWin(in moves: [Move?]) -> Int? {
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPosition = Set(computerMoves.map { $0.boardIndex})
        
        for pattern in winPatterns {
            let winPositons = pattern.subtracting(computerPosition)
            
            if winPositons.count == 1 {
                let isAvailable = !isSpaceOccuppied(in: moves, forIndex: winPositons.first!)
                if isAvailable { return winPositons.first! }
            }
        }
        
        return nil
    }
    
    func computerCanBlock(in moves: [Move?]) -> Int? {
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPosition = Set(humanMoves.map { $0.boardIndex})
        
        for pattern in winPatterns {
            let drawPositon = pattern.subtracting(humanPosition)
            
            if drawPositon.count == 1 {
                let isAvailable = !isSpaceOccuppied(in: moves, forIndex: drawPositon.first!)
                if isAvailable { return drawPositon.first! }
            }
        }
        
        return nil
    }
    
    func computerCanTakeCenterCircle(in moves: [Move?]) -> Int? {
        let centerSquare = 4
        if !isSpaceOccuppied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        return nil
    }
    
    func computerChoosesRandomPosition(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSpaceOccuppied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        switch  difficultyLevel {
        case .easy:
            return computerChoosesRandomPosition(in: moves)
        case .medium:
            if let position = computerCanBlock(in: moves) {
                return position
            }
            
            return computerChoosesRandomPosition(in: moves)
        case .hard:
            if let position = computerCanWin(in: moves) {
                return position
            }
            
            if let position = computerCanBlock(in: moves) {
                return position
            }
            
            if let position = computerCanTakeCenterCircle(in: moves) {
                return position
            }
            
            return computerChoosesRandomPosition(in: moves)
        default:
            return computerChoosesRandomPosition(in: moves)
        }
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPosition = Set(playerMoves.map { $0.boardIndex})
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return true }
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
}
