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
    
    var rowHeight: CGFloat
    @Bindable var viewModel: GameViewModel
    
    
    init(configuration: GameConfiguration) {
        viewModel = GameViewModel(configuration: configuration)
        let cardsCount = configuration.itemsCount *  2
        let rowsCount = CGFloat(cardsCount / 4)
        rowHeight = (UIScreen.main.bounds.height * 0.6) / rowsCount
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(viewModel.timerString)
            }
            
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
        }.alert("Game Over", isPresented: $viewModel.gameOver, actions: {
            Button("Retry") {
                viewModel.startGame()
            }
        }, message: {
            Text(viewModel.gameOverMessage)
        })
    }
}

#Preview {
    GameView(configuration: GameConfiguration(gameDificulty: .easy))
}
