//
//  PagerViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 29/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import RealmSwift

class PagerViewController: UIPageViewController {

    var ads:List<Ad>?
    var currentIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource = self
        
        
        let startVC = self.viewControllerAtIndex(currentIndex!, ad: self.ads![currentIndex!])
        let viewControllers = [startVC]
        self.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewControllerAtIndex(index:Int, ad:Ad)-> DetailViewController {
        if self.ads!.count == 0 || index >= self.ads!.count {
            return DetailViewController()
        }
        
        let vc:DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        vc.ad = ad
        vc.pageIndex = index
        return vc
    }
}

extension PagerViewController:UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! DetailViewController
        var index = vc.pageIndex!
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, ad: self.ads![index])
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! DetailViewController
        var index = vc.pageIndex!
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
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