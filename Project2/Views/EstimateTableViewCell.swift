//
//  EstimateTableViewCell.swift
//  Project2
//
//  Created by qwerty on 5/26/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class EstimateTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ratingLabel.layer.masksToBounds = true
        self.ratingLabel.layer.cornerRadius = 3

        self.mainImage.layer.masksToBounds = true
        self.mainImage.layer.cornerRadius = self.mainImage.frame.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
