//
//  ViewController.swift
//  Concetration
//
//  Created by Gal Shitrit on 03/02/2018.
//  Copyright © 2018 Gal Shitrit. All rights reserved.
//

import UIKit

class ConcetrationViewController: UIViewController
{
    private lazy var game: Concetration = Concetration(numberOfPairOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get{
            return (CardButtons.count+1) / 2
        }
    }
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCount()
        }
    }
    
    private func updateFlipCount(){
        //TODO: Replace Any to Swift Enum with associated values
        
        let FlipCountAttributes : [NSAttributedStringKey:Any] = [
            .strokeWidth : 0 ,
            .strokeColor : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "FLIPS: \(flipCount)", attributes: FlipCountAttributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCount()
        }
    }

    
    @IBOutlet private var CardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender){
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
        }
        else{
            print("card is not the in the cardButtons array")
        }
    }
    private func updateViewFromModel(){
        for index in CardButtons.indices{
            let button = CardButtons[index]
            let card = game.cards[index]
            if card.isFacUp {
                button.setTitle(emoji(for: card) , for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
    }
    private func unmatchAll(){
        for index in CardButtons.indices{
            let button = CardButtons[index]
            var card = game.cards[index]
            if game.cards[index].isFacUp {
                card.isMatched = false
                card.isFacUp = false
                button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
    }
//    private var emojiChoices = ["👹","👺","💀","☠️","👿","👽","👾","🤖","🐝","🧞‍♂️"]
    private var emojiChoices = "👹👺💀☠️👿👽👾🤖🐝🧞‍♂️"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
                let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            }
                return emoji[card] ?? "?"
        }
    //TODO : new shuffle
    @IBAction private func ShuffleCards(_ sender: UIButton) {
        //unmatchAll()
        self.game.shuffleIt()
        self.updateViewFromModel()
        
    }
    
    // TODO: new game button
    // NEWGAME makes new cards instead of taking them from the dictionary
    @IBAction private func NewGameFromUI(_ sender: UIButton) {
        flipCount = 0
        self.game = Concetration(numberOfPairOfCards: numberOfPairsOfCards)
        self.emojiChoices = "👹👺💀☠️👿👽👾🤖🐝🧞‍♂️"
        self.game.shuffleIt()
        self.updateViewFromModel()
        
    }
    
}
extension Int {
    var arc4random: Int {
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
