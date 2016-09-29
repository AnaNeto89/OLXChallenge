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
        if let photo = ad?.getImageURL(0) {
            let headerView = NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: self, options: nil).first as? DetailHeaderView
            headerView?.imageView.sd_setImageWithURL(NSURL(string: photo))
            self.tableView.parallaxHeader.view = headerView  // You can set the parallax header view from the floating view
            tableView.parallaxHeader.height = 300
            tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
            tableView.parallaxHeader.minimumHeight = 64
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
