//
//  Card.swift
//  Concetration
//
//  Created by Gal Shitrit on 05/02/2018.
//  Copyright © 2018 Gal Shitrit. All rights reserved.
//

import Foundation
struct Card : Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFacUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var IdentifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        IdentifierFactory += 1
        return IdentifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
}
}
