//
//  SettingsViewModel.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 24.03.2025.
//

import Foundation

@Observable final class SettingsViewModel {
    
    var storage: DefaultsStorage
    var selectedDifficulty: GameDificulty
    var selectedType: GameType
    
    init(storage: DefaultsStorage = DefaultsStorage.shared) {
        self.storage = storage
        selectedDifficulty = storage.getDifficultyLevel()
        selectedType = storage.getGameType()
    }
    
    func selectDifficulty(_ difficulty: GameDificulty) {
        storage.saveDifficultyLevel(difficulty)
        selectedDifficulty = difficulty
    }
    
    func selectGameType(_ type: GameType) {
        storage.saveGameType(type)
        selectedType = type
    }
    
}
