//
//  DefaultsStorage.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 10.03.2025.
//

import Foundation

final class DefaultsStorage {
    static var shared = DefaultsStorage()
    //MARK: Identifiers
    private let difficultyLevelKey = "difficultyLevel"
    private let recordKey = "record"
    
    private var userDefaults = UserDefaults.standard
    
    
    func saveDifficultyLevel(_ level: GameDificulty) {
        userDefaults.set(level.rawValue, forKey: difficultyLevelKey)
    }
    
    func getDifficultyLevel() -> GameDificulty {
        let savedLevel = userDefaults.string(forKey: difficultyLevelKey) ?? ""
        return GameDificulty(rawValue: savedLevel) ?? .medium
    }
    
    func saveRecord(_ record: Int) {
        userDefaults.set(record, forKey: recordKey)
    }
    
    func getRecord() -> Int {
        return userDefaults.integer(forKey: recordKey)
    }
    
}
