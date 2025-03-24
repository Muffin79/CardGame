//
//  GameType.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 24.03.2025.
//

import Foundation

enum GameType: String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    
    case icons = "Icons"
    case colors = "Colors"
}
