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
import ImageSlideshow

public protocol DetailViewControllerProtocol {
    func locationPressed()
}

public class DetailViewController: UIViewController {
    
    //MARK: Variables
    var ad:Ad?
    var pageIndex:Int?
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    var header:DetailHeaderView?
    var delegate:DetailViewControllerProtocol?
    
    //MARK: IBOutlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: lifecycle methods
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        buildHeader()
        tableViewConfigurations()

    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: auxiliar methods
    
    func buildHeader(){
        if let photo = ad?.getImageURL(0) {
            self.header = NSBundle.mainBundle().loadNibNamed("DetailHeaderView", owner: self, options: nil).first as? DetailHeaderView
            
            self.header!.imageView.backgroundColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
            self.header!.imageView.slideshowInterval = 5.0
            self.header!.imageView.pageControlPosition = PageControlPosition.UnderScrollView
            self.header!.imageView.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
            self.header!.imageView.pageControl.pageIndicatorTintColor = UIColor.blackColor();
            self.header!.imageView.contentScaleMode = UIViewContentMode.ScaleAspectFill
            
            var sources:[SDWebImageSource] = [SDWebImageSource]()
            
            for i in 0...ad!.photos.count-1 {
                sources.append(SDWebImageSource(urlString: ad!.getImageURL(i)!)!)
            }
            
            self.header!.imageView.setImageInputs(sources)
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.click))
            self.header!.imageView.addGestureRecognizer(recognizer)
            
//            headerView?.imageView.sd_setImageWithURL(NSURL(string: photo))
            self.tableView.parallaxHeader.view = self.header  // You can set the parallax header view from the floating view
            tableView.parallaxHeader.height = self.view.frame.height/3
            tableView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
            tableView.parallaxHeader.minimumHeight = 0
        }
    }
    
    func click() {
        let ctr = FullScreenSlideshowViewController()
        ctr.pageSelected = {(page: Int) in
            self.header?.imageView.setScrollViewPage(page, animated: false)
        }
        
        ctr.initialImageIndex = self.header!.imageView.scrollViewPage
        ctr.inputs = self.header?.imageView.images
        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: self.header!.imageView, slideshowController: ctr)
        // Uncomment if you want disable the slide-to-dismiss feature on full screen preview
        // self.transitionDelegate?.slideToDismissEnabled = false
        ctr.transitioningDelegate = slideshowTransitioningDelegate
        self.presentViewController(ctr, animated: true, completion: nil)
    }
    
    func tableViewConfigurations(){
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0 ;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.registerNib(UINib(nibName: "AdTitleTableViewCell", bundle:nil), forCellReuseIdentifier: "AdTitleTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdLocationTableViewCell", bundle:nil), forCellReuseIdentifier: "AdLocationTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdDescriptionTableViewCell", bundle:nil), forCellReuseIdentifier: "AdDescriptionTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdPriceTableViewCell", bundle:nil), forCellReuseIdentifier: "AdPriceTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdVendorTableViewCell", bundle:nil), forCellReuseIdentifier: "AdVendorTableViewCell")
        self.tableView.registerNib(UINib(nibName: "AdCreationTableViewCell", bundle:nil), forCellReuseIdentifier: "AdCreationTableViewCell")
    }
}

extension DetailViewController:UITableViewDelegate {
    
    //MARK: UITableViewDelegate methods
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23
    }
}

extension DetailViewController:UITableViewDataSource {
    
    //MARK: UITableViewDataSource methods
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:AdTitleTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdTitleTableViewCell", forIndexPath: indexPath) as! AdTitleTableViewCell
            cell.titleLabel.text =  self.ad?.title
            
            cell.userInteractionEnabled = false
            cell.contentView.layoutIfNeeded()
            
            return cell
            
        case 1:
            let cell:AdPriceTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdPriceTableViewCell", forIndexPath: indexPath) as! AdPriceTableViewCell
            cell.priceLabel.text =  self.ad?.price
            
            cell.userInteractionEnabled = false
            cell.contentView.layoutIfNeeded()
            
            return cell
        case 2:
            let cell:AdCreationTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdCreationTableViewCell", forIndexPath: indexPath) as! AdCreationTableViewCell
            cell.creationLabel.text =  self.ad?.creationDate
            
            cell.userInteractionEnabled = false
            cell.contentView.layoutIfNeeded()
            
            return cell
        case 3:
            let cell:AdVendorTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdVendorTableViewCell", forIndexPath: indexPath) as! AdVendorTableViewCell
            cell.vendorNameLabel.text =  self.ad?.vendorName
            
            cell.userInteractionEnabled = false
            cell.contentView.layoutIfNeeded()
            
            return cell
        case 4:
            let cell:AdLocationTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdLocationTableViewCell", forIndexPath: indexPath) as! AdLocationTableViewCell
            cell.locationLabel.text =  self.ad?.locationText
            
            cell.contentView.layoutIfNeeded()
            
            return cell
        case 5:
            let cell:AdDescriptionTableViewCell = tableView.dequeueReusableCellWithIdentifier("AdDescriptionTableViewCell", forIndexPath: indexPath) as! AdDescriptionTableViewCell
            cell.descriptionLabel.text =  self.ad?.descriptionText
            
            cell.userInteractionEnabled = false
            cell.contentView.layoutIfNeeded()
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 4 {
            self.delegate?.locationPressed()
        }
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return buildDescriptionHeader(section)
    }
    
    //MARK: auxiliar methods
    
    func buildDescriptionHeader(section:Int)-> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 23))
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: self.tableView.frame.width-16, height: 21))
        
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        
        switch section {
        case 0:
            label.text = NSLocalizedString("SECTION_PRODUCT_TITLE", comment: "")
        case 1:
            label.text = NSLocalizedString("SECTION_PRICE_TITLE", comment: "")
        case 2:
            label.text = NSLocalizedString("SECTION_CREATEDATE_TITLE", comment: "")
        case 3:
            label.text = NSLocalizedString("SECTION_VENDOR_TITLE", comment: "")
        case 4:
            label.text = NSLocalizedString("SECTION_LOCATION_TITLE", comment: "")
        case 5:
            label.text = NSLocalizedString("SECTION_DESCRIPTION_TITLE", comment: "")
        default:
            label.text = ""
        }
        
        view.backgroundColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        view.addSubview(label)
        label.textColor = UIColor.darkGrayColor()
        
        return view
    }
}