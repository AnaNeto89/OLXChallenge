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
    func returnError()
}

public class OLXManager: NSObject {
    
    static let sharedInstance = OLXManager()
    public var delegate:OLXManagerProtocol?
    private var olxAPIRepository:OLXAPIRepository = OLXAPIRepository.sharedInstance
    
    public override init(){
        super.init()
        self.olxAPIRepository.delegate = self
    }
    
    public func getData(url:String?, page:Int){
        if url == nil {
            //default starting call
            if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist") {
                if let configDict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                    if let defaultURL:String = configDict["API_URL"] as? String {
                        sendAPICallToRepository(defaultURL, page:0)
                    }
                }
            }
        }
        else {
            sendAPICallToRepository(url!,page:page)
        }
    }
    
    func sendAPICallToRepository(url:String, page:Int){
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            self.olxAPIRepository.olxAPIRequest(url, page:page)
        })
    }
}

extension OLXManager: OLXAPIRepositoryProtocol {
    public func returnApiResponse(response: Response) {
        
        //save data in realm db
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(response, update: true)
            try! realm.commitWrite()
        }
        
        self.delegate?.returnResponse(response)
        
    }
    
    public func returnError(index:Int) {
        
        //save data in realm db
        let result  = try! Realm().objects(Response.self)
        
        if result.count > 0 {
            if index < result.count {
                self.delegate?.returnResponse(result[index])
            }
            else{
                self.delegate?.returnError()
            }
        }
        
    }
}