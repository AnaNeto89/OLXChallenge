//
//  PagerViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 29/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import RealmSwift

public protocol PagerViewControllerProtocol {
    func continueWithCurrentData(data:List<Ad>, page:Int, nextURL:String)
}

class PagerViewController: UIPageViewController {

    //MARK: Variables
    var ads:List<Ad>?
    var currentIndex:Int?
    var page:Int = 0
    var nextPageURL:String?
    var comebackDelegate:PagerViewControllerProtocol?
    private var olxManager:OLXManager = OLXManager.sharedInstance
    
    //MARK: lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runConfigurations()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.comebackDelegate?.continueWithCurrentData(self.ads!, page: self.page, nextURL: self.nextPageURL!)
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: auxiliar methods
    func runConfigurations(){
        self.dataSource = self
        let startVC = self.viewControllerAtIndex(currentIndex!, ad: self.ads![currentIndex!])
        let viewControllers = [startVC]
        self.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        self.olxManager.delegate = self
    }

    func viewControllerAtIndex(index:Int, ad:Ad)-> DetailViewController {
        if self.ads!.count == 0 || index >= self.ads!.count {
            return DetailViewController()
        }
        
        self.title = "Ad "+self.ads![index].adId!
        
        let vc:DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        vc.delegate = self
        vc.ad = ad
        vc.pageIndex = index
        return vc
    }
    
    @IBAction func mapsButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("SegueFromPagerToMap", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueFromPagerToMap" {
            let vc:MapViewController = segue.destinationViewController as! MapViewController
            let ad = self.ads![self.currentIndex!]
            vc.adLatitude = Double(ad.latitude!)
            vc.adLongitude = Double(ad.longitude!)
            vc.adTitle = ad.title
            
        }
    }
}

extension PagerViewController:UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! DetailViewController
        var index = vc.pageIndex!
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        self.currentIndex = index
        index -= 1
        return self.viewControllerAtIndex(index, ad: self.ads![index])
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! DetailViewController
        var index = vc.pageIndex!
        
        if index == NSNotFound {
            return nil
        }
        
        self.currentIndex = index
        index += 1
        
        if index  == self.ads!.count-2 {
            self.olxManager.getData(nextPageURL, page:self.page)
        }
        
        if index == self.ads!.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index, ad: self.ads![index])
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex!
    }
}

extension PagerViewController:UIPageViewControllerDelegate {
    
}

extension PagerViewController:DetailViewControllerProtocol {
    func locationPressed() {
        self.performSegueWithIdentifier("SegueFromPagerToMap", sender: self)
    }
}

extension PagerViewController:OLXManagerProtocol {
    
    func returnResponse(response: Response) {
        
        if self.ads == nil {
            self.ads = List<Ad>()
        }
        self.ads!.appendContentsOf(response.ads)
        self.page = response.page
        self.nextPageURL = response.nextPageURL
        
        self.viewControllerAtIndex(self.currentIndex!, ad: self.ads![self.currentIndex!])
    }
    
    func returnError() {
        let myAlert = UIAlertView()
        myAlert.title = NSLocalizedString("ERROR_TITLE", comment: "")
        myAlert.message = NSLocalizedString("ERROR_MSG", comment: "")
        myAlert.addButtonWithTitle("OK")
        myAlert.delegate = self
        myAlert.show()
    }
}