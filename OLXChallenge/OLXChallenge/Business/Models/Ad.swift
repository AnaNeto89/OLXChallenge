//
//  Ad.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift

class Ad: Object {
    
    dynamic var adId:Int = 0
    dynamic var url:String = ""
    dynamic var title:String = ""
    dynamic var descriptionText:String = ""
    dynamic var price:String = ""
    dynamic var numericUserId:String = ""
    dynamic var user:Vendor?
    var photos:List<Photo> = List<Photo>()
    
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
