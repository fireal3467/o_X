//
//  OXGameController.swift
//  o_X
//
//  Created by Alan Yu on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


class OXGameController {
    
    static var sharedInstance = OXGameController()
    
    private var currentGame:OXGame = OXGame()
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    
    func restartGame(){
        currentGame.reset()
    }
    
    func playMove(location:Int) {
        currentGame.playMove(location)
    }
    
    
    
}