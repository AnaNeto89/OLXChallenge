//
//  ViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 27/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    private var olxManager:OLXManager = OLXManager.sharedInstance
    private var page:Int = 0
    private var data:List<Ad>?
    
    @IBOutlet var loadingCircle: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        runScreenConfigurations()
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
        self.olxManager.getData()
    }
}

extension ViewController:OLXManagerProtocol {
    func returnResponse(response: Response) {
        
        self.data = response.ads
        self.page = response.page
        
        self.loadingCircle.stopAnimating()
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.alpha = 1
        })
    }
}

extension ViewController:UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MainTableViewCell = tableView.dequeueReusableCellWithIdentifier("MainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
        let ad = data![indexPath.row]
        
//        @IBOutlet var adImageView: UIImageView!
//        @IBOutlet var priceLabel: UILabel!
//        @IBOutlet var adLocationLabel: UILabel!
//        @IBOutlet var adTitleLabel: UILabel!
        
        cell.priceLabel.text = ad.price
        cell.adLocationLabel.text = ad.locationText
        cell.adTitleLabel.text = ad.title
        
        return cell
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

