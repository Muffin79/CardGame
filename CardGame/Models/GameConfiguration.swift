//
//  GameConfiguration.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 07.03.2025.
//
import Foundation

enum GameDificulty: String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    
    case easy
    case medium
    case hard
}

struct GameConfiguration {
    var itemsCount: Int {
        switch gameDificulty {
        case .easy:
            return 6
        case .medium:
            return 8
        case .hard:
            return 12
        }
    }
    var timeLimit: Int {
        switch gameDificulty {
        case .easy:
            return 40
        case .medium:
            return 80
        case .hard:
            return 120
        }
    }
    
    var gameDificulty: GameDificulty
}
