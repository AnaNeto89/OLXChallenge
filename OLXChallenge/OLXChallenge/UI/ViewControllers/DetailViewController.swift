//
//  DetailViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 29/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import RealmSwift
import MXParallaxHeader

public class DetailViewController: UIViewController {
    
    var ad:Ad?
    var pageIndex:Int?
    
    @IBOutlet var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let photo = ad?.getImageURL(0) {
            let headerView = NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: self, options: nil).first as? DetailHeaderView
            headerView?.imageView.sd_setImageWithURL(NSURL(string: photo))
            self.tableView.parallaxHeader.view = headerView  // You can set the parallax header view from the floating view
            tableView.parallaxHeader.height = self.view.frame.height/3
            tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
            tableView.parallaxHeader.minimumHeight = 0
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0 ;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.registerNib(UINib(nibName: "AdTitleTableViewCell", bundle:nil), forCellReuseIdentifier: "AdTitleTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdLocationTableViewCell", bundle:nil), forCellReuseIdentifier: "AdLocationTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdDescriptionTableViewCell", bundle:nil), forCellReuseIdentifier: "AdDescriptionTableViewCell")
        
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController:UITableViewDelegate {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 5 : 0
    }
}

extension DetailViewController:UITableViewDataSource {
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:AdTitleTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdTitleTableViewCell", forIndexPath: indexPath) as! AdTitleTableViewCell
            cell.titleLabel.text =  self.ad?.title
            
            cell.contentView.layoutIfNeeded()
            
            return cell
        case 1:
            let cell:AdLocationTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdLocationTableViewCell", forIndexPath: indexPath) as! AdLocationTableViewCell
            cell.locationLabel.text =  self.ad?.locationText
            
            cell.contentView.layoutIfNeeded()
            
            return cell
        case 2:
            let cell:AdDescriptionTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdDescriptionTableViewCell", forIndexPath: indexPath) as! AdDescriptionTableViewCell
            cell.descriptionLabel.text =  self.ad?.descriptionText
            
            cell.contentView.layoutIfNeeded()
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}