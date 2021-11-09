//
//  BackArrowView.swift
//  LetsTicTacToe
//
//  Created by Alvin Escobar on 11/7/21.
//

import SwiftUI

struct BackArrowView: View {
    var body: some View {
        Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct BackArrowView_Previews: PreviewProvider {
    static var previews: some View {
        BackArrowView()
    }
}
