//
//  APIRepository.swift
//  OLXChallenge
//
//  Created by Ana Neto on 27/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

public class OLXAPIRepository: NSObject {
    
    public static let sharedInstance = OLXAPIRepository()
    
    override init() {
        super.init()
    }
    
    public func olxAPIRequest(url:String){
        Alamofire.request(.GET, url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                // response handling code
                if let data = response.data {
                    if let json:JSON = JSON(data: data) {
                        let response = Response.parseFromJSON(json)
                        let realm = try! Realm()
                        
                        try! realm.write {
                            realm.add(response, update: true)
                        }
                        
                        print(realm.objects(Photo.self))
                    }
                }
            }
    }
}