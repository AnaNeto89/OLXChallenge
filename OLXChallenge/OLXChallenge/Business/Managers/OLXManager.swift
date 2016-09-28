//
//  OLXManager.swift
//  OLXChallenge
//
//  Created by Ana Neto on 27/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public protocol OLXManagerProtocol {
    func returnResponse(response:Response)
}

public class OLXManager: NSObject {
    
    static let sharedInstance = OLXManager()
    public var delegate:OLXManagerProtocol?
    private var olxAPIRepository:OLXAPIRepository = OLXAPIRepository.sharedInstance
    
    public override init(){
        super.init()
        self.olxAPIRepository.delegate = self
    }
    
    public func getData(){
        if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
            if let configDict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                if let url:String = configDict["API_URL"] as? String {
                    self.olxAPIRepository.olxAPIRequest(url)
                }
            }
        }
    }
}

extension OLXManager: OLXAPIRepositoryProtocol {
    public func returnApiResponse(response: Response) {
        
        //save data in realm db
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(response, update: true)
        }
        
        self.delegate?.returnResponse(response)

    }
}