//
//  DetailViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 29/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import RealmSwift

public class DetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    var ad:Ad?
    var pageIndex:Int?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if ad != nil {
            self.titleLabel.text = ad!.title
        }
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.lt_reset()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
