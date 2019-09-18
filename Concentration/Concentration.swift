//
//  Concentration.swift
//  Concentration
//
//  Created by Sabri Sönmez on 9/5/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    //optional variable, only one card is selected
    private var indexOfOneAndOnlyFaceUpCard : Int?{
        get
        {
            var foundIndex:Int?
            for index in cards.indices
            {
                if cards[index].isFaceUp
                {
                    if foundIndex == nil
                    {
                        foundIndex = index
                    }else{
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue)
        {
            for index in cards.indices
            {
                //sets other cards to false/facedown
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    internal func chooseCard(at index: Int)
    {assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not valid")
        if !cards[index].isMatched
        { //
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
                //check if the cards match
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
               // if they don't match
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            }
            else
            {  //at the beginning sets the one and only card
                // either 0 or 2 cards are face up
//                for flipDownIndex in cards.indices
//                {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards : Int)
    {assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        //... include all ..< include one less than
        
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            //different ways to make 2 same card:
            // let matchingCard = Card(identifier: identifier)
            //cards.append(card)
            //cards.append(card)
            cards += [card,card]
        }
        //TODO: Shuffle the deck of cards for homework
    }
}
