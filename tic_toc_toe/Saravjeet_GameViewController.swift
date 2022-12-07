//
//  Saravjeet_GameViewController.swift
//  tic_toc_toe
//
//  Created by Saravjeet Singh on 2022-11-06.
//

import UIKit

class Saravjeet_GameViewController: UIViewController {
    
    //Marks : -> class variable
    
    var theGameModel = Saravjeet_GameModel()
    var gameFinished = false
    
    var pastGameData : GameData?
    
    var replayingPastGame = false
    
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var delay : Double = 0.0
        
        // Do any additional setup after loading the view.
        if replayingPastGame {
            navigationItem.title = "Past Game"
            
            // play move for past game
            let pastGameMove = pastGameData?.orderOfMove
            theGameModel.isPastGame = true
            
            for move in pastGameMove! {
                
                delay += 1.0
                DispatchQueue.main.asyncAfter(deadline: .now()+delay, execute: {
                    let button = self.view.viewWithTag(move)
                    self.playTheMove(button as! UIButton)
                })
                
                
            }
        }
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        if !replayingPastGame {
            playTheMove(sender)
        }
    }
    
    func playTheMove(_ sender: UIButton){
        print(sender.tag)
        if(sender.currentTitle == "X" || sender.currentTitle == "O" || gameFinished){
            return
        }
        sender.setTitle(theGameModel.whoseTurn, for: .normal)
        theGameModel.playMove(tag: sender.tag)
        
        if theGameModel.isGameFinished(){
            let winner = theGameModel.whoWon
            if winner.count > 0 {
                gameStateLabel.text = winner + " won"
            }else{
                gameStateLabel.text = "Draw!"
            }
//            gameStateLabel.text = "Game Over"
            gameFinished = true
            
        }else{
            gameStateLabel.text = theGameModel.whoseTurn + "'s Turn"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
