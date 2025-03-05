//
//  GameViewModel.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 05.03.2025.
//
import Foundation

final class GameViewModel {
    
    var cards: [CardItem] = CardItem.testItems
    var selectedItem: CardItem?
    
    func cardSelected(_ item: CardItem) {
        print("Item selected")
        guard item.canFlip else { return }
        item.isFliped.toggle()
        
        if selectedItem == nil {
            selectedItem = item
            return
        }
        
        if item.id == selectedItem?.id {
            selectedItem = nil
            return
        }
        
       
        
        if selectedItem?.color == item.color {
            selectedItem?.canFlip = false
            item.canFlip = false
            selectedItem = nil
            return
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                item.isFliped.toggle()
                self.selectedItem?.isFliped.toggle()
                self.selectedItem = nil
            }
        }
    }
}
