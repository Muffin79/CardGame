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
    private let recordListKey = "recordList"
    private let gameTypeKey = "gameType"
    
    private let recordsListMaxSize = 10
    
    private var userDefaults = UserDefaults.standard
    
    
    func saveDifficultyLevel(_ level: GameDificulty) {
        userDefaults.set(level.rawValue, forKey: difficultyLevelKey)
    }
    
    func getDifficultyLevel() -> GameDificulty {
        let savedLevel = userDefaults.string(forKey: difficultyLevelKey) ?? ""
        return GameDificulty(rawValue: savedLevel) ?? .medium
    }
    
    func saveRecordIfNeeded(_ record: Int) {
        var records = getRecords().sorted()
        if records.count < recordsListMaxSize {
            records.append(record)
            userDefaults.set(records, forKey: recordListKey)
            return
        }
        
        if (getRecords().min() ?? 0) < record {
            records[records.count - 1] = record
        }
        
        userDefaults.set(records, forKey: recordListKey)
    }
    
    func getRecords() -> [Int] {
        return userDefaults.array(forKey: recordListKey) as? [Int] ?? []
    }
    
    func saveGameType(_ type: GameType) {
        userDefaults.set(type.rawValue, forKey: gameTypeKey)
    }
    
    func getGameType() -> GameType {
        let savedType = userDefaults.string(forKey: gameTypeKey) ?? ""
        return GameType(rawValue: savedType) ?? .colors
    }
}
