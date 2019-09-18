//
//  Card.swift
//  Concentration
//
//  Created by Sabri Sönmez on 9/5/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import Foundation
//struct is like a class except doesn't have inheritence, passed by value, if you change it nothing happens to where it came from, a class passed by reference changes for everybody. When you pass struct it doesn't get copied right away, only when changed.
struct Card
{
    internal var isFaceUp = false
    internal var isMatched = false
    internal var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int
    {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
