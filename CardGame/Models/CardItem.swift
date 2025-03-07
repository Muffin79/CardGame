//
//  CardItem.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 04.03.2025.
//

import Foundation
import SwiftUI

class CardItem: Identifiable, Equatable, ObservableObject {
    static func == (lhs: CardItem, rhs: CardItem) -> Bool {
        return rhs.color == lhs.color
    }
    
    var id: UUID = UUID()
    @Published var isFliped: Bool = false
    var color: Color
    var canFlip =  true
    
    init(isFliped: Bool = false, color: Color, canFlip: Bool = true) {
        self.isFliped = isFliped
        self.color = color
        self.canFlip = canFlip
    }
}
