//
//  Vendor.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Vendor: Object {
    
    dynamic var vendorId:String = ""
    dynamic var vendorName:String = ""
    dynamic var vendorAdsURL:String = ""
    
    override static func primaryKey() -> String? {
        return "vendorId"
    }
    
    static func parseFromJSON(data:JSON)->Vendor {
    
        var vendor:Vendor = Vendor()
        
        return vendor
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
