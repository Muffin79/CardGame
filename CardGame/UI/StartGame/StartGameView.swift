//
//  StartGameView.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 10.03.2025.
//

import SwiftUI

struct StartGameView: View {
    
    @State var showGameScreen: Bool = false
    @State var showDifficultySelection: Bool = false
    @State var selectedDifficulty = DefaultsStorage.shared.getDifficultyLevel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
 
                Button("Start Game") {
                    showGameScreen.toggle()
                }.navigationDestination(isPresented: $showGameScreen) {
                    GameView(configuration: GameConfiguration(gameDificulty: selectedDifficulty))
                }
                
                Button("Select Difficulty") {
                    showDifficultySelection.toggle()
                }
            }
           
            .alert("Select Difficulty", isPresented: $showDifficultySelection) {
                ForEach(GameDificulty.allCases) { value in
                    Button(value.rawValue.capitalized) {
                        selectedDifficulty = value
                        DefaultsStorage.shared.saveDifficultyLevel(value)
                    }.keyboardShortcut(selectedDifficulty == value ? .defaultAction : nil)
                }
            }
        }
    }
}

#Preview {
    StartGameView()
}
