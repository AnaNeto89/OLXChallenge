//
//  Map.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift

class Map: Object {
    
    dynamic var latitude:Double = 0.0
    dynamic var longitude:Double = 0.0
    dynamic var zoom:Int = 0
    dynamic var radius:Int = 0
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
