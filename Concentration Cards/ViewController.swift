//
//  ViewController.swift
//  Concentration Cards
//
//  Created by Evgeniy Nosko on 31.08.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches()
        }
    }
    
    //    создаем экземпляр класса
    //    lazy - не будет инициализирована, пока не будет использована
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private func updateTouches () {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let atributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = atributedString
    }
    
    private(set) var touches = 0 {
        //        Observer - следит за изменением значения переменной touches, если она изменяется, то выполняет код (touchLabel.text = "Touches: \(touches)")
        didSet {
           updateTouches()
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
    
//    private var emojiCollection = ["🐫", "🐜", "🦅", "🐥", "🦉", "🦆", "🦈", "🦧", "🦒", "🦢", "🐊", "🐢"]
//    заменил массив из String, на String
    private var emojiCollection = "🐫🐜🦅🐥🦉🦆🦈🦧🦒🦢🐊🐢"
    
    private var emojiDictionary = [Card: String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            //            метод который берет РАНДОМНЫЙ индекс из СЛОВАРЯ
            //            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtension)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStringIndex))
        }
        //        ТОЖЕ САМОЕ что написано ниже (return emojiDictionary[card.identifier] ?? "?")
        //        if emojiDictionary[card.identifier] != nil {
        //            return emojiDictionary[card.identifier]!
        //        } else {
        //            return "?"
        //        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateVeiwFromModel() {
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
    
    
    
    @IBAction  private func buttonAction(_ sender: UIButton) {
        touches += 1
        //        безопасное разворачиваение опционала (Optional Binding)
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            //        обращаемся к функции из модели
            game.chooseCard(at: buttonIndex)
            updateVeiwFromModel()
        }
    }
    
    
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
