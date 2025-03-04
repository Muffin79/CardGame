//
//  GameView.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 04.03.2025.
//

import SwiftUI

struct GameView: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var rowHeight = (UIScreen.main.bounds.height * 0.6) / 4
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(0...15, id: \.self) { _ in
                CardView().frame(height: rowHeight)
            }
        }
        .padding(16)
    }

}

#Preview {
    GameView()
}
