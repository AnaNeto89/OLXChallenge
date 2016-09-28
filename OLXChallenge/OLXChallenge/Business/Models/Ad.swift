//
//  Ad.swift
//  OLXChallenge
//
//  Created by Ana Neto on 28/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import Realm

public class Ad: Object {
    
    dynamic var adId:String?
    dynamic var url:String?
    dynamic var title:String?
    dynamic var descriptionText:String?
    dynamic var price:String?
    
    dynamic var latitude:String?
    dynamic var longitude:String?
    dynamic var zoom:String?
    
    dynamic var vendorId:String?
    dynamic var vendorName:String?
    
    var photos:List<Photo> = List<Photo>()
    
    override public static func primaryKey() -> String? {
        return "adId"
    }
    
    static func parseFromJSON(data:JSON)->Ad {
        
        let newAd = Ad()
        newAd.adId = data["id"].string
        newAd.url = data["url"].string
        newAd.title = data["title"].string
        newAd.descriptionText = data["description"].string
        newAd.price = data["list_label"].string
        
        newAd.latitude = data["map_lat"].string
        newAd.longitude = data["map_lon"].string
        newAd.zoom = data["map_zoom"].string
        
        newAd.vendorId = data["numeric_user_id"].string
        newAd.vendorName = data["user_label"].string
        
        if let photosData:JSON = data["photos"] {
            
            if let key = photosData["riak_key"].int {
                
                if let innerData = photosData["data"].array {
                    for photo in innerData {
                        let newPhoto = Photo.parseFromJSON(key, data: photo)
                        newAd.photos.append(newPhoto)
                    }
                }
            }
        }
        
        return newAd
    }
}
