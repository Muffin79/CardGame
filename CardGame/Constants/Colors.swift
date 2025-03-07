//
//  Colors.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 07.03.2025.
//

import Foundation
import SwiftUI

struct CardColors {
    static let red = Color(red: 255/255, green: 0/255, blue: 0/255)
    static let darkBlue = Color(red: 4/255, green: 34/255, blue: 158/255)
    static let purple = Color(red: 173/255, green: 41/255, blue: 239/255)
    static let lightBlue = Color(red: 64/255, green: 143/255, blue: 222/255)
    static let pink = Color(red: 255/255, green: 102/255, blue: 255/255)
    static let yellow = Color(red: 255/255, green: 255/255, blue: 51/255)
    static let green = Color(red: 20/255, green: 242/255, blue: 28/255)
    static let black = Color(red: 0/255, green: 0/255, blue: 0/255)
    
    static let availableColors = Set<Color>([red, darkBlue, purple, lightBlue, pink, yellow, green, black])
    
    static func getColorsForCards(_ count: Int) -> [Color] {
        guard count <= availableColors.count else { return [] }
        return Array(availableColors.shuffled().prefix(count))
    }
}
