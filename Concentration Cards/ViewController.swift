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
    
    //    создаем экземпляр класса
    //    lazy - не будет инициализирована, пока не будет использована
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
    
    var touches = 0 {
        //        Observer - следит за изменением значения переменной touches, если она изменяется, то выполняет код (touchLabel.text = "Touches: \(touches)")
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
//    func flipButton(emoji: String, button: UIButton) {
//        //      currentTitle - заголовок который видим в данный момент
//        if button.currentTitle == emoji {
//            //      setTitle - заголовок который назначаем
//            button.setTitle("", for: .normal)
//            button.backgroundColor = .orange
//        } else {
//            button.setTitle(emoji, for: .normal)
//            button.backgroundColor = .white
//        }
//    }
    
    var emojiCollection = ["🐫", "🐜", "🦅", "🐥", "🦉", "🦆", "🦈", "🦧", "🦒", "🦢", "🐊", "🐢"]
    
    var emojiDictionary = [Int: String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
//            метод который берет РАНДОМНЫЙ индекс из СЛОВАРЯ
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
//        ТОЖЕ САМОЕ что написано ниже (return emojiDictionary[card.identifier] ?? "?")
//        if emojiDictionary[card.identifier] != nil {
//            return emojiDictionary[card.identifier]!
//        } else {
//            return "?"
//        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateVeiwFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9933148026, green: 0.6221938133, blue: 0.04744280875, alpha: 1)
            }
        }
    }
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        //        безопасное разворачиваение опционала (Optional Binding)
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            //        обращаемся к функции из модели
            game.chooseCard(at: buttonIndex)
            updateVeiwFromModel()
        }
    }
    
    
}

