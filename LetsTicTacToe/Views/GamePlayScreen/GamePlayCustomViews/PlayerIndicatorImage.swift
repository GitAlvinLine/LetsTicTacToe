//
//  PlayerIndicatorImage.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import SwiftUI

struct PlayerIndicatorImage: View {
    var proxy: GeometryProxy
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: proxy.size.width / 7, height: proxy.size.width / 7)
            .foregroundColor(.white)
    }
}

struct PlayerIndicatorImage_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            PlayerIndicatorImage(proxy: proxy, systemImageName: "xmark")
        }
    }
}
