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
    var timer: Timer?// = Timer.publish(every: 1, on: .main, in: .common)
    private var timeLeft: Int = 0
    
    //MARK: For Tests
    private var isUseIcons = true
    
    private var mistakesCount = 0
    var paused = false {
        didSet {
            if paused {
                stopTimer()
            } else {
                startTimer()
            }
        }
    }
    
    var gameOver = false {
        didSet {
            if gameOver {
                stopTimer()
            }
        }
    }
    
    let secondsFormatter = SecondsToStringFormatter()
    var configuration: GameConfiguration
    private var defaultsStorage: DefaultsStorage
    
    var gameOverMessage: String {
        if timeLeft == 0 {
            return "You lose! Try again."
        }
        
        return "Your score: \(calculateScore())"
    }
    
    init(configuration: GameConfiguration, defaultsStorage: DefaultsStorage = DefaultsStorage.shared) {
        self.configuration = configuration
        self.defaultsStorage = defaultsStorage
        
       // setupGame()
    }
    
    func setupGame() {
        timeLeft = configuration.timeLimit
        timerString = secondsFormatter.secondsToString(configuration.timeLimit)
        setupCards()
    }
    
    func setupCards() {
        if !isUseIcons {
            var colors = CardColors.getColorsForCards(configuration.itemsCount)
    
            colors.append(contentsOf: colors)
            cards = colors.shuffled().map{ CardItem(type: .color($0)) }
        } else {
            var icons = CardIcons.getIconsForCards(configuration.itemsCount)
    
            icons.append(contentsOf: icons)
            cards = icons.shuffled().map{ CardItem(type: .icon($0)) }
        }
        
        timeLeft = configuration.timeLimit
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {[weak self] _ in
            guard let self else { return }
            
            timeLeft -= 1
            timerString = secondsFormatter.secondsToString(self.timeLeft)
            checkGameOver()
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
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
        
       
        
        if selectedItem == item {
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
            defaultsStorage.saveRecordIfNeeded(calculateScore())
        }
    }
    
    func calculateScore() -> Int {
        return 1000 - (mistakesCount * 3) + timeLeft
    }
}
