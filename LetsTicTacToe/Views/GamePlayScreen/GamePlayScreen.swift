//
//  GamePlayScreen.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/6/21.
//

import SwiftUI

struct GamePlayScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameVM: GamePlayViewModel
    var body: some View {
        GeometryReader { proxy in
            VStack {
                BackArrowView()
                    .onTapGesture {
                        gameVM.resetGame()
                        presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                LazyVGrid(columns: gameVM.columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameCircleView(proxy: proxy)
                            PlayerIndicatorImage(proxy: proxy, systemImageName: gameVM.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            gameVM.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(gameVM.isGameBoardDisabled)
            .padding()
            .alert(item: $gameVM.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { gameVM.resetGame() }))
            }
        }
    }
}

struct GamePlayScreen_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayScreen()
    }
}
