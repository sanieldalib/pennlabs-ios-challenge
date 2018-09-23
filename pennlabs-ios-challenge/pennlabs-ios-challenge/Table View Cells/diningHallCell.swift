//
//  diningHallCell.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import UIKit

class diningHallCell: UITableViewCell {

    @IBOutlet weak var diningName: UILabel?
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            if statusLabel.text == "OPEN" {
                statusLabel.textColor = UIColor.openColor
            }
        }
    }
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var diningImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        diningImage.layer.cornerRadius = 10
        diningImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
