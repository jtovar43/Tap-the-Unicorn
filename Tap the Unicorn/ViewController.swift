//
//  ViewController.swift
//  Tap the Unicorn
//
//  Created by Justin Tovar on 5/14/20.
//  Copyright © 2020 Justin Tovar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var unicornButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pointCounter: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    var gameStarted = false
    var timeRemaining = 60
    var totalPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerLabel.isHidden = true
        pointCounter.isHidden = true
        finalScoreLabel.isHidden = true
        finalScoreLabel.numberOfLines = 0
        playAgainButton.isHidden = true
        
    }
    
//MARK: buttonClicked()
    @IBAction func buttonClicked(_ sender: Any) {
        if (gameStarted == false) {
            startGame()
            timerLabel.isHidden = false
            pointCounter.isHidden = false
            self.titleLabel.isHidden = true
            gameStarted = true
        }
        self.totalPoints += 1
        self.pointCounter.text = "Points: " + String(self.totalPoints)
    }
    
    
//MARK: startTimer()
    func startGame() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if (self.timeRemaining == 0) {
                self.unicornButton.isEnabled = false // TODO: Touching button too fast at end triggers game reset
                timer.invalidate()
                self.pointCounter.isHidden = true
                self.timerLabel.isHidden = true
                self.finalScoreLabel.text = "Game Over\nYou Scored " + String(self.totalPoints) + " Points!"
                self.finalScoreLabel.isHidden = false
                self.unicornButton.isHidden = true
                var playAgainDelay = 2
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {timer in
                    if (playAgainDelay == 0) {
                        timer.invalidate()
                        self.playAgainButton.isHidden = false
                    }
                    playAgainDelay -= 1
                })
            }
            self.timerLabel.text = "Time Remaining: " + String(self.timeRemaining)
            self.timeRemaining -= 1
        })
    }
    
    //MARK: playAgain()
    @IBAction func playAgain(_ sender: Any) {
        finalScoreLabel.isHidden = true
        timeRemaining = 60
        totalPoints = 0
        pointCounter.text = "Points: -"
        playAgainButton.isHidden = true
        timerLabel.isHidden = false
        pointCounter.isHidden = false
        unicornButton.isEnabled = true
        unicornButton.isHidden = false
        
        startGame()
    }
    
    
}
