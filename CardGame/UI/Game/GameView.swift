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
    var viewModel: GameViewModel = GameViewModel()
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(viewModel.cards) { item in
                CardView(cardItem: item)
                    .frame(height: rowHeight)
                    .onTapGesture {
                        viewModel.cardSelected(item)
                    }
            }
        }
        .padding(16)
    }
}

#Preview {
    GameView()
}
