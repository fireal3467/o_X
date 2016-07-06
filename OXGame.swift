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
    case Open = "Open"
    case Abandoned = "Abandoned"
    
}


class OXGame {
    var Board:[CellType] = [CellType](count: 9, repeatedValue: CellType.Empty)
    private let startType: CellType = CellType.X
    
    
    var ID:Int = 0
    var host: String = ""
    
   
    func updateBoardNetwork(board:String) {
        print("updating board Network Style")
        self.Board = deserialiseBoard(board)
        
    }
    
    
    func getNetworkBoard() -> String {
        print("getting board to send to network")
        
        return serialiseBoard()
    }
    
    
    private func deserialiseBoard(board:String) -> [CellType] {
        print("start deserialise")
        var importedBoard:[CellType] = [CellType]()
        for char in board.characters{
            if char == "_" {
                importedBoard.append(CellType.Empty)
            } else if char == "x" {
                importedBoard.append(CellType.X)
            } else if char == "o" {
                importedBoard.append(CellType.O)
            } else {
                print("error")
            }
        }
        return importedBoard
    }
    
    
    private func serialiseBoard() -> String {
        print("Start serialiseBoard")
        var boardString:String = ""
        for cell in Board {
            if cell == CellType.Empty{
                boardString += "_"
            } else if cell == CellType.X {
                boardString += "x"
            } else if cell == CellType.O {
                boardString += "o"
            }
        }
        return boardString
    }
    
    
    func checkCell(location: Int) -> CellType {
        return Board[location]
    }
    
    
    func turnCount() -> Int {
        var moves:Int = 0
        for cell in Board {
            if cell != .Empty{
                moves += 1
            }
        }
        return moves
    }
    
    func whoseTurn() -> CellType {
        if(turnCount()%2 == 0){
            return CellType.X
        } else {
            return CellType.O
        }
    }
    
    func playMove(location: Int) {
        if(Board[location] == .Empty) {

        print(String(location))
        Board[location] = whoseTurn()
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
        Board = [CellType](count: 9, repeatedValue: CellType.Empty)
        
    }




}
    
    

