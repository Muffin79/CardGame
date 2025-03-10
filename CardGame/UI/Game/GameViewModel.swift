//
//  GameViewModel.swift
//  CardGame
//
//  Created by Maksim Zakhorolskiy on 05.03.2025.
//
import Foundation
import Combine

@Observable final class GameViewModel {
    
    private var cancelables = Set<AnyCancellable>()
    
    var cards: [CardItem] = []
    var selectedItem: CardItem?
    
    var timerString: String = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var timeLeft: Int = 0
    
    private var mistakesCount = 0
    var paused = false
    var gameOver = false
    
    let secondsFormatter = SecondsToStringFormatter()
    var configuration: GameConfiguration
    
    var gameOverMessage: String {
        if timeLeft == 0 {
            return "You lose! Try again."
        }
        
        return "Your score: \(calculateScore())"
    }
    
    init(configuration: GameConfiguration) {
        self.configuration = configuration
        
        startGame()
        startTimer()
    }
    
    func startGame() {
        timeLeft = configuration.timeLimit
        timerString = secondsFormatter.secondsToString(configuration.timeLimit)
        setupCards()
    }
    
    func setupCards() {
        var colors = CardColors.getColorsForCards(configuration.itemsCount)
        timeLeft = configuration.timeLimit
        colors.append(contentsOf: colors)
        cards = colors.shuffled().map{ CardItem(color: $0) }
    }
    
    private func startTimer() {
        timer.sink {[weak self] _ in
            guard let self else { return }
            if !self.paused && !self.gameOver {
                self.timeLeft -= 1
                self.timerString = self.secondsFormatter.secondsToString(self.timeLeft)
                checkGameOver()
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
        if timeLeft == 0 {
            gameOver = true
            return
        }
        
        if cards.allSatisfy({ !$0.canFlip }) {
            gameOver = true
        }
    }
    
    func calculateScore() -> Int {
        return 1000 - (mistakesCount * 3) + timeLeft
    }
}
