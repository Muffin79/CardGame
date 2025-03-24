//
//  StartGameView.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 10.03.2025.
//

import SwiftUI

struct StartGameView: View {
    
    var storage = DefaultsStorage.shared
    @State var showGameScreen: Bool = false
    @State var showSettingsScreen: Bool = false
    @State var selectedDifficulty: GameDificulty = .medium//storage.getDifficultyLevel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
 
                Button("Start Game") {
                    showGameScreen.toggle()
                }
                
                Button("Settings") {
                    showSettingsScreen.toggle()
                }
            }.navigationDestination(isPresented: $showGameScreen) {
                GameView()
            }.navigationDestination(isPresented: $showSettingsScreen) {
                SettingsView(viewModel: SettingsViewModel())
            }
           
//            .alert("Select Difficulty", isPresented: $showDifficultySelection) {
//                ForEach(GameDificulty.allCases) { value in
//                    Button(value.rawValue.capitalized) {
//                        selectedDifficulty = value
//                        storage.saveDifficultyLevel(value)
//                    }.keyboardShortcut(selectedDifficulty == value ? .defaultAction : nil)
//                }
//            }
        }.onAppear {
            selectedDifficulty = storage.getDifficultyLevel()
        }
    }
}

#Preview {
    StartGameView()
}
