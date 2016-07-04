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
    
    private var SpacesFilled:[Int] = [Int](count: 9, repeatedValue: 0)
    
    var AI: Bool = false
    
    var ID:Int = 0
    var Host:String  = ""
    
    func getGames(onCompletion onCompletion:([OXGame?],String?) -> Void) {
        onCompletion([],nil)
        
    }
    
    
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    
    func restartGame(){
        currentGame.reset()
        SpacesFilled = [Int](count: 9, repeatedValue: 0)

    }
    
    func playMove(location:Int) {
        currentGame.playMove(location)
        SpacesFilled[location] = 1
    }
    
    
    func playMoveAI() -> Int  {
        let location:Int = Int(arc4random_uniform(9))
        print(String(location))
        if SpacesFilled[location] == 0 {
            playMove(location)
            return location
        } else {
            return playMoveAI()
            
        }
    }
    
    
    
    
    
}