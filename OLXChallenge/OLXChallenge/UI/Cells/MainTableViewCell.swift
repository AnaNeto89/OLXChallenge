//
//  MainTableViewCell.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var adImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var adLocationLabel: UILabel!
    @IBOutlet var adTitleLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
