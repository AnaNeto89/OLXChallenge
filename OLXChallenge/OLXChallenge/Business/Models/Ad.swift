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
    
    //details
    dynamic var adId:String?
    dynamic var url:String?
    dynamic var title:String?
    dynamic var descriptionText:String?
    dynamic var price:String?
    
    //location
    dynamic var locationText:String?
    dynamic var latitude:String?
    dynamic var longitude:String?
    dynamic var zoom:String?
    
    //vendor
    dynamic var vendorId:String?
    dynamic var vendorName:String?
    
    var photos:List<Photo> = List<Photo>()
    
    override public static func primaryKey() -> String? {
        return "adId"
    }
    
    func getImageURL(index:Int)->String? {
        if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
            if let configDict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                if let imageBaseURL:String = configDict["IMAGE_URL_BASE"] as? String {
                    if photos.count > 0 {
                        if let photo:Photo = photos[index] {
                            return imageBaseURL + "\(photo.key)_\(photo.slot)_.jpg"
                        }
                    }
                }
            }
        }
        return nil
    }
    
    static func parseFromJSON(data:JSON)->Ad {
        
        let newAd = Ad()
        newAd.adId = data["id"].string
        newAd.url = data["url"].string
        newAd.title = data["title"].string
        newAd.descriptionText = data["description"].string
        newAd.price = data["list_label"].string
        
        newAd.locationText = data["city_label"].string
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
