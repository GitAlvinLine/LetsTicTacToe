//
//  Move.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import Foundation

struct Move {
    let player: Player
    let boardIndex: Int

    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
