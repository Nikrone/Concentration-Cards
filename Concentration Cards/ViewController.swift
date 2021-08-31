//
//  ViewController.swift
//  Concentration Cards
//
//  Created by Evgeniy Nosko on 31.08.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    
    var touches = 0 {
//        Observer - следит за изменением значения переменной touches, если она изменяется, то выполняет код (touchLabel.text = "Touches: \(touches)")
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    func flipButton(emoji: String, button: UIButton) {
//      currentTitle - заголовок который видим в данный момент
        if button.currentTitle == emoji {
//      setTitle - заголовок который назначаем
            button.setTitle("", for: .normal)
            button.backgroundColor = .orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
    
let emojiCollection = ["🦊", "🐰", "🦊", "🐰"]

    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
//        безопасное разворачиваение опционала (Optional Binding)
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            flipButton(emoji: emojiCollection[buttonIndex], button: sender)
        }
    }
    


}

