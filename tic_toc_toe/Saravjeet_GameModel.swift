//
//  Saravjeet_GameModel.swift
//  tic_toc_toe
//
//  Created by Saravjeet Singh on 2022-11-06.
//

import Foundation

class Saravjeet_GameModel {
    var whoseTurn = "X"
    var squareContents = Array(repeating: "", count: 10)
    var numberOfMovesPlayed = 0
    var lastPlayed = ""
    var whoWon = ""
    var orderOfMove = [Int]()
    var isPastGame = false
//    var numberOfGamesPlayed =
    let winningCombination = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
    ]
    
    func playMove(tag : Int) {
        
        squareContents[tag] = whoseTurn
        // get last played game for next move
        lastPlayed = whoseTurn
        
        // save order of move
        orderOfMove.append(tag)
        
        // order of move
        // ways to save data
        /**
         User Defaults, Core Data, Sqlite, Files
         
         */
        
        if whoseTurn == "X" {
            whoseTurn = "O"
        }else{
            whoseTurn = "X"
        }
        numberOfMovesPlayed += 1
    }
    
    func isGameFinished() -> Bool{
        
        if numberOfMovesPlayed < 5 {
            return false
        }
        
        
        // check somebody is won or not
        
        for winningCombo in winningCombination {
            let index1 = winningCombo[0]
            let index2 = winningCombo[1]
            let index3 = winningCombo[2]
            
            if( squareContents[index1] == lastPlayed && squareContents[index2] == lastPlayed && squareContents[index3] == lastPlayed) {
                // game over
                whoWon = lastPlayed
                saveGame()
                return true
            }
        }
        
        if numberOfMovesPlayed == 9 {
            return true
        }
        return false
    }
    
    func saveGame(){
        
        if isPastGame{
            return
        }
        let numberGamePlayed = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES)
        let gameNumber = numberGamePlayed + 1
        UserDefaults.standard.set(whoWon, forKey: Constants.WHO_WON + String(gameNumber))
        
        UserDefaults.standard.set(Date(), forKey: Constants.DATE_TIME + String(gameNumber))
        
        UserDefaults.standard.set(orderOfMove, forKey: Constants.ORDER_OF_MOVES + String(gameNumber))
        
        UserDefaults.standard.set(gameNumber, forKey: Constants.NUM_GAMES)
        print("game Saved!!!")
    }
}

struct Constants {
    static let NUM_GAMES = "numberOfGamesPlayed"
    static let WHO_WON = "whoWon"
    static let DATE_TIME = "dateTime"
    static let ORDER_OF_MOVES = "orderOfMoves"
}
