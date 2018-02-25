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
    lazy var game = Concetration(numberOfPairOfCards: (CardButtons.count/2)+1)
    // ..count +1 ) /2 removed;
    var flipCount = 0 {didSet { flipCountLabel.text = "FLIPS: \(flipCount)"} }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var CardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender){
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
        }
        else{
            print("card is not the in the cardButtons array")
        }
    }
    func updateViewFromModel(){
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
    func unmatchAll(){
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
    var emojiChoices = ["👹","👺","💀","☠️","👿","👽","👾","🤖","🐝","🧞‍♂️"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
                return emoji[card.identifier] ?? "?"
        }
    //TODO : new shuffle
    @IBAction func ShuffleCards(_ sender: UIButton) {
        unmatchAll()
        self.game.shuffleIt()
        self.updateViewFromModel()
        
    }
    
    // TODO: new game button
    // NEWGAME makes new cards instead of taking them from the dictionary
    @IBAction func NewGameFromUI(_ sender: UIButton) {
        flipCount = 0
        self.game = Concetration(numberOfPairOfCards:(CardButtons.count/2)+1)
        emojiChoices = ["👹","👺","💀","☠️","👿","👽","👾","🤖","🐝","🧞‍♂️"]
        self.game.shuffleIt()
        self.updateViewFromModel()
        
    }
    
}
