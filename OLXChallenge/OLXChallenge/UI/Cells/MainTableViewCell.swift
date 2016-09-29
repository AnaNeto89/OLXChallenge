//
//  MainTableViewCell.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit

public protocol MainTableViewCellProtocol {
    func shareButtonPressed(id:String?)
}

public class MainTableViewCell: UITableViewCell {

    @IBOutlet var adImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var adLocationLabel: UILabel!
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var creationLabel: UILabel!
    
    public var adId:String?
    public var delegate:MainTableViewCellProtocol?
    
    override public func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        self.delegate?.shareButtonPressed(self.adId)
    }
}
