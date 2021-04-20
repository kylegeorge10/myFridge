//
//  ReviewViewCell.swift
//  myFridge
//
//  Created by Kyle George on 4/20/21.
//

import UIKit

class ReviewViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var reviewTextField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
