//
//  Game.swift
//  FindNumber
//
//  Created by Dauren Sarsenov on 18.04.2022.
//

import Foundation

enum StatusGame {
    case start
    case win
    case lose
}

class Game{
    
    struct Item {
        var title:String
        var isFound = false
        var isError = false
    }
    
    private let data = Array(1...99)
    
    var items:[Item] = []
    
    private var countItems:Int
    
    var nextItem: Item?
    
    var status: StatusGame = .start{
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    
    private var secondsGame:Int {
        didSet {
            if secondsGame == 0 {
                status = .lose }
            updateTimer(status,secondsGame)
        }
    }
    private var timer: Timer?
    
    private var updateTimer:((StatusGame, Int) -> Void)
    
    
    init(countItems:Int, time: Int, updateTimer:@escaping (_ status:StatusGame,_ seconds:Int)->()) {
        self.countItems = countItems
        self.secondsGame = time
        self.timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
    func check(index : Int) {
        guard status == .start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {
                (item) -> Bool in item.isFound == false
            })
        } else {
            items[index].isError = true
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
    private var timeForGame:Int
    
    func newGame() {
        status = .start
        self.secondsGame = self.timeForGame
        setupGame()
    }
    
    private func setupGame() {
        var digits = data.shuffled()
        
        items.removeAll()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        updateTimer(status,secondsGame)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.secondsGame -= 1
        })
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
}

extension Int{
    func secondsToStrings()->String{
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}
