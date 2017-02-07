//
//  LikedTableViewCell.swift
//  RestaurantIS
//
//  Created by Liya Wu-17 on 2/6/17.
//  Copyright © 2017 chapin. All rights reserved.
//

import UIKit

class LikedTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
