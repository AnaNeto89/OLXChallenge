//
//  Vendor.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift

class Vendor: Object {
    
    dynamic var venderName:String = ""
    dynamic var vendorId:String = ""
    dynamic var vendorAdsURL:String = ""
    dynamic var map:Map?
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
