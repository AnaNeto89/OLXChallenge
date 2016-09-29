//
//  ViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 27/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class ViewController: UIViewController {
    
    private var olxManager:OLXManager = OLXManager.sharedInstance
    private var isLoadingTableView = true
    private var page:Int = 0
    private var data:List<Ad>?
    private var nextPageURL:String?
    
    @IBOutlet var loadingCircle: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 44.0 ;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        runScreenConfigurations()
        apiCall()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func runScreenConfigurations(){
        self.olxManager.delegate = self
        self.tableView.alpha = 0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loadingCircle.startAnimating()
    }
    
    private func apiCall(){
        self.olxManager.getData(nextPageURL)
    }
}

extension ViewController:OLXManagerProtocol {
    
    func returnResponse(response: Response) {
        
        if self.data == nil {
            self.data = List<Ad>()
        }
        self.data!.appendContentsOf(response.ads)
        self.page = response.page
        self.nextPageURL = response.nextPageURL
        
        self.loadingCircle.stopAnimating()
        self.tableView.reloadData()
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.alpha = 1
        })
    }
}

extension ViewController:UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MainTableViewCell = tableView.dequeueReusableCellWithIdentifier("MainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
        let ad = data![indexPath.row]
        
        if let imgURL = ad.getImageURL(0) {
            cell.adImageView.sd_setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "imagePlaceholder"))
        }
        else {
            cell.adImageView.image = UIImage(named: "imagePlaceholder")
        }
        
        cell.delegate = self
        cell.adId = ad.adId
        cell.priceLabel.text = ad.price
        cell.adLocationLabel.text = ad.locationText
        cell.adTitleLabel.text = ad.title
        
        cell.contentView.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("SegueFromTableToDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row+1 == data?.count {
            apiCall()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ViewController:UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data != nil ? data!.count : 0
    }
}

extension ViewController:MainTableViewCellProtocol {
    
    func shareButtonPressed(id: String?) {
        if let str = id {
            var result  = try! Realm().objects(Ad.self).filter("adId = '\(str)'")
            
            //single result
            if result.count == 1 {
                
            let textToShare = result.first!.title
            if let url = result.first!.url {
                if let adURL = NSURL(string: url) {
                    let objectsToShare = [textToShare!,adURL]
                    
                    let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                    
                    // exclude some activity types from the list (optional)
                    activityViewController.excludedActivityTypes = [ UIActivityTypeAirDrop, UIActivityTypePostToFacebook ]
                    
                    // present the view controller
                    self.presentViewController(activityViewController, animated: true, completion: nil)
                }
            }
            }
        }
    }
}
