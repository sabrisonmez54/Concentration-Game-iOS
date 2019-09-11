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
    }
    
    // lazy meaning leave this variable until class is initialized and initialize it when this variable is used
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count / 2 ))
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👻","🎃","☠️","👹","🍎","🧟‍♂️","🍬","🍫","🍭"]
    var flipCount = 0
    {//everytime the variable changes run this code:
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String
    {
//        if let chosenEmoji = emoji[card.identifier]{
//            return emoji[card.identifier]!
//        }
//        else {return "?"}
                                                //convert to unsigned int32
        //2 if statements can be written like this:
        if emoji[card.identifier] == nil , emojiChoices.count > 0
        {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                //need to remove after getting one randomindex, this method removes and returns at the same time.
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            
        }
           return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {print("chosen card not found in cardButtons")}
    }
    
    func updateViewFromModel()
    {
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
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
//    func flipCard(withEmoji emoji:String, on button: UIButton)
//    {
//        if button.currentTitle == emoji
//        {
//            button.setTitle("", for: .normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
//        }
//        else
//        {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//    }
}
