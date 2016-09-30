//
//  DetailHeaderView.swift
//  OLXChallenge
//
//  Created by Ana Neto on 29/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import MXParallaxHeader
import ImageSlideshow

class DetailHeaderView: UIView, MXParallaxHeaderProtocol {
    
    @IBOutlet var imageView: ImageSlideshow!
    
    class func instanciateFromNib() -> DetailHeaderView {
        return NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: nil, options: nil)[0] as! DetailHeaderView
    }
    
    // MARK: - <MXParallaxHeader>
    
    func parallaxHeaderDidScroll(parallaxHeader: MXParallaxHeader) {
    }
}