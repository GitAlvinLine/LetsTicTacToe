//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Alvin Escobar on 11/6/21.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    @StateObject var gameVM = GamePlayViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameVM)
        }
    }
}
