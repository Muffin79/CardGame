//
//  CardIcons.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 17.03.2025.
//

import Foundation

struct CardIcons {
    private static var availableIcons = [
        "suit.diamond.fill",
        "suit.club.fill",
        "suit.spade.fill",
        "suit.heart.fill",
        "backpack.fill",
        "flag.pattern.checkered",
        "house.fill",
        "arcade.stick.console.fill",
        "car.2.fill",
        "airplane",
        "tram.fill",
        "motorcycle.fill"
    ]
    
    static func getIconsForCards(_ count: Int) -> [String] {
        guard count <= availableIcons.count else { return [] }
        return Array(availableIcons.shuffled().prefix(count))
    }
}
