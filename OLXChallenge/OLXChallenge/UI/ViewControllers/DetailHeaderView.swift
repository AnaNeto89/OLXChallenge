//
//  DetailHeaderView.swift
//  OLXChallenge
//
//  Created by Ana Neto on 29/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import MXParallaxHeader

class DetailHeaderView: UIView, MXParallaxHeaderProtocol {
    
    @IBOutlet var imageView: UIImageView!
    
    class func instanciateFromNib() -> DetailHeaderView {
        return NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: nil, options: nil)[0] as! DetailHeaderView
    }
    
    // MARK: - <MXParallaxHeader>
    
    func parallaxHeaderDidScroll(parallaxHeader: MXParallaxHeader) {
    }
}