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


public protocol OLXAPIRepositoryProtocol {
    func returnApiResponse(response:Response)
    func returnError(index:Int)
}

public class OLXAPIRepository: NSObject {
    
    public static let sharedInstance = OLXAPIRepository()
    public var delegate:OLXAPIRepositoryProtocol?
    
    override init() {
        super.init()
    }
    
    public func olxAPIRequest(url:String, page:Int){
        
        print(url)
        
        Alamofire.request(.GET, url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    // response handling code
                    if let data = response.data {
                        if let json:JSON = JSON(data: data) {
                            let response = Response.parseFromJSON(json)
                            self.delegate?.returnApiResponse(response)
                        }
                    }
                    break
                case .Failure(let error):
                    //error handling
                    print(error.description)
                    self.delegate?.returnError(page)
                    break
                }
                
        }
    }
}