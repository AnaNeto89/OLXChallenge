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
                    let json = JSON(data: data)
                    
                }
            }
    }
}