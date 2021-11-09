//
//  Alerts.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win!"),
                                    message: Text("You beat the Computer"),
                                    buttonTitle: Text("Play Again"))
    static let computerWin = AlertItem(title: Text("Computer Win!"),
                                       message: Text("Computer is better than Human"),
                                       buttonTitle: Text("Better Luck Next Time"))
    static let draw = AlertItem(title: Text("Draw!"),
                                message: Text("No One is a Winner!"),
                                buttonTitle: Text("Play Again!"))
}
