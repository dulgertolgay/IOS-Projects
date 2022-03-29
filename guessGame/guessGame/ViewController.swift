//
//  ViewController.swift
//  guessGame
//
//  Created by Tolgay Dulger on 17.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var chanceWarning: UILabel!
    
    let guessGameHelper = GuessGameHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetGame()
        guessGameHelper.delegate = self
    }

    func resetGame() {
        playButton.isEnabled = true
        guessLabel.text = "Click Play to Start. You Have 3 Chances!"
        chanceWarning.text = ""
        arrowView.image = UIImage(named: "")
    }
    
    @IBAction func guessChanged(_ sender: Any) {
        chanceWarning.text = ""
        guessGameHelper.getPlayerGuess(guess: guessField.text ?? "")
        arrowView.image = UIImage(named: guessGameHelper.getArrow())
        guessLabel.text = "\(guessGameHelper.checkGuess())"
    }
    
    @IBAction func play(_ sender: Any) {
        guessGameHelper.startAndGetGuessNumber()
        guessField.text = ""
        guessLabel.text = "Enter a Number Between 1 and 10"
        playButton.isEnabled = false
    }
}

extension ViewController: GuessGameProtocol {
    func resetUI() {
        resetGame()
    }
    
    func throwLastChanceWarning() {
        chanceWarning.text = "This is your last chance"
    }
    
    func enterNumberWarning() {
        chanceWarning.text = "Please Enter a Number"
    }
}

