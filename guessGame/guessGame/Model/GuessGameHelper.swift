//
//  GuessGameHelper.swift
//  guessGame
//
//  Created by Tolgay Dulger on 17.10.2021.
//

import Foundation

class GuessGameHelper {
    weak var delegate: GuessGameProtocol?
    
    private var player: Player!
    private var correctGuess: Int!
    
    init() {
        
    }
    
    func startAndGetGuessNumber() {
        player = Player(guessNumber: 0, chance: 3)
        correctGuess = Int.random(in: 1...10)
    }
    
    func getPlayerGuess (guess: String) {
        if (!guess.isEmpty) {
            player.guessNumber = Int(guess) ?? 0
        } else {
            player.guessNumber = 0
        }
        
    }
    
    func getArrow() -> String {
        if(player.guessNumber != 0 && player.guessNumber > correctGuess) {
            player.chance -= 1
            return "downArrow"
        } else if (player.guessNumber != 0 && player.guessNumber < correctGuess) {
            player.chance -= 1
            return "upArrow"
        } else {
            return ""
        }
    }
    
    func checkGuess() -> String {
        if (player.chance == 1) {
            self.delegate?.throwLastChanceWarning()
        }
        if (player.guessNumber == 0) {
            self.delegate?.enterNumberWarning()
            return ""
        }
        if (player.chance > 0 && correctGuess == player.guessNumber) {
                self.delegate?.resetUI()
                return "Congratulations! Your guess is correct!"
        } else if (player.chance > 0 && correctGuess != player.guessNumber) {
            if (player.guessNumber > correctGuess) {
                return "Make a lower guess"
            } else {
                return "Make a higher guess"
            }
        } else {
            self.delegate?.resetUI()
            return "You run out of chances and lost! Correct number was \(correctGuess ?? 0)"
        }
    }
}
