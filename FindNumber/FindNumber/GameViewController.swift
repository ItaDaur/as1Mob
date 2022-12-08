//
//  GameViewController.swift
//  FindNumber
//
//  Created by Dauren Sarsenov on 18.04.2022.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var nextDigit: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self](status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondsToStrings()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        updateUI()
    }
    
    private func setupScreen() {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI() {
        for index in game.items.indices {
            //buttons[index].isHidden = game.items[index].isFound
            
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self](_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }

            }
        }
        nextDigit.text = game.nextItem?.title
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
            newGameButton.isHidden = true
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = true
        }
    }

}
