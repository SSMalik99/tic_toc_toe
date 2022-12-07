//
//  Saravjeet_TableViewController.swift
//  tic_toc_toe
//
//  Created by Saravjeet Singh on 2022-11-06.
//

import UIKit

class Saravjeet_TableViewController: UITableViewController {

    var gameDataArray = [GameData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    func loadData(){
        let numberOfGamesPlayed = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES)
        gameDataArray = [GameData]()
        
        for i in (0..<numberOfGamesPlayed).reversed() {
            let gameNumber = i + 1
            let whoWonTheGame = UserDefaults.standard.string(forKey: Constants.WHO_WON + String(gameNumber))
            let dateTimeThisGame = UserDefaults.standard.object(forKey: Constants.DATE_TIME + String(gameNumber)) as! Date
            
            let orderOfMovesThisGame = UserDefaults.standard.array(forKey: Constants.ORDER_OF_MOVES+String(gameNumber)) as! [Int]
            
            let thisGameDate = GameData(whoWon: whoWonTheGame!, dateTime: dateTimeThisGame, orderOfMove: orderOfMovesThisGame)
            
            
            gameDataArray.append(thisGameDate)
            
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserDefaults.standard.integer(forKey: Constants.NUM_GAMES)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Saravjeet_tablecell", for: indexPath) as! Saravjeet_TableViewCell
        
        

        // Configure the cell...
        let rowNumber = indexPath.row
        let thisRowData = gameDataArray[rowNumber]
        
        if thisRowData.whoWon == "" {
            cell.whoWon.text = "Draw!"
        }else{
            cell.whoWon.text = thisRowData.whoWon + " Won"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        
        cell.dateTimeLabel.text = dateFormatter.string(from: thisRowData.dateTime)
        
        
        if thisRowData.whoWon == "X" {
            cell.winLoseImage.image = UIImage(named: "orange_win")
        }else{
            cell.winLoseImage.image = UIImage(named: "orange_loss")
        }
        
        cell.gameDate = thisRowData
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier
        
        if identifier == "newGame" {
            return
        }
        
        let whichCell = sender as! Saravjeet_TableViewCell
        let destinationView = segue.destination as! Saravjeet_GameViewController
        
        destinationView.pastGameData = whichCell.gameDate
        destinationView.replayingPastGame = true
        
        
        
        
    }
    

}

struct GameData{
    var whoWon : String
    var dateTime : Date
    var orderOfMove : [Int]
    
}
