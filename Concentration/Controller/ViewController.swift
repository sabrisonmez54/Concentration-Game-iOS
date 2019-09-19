//
//  ViewController.swift
//  Concentration
//
//  Created by Sabri Sönmez on 8/28/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //changing theme based on user selection
        if halloweenTheme == true
        {
            for index in cardButtons.indices
            {
                let button = cardButtons[index]
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
            mainView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            
        }
        else
        {
            for index in cardButtons.indices
            {
            let button = cardButtons[index]
            button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            }
            mainView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            scoreCountLabel.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            flipCountLabel.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            
        }
    }
    
    // lazy meaning leave this variable until class is initialized and initialize it when this variable is used
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count / 2 ))
    
    private lazy var numberOfPairsOfcards = cardButtons.count / 2
    
    @IBOutlet var mainView: UIView!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    var halloweenTheme : Bool?
    var emojiChoices : [String]  = []
        //= ["👻","🎃","☠️","👹","🍎","🧟‍♂️","🍬","🍫","🍭"]
    
    var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String
    {
//        if let chosenEmoji = emoji[card.identifier]{
//            return emoji[card.identifier]!
//        }
//        else {return "?"}
//convert to unsigned int32
        
        //2 if statements can be written like this:
        if emoji[card.identifier] == nil , emojiChoices.count > 0
        {
                let randomIndex = emojiChoices.count.arc4random
                //need to remove after getting one randomindex, this method removes and returns at the same time.
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            
        }
           return emoji[card.identifier] ?? "?"
    }
    
    @IBAction private func touchCard(_ sender: UIButton)
    {
        if let cardNumber = cardButtons.firstIndex(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {print("chosen card not found in cardButtons")}
    }
    
    private func updateViewFromModel()
    {
        //check if there are cards remaining
        if numberOfPairsOfcards - game.numberOfMatches > 0
        {
            //updateLabels coming from model
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreCountLabel.text = "Score: \(game.scoreCount)"
            for index in cardButtons.indices
            {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp
                {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                else
                {
                    button.setTitle("", for: .normal)
                    if card.isMatched
                    {
                        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                    
                    }
                    else
                    {
                        if halloweenTheme == true
                        {
                            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                        }
                        else
                        {
                            button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)}
                    }
                }
            }
        }
        else
        {
            //If no cards are remaining create an alert to the user
            // create the alert
            let alert = UIAlertController(title: "Game Over!", message: "You have matched every card. Your score is \(game.scoreCount) in \(game.flipCount) flips.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "New Game", style: UIAlertAction.Style.default, handler: alertHandler))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    //handler for alert
    func alertHandler(alert: UIAlertAction!)
    {
         self.performSegue(withIdentifier: "gameToWelcome", sender: self)
    }
}

extension Int
{
    var arc4random: Int
    {
        if(self > 0)
        {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if (self < 0)
        {
            return Int(arc4random_uniform(UInt32(-self)))
        }
        else
        {
            return 0
        }
    }
}
