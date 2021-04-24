//
//  userPostCell.swift
//  myFridge
//
//  Created by Senuda Ratnayake on 4/24/21.
//

import UIKit

class userPostCell: UITableViewCell {

    @IBOutlet weak var userPostImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
