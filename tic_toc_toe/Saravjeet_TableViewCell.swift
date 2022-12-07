//
//  Saravjeet_TableViewCell.swift
//  tic_toc_toe
//
//  Created by Saravjeet Singh on 2022-11-06.
//

import UIKit

class Saravjeet_TableViewCell: UITableViewCell {

    
    // class variables
    var gameDate : GameData?
    // outlets
    
    @IBOutlet weak var winLoseImage: UIImageView!
    @IBOutlet weak var whoWon: UILabel!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
