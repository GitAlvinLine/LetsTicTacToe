//
//  GameCircleView.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import SwiftUI

struct GameCircleView: View {
    var proxy: GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.blue)
            .frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15)
    }
}

struct GameCircleView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            GameCircleView(proxy: proxy)
        }
    }
}
