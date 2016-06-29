//
//  File.swift
//  o_X
//
//  Created by Alan Yu on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation


enum CellType:String {
    case O = "O"
    case X = "X"
    case Empty = ""
    
}

enum OXGameState:String {
    case InProgress = "InProgress"
    case Tie = "Tie"
    case Won = "Won"
    
}


class OXGame {
    private var Board:[CellType] = [CellType](count: 9, repeatedValue: CellType.Empty)
    private let startType: CellType = CellType.X
    
    var turn: Int = 0
    var player: CellType = .X
    
    
    func turnCount() -> Int {
        return turn
    }
    
    func whoseTurn() -> CellType {
        return player
    }
    
    func playMove(location: Int) {
        if(Board[location] == .Empty) {

        print(String(location))
        Board[location] = whoseTurn()
        if(whoseTurn() == CellType.X) {
            player = CellType.O
        } else if(whoseTurn() == CellType.O) {
            player = CellType.X
        }
        turn += 1
        }
    }
    
    func gameWon() -> Bool {
        if (Board[0] == Board[1] && Board[1] == Board[2] && Board[2] != CellType.Empty) {
            //1
            return true
        } else if (Board[3] == Board[4] && Board[4] == Board[5] && Board[5] != CellType.Empty){
            //2
            return true
        } else if (Board[6] == Board[7] && Board[7] == Board[8] && Board[8] != CellType.Empty){
            //3
            return true
        } else if (Board[0] == Board[3] && Board[3] == Board[6] && Board[6] != CellType.Empty){
            //4
            return true
        } else if (Board[1] == Board[4] && Board[4] == Board[7] && Board[7] != CellType.Empty){
            //5
            return true
        } else if (Board[2] == Board[5] && Board[5] == Board[8] && Board[8] != CellType.Empty){
            //6
            return true
        } else if (Board[0] == Board[4] && Board[4] == Board[8] && Board[8] != CellType.Empty){
            //7
            return true
        } else if (Board[2] == Board[4] && Board[4] == Board[6] && Board[6] != CellType.Empty){
            //8
            return true
        } else{
            return false
        }
    }
    
    
    
    func state() -> OXGameState {
        if(gameWon()) {
            return OXGameState.Won
        } else if(turnCount() >= 9) {
            return OXGameState.Tie
        } else {
            return OXGameState.InProgress
        }
    }

    func reset() {
        turn = 0
        Board = [CellType](count: 9, repeatedValue: CellType.Empty)
        player = startType
    }




}
    
    

