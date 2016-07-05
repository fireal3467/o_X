//
//  OXGameController.swift
//  o_X
//
//  Created by Alan Yu on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


class OXGameController:WebService {
    
    static var sharedInstance = OXGameController()
    
    private var currentGame:OXGame = OXGame()
    
    private var SpacesFilled:[Int] = [Int](count: 9, repeatedValue: 0)
    
    var AI: Bool = false
    
    func getGames(onCompletion onCompletion:([OXGame]?,String?) -> Void) {
    
        let request = createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            print(json)
            
            
            print(String(responseCode))
            
            
            
            if responseCode/100 == 2 {
                
                print("FDSAFDSA")
                
                var games = [OXGame]()
                
                for game in json.arrayValue {
                    let g = OXGame()
                    g.ID = game["id"].intValue
                    g.host = game["host_user"]["uid"].stringValue
                    games.append(g)
                }
                
                onCompletion(games, nil)
                
            } else {
                
                
                print("failed to get a game list")
                
                onCompletion(nil,"error, couldn't get 200 response code")
            }

            })
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