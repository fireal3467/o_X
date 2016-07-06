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
    
    var player: CellType?
    
    
    func cancelGame(onCompletion: (Bool) -> Void) {
        let request = createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games/\(self.currentGame.ID)"), method: "DELETE", parameters: nil)
        
            self.executeRequest(request, requestCompletionFunction: {(responseCode,json) in
                
                print("delete json Code")
                print(responseCode)
                print(json)
                
                if(responseCode/100 == 2 || responseCode == 403){
                    
                    print("successfully delete game")
                    onCompletion(true)
                    
                }else {
                    
                    
                    print("failed to delete game")
                    onCompletion(false)
                    
                }
        })
    }
    
    
    
    func viewGame(onCompletion: (Bool,String?) -> Void) {
        
        let request = createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games/\(self.currentGame.ID)"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json ) in
        
            print("printing view game JSON")
            print(json)
            
            
            if(responseCode/100 == 2) {
                print("successfully entered 200 response code, board string is:")
                print(json["board"].stringValue)
                self.currentGame.updateBoardNetwork(json["board"].stringValue)
                
                print(self.currentGame.Board)
                
                print(json["state"].stringValue)
                onCompletion(true, json["state"].stringValue)
                
            }else {
                print("error, couldn't view game")
                
                onCompletion(false,nil)
            }
        })
    }
    
    
    
    
    
    func playNetworkMove(location:Int) {
        
        let board = ["board":currentGame.getNetworkBoard()]
        
        
        let request = createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games/\(currentGame.ID)"), method: "PUT", parameters: board)
        
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode,json) in
            
            print("printing playmove json")
            print(json)
            
            if (responseCode/100 == 2) {
                
                print("successfully played move at location \(location)")
                
            }else {
                
                print("failed to play move at location")
                
            }
            
            })
  
    }
    
    
    
    
    
    
    func acceptGame(game:OXGame,onCompletion:(game:OXGame?, message:String?) -> Void){
        let request = self.createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games/\(game.ID)/join"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode,json) in
            print("acceptGameJSON")
            print(json)
            if(responseCode/100 == 2) {
                print("entered the 200 response")
                self.player = CellType.O
                self.currentGame = game
                onCompletion(game:game,message: nil)
            
            }else {
                
                
                print("entered error message")
                
                onCompletion(game:nil, message: "Could not accept game")
            }
        } )
    }
    
 
    //TODO, make a on completition that allows me do to UI popup alerts in the board view controller
    func hostGame(onCompletion:(game:OXGame?, message:String?) -> Void){
        
        let request = self.createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode,json) in
            print("host game JSON")
            
            print(json)
            print(responseCode)
            if(responseCode/100 == 2 ) {
                
//                print("entered responseCode 200")
                
                self.getCurrentGame().ID = json["id"].intValue
                self.getCurrentGame().host = json["host_user"]["uid"].stringValue
                self.getCurrentGame().updateBoardNetwork(json["board"].stringValue)
                
                self.player = CellType.X
                
                
                onCompletion(game:self.getCurrentGame(),message: nil)
                
            } else {
                
                print("failed to make a game, try again")
                
                onCompletion(game: nil, message: "YOU HAVE FAILED TO MAKE A GAME")
                
            }
            
        })
    }
    
    
    func getGames(onCompletion onCompletion:([OXGame]?,String?) -> Void) {
    
        let request = createMutableRequest(NSURL(string:"https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            print(json)
            

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