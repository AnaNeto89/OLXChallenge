//
//  Response.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

public class Response: Object {
    
    dynamic var page:Int = 0
    dynamic var totalPages:Int = 0
    dynamic var nextPageURL:String = ""
    var ads:List<Ad> = List<Ad>()
    
    override public static func primaryKey() -> String? {
        return "page"
    }
    
    static func parseFromJSON(data:JSON)->Response {
        
        let newResponse = Response()
        if let page = data["page"].int {
            newResponse.page = page
        }
        
        if let totalPage = data["total_pages"].int {
            newResponse.totalPages = totalPage
        }
        
        if let url = data["next_page_url"].string {
            newResponse.nextPageURL = url
        }
        
        if let ads = data["ads"].array {
            for ad in ads {
                let adObj:Ad = Ad.parseFromJSON(ad)
                newResponse.ads.append(adObj)
            }
        }
        
        return newResponse
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
