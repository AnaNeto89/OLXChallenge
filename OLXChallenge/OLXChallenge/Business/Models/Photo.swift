//
//  Photo.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object {
    
    dynamic var key:Double  = 0
    dynamic var slot:Int = 0
    dynamic var width: Int = 0
    dynamic var height: Int = 0
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
