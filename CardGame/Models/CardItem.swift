//
//  CardItem.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 04.03.2025.
//

import Foundation
import SwiftUI

enum CardType {
    case color(Color)
    case icon(String)
}

class CardItem: Identifiable, Equatable {
    static func == (lhs: CardItem, rhs: CardItem) -> Bool {
        switch lhs.type {
        case .color:
            return lhs.color == rhs.color
        case .icon:
            return lhs.iconName == rhs.iconName
        }
    }
    
    var id: UUID = UUID()
    @Published var isFliped: Bool = false
    var type: CardType
    var color: Color? {
        switch type {
        case .color(let color):
            return color
        default:
            return nil
        }
    }
    var iconName: String? {
        switch type {
        case .icon(let iconName):
            return iconName
        default :
            return nil
        }
    }
    var canFlip =  true
    
    init(isFliped: Bool = false, type: CardType, canFlip: Bool = true) {
        self.isFliped = isFliped
        self.type = type
        self.canFlip = canFlip
    }
}
