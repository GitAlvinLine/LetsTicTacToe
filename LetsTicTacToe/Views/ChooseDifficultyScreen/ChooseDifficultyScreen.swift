//
//  ChooseDifficultyScreen.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import SwiftUI

struct ChooseDifficultyScreen: View {
    @EnvironmentObject var gameVM: GamePlayViewModel
    @State private var isPresented = false
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Text("Choose Difficulty")
                    Spacer()
                }
                HStack {
                    ForEach(LevelDifficulty.allCases, id: \.self) { level in
                        Button {
                            gameVM.playerSelectsDifficulty(level)
                            isPresented.toggle()
                        } label: {
                            Text(level.rawValue)
                                .font(.system(size: 30, weight: .bold, design: .default))
                        }
                        .fullScreenCover(isPresented: $isPresented) {
                            GamePlayScreen()
                        }
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct ChooseDifficultyScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDifficultyScreen()
    }
}
