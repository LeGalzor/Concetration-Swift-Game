//
//  Concentration.swift
//  Concetration
//
//  Created by Gal Shitrit on 05/02/2018.
//  Copyright © 2018 Gal Shitrit. All rights reserved.
//

import Foundation

class Concetration{
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFacUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFacUp = (index == newValue)
            }
        }
    }
    
    
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
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index out of range")
        if !cards[index].isFacUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                cards[index].isMatched = true
                cards[matchIndex].isMatched = true
                }
                cards[index].isFacUp = true
            }else{
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairOfCards: Int) {
                assert(numberOfPairOfCards > 0, "Concentration.init(\(numberOfPairOfCards)): chosen number of pairs is illegal")
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        }
    }
