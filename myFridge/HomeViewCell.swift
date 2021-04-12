//
//  HomeViewCell.swift
//  myFridge
//
//  Created by Kyle George on 3/30/21.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeSummaryLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
