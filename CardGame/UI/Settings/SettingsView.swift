//
//  SettingsView.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 24.03.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State var viewModel: SettingsViewModel
    
    var body: some View {
        List {
            HStack {
                Text("Difficulty")
                Spacer()
                Menu {
                    ForEach(GameDificulty.allCases) { difficulty in
                        Button(difficulty.rawValue.capitalized) {
                            viewModel.selectDifficulty(difficulty)
                        }
                    }
                } label: {
                    Text(viewModel.selectedDifficulty.rawValue.capitalized)
                }
            }
            
            HStack {
                Text("Game Type")
                Spacer()
                Menu {
                    ForEach(GameType.allCases) { type in
                        Button(type.rawValue.capitalized) {
                            viewModel.selectGameType(type)
                        }
                    }
                } label: {
                    Text(viewModel.selectedType.rawValue.capitalized)
                }
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
