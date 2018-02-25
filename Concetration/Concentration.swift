//
//  Concentration.swift
//  Concetration
//
//  Created by Gal Shitrit on 05/02/2018.
//  Copyright © 2018 Gal Shitrit. All rights reserved.
//

import Foundation

class Concetration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    func shuffleIt(){
        var temp = Card()
        for i in 1..<cards.count {
            let rand = Int(arc4random_uniform(UInt32(self.cards.count)))
             temp = self.cards[i]
             self.cards[i] = self.cards[rand]
             self.cards[rand] = temp
            
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isFacUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                cards[index].isMatched = true
                cards[matchIndex].isMatched = true
                }
                cards[index].isFacUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacUp = false
                }
                cards[index].isFacUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairOfCards: Int) {
        for _ in 1..<numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        }
    }
