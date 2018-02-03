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
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var CardButtons: [UIButton]!
    
    var emojiChoices = ["👹","👺","👹","👺","💩","💩"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender){
        flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        else{
            print("card is not the in the cardButtons array")
        }
    }
    func flipCard(withEmoji emoji: String, on button:UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }else{
            button.setTitle(emoji , for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } 
    }
    
}

