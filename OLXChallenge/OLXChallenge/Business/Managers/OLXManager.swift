//
//  OLXManager.swift
//  OLXChallenge
//
//  Created by Ana Neto on 27/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import UIKit

public class OLXManager: NSObject {
    
    static let sharedInstance = OLXManager()
    
    private var olxAPIRepository:OLXAPIRepository = OLXAPIRepository.sharedInstance
    
    public override init(){
        super.init()
    }
    
    public func getData(){
        if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
            if let configDict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                if let url:String = configDict["API_URL"] as? String {
                    self.olxAPIRepository.olxAPIRequest(url)
                }
            }
        }
    }
    
}