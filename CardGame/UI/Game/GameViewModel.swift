//
//  GameViewModel.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 05.03.2025.
//
import Foundation
import Combine

final class GameViewModel {
    
    var cancelables = Set<AnyCancellable>()
    var cards: [CardItem]
    var selectedItem: CardItem?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var secondsTimer = 0
    private var mistakesCount = 0
    var paused = false
    
    init() {
        var colors = CardColors.getColorsForCards(8)
        colors.append(contentsOf: colors)
        cards = colors.shuffled().map{ CardItem(color: $0) }
        timer.sink {[weak self] _ in
            guard let self else { return }
            if !self.paused {
                self.secondsTimer += 1
            }
        }.store(in: &cancelables)
    }
    
    func cardSelected(_ item: CardItem) {
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
            checkGameOver()
            return
        } else {
            mistakesCount += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + CardConfiguration.flipAnimationDuration * 2) {
                item.isFliped.toggle()
                self.selectedItem?.isFliped.toggle()
                self.selectedItem = nil
            }
        }
    }
    
    func checkGameOver() {
        if cards.allSatisfy({ !$0.canFlip }) {
            print("Game Over!")
            print("Your score \(calculateScore())")
        }
    }
    
    func calculateScore() -> Int {
        return 1000 - mistakesCount - secondsTimer
    }
}
